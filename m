Return-Path: <linux-wireless+bounces-33654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wwCkI5IUv2nQtQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:58:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83492E75C7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB733010B8B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB381303A0D;
	Sat, 21 Mar 2026 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur4zK/+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076331A9F91
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774130319; cv=none; b=X1q2TI4ut2maR4s3vnP1u78UNu73Q78Q5i1krA8eI5dKpWt3hFg1pIaloYOEr/YNpbL/dTjpqGkSaJWHzvyKDmC59bidrPoFGvI/cKexKfMLQ0I3FtiAg7oGH+98mFPN8YorpM89xPUEInRo38ixQDfwL8pkyg37ALsbR2HxD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774130319; c=relaxed/simple;
	bh=op3jJNcZsY2iDFPAV3tsfou4jP0OU3+BhZdrGoHdUeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuK0Sxq13y3jH9ch9wWnVsKkusAQi1OgPOL0kDXoPAPQCrBlhtwYa1twqcd3puS6LJiX6nMzYaRpA6lfgFmcKtWaof0EYdNoTwharWfsjUSyfq6LnNCHAwHeEqCIK+vsvyfGpE5pa3J/wVFMcRvROFx5XTB7OdIHAbuAdxOELkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur4zK/+g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b611274bso1603641f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774130316; x=1774735116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFqFuU1mA9wSPwIp81LzkipH0sID9zeFkJtqFLBhlLM=;
        b=Ur4zK/+gBJB4p4bB9ZDQnyBLo+OYByHPng8Zyy5ZmrHnNit0rtkMiHxZdtDIbmmRe+
         kjPAeP5IbecC7H7M1ibh1OHxkN5uh8QUZtwIqghetODCxLezdnjEF6VLWbi/aOZFbj83
         UTc2+huh0aOUlSq2kag6WeWPfyE6lHggODYHCGNFnF/T6fnZ15yR7BZAjfqNwZ0lFg6m
         a7dqyF0nl7AYxLT1kJf64Yaij87nQ5DEJVmZ/QLoY0kYBBTIlQ9Iw9FLTmQPt1jVFiwd
         q85zfjo8ftVVU69cl86sQJBUwu6ZG0ssp6b3ncesaZj3JsaVNOC9HC0ujMaTIZwHSGyi
         gBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774130316; x=1774735116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFqFuU1mA9wSPwIp81LzkipH0sID9zeFkJtqFLBhlLM=;
        b=ralJ8MCI7pHihZahTIlIcHGpQXZw5tCWoFpi98eiolcDNETPnK3Qjmveh/r0scppKr
         vvXa9iFCQ32Ok2ch9qs68k0t8ESlL/Hq2TE2W50rEhxvG5n7BLmBdCpBmGNHQozgsyEw
         mbdLxOYY8wRzWzHYtQpj0fN1gBV2UMO9wnL0SLzlYVwk2g9xdOPTf9jQYK5/KYf1p4RH
         fYXnw3/jQKWn3NUu1X1USf01Fb+ptl1T7y4g8K2g2yVB4DKdbxP8/UB8wxYLXtRq5Ae8
         C9T3h/8ZDRMe+CWwK8GZaLtclnD7rz/FssFbOa3Muaq8FkMKzwqUykBOqXqraRen2PYM
         FQrg==
X-Gm-Message-State: AOJu0Yw3BHMhQsUh27k7sZAKp8rw4jPleruSjch/S7Hrs6q4sxo+EdLA
	vDMyNEzUwH69FhP/1DnyaGMA3OT2yQw8fn80+a+Khk2IqoYhdUI22fqg
