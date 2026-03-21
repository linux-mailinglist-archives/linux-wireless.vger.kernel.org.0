Return-Path: <linux-wireless+bounces-33649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OGFN3L7vmlknQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:11:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403312E720C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFAB1300BD97
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A636AB72;
	Sat, 21 Mar 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPmZKSj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D452361679
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123888; cv=none; b=X+hCXBkBLoynuyrUj1GHX8NUahM3GNd9m66lELD/VvEcbbT6ez+3gRBmcgt20bqNi60puz/FCRAtS0X67o4K+VTHBWS9zczpNw7NkrlxMCwSMWEheM+DX2hIT2VD9nJRJGwSeeCRr2Qb0CyrUKvr89l2kcatmSbHCg0v/tfr6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123888; c=relaxed/simple;
	bh=cBuHMpy5UUKizEIEYvpxPdsMht/LloxUfefqT5HPX/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rql8t05hWtY1CFpg7Dlogx6TIqHzItHNoHApeIu5+ZfW4yBicXzTaWty28ND2cu4n/MLOcyFOVdZujCQLQco2JbsMlbuZzEyIJDQDY2xQmQxSZ7uOLwsh5KAW+GpJ0t/4xaR1ro248BPwDLxkoP35h3bCgFOghdBbW7KZOH0taU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPmZKSj5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1967082f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774123885; x=1774728685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVjjk03GALD+cgsNgifk6fqg2nyEid7i6csmiC3UezY=;
        b=aPmZKSj5bOIad6RABhZQ4ucB4jcxif3bDrfrZQJJn8euIBIXt8K55gn/hDvLq8DNHI
         b2PGQNpDuRtmpeB6mum1wpC2X129CsqigF6a8b9sa3Hcnk26KSOBlflcBa36oJHHalms
         CRDbxeQmU6LBBKFlKJPvqQu1AaPTOqaSoxTOEpe11Sy24s/zJ7MAeddqIZFY8EpO8Wd6
         be29UCf6UJBeYYZvD5FEMdJMWTInqEQFoy15xwaGU8B0shpAn6yYZxGHIDMNDzy9kywj
         EObl+aGhqwcv0VSJ1CUYFs5uft1URDZU0g1adJNi5tAbQ7DulNkUqA3HKF+JYDLfT2Fr
         QYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774123885; x=1774728685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVjjk03GALD+cgsNgifk6fqg2nyEid7i6csmiC3UezY=;
        b=g+VLMLYW9BvyXx16/WK5w8P+wbQvNf02oXyee/f6F2Ztsx32iizUGFZ6ofd+5sLql4
         HIblLmU8460Sns+8+JahlLWkq70k7zbmx7snUhM0sgSvZbuVCrUROOqmIE/X+1P3KJd3
         WDj6z1J6m2diOgtDGLt0GdBbFz2oBf4jjzCU4s4f5vpEDh9UBQR7EFX9kSEolNTnNCGg
         FqvO0NTjE9CJXsbzY2bbXjlCJ0RrH1jlk5LJF85+PgrlWbpPlOpIymlbeobVfCzDfAJ0
         OB6avh4HefreHO7LDctE4PZtvOFbF59RLXuEPocR+GlX69PyGFqS+Ry1/r08D5b3IVa9
         UYvw==
X-Gm-Message-State: AOJu0YxDFIb1WDKzpYh5O1m2KVRHWZ5J/GwWh/by4HOaH0U3EY961clW
	S9s83RAdquTLQPb7zFAgsNOQTfuFIPI2K/ws6FF8nRkgMJgIeqr8lOfCqE/emg==
