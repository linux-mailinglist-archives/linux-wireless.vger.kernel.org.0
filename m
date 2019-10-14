Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5754ED5F17
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfJNJin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:38:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbfJNJin (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:38:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4006606CF; Mon, 14 Oct 2019 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045921;
        bh=Y/WUmvxtt2ct72xivy/HB/JPyDxQNH0PBfGq2Jt3EBg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JGLe5m3njmhNqMGIyZFFHfFRLjlAGIF2/PSKTk8sBPehWf82ZhahZod8cHpQagD6A
         D5Lda/8j6k4fKiyRdoSjJptiVOPLp90Md9N3c65HzAzJu+FRu7exIkdVSLz3MiiwSZ
         /RA5EK3yses3D8b1CLBCoqM9g6itCcMjeXxW9U8I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 901CE60159;
        Mon, 14 Oct 2019 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571045921;
        bh=Y/WUmvxtt2ct72xivy/HB/JPyDxQNH0PBfGq2Jt3EBg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JGLe5m3njmhNqMGIyZFFHfFRLjlAGIF2/PSKTk8sBPehWf82ZhahZod8cHpQagD6A
         D5Lda/8j6k4fKiyRdoSjJptiVOPLp90Md9N3c65HzAzJu+FRu7exIkdVSLz3MiiwSZ
         /RA5EK3yses3D8b1CLBCoqM9g6itCcMjeXxW9U8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 901CE60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: Re: [PATCH 02/10] rtw88: Enable 802.11ac beamformee support
References: <20191008082101.2494-1-yhchuang@realtek.com>
        <20191008082101.2494-3-yhchuang@realtek.com>
Date:   Mon, 14 Oct 2019 12:38:36 +0300
In-Reply-To: <20191008082101.2494-3-yhchuang@realtek.com> (yhchuang's message
        of "Tue, 8 Oct 2019 16:20:53 +0800")
Message-ID: <87v9srfyzn.fsf@tynnyri.adurom.net>
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
> Enable MU-MIMO transmit beamformee support for chipset 8822b and 8822c.
>
> If the rtw88 is in station mode and associated with an AP, and the
> capabilities of both meet the requirement of beamforming, driver will
> run as a beamformee and the corresponding chip settings will be set.
>
> In addition, module parameter support_bf is added to enable or disable
> beamforming.

Why do you need a module parameter? Module paramaters are not meant to
be replacement for ini files, where you have a setting to enable or
disable each future. Module parameters should be added only for really
good reasons.

> +void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> +		  struct ieee80211_bss_conf *bss_conf)
> +{
> +	struct ieee80211_hw *hw = rtwdev->hw;
> +	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
> +	struct rtw_bfee *bfee = &rtwvif->bfee;
> +	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
> +	struct rtw_chip_info *chip = rtwdev->chip;
> +	struct ieee80211_sta *sta;
> +	struct ieee80211_sta_vht_cap vht_cap;
> +	struct ieee80211_sta_vht_cap ic_vht_cap;
> +	u32 sound_dim;
> +	u8 *bssid, i;
> +
> +	if (chip->band & RTW_BAND_5G) {
> +		ic_vht_cap = hw->wiphy->bands[NL80211_BAND_5GHZ]->vht_cap;
> +		if (!(ic_vht_cap.cap &
> +		      (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
> +		       IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE)))
> +			goto exit;
> +	} else {
> +		goto exit;
> +	}
> +
> +	bssid = (u8 *)bss_conf->bssid;

This cast looks very fishy, you are again casting away const. Like I
said in patch 1, avoid casts as much as possible. They are fragile and
can easily create bugs if you are not careful.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
