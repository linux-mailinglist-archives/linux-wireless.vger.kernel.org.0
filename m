Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07DA2DD553
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgLQQiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:38:04 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:10238 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgLQQiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:38:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608223064; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Vx2C+sbNgyVTbuysVJH2GaPKH7UYBSRxZzN5DSynQGA=;
 b=H0T3k+wIXpUd+0IwSmoxTpg98v8f8jt1Z/KZpw89APmClk77a0S3J285yD48GFZ+G3J6JoLU
 BTieebILU6sS1YV0uEb+StihBP8L5jddQBGg2amXqA51N4281Ay3L6eLOVteSfKC873dNnby
 46Q4NdX1Ro1rW4dmxtKwIexpzpc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fdb89540564dfefcd8d3bb4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 16:37:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65051C433ED; Thu, 17 Dec 2020 16:37:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECDF1C433C6;
        Thu, 17 Dec 2020 16:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECDF1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: mt76u: fix NULL pointer dereference in
 mt76u_status_worker
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <cd44dc407cf3e5f27688105d4a75fb1c68e62b06.1607419147.git.lorenzo@kernel.org>
References: <cd44dc407cf3e5f27688105d4a75fb1c68e62b06.1607419147.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217163739.65051C433ED@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 16:37:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following NULL pointer dereference in mt76u_status_worker that
> can occur if status thread runs before allocating tx queues
> 
> [   31.395373] BUG: kernel NULL pointer dereference, address: 000000000000002c
> [   31.395769] #PF: supervisor read access in kernel mode
> [   31.395985] #PF: error_code(0x0000) - not-present page
> [   31.396178] PGD 0 P4D 0
> [   31.396277] Oops: 0000 [#1] SMP
> [   31.396430] CPU: 3 PID: 337 Comm: mt76-usb-status Not tainted 5.10.0-rc1-kvm+ #49
> [   31.396703] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-3.fc33 04/01/2014
> [   31.397048] RIP: 0010:mt76u_status_worker+0x2b/0x190
> [   31.397931] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
> [   31.398118] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 0000000000000000
> [   31.398400] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff888111203fe8
> [   31.398668] RBP: ffff888111201d00 R08: 000000000000038c R09: 000000000000009b
> [   31.398952] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   31.399235] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c987300
> [   31.399494] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
> [   31.399767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.399991] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000006a0
> [   31.400236] Call Trace:
> [   31.400348]  ? schedule+0x3e/0xa0
> [   31.400514]  __mt76_worker_fn+0x71/0xa0
> [   31.400634]  ? mt76_get_min_avg_rssi+0x110/0x110
> [   31.400827]  kthread+0x118/0x130
> [   31.400984]  ? __kthread_bind_mask+0x60/0x60
> [   31.401212]  ret_from_fork+0x1f/0x30
> [   31.401353] Modules linked in:
> [   31.401480] CR2: 000000000000002c
> [   31.401627] ---[ end trace 8bf174505cc34851 ]---
> [   31.401798] RIP: 0010:mt76u_status_worker+0x2b/0x190
> [   31.402636] RSP: 0018:ffffc9000076fe98 EFLAGS: 00010282
> [   31.402829] RAX: 0000000000000001 RBX: ffff888111203fe8 RCX: 0000000000000000
> [   31.403118] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff888111203fe8
> [   31.403424] RBP: ffff888111201d00 R08: 000000000000038c R09: 000000000000009b
> [   31.403689] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   31.403933] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810c987300
> [   31.404209] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
> [   31.404482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.404726] CR2: 000000000000002c CR3: 0000000103525000 CR4: 00000000000006a0
> [   31.405294] mt76x0u: probe of 1-1:1.0 failed with error -110
> [   31.406007] usb 1-1: USB disconnect, device number 2
> [   31.840756] usb 1-1: new high-speed USB device number 3 using xhci_hcd
> [   32.461295] usb 1-1: reset high-speed USB device number 3 using xhci_hcd
> [   32.659932] mt76x0u 1-1:1.0: ASIC revision: 76100002 MAC revision: 76502000
> [   33.197032] mt76x0u 1-1:1.0: EEPROM ver:02 fae:01
> 
> Fixes: 9daf27e62852 ("mt76: mt76u: use dedicated thread for status work")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

e7f6f893ac39 mt76: mt76u: fix NULL pointer dereference in mt76u_status_worker

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/cd44dc407cf3e5f27688105d4a75fb1c68e62b06.1607419147.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