X-Gm-Gg: ATEYQzxb7Kenm1s4hSRIKnvnao/ZTJH8k6ST9yAZk7Zl1G8P/J4fJnlohOOwUpuLTQN
	+zgWAXNcvwIAPV0okszMmv6wBiQZz/0BAfjjKTPBe5tqGrLoeu4QwD733hZ4UkWYYVMq5+AUWLC
	BkYqt4jUikzgS/xEaQws4HhOW8wmCarpLpof463QDbdDp5uPhqbVbhmjKh6xfypMxkJSRt3HkZZ
	INTQxElzOB+nOl0ea+yri6AHwBwibRFf/kKcrVjLG6ju+NQwNp+l8cziqHFg0a3TM/3yGQp7UV5
	Pb7rP8CytXeFkngvOfN/mNXBQEYSZuKp+HOT3r2fu+S4j7W5nIUrZdVBuXDUS7NaTBd5XyjA2aD
	BYaKqs11TWhsVfy2/+25xqTa23Jf1A5meKyb9m0pyvqsn01tEZhBunROVxxF2AGP5AmMV9WxJk2
	PfuvPNxui8Yob4Di9rZQmjHHIj0ZMTGsWrbH7/hfTntV+AVHT4WTZZlnfyVo+tDVCwzNf/38fLG
	Wt9MXRPtVxf11Ye9xQJwIlGaEfokGZs
X-Received: by 2002:a05:600c:3514:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-486fedb54cdmr101881855e9.9.1774123884791;
        Sat, 21 Mar 2026 13:11:24 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fd9845a2sm292393045e9.6.2026.03.21.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:11:24 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w42ci-00000001NvL-3ASr;
	Sat, 21 Mar 2026 21:11:22 +0100
Message-ID: <093b7bad-2ecc-47af-9763-958283a102d6@gmail.com>
Date: Sat, 21 Mar 2026 21:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] carl9170: fw: enable DFS radar detection
To: Masi Osmani <mas-i@hotmail.de>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33649-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 403312E720C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> Enable DFS (Dynamic Frequency Selection) radar detection on the
> AR9170.  The hardware has radar detection registers (RADAR_0,
> RADAR_1, RADAR_EXT) and the firmware already sends
> CARL9170_RSP_RADAR events, but the driver never programmed the
> detection parameters and only logged a "please report" message.
> 
> Changes:
> - Program radar detection pulse parameters in phy.c when the
>    current channel has IEEE80211_CHAN_RADAR set.  Values are
>    based on ath9k defaults for FCC/ETSI compliance.

Which values did you use? The best I can find are in ar5008_phy.c
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/ar5008_phy.c?h=v7.0-rc4#n1268>


|	conf->fir_power = -33;
|	conf->radar_rssi = 20;
|	conf->pulse_height = 10;
|	conf->pulse_rssi = 15;
|	conf->pulse_inband = 15;
|	conf->pulse_maxlen = 255;
|	conf->pulse_inband_step = 12;
|	conf->radar_inband = 8;

the one in the patch look a little bit different.
Can I ask, how did you tune them? Do you have a setup to mimic
those air-port or weather radars? Or are you living close to one?

