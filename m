Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC73F3B8D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhHUQ7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 12:59:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32311 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhHUQ7T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 12:59:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629565119; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ThfIHOL8f9W8Dq/G5jD7jHTrOcelhKtCDeXIg49SAVw=;
 b=svhiAlHqzkizyjcniilij3i8Z8ZMbT0PCXKOzPvQwfNjJIQ2slm+FCS5YlnpCpGnb5L2my1R
 1B+G6ww9wSaKgTAc3jAKYICMc95V+T1mXmi+AWp+sdwsEm4/kXAN5e10+0p6YER5Fz0oYtio
 0I9LzUdCBJ7ZU+IUxtlvOBf77gE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 612130aa1d4eeff4c3f3ba24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 16:58:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5AB80C4360D; Sat, 21 Aug 2021 16:58:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB788C4338F;
        Sat, 21 Aug 2021 16:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AB788C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] brcmfmac: use separate firmware for 43430 revision 2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210804231308.576071-1-mike.rudenko@gmail.com>
References: <20210804231308.576071-1-mike.rudenko@gmail.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821165818.5AB80C4360D@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 16:58:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mikhail Rudenko <mike.rudenko@gmail.com> wrote:

> A separate firmware is needed for Broadcom 43430 revision 2.  This
> chip can be found in e.g. certain revisions of Ampak AP6212 wireless
> IC. Original firmware file from IC vendor is named
> 'fw_bcm43436b0.bin', but brcmfmac and also btbcm drivers report chip
> id 43430, so requested firmware file name is
> 'brcmfmac43430b0-sdio.bin' in line with other 43430 revisions.
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

f8d6523891cf brcmfmac: use separate firmware for 43430 revision 2

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210804231308.576071-1-mike.rudenko@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

