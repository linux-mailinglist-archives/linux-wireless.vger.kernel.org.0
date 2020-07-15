Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0262207C7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgGOIuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 04:50:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729618AbgGOIuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 04:50:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594803053; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cAWvSEXhFpcYlZMxj97lK9Uq5eEsGnpChzGFhVB6wo0=; b=eXBrz3jaTguj/zDCjO22MFeuEAEpnJ0O0MI1rJIb/eKinITsfeGJIFpGgmGjs2i14ZPDI2mk
 jt1UokwOCpjCLXrYIa2fU0/XBjEPAWXvKzOADg86zEE0dNXrH6Fdeu/awOQOvImZjgo39Kbo
 COycHvuSBBYYoEfmzFLmGGp+uH4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f0ec36c75eeb235f64c53e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 08:50:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A6ABC433C6; Wed, 15 Jul 2020 08:50:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E7E3C433CA;
        Wed, 15 Jul 2020 08:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E7E3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <tehuang@realtek.com>, <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
References: <20200603094218.19942-1-yhchuang@realtek.com>
        <20200603094218.19942-2-yhchuang@realtek.com>
Date:   Wed, 15 Jul 2020 11:50:47 +0300
In-Reply-To: <20200603094218.19942-2-yhchuang@realtek.com> (yhchuang's message
        of "Wed, 3 Jun 2020 17:42:14 +0800")
Message-ID: <87r1tdb1qw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Tzu-En Huang <tehuang@realtek.com>
>
> CCK PD can reduce the number of false alarm of the CCK rates.
> It dynamically adjusts the power threshold and CS ratio.
> The values are compared to the values of the previous level, if
> the level is changed, set new values of power threshold and CS
> ratio.
>
> Implement rtw_chip_ops::cck_pd_set() for 8821c.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -102,6 +102,7 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
>  	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER, MASKDWORD);
>  
>  	rtw_phy_init(rtwdev);
> +	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) & 0x1f;
>  }
>  
>  static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
> @@ -596,6 +597,29 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
>  	rtw8821c_do_iqk(rtwdev);
>  }
>  
> +static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
> +{
> +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
> +
> +	if (dm_info->min_rssi > 60) {
> +		new_lvl = 4;
> +		pd[4] = 0x1d;
> +		goto set_cck_pd;
> +	}
> +
> +	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] == new_lvl)
> +		return;
> +
> +	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
> +
> +set_cck_pd:
> +	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
> +	rtw_write32_mask(rtwdev, REG_PWRTH, 0x3f0000, pd[new_lvl]);
> +	rtw_write32_mask(rtwdev, REG_PWRTH2, 0x1f0000,
> +			 dm_info->cck_pd_default + new_lvl * 2);
> +}

I'm starting to see the trend of using magic values in rtw88 on the rise
again. Please be careful with this, the source code should not be full
of undocument values. In some special cases (eg calibration data etc)
using undocumented values is ok, but most of cases should have proper
defines for documenting what's happening.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