> - Advertise radar_detect_widths in the interface combination
>    (fw.c) for 20 MHz noHT, 20 MHz HT, and 40 MHz HT.
> - Replace the old "please report" message with a call to
>    ieee80211_radar_detected() so mac80211 can trigger the
>    proper DFS state machine (channel switch / CAC).
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/fw.c  |  3 ++
>   drivers/net/wireless/ath/carl9170/phy.c | 45 +++++++++++++++++++++++++
>   drivers/net/wireless/ath/carl9170/rx.c  |  7 ++--
>   3 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
> index 419f553..a730593 100644
> --- a/drivers/net/wireless/ath/carl9170/fw.c
> +++ b/drivers/net/wireless/ath/carl9170/fw.c
> @@ -215,6 +215,9 @@ static void carl9170_fw_set_if_combinations(struct ar9170 *ar,
>   	ar->if_combs[0].max_interfaces = ar->fw.vif_num;
>   	ar->if_combs[0].limits = ar->if_comb_limits;
>   	ar->if_combs[0].n_limits = ARRAY_SIZE(ar->if_comb_limits);
> +	ar->if_combs[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
> +					      BIT(NL80211_CHAN_WIDTH_20) |
> +					      BIT(NL80211_CHAN_WIDTH_40);
>   
>   	ar->hw->wiphy->iface_combinations = ar->if_combs;
>   	ar->hw->wiphy->n_iface_combinations = ARRAY_SIZE(ar->if_combs);
> diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
> index bcd9066..c294df7 100644
> --- a/drivers/net/wireless/ath/carl9170/phy.c
> +++ b/drivers/net/wireless/ath/carl9170/phy.c
> @@ -1637,6 +1637,47 @@ void carl9170_update_channel_maxpower(struct ar9170 *ar)
>   	}
>   }
>   
> +static int carl9170_set_radar_detection(struct ar9170 *ar,
> +					struct ieee80211_channel *channel)
> +{
> +	bool enable = channel->flags & IEEE80211_CHAN_RADAR;
> +
> +	carl9170_regwrite_begin(ar);
> +
> +	if (enable) {
> +		/*
> +		 * Configure radar detection pulse parameters.
> +		 * Values based on ath9k's defaults for FCC/ETSI.
> +		 */
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_0,
> +				  AR9170_PHY_RADAR_0_ENA |
> +				  AR9170_PHY_RADAR_0_FFT_ENA |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_0_INBAND, 5) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_0_PRSSI, 1) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_0_HEIGHT, 6) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_0_RRSSI, 12) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_0_FIRPWR, 33));
> +
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_1,
> +				  AR9170_PHY_RADAR_1_MAX_RRSSI |
> +				  AR9170_PHY_RADAR_1_BLOCK_CHECK |
> +				  AR9170_PHY_RADAR_1_RELSTEP_CHECK |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_1_RELSTEP_THRESH, 8) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_1_RELPWR_THRESH, 12) |
> +				  SET_CONSTVAL(AR9170_PHY_RADAR_1_MAXLEN, 255));
> +
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_EXT,
> +				  AR9170_PHY_RADAR_EXT_ENA);


This seems to be based on ar5008_hw_set_radar_params except that:

|	if (conf->ext_channel)
|		REG_SET_BIT(ah, AR_PHY_RADAR_EXT, AR_PHY_RADAR_EXT_ENA);
|	else
|		REG_CLR_BIT(ah, AR_PHY_RADAR_EXT, AR_PHY_RADAR_EXT_ENA);

you always set the EXT_ENA bit?


> +	} else {
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_0, 0);
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_1, 0);
> +		carl9170_regwrite(AR9170_PHY_REG_RADAR_EXT, 0);
> +	}
> +
> +	carl9170_regwrite_finish();
> +	return carl9170_regwrite_result();
> +}
> +
>   int carl9170_get_noisefloor(struct ar9170 *ar)
>   {
>   	static const u32 phy_regs[] = {
> @@ -1739,6 +1780,10 @@ int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
>   	if (err)
>   		return err;
>   
> +	err = carl9170_set_radar_detection(ar, channel);
> +	if (err)
> +		return err;
> +
>   	tmp = AR9170_PHY_TURBO_FC_SINGLE_HT_LTF1 |
>   	      AR9170_PHY_TURBO_FC_HT_EN;
>   
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index bb909b5..1fe727c 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -259,11 +259,8 @@ void carl9170_handle_command_response(struct ar9170 *ar, void *buf, u32 len)
>   		break;
>   
>   	case CARL9170_RSP_RADAR:
> -		if (!net_ratelimit())
> -			break;
> -
> -		wiphy_info(ar->hw->wiphy, "FW: RADAR! Please report this "
> -		       "incident to linux-wireless@vger.kernel.org !\n");
> +		wiphy_info(ar->hw->wiphy, "FW: radar pulse detected\n");
> +		ieee80211_radar_detected(ar->hw, NULL);
>   		break;
>   
>   	case CARL9170_RSP_GPIO:


