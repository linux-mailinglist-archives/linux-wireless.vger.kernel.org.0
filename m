Return-Path: <linux-wireless+bounces-33647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JpNBWLwvml1kwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:24:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3022E6F5E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 083943006B69
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0131F98E;
	Sat, 21 Mar 2026 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDh6twUn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDB32D45C
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121054; cv=none; b=fwwqLrhrt30MUTw/pdoivPkLEUaSh7IqghHhhFKrOWjtEwK0pyny1xmFugIbI+3JwPyLEmmjKMWQXL57fI3WWveGX5DazDYWr/JID9Ky3FoAkkNwCd/tvjrf5YfRpdQpZ3NvZjBYENqBR1xCfc4tCBGAaIwobzzSJzeaMNI7lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121054; c=relaxed/simple;
	bh=N06lp4c+36SwyttTwgk/mHRuAUopAHwzioAO+/pEwqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxNSpllkXaNwzFmGfJjhzpocieWRuszl3f8tELxvllJYLX9YJazCvsZwfhfn2h1c0V6lTOSanJln1TC/KATiGGYC3SFImfo3lparRG1AGg7e0oeWygkDu+dX4RBm2GsjJIAQpFXOTgFg2yFfJT4C1c+YyGTsTwMKovMjRRBWGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDh6twUn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fe655187so22202255e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774121049; x=1774725849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDP4HG7V+xE7MNLowJHASJyeM7Q4R/c1m2N1pjMkx1o=;
        b=HDh6twUnuF7X9o8ZhXubJFqbv1P4/ze1S40QxS7kvfmP9BaY44RVBAGtuXYAach7eE
         /ZiGWL3UEJgvKbbnMroO5x+EGa8kIm581maG3w4XKMjtjMcojefrr2cwndUAZ//Ao2Nt
         xLQ927BsrLSoSzofNY1h/S5R/XLN/eJURcPKHoCyEZubKuRn94irxQNPEaM6HjcQNzjv
         sJlc0+fbfL0P9d5fxbuSWxMdp9lRH4QoBX6u7oDetGrIqI85GxrMo98oEqGMlTZPI7VW
         z6O5KrYFDyFabTioLKuseA9EhNsiGmRxSRtCUDGWK90TOwMnbYppgel8k+J3T0+Bs1Tp
         2NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774121049; x=1774725849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDP4HG7V+xE7MNLowJHASJyeM7Q4R/c1m2N1pjMkx1o=;
        b=cmjEfjbwJQJB9aVrzf1Ipm4LepkwiVSGyEQTJ3Aq/3TVy5IPnIsOSL8n+s+RJEGDdX
         J2xNR3vb7JSC0GrPNgJyA9Yaer5TvqQpFS+EaGWb3p3Hat7ngFWljxPkpTrZeoYfJufw
         bWos+qWP09B7MWLcUEwyKQqnl0X+RHDpoB1W64xnHplZ5m1gHsWXXo8cAUNd1oLOdM59
         CpJ4wK5FO7l2IIvb6AB+rTcwTasMtBOEC/bdcMH6NJ4SZIIc25lyjMYcxGyBCw28zIUH
         9ej6WAN/fol9IYP6lAfaE424hK18tbwBm9uNnOl88dxXbD9DsWCT6aTdZzffAf2NxChK
         jgbw==
X-Gm-Message-State: AOJu0YwxbwMe59x1cuwqgQnoz/GvjyOEmEAam/w9MzG4lL5hGryT2Giv
	LB26UHWX+RRBgJLi60hJS7yZpTJOdVgLuOD/Hn8mIN7Xz/K4HRWa9nMJ
