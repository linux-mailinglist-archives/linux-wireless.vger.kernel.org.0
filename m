Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB301CBAF7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHWxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 18:53:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53896 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbgEHWxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 18:53:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588978433; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ET434Jh6IAHKYzohsSbQviCIHmAVP273Lv89DYYfyn0=;
 b=COHlTJgS+jrtIawZcClU4UKRwHvie6oV9KDzqwtqBeyC9iAx/Uglzg1kROEyExwpRKhr+4MC
 Hg8N+87F8JCeGbBtNZveUAd5SzjebuqJf410Pzql5KZjfaXsXn//1Pai62y553/jYZyDo4pg
 iaMpQN6WFdaswMoIgf04vfWRX+I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5e2fc.7f387c199030-smtp-out-n01;
 Fri, 08 May 2020 22:53:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4860C433BA; Fri,  8 May 2020 22:53:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3368BC433D2;
        Fri,  8 May 2020 22:53:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 May 2020 15:53:48 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v2 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
In-Reply-To: <1588285252-30034-10-git-send-email-rmanohar@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
 <1588285252-30034-10-git-send-email-rmanohar@codeaurora.org>
Message-ID: <29370be316eca4d5592baeeaa6c1a779@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index b4dfefd482a6..9115dc9c7d78 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -163,6 +163,9 @@ ieee80211_determine_chantype(struct
> ieee80211_sub_if_data *sdata,
>  	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
>  	chandef->center_freq1 = channel->center_freq;
> 
> +	if (channel->band == NL80211_BAND_6GHZ)
> +		goto skip_ht_vht_oper;
> +
>  	if (!ht_oper || !sta_ht_cap.ht_supported) {
>  		ret = IEEE80211_STA_DISABLE_HT |
>  		      IEEE80211_STA_DISABLE_VHT |
> @@ -263,6 +266,15 @@ ieee80211_determine_chantype(struct
> ieee80211_sub_if_data *sdata,
> 
>  	*chandef = vht_chandef;
> 
> +skip_ht_vht_oper:
> +	if (!ieee80211_chandef_he_oper(sdata, he_oper, chandef)) {
> +		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
> +			sdata_info(sdata,
> +				   "AP HE information is invalid, disable HE\n");
> +		ret = IEEE80211_STA_DISABLE_HE;
> +		goto out;
> +	}
> +
Hi Rajkumar,
Above is causing to disable HE in STA mode even when AP supports HE.
Shouldn't this be done only for 6GHz band?
something like below?
if (channel->band == NL80211_BAND_6GHZ &&
     !ieee80211_chandef_he_oper(sdata, he_oper, chandef))

>  	ret = 0;
> 
>  out:
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 90b8c42b1aa8..660cf52913f1 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -3170,6 +3170,98 @@ bool ieee80211_chandef_vht_oper(struct 
> ieee80211_hw *hw,
>  	return true;
>  }
> 
> +bool ieee80211_chandef_he_oper(struct ieee80211_sub_if_data *sdata,
> +			       const struct ieee80211_he_operation *heop,
> +			       struct cfg80211_chan_def *chandef)
> +{
> +	struct ieee80211_he_oper_6ghz_op_info info;
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	struct ieee80211_supported_band *sband;
> +	struct cfg80211_chan_def new = *chandef;
> +	int cf0, cf1;
> +	int ccf0, ccf1;
> +	bool support_80_80;
> +	bool support_160;
> +	u8 he_phy_cap;
> +	u8 pos = 0;
> +
> +	if (!heop)
> +		return false;
> +
> +	sband = ieee80211_get_sband(sdata);
> +	if (!sband)
> +		return false;
> +
> +	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
> +	if (!he_cap)
> +		return false;
> +
or return true here if band is not NL80211_BAND_6GHZ?

> +	if (!(le32_to_cpu(heop->he_oper_params) &
> +				IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
> +		return false;
> +
