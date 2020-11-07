Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D672AA32B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKGIEZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:04:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:40655 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgKGIEY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:04:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604736264; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4bnW9aPUT6dJw+8IsTDjXp4lsbpYRbEg1kaXwCzeWVs=;
 b=JRnPvlRofghk2JucnTs+rZmH8vTD1gWlm57s3KX/sWDbbD/3jJGyr5UPYkwDsxG8gynhc09N
 v/HN5RpQ07SDUg2nqRzRGtEkr6t9RjoZA1kLok0DC7m92dbQk2GnmZ0ENCosgUwUyaW2bpzC
 m+nez/RE8+jnSX+jJS7godwgUqs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa654eb82aad55dcb80b0e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 08:03:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83BE0C433C9; Sat,  7 Nov 2020 08:03:55 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14E6CC433C8;
        Sat,  7 Nov 2020 08:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14E6CC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix number of rules in filtered ETSI regdomain
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201030101940.2387952-1-sven@narfation.org>
References: <20201030101940.2387952-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107080355.83BE0C433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 08:03:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> The ath11k code will try to insert wheather rader related limits when the
> DFS region is set to ETSI. For this reason, it will add two more entries in
> the array of reg_rules. But the 2.4.0.1 firmware is prefiltering the list
> of reg rules it returns for 2.4GHz PHYs. They will then not contain the
> list of 5GHz rules and thus no wheather radar band rules were inserted by
> this code.
> 
> But the code didn't fix the n_reg_rules for this regulatory domain and PHY
> when this happened. This resulted in a rejection by is_valid_rd because it
> found rules which start and end at 0khz. This resulted in a splat like:
> 
>   Invalid regulatory domain detected
>   ------------[ cut here ]------------
>   WARNING: at backports-20200628-4.4.60-9a94b73e75/net/wireless/reg.c:3721
>   [...]
>   ath11k c000000.wifi1: failed to perform regd update : -22
> 
> The number of rules must therefore be saved after they were converted from
> the ath11k format to the ieee80211_regdomain format and not before.
> 
> Tested with IPQ8074 WLAN.HK.2.4.0.1.r1-00019-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6189be7d145c ath11k: Fix number of rules in filtered ETSI regdomain

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201030101940.2387952-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