X-Gm-Gg: ATEYQzyApDXQEGON8L3wZSfNKUxXeIjB+gudIfTIfxC9OGxNRd1o9C0gybgwMazkqoX
	YS97ZsoZWQTdQzwfXcPO8T/Oh+aOxX+K/TI2EOOAyYkRZo32UI0rbpvGnEGppE55e9Zffmru8kw
	yOllkiFpjMJiwQz1HTW3X/rIJxGuFJRT3WSNMAnhsIThQZZ71i86tTUzbST6Vlx0cinnW+8t01F
	Yt5Ow8ybNB0x1fmag5e6hucWlDFpa41GIasoHKFzBms3gY5sjYL48H/FUmI6vifUXinUsCrVFvU
	KtUFs6NUqEdWqxD15LKoLYbUbVjwEum+7IZ7vUGhrOf+zMwLeFQDVWS4GN+XFcrT1g6kUMv1ivh
	00Tlszonki/vKwrxa4MUgyYaOKcb7yshixQLhwGg8RfwNm3HYavMOehHMtKnB3BEK2AWPvxNSbc
	3Wn28ZUouFWYpV+bSR+I7e+xvvQ+BVlrfov5SAN75yYFr68WoQtkPzs3smVJegHwYlCOhUWJrdu
	hr+nG5+pnvdSXHw6aaik//oXUhpJauDLJAc5O6RwKE=
X-Received: by 2002:a05:600c:a402:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-486fedb546amr78815995e9.13.1774121048924;
        Sat, 21 Mar 2026 12:24:08 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d91fbsm153632765e9.3.2026.03.21.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:24:08 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w41sz-00000001NSQ-49GL;
	Sat, 21 Mar 2026 20:24:07 +0100
Message-ID: <ec4490af-1156-41b0-9df1-770fe8be6f91@gmail.com>
Date: Sat, 21 Mar 2026 20:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] carl9170: phy: populate per-channel TX power from
 EEPROM
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6E8EAEDB73BAB87748A8C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6E8EAEDB73BAB87748A8C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33647-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email]
X-Rspamd-Queue-Id: AE3022E6F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> Replace the hardcoded max_power = 18 dBm (marked XXX) in the
> channel definitions with actual per-channel values derived from
> the EEPROM calibration target power tables.
> 
> The new carl9170_get_max_tgt_power() function interpolates the
> maximum target power for a given frequency from the EEPROM's
> legacy OFDM and CCK target power tables, using the same frequency
> encoding and interpolation helpers already used by the power
> calibration code.  carl9170_update_channel_maxpower() iterates
> all registered channels and updates their max_power fields.


Why the need for interpolation here? Don't you just need to look
for the max(ctpl[idx].power, previous_value) within the band?

I'm not aware of any high-powered AR9170 devices. Were/are there any?

Cheers,
Christian

