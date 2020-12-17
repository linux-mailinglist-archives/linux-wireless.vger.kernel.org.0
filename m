Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A969A2DD555
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgLQQiu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:38:50 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:44206 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:38:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608223110; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Xg9MEWAHElZcDTMwerb+8DDdxVXFnWzkVVWchBYm6RE=;
 b=GYBiCfl4d7Jq6hUbGXxdzDrg0///cfbHXmBtJU2FQVtOYx9tZJXNy4Xioy3GlpQOuXWxjEPA
 WjptexQqYUZSGdXsYxjibp+tZw20WNZLWgZPS10gT5NJDT6Bv2T3CN7nV1sck6i7EIhFXHCw
 D8ow6TsZMBCYVmsaN4lmHX4FJ6Y=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fdb896b031793dcb416b8f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 16:38:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25D23C43461; Thu, 17 Dec 2020 16:38:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0348C433CA;
        Thu, 17 Dec 2020 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0348C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtlwifi: rise completion at the last step of firmware
 callback
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201214053106.7748-1-pkshih@realtek.com>
References: <20201214053106.7748-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201217163802.25D23C43461@smtp.codeaurora.org>
Date:   Thu, 17 Dec 2020 16:38:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> request_firmware_nowait() which schedules another work is used to load
> firmware when USB is probing. If USB is unplugged before running the
> firmware work, it goes disconnect ops, and then causes use-after-free.
> Though we wait for completion of firmware work before freeing the hw,
> firmware callback rises completion too early. So I move it to the
> last step.
> 
> usb 5-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
> rtlwifi: Loading alternative firmware rtlwifi/rtl8192cufw.bin
> rtlwifi: Selected firmware is not available
> ==================================================================
> BUG: KASAN: use-after-free in rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
> Write of size 4 at addr ffff8881454cff50 by task kworker/0:6/7379
> 
> CPU: 0 PID: 7379 Comm: kworker/0:6 Not tainted 5.10.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events request_firmware_work_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
>  __kasan_report mm/kasan/report.c:545 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
>  rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
>  request_firmware_work_func+0x12c/0x230 drivers/base/firmware_loader/main.c:1079
>  process_one_work+0x933/0x1520 kernel/workqueue.c:2272
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
>  kthread+0x38c/0x460 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> The buggy address belongs to the page:
> page:00000000f54435b3 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1454cf
> flags: 0x200000000000000()
> raw: 0200000000000000 0000000000000000 ffffea00051533c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8881454cfe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8881454cfe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff8881454cff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                                  ^
>  ffff8881454cff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8881454d0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Reported-by: syzbot+65be4277f3c489293939@syzkaller.appspotmail.com
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers.git, thanks.

4dfde294b979 rtlwifi: rise completion at the last step of firmware callback

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201214053106.7748-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

