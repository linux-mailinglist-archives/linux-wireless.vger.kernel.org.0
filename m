Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0302FA488
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393388AbhARPXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 10:23:41 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48887 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389680AbhARPX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 10:23:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610983389; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=srpPkNpRBICBrWQ2ecRPRjIdG0DJ9BuJWG1ugh7Q28c=;
 b=WoAXqZHeJ71e+g3maKYAI8MPAc/BPW91LPxkQXvmE3eBTqz855NOhmY6YxdL8L1K6ua8w/Dx
 0X2fJInefotGOmy78zst7G3fc/E313tHMUdbBv5O5envTtO3DmrlOc93a4LFjGiNVsJILQ/G
 79GkVj6fRPdwBeFzAVv/jB1eL9A=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6005a7b675e5c01cba4d7f2f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 15:22:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66EAFC43464; Mon, 18 Jan 2021 15:22:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E52BC433C6;
        Mon, 18 Jan 2021 15:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E52BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt7601u: fix rx buffer refcounting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org>
References: <62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kuba@kernel.org, nbd@nbd.name, matthias_berndt@gmx.de,
        mozlima@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210118152230.66EAFC43464@smtp.codeaurora.org>
Date:   Mon, 18 Jan 2021 15:22:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following crash due to erroneous page refcounting:
> 
> [   32.445919] BUG: Bad page state in process swapper/1  pfn:11f65a
> [   32.447409] page:00000000938f0632 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x11f65a
> [   32.449605] flags: 0x8000000000000000()
> [   32.450421] raw: 8000000000000000 ffffffff825b0148 ffffea00045ae988 0000000000000000
> [   32.451795] raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
> [   32.452999] page dumped because: nonzero mapcount
> [   32.453888] Modules linked in:
> [   32.454492] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.11.0-rc2+ #1976
> [   32.455695] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
> [   32.457157] Call Trace:
> [   32.457636]  <IRQ>
> [   32.457993]  dump_stack+0x77/0x97
> [   32.458576]  bad_page.cold+0x65/0x96
> [   32.459198]  get_page_from_freelist+0x46a/0x11f0
> [   32.460008]  __alloc_pages_nodemask+0x10a/0x2b0
> [   32.460794]  mt7601u_rx_tasklet+0x651/0x720
> [   32.461505]  tasklet_action_common.constprop.0+0x6b/0xd0
> [   32.462343]  __do_softirq+0x152/0x46c
> [   32.462928]  asm_call_irq_on_stack+0x12/0x20
> [   32.463610]  </IRQ>
> [   32.463953]  do_softirq_own_stack+0x5b/0x70
> [   32.464582]  irq_exit_rcu+0x9f/0xe0
> [   32.465028]  common_interrupt+0xae/0x1a0
> [   32.465536]  asm_common_interrupt+0x1e/0x40
> [   32.466071] RIP: 0010:default_idle+0x18/0x20
> [   32.468981] RSP: 0018:ffffc90000077f00 EFLAGS: 00000246
> [   32.469648] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [   32.470550] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81aac3dd
> [   32.471463] RBP: ffff88810022ab00 R08: 0000000000000001 R09: 0000000000000001
> [   32.472335] R10: 0000000000000046 R11: 0000000000005aa0 R12: 0000000000000000
> [   32.473235] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   32.474139]  ? default_idle_call+0x4d/0x200
> [   32.474681]  default_idle_call+0x74/0x200
> [   32.475192]  do_idle+0x1d5/0x250
> [   32.475612]  cpu_startup_entry+0x19/0x20
> [   32.476114]  secondary_startup_64_no_verify+0xb0/0xbb
> [   32.476765] Disabling lock debugging due to kernel taint
> 
> Fixes: c869f77d6abb ("add mt7601u driver")
> Co-developed-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers.git, thanks.

d24c790577ef mt7601u: fix rx buffer refcounting

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/62b2380c8c2091834cfad05e1059b55f945bd114.1610643952.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

