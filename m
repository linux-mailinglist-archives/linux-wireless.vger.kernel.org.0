Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3896D2C670
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE1M0v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:26:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1M0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:26:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D35960A05; Tue, 28 May 2019 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046410;
        bh=j4dKDn9bgtvYEkraFF5UTv+7sZn2waN2LnSfkgwzPsw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fU5b4ZEr0utjTpLqGxM4ZvR3rqW8AdFTpqnhAyAHOYAUWjIyRq9ZQUSwPL7jw/Pa3
         1YrpzZszp3jJnu5lIa59t7Qmt7gtjiMcoH/Q/MQuyzk0+5dJW4CBqeT9Lxr+scWstj
         9pINXCVO9Ru7fk/HJSLVHX5pLY1nUWSPRCr+m5Rg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B933C6086B;
        Tue, 28 May 2019 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046409;
        bh=j4dKDn9bgtvYEkraFF5UTv+7sZn2waN2LnSfkgwzPsw=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=DK3nm9wFt6CjnZ25xM/E5fIKkMYUZ0bR/gVPpBKKe2JGf8rr6ewldIrmb4CfmbrDi
         n5DG9MYTEj39vfil+2uU9Ya12SUTHcDZ5V5W+Pb4hJ/YrBtIvcn0fIPC2xw6b0U3k/
         5sQpZ3jL4KiPw2d6Ghnr1Xlp0EZFN/IEEiMeYaWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B933C6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] p54: fix crash during initialization
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190518200548.7662-1-chunkeey@gmail.com>
References: <20190518200548.7662-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528122650.1D35960A05@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:26:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch fixes a crash that got introduced when the
> mentioned patch replaced  the direct list_head access
> with skb_peek_tail(). When the device is starting up,
> there are  no entries in  the queue, so previously to
> "Use skb_peek_tail() instead..." the target_skb would
> end up as the  tail and head pointer which then could
> be used by __skb_queue_after to fill the empty queue.
> 
> With skb_peek_tail() in its place will instead just
> return NULL which then causes a crash in the
> __skb_queue_after().
> 
> | BUG: unable to handle kernel NULL pointer dereference at 000000
> | #PF error: [normal kernel read fault]
> | PGD 0 P4D 0
> | Oops: 0000 [#1] SMP PTI
> | CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: GO   5.1.0-rc7-wt+ #218
> | Hardware name: MSI MS-7816/Z87-G43 (MS-7816), BIOS V1.11 05/09/2015
> | Workqueue: events request_firmware_work_func
> | RIP: 0010:p54_tx_pending+0x10f/0x1b0 [p54common]
> | Code: 78 06 80 78 28 00 74 6d <48> 8b 07 49 89 7c 24 08 49 89 04 24 4
> | RSP: 0018:ffffa81c81927d90 EFLAGS: 00010086
> | RAX: ffff9bbaaf131048 RBX: 0000000000020670 RCX: 0000000000020264
> | RDX: ffff9bbaa976d660 RSI: 0000000000000202 RDI: 0000000000000000
> | RBP: ffff9bbaa976d620 R08: 00000000000006c0 R09: ffff9bbaa976d660
> | R10: 0000000000000000 R11: ffffe8480dbc5900 R12: ffff9bbb45e87700
> | R13: ffff9bbaa976d648 R14: ffff9bbaa976d674 R15: ffff9bbaaf131048
> | FS:  0000000000000000(0000) GS:ffff9bbb5ec00000(0000) knlGS:00000
> | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> | CR2: 0000000000000000 CR3: 00000003695fc003 CR4: 00000000001606f0
> | Call Trace:
> |  p54_download_eeprom+0xbe/0x120 [p54common]
> |  p54_read_eeprom+0x7f/0xc0 [p54common]
> |  p54u_load_firmware_cb+0xe0/0x160 [p54usb]
> |  request_firmware_work_func+0x42/0x80
> |  process_one_work+0x1f5/0x3f0
> |  worker_thread+0x28/0x3c0
> 
> Cc: stable@vger.kernel.org
> Fixes: e3554197fc8f ("p54: Use skb_peek_tail() instead of direct head pointer accesses.")
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

1645ab931998 p54: fix crash during initialization

-- 
https://patchwork.kernel.org/patch/10949055/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

