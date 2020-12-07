Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99922D0DF6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLGKZ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 05:25:27 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:61043 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGKZ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 05:25:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607336702; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9RU7bVZIbDlFqSXZBGQbRIuEH+XYkrrRgAj8/hvjBMY=;
 b=UUIdL4FYsYSbX4L1vDYwZN6vXtTaNfpovYVHf8k2uvSleCWIoyBOff5joQ7c2UWQcLWVka43
 dC8FKFSr1Rf6VWZROTkYtaK0zSG35AxwLUafxpPTZExBPmuoPr3JQga/NSGzmW1UDgBu8Tgp
 +r2dcvRvUIghUgG83/4NWDX/l+A=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fce02e17d6a74e4094647e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 10:24:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD525C433C6; Mon,  7 Dec 2020 10:24:32 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2EDD3C433CA;
        Mon,  7 Dec 2020 10:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EDD3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2020-12-04 v2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <f42bcdc1-2cd4-9f44-2889-bbb9e10e038a@nbd.name>
References: <f42bcdc1-2cd4-9f44-2889-bbb9e10e038a@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201207102432.AD525C433C6@smtp.codeaurora.org>
Date:   Mon,  7 Dec 2020 10:24:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> sorry about the last one. Here's the updated PR with the missing 
> S-o-b fixed.
> 
> - Felix
> 
> The following changes since commit 9eb597c74483ad5c230a884449069adfb68285ea:
> 
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-12-02 21:46:55 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-12-04
> 
> for you to fetch changes up to f12758f6f929dbcd37abdb1d91d245539eca48f8:
> 
>   mt76: mt7615: Fix fall-through warnings for Clang (2020-12-04 22:24:54 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.11
> 
> * mt7915 fixes
> * mt7615 fixes
> * support for more sta interfaces on mt7615/mt7915
> * mt7915 encap offload
> * performance improvements
> * channel noise report on mt7915
> * usb/sdio support improvements
> * mt7915 testmode support
> * mt7915 DBDC support
> * warning fixes
> 
> ----------------------------------------------------------------

This conflicted with commit 807982017730 ("mt76: usb: fix crash on device
removal") from wireless-drivers. I fixed with a diff below and pushed it to the
pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=f4a243bfdb0d9afc850d35755dc0bae0b980b4ac

Please double check my resolution. Also I wonder should the usb.status_worker
have a similar fix as tx_worker had? If yes, someone please send a followup
patch for that.

diff --cc drivers/net/wireless/mediatek/mt76/usb.c
index f1ae9ff835b2,81393788f98e..000000000000
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@@ -1020,6 -1039,9 +1039,8 @@@ void mt76u_stop_tx(struct mt76_dev *dev
  {
        int ret;
  
 -      mt76_worker_disable(&dev->tx_worker);
+       mt76_worker_disable(&dev->usb.status_worker);
+ 
        ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
                                 HZ / 5);
        if (!ret) {
@@@ -1061,6 -1078,9 +1082,8 @@@
        cancel_work_sync(&dev->usb.stat_work);
        clear_bit(MT76_READING_STATS, &dev->phy.state);
  
 -      mt76_worker_enable(&dev->tx_worker);
+       mt76_worker_enable(&dev->usb.status_worker);
+ 
        mt76_tx_status_check(dev, NULL, true);
  }
  EXPORT_SYMBOL_GPL(mt76u_stop_tx);



-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f42bcdc1-2cd4-9f44-2889-bbb9e10e038a@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