X-Gm-Gg: ATEYQzyr1Ac6HgUBo+SYX9XoJTby2lkC0XJBzQZzsqdfbFBZarBEsb5LIQOZEy2Lgfz
	8aNrM0LbDoeMJNUkd0dqbzlHhw6O/Mey5DZQac+jjJXZkLAxnwxZilWz7q65oqfhqWKrqgsSiJF
	LyCFsvjTamdcOcaVeMWr8xnCO5yrBV7CZMM9PjlZe/n1NL0q13Q8VE4sA3Fukb2c/GWmtDQKck8
	RfhocUfbm+oiGlMtD+tWJJFI/tHASYLyHIclmt730dknobWhtgZvEJ5Gt0RIqU+SrJT7Mu2FFVM
	ZVSCZlPlxB+6v2omb7oi7lUHOrx430SNcO1KpI9018uuSINxIbydDKc86BggW9qsAqZQkbsYXGk
	xeihDmIv8OCBLzoDxBmdItKc0uZOeZIib1z6DP1GVhZBYg8+ZVmb4Bk+jeNgu6v7AZ8nHVJafR7
	/l8xreGFDmD8KsfVoT6nZVb8SqZJttOkGgjo7IICvev9/1elHSCfw8Al16s8oYGDWFbQeWEEfxC
	/EagvyZd1G/ppwMIxEjqDmeyMvr76Yh
X-Received: by 2002:a05:6000:4381:b0:439:c550:d920 with SMTP id ffacd0b85a97d-43b642895a0mr11714204f8f.47.1774130316089;
        Sat, 21 Mar 2026 14:58:36 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm7255170f8f.9.2026.03.21.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:58:35 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44IT-00000001Q3S-0nB0;
	Sat, 21 Mar 2026 22:58:35 +0100
Message-ID: <73153743-e0e8-4f2d-8774-066f53460511@gmail.com>
Date: Sat, 21 Mar 2026 22:58:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] carl9170: skip cross-band channel changes during
 software scan
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
References: <AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33654-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: D83492E75C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/15/26 11:56 PM, Masi Osmani wrote:
> The carl9170 relies on mac80211 software scanning because it does not
> implement a hw_scan callback.  During a scan, mac80211 iterates all
> supported channels across both bands, calling carl9170_op_config()
> with IEEE80211_CONF_CHANGE_CHANNEL for each one.
> 
> Every channel change triggers a full baseband cold reset, RF bank
> re-initialisation and AGC calibration via the firmware RF_INIT command
> with a 200 ms timeout.  Cross-band switches (2.4 GHz <-> 5 GHz) are
> especially expensive and error-prone: the AGC calibration frequently
> times out (firmware returns error code 2), leaving the PHY in a
> degraded state.  Subsequent channel changes -- even within the same
> band -- then also fail, and after three consecutive failures the
> driver restarts the device, causing a multi-second connectivity gap.
> 
> When the adapter is associated on a specific band, scanning channels
> on the other band produces no useful roaming candidates for the
> current BSS.  Add sw_scan_start/sw_scan_complete callbacks to track
> the scanning state and skip cross-band channel changes while a
> software scan is in progress.  Intentional cross-band association
> changes (e.g. roaming from 2.4 GHz to 5 GHz on a dual-band SSID)
> are not affected because they occur outside the scanning window.
> 
> Tested on Fritz\!WLAN N (AR9170) with 2.4 GHz association and
> concurrent full-band scans: no channel change failures, no device
> restarts, no PHY corruption.

Dealing with hardware misbehaving... Yeah!

I always suspected that the reason for this misbehaving are clock glitches.
This is because the whole device gets reclocked when switching between 2.4GHz (44/88MHz)
and 5GHz (40/80MHz) band and also HT40 (88/80MHz) vs HT20/Legacy(40/44MHz) too).

I do see the point here and I can confirm that to this day, this causes the
described annoyances.

@Johannes: Is this "stay within the band" something the driver should do,
or could this be moved up to mac80211/cfg80211?

(The way I did it was with wpa_supplicant since it allows one to specifiy
the scanning frequencies with scan_freq ... or even limit the frequencies
with freq_list. That said, this doesn't work great with NetworkManager
and the likes)

> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
>   drivers/net/wireless/ath/carl9170/main.c     | 42 +++++++++++++++++++
>   2 files changed, 43 insertions(+)
> 
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h	2026-03-15 23:51:23.598565789 +0100
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h	2026-03-15 23:51:39.769123563 +0100
> @@ -333,6 +333,7 @@ struct ar9170 {
>   	/* PHY */
>   	struct ieee80211_channel *channel;
>   	unsigned int num_channels;
> +	bool scanning;
>   	int noise[4];
>   	unsigned int chan_fail;
>   	unsigned int total_chan_fail;
> --- a/drivers/net/wireless/ath/carl9170/main.c	2026-03-15 23:51:23.597355728 +0100
> +++ b/drivers/net/wireless/ath/carl9170/main.c	2026-03-15 23:52:02.845563524 +0100
> @@ -916,6 +916,33 @@ static int carl9170_op_config(struct iee
>   		enum nl80211_channel_type channel_type =
>   			cfg80211_get_chandef_type(&hw->conf.chandef);
>   
> +		/*
> +		 * Skip cross-band channel changes during software scan.
> +		 *
> +		 * mac80211 sw_scan iterates all channels including the
> +		 * other band.  Each channel change requires a full BB
> +		 * cold reset and AGC calibration via the firmware RF_INIT
> +		 * command (200 ms timeout).  Cross-band switches
> +		 * frequently cause AGC calibration timeouts (firmware
> +		 * returns error 2), leaving the PHY in a degraded state
> +		 * that cascades into failures on subsequent intra-band
> +		 * channel changes and ultimately triggers a device
> +		 * restart after three consecutive failures.
> +		 *
> +		 * When associated, scanning the other band yields no
> +		 * useful roaming candidates for the current BSS.  Skip
> +		 * the channel change so mac80211 advances to the next
> +		 * scan channel harmlessly.
> +		 */
> +		if (ar->scanning && ar->channel &&
> +		    hw->conf.chandef.chan->band != ar->channel->band) {
> +			wiphy_dbg(ar->hw->wiphy,
> +				  "skip cross-band scan: %d MHz -> %d MHz\n",
> +				  ar->channel->center_freq,
> +				  hw->conf.chandef.chan->center_freq);
> +			goto out;
> +		}
> +
>   		/* adjust slot time for 5 GHz */
>   		err = carl9170_set_slot_time(ar);
>   		if (err)
> @@ -954,6 +981,27 @@ out:
>   	return err;
>   }
>   
> +static void carl9170_op_sw_scan_start(struct ieee80211_hw *hw,
> +				      struct ieee80211_vif *vif,
> +				      const u8 *mac_addr)
> +{
> +	struct ar9170 *ar = hw->priv;
> +
> +	mutex_lock(&ar->mutex);
> +	ar->scanning = true;
> +	mutex_unlock(&ar->mutex);
> +}
> +
> +static void carl9170_op_sw_scan_complete(struct ieee80211_hw *hw,
> +					 struct ieee80211_vif *vif)
> +{
> +	struct ar9170 *ar = hw->priv;
> +
> +	mutex_lock(&ar->mutex);
> +	ar->scanning = false;
> +	mutex_unlock(&ar->mutex);
> +}
> +
>   static u64 carl9170_op_prepare_multicast(struct ieee80211_hw *hw,
>   					 struct netdev_hw_addr_list *mc_list)
>   {
> @@ -1723,6 +1771,8 @@ static const struct ieee80211_ops carl91
>   	.add_interface		= carl9170_op_add_interface,
>   	.remove_interface	= carl9170_op_remove_interface,
>   	.config			= carl9170_op_config,
> +	.sw_scan_start		= carl9170_op_sw_scan_start,
> +	.sw_scan_complete	= carl9170_op_sw_scan_complete,
>   	.prepare_multicast	= carl9170_op_prepare_multicast,
>   	.configure_filter	= carl9170_op_configure_filter,
>   	.conf_tx		= carl9170_op_conf_tx,