> 
> This is called during EEPROM parsing, so mac80211 and userspace
> see correct per-channel power limits from the start.  The CHAN
> macro default of 18 dBm remains as a safe fallback for channels
> where EEPROM data is missing.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
>   drivers/net/wireless/ath/carl9170/main.c     |  4 +-
>   drivers/net/wireless/ath/carl9170/phy.c      | 88 ++++++++++++++++++++
>   3 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> index eaac859..a2ffa62 100644
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> @@ -602,6 +602,7 @@ int carl9170_led_set_state(struct ar9170 *ar, const u32 led_state);
>   int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
>   			 enum nl80211_channel_type bw);
>   int carl9170_get_noisefloor(struct ar9170 *ar);
> +void carl9170_update_channel_maxpower(struct ar9170 *ar);
>   
>   /* FW */
>   int carl9170_parse_firmware(struct ar9170 *ar);
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index d75688c..dcedcb1 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -89,7 +89,7 @@ struct ieee80211_rate __carl9170_ratetable[] = {
>   #define CHAN(_freq, _idx) {		\
>   	.center_freq	= (_freq),	\
>   	.hw_value	= (_idx),	\
> -	.max_power	= 18, /* XXX */	\
> +	.max_power	= 18,		\
>   }
>   
>   static struct ieee80211_channel carl9170_2ghz_chantable[] = {
> @@ -1930,6 +1930,8 @@ static int carl9170_parse_eeprom(struct ar9170 *ar)
>   	if (!bands)
>   		return -EINVAL;
>   
> +	carl9170_update_channel_maxpower(ar);
> +
>   	ar->survey = devm_kcalloc(&ar->udev->dev, chans,
>   				  sizeof(struct survey_info), GFP_KERNEL);
>   	if (!ar->survey)
> diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
> index 34d9fd7..290c336 100644
> --- a/drivers/net/wireless/ath/carl9170/phy.c
> +++ b/drivers/net/wireless/ath/carl9170/phy.c
> @@ -1524,6 +1524,94 @@ static void carl9170_set_power_cal(struct ar9170 *ar, u32 freq,
>   	carl9170_calc_ctl(ar, freq, bw);
>   }
>   
> +static u8 carl9170_get_max_tgt_power(struct ar9170 *ar, u32 freq)
> +{
> +	struct ar9170_calibration_target_power_legacy *ctpl;
> +	int ntargets, idx, n, i;
> +	u8 f, max_power = 0;
> +	u8 pwr_freqs[AR5416_MAX_NUM_TGT_PWRS];
> +
> +	if (freq < 3000)
> +		f = freq - 2300;
> +	else
> +		f = (freq - 4800) / 5;
> +
> +	/* check legacy target powers (OFDM for 2G, 5G leg) */
> +	for (i = 0; i < 2; i++) {
> +		switch (i) {
> +		case 0:
> +			if (freq >= 3000) {
> +				ctpl = &ar->eeprom.cal_tgt_pwr_5G[0];
> +				ntargets = AR5416_NUM_5G_TARGET_PWRS;
> +			} else {
> +				ctpl = &ar->eeprom.cal_tgt_pwr_2G_ofdm[0];
> +				ntargets = AR5416_NUM_2G_OFDM_TARGET_PWRS;
> +			}
> +			break;
> +		case 1:
> +			if (freq < 3000) {
> +				ctpl = &ar->eeprom.cal_tgt_pwr_2G_cck[0];
> +				ntargets = AR5416_NUM_2G_CCK_TARGET_PWRS;
> +			} else {
> +				continue;
> +			}
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		for (n = 0; n < ntargets; n++) {
> +			if (ctpl[n].freq == 0xff)
> +				break;
> +			pwr_freqs[n] = ctpl[n].freq;
> +		}
> +		ntargets = n;
> +		if (ntargets < 2)
> +			continue;
> +
> +		idx = carl9170_find_freq_idx(ntargets, pwr_freqs, f);
> +		for (n = 0; n < 4; n++) {
> +			u8 pwr;
> +
> +			pwr = carl9170_interpolate_u8(f,
> +						     ctpl[idx + 0].freq,
> +						     ctpl[idx + 0].power[n],
> +						     ctpl[idx + 1].freq,
> +						     ctpl[idx + 1].power[n]);
> +			max_power = max(max_power, pwr);
> +		}
> +	}
> +
> +	/* target power is in half-dBm, max_power is in dBm */
> +	return max_power / 2;
> +}
> +
> +void carl9170_update_channel_maxpower(struct ar9170 *ar)
> +{
> +	struct ieee80211_supported_band *band;
> +	int i;
> +
> +	band = ar->hw->wiphy->bands[NL80211_BAND_2GHZ];
> +	if (band) {
> +		for (i = 0; i < band->n_channels; i++) {
> +			u8 pwr = carl9170_get_max_tgt_power(ar,
> +				band->channels[i].center_freq);
> +			if (pwr)
> +				band->channels[i].max_power = pwr;
> +		}
> +	}
> +
> +	band = ar->hw->wiphy->bands[NL80211_BAND_5GHZ];
> +	if (band) {
> +		for (i = 0; i < band->n_channels; i++) {
> +			u8 pwr = carl9170_get_max_tgt_power(ar,
> +				band->channels[i].center_freq);
> +			if (pwr)
> +				band->channels[i].max_power = pwr;
> +		}
> +	}
> +}
> +
>   int carl9170_get_noisefloor(struct ar9170 *ar)
>   {
>   	static const u32 phy_regs[] = {


