Return-Path: <linux-wireless+bounces-33652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJU5K+cMv2lurgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:25:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F162E751E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8BA430185B0
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7452D662F;
	Sat, 21 Mar 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlXaO9dl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D94346FC8
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774128357; cv=none; b=meE3k72LwMYLRK8C3RexAhM5z36uuuIyhcGXv0r0BtxVsjYiBooDSXFkjJ6x2/coJVlWDFatbHsmNE3eCMz4NjBRtoQEPdJ71Cq32fIKaclsIL44f6iW6FuKoJ97uHnUKFJbc/ulyDUkx22ciPyYlpIWrsWo3Lwiv8Bl3HafOPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774128357; c=relaxed/simple;
	bh=vf/+XPBj15MYnXKxbrk12hmFNRybJtERxcrSjvlz7t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2E/36zvJ3SV2tljFP5X7CYUrAw+w1x2EjsDlBJES5XwM2aVKgPTI574TL+V3qIpE7HooFS22Oxf+qTEQ+33xq3qGsld5NttMz7JTRej7XFWegmgIYyEu1vhFikq7XsCXsdzAj78j+Rfep9sN7QoGos9sQ8vA8Tz13KolaxwORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlXaO9dl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439af7d77f0so2136726f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774128353; x=1774733153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmEGf2P1jFejjiU56sWwb/XskXttNooh/KJbUC1+k3k=;
        b=ZlXaO9dl0KY4Rc0HpWzgjO/D1xeMvsAeBv286pAyd/pT+HkV2CZx44jBYdKTAYH99H
         bOBPTogfNGkUlFp83QeDxo4GHLlLS0HdW8TfVvFgSoOGQIZ/LW2uvls/jwUirpXfCGd8
         PNhbstI26u/Z7a+ewlD/tVinosNX4/8vjUUHImmS7BsUj5CXJeTfmK4QKzeFdJNwPAoR
         UU4i1w5tzRh4CLHduzqx+ww7n71dvkkt371WSpXLG3GyBL31lyUSCVA6cwpOoK0QRH6G
         vrod9fpDrrQTFVnTxpWOh6lNPg8CQofEIqlx9tc3YxeVdAl1hOPN28T3lPmRz+MjKPE8
         gu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774128353; x=1774733153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmEGf2P1jFejjiU56sWwb/XskXttNooh/KJbUC1+k3k=;
        b=fRU2eZbTOmP790zDaIUKGxWqinXmkATcBnVMR0S+3EIWcM54K5kiTe32dOGiyDNM2/
         bIhRCd/wkzANKJWMyfkIMpnZ7YG2ITHkkVmf20UW+bfHrZVdcoDPEKWVcA/2ROR+CSgd
         uBE5vfOL3cyMeeMBujsyyH7LP799eI251ImddbSwE+juy5ffPJiElXebcov32Ije3qY2
         eBpAsUN0IXB2B3egwkTQp8ivLoyJ0yZnPq47TCsnGjxwN5MBoquL93ZubCtio2F0W6lU
         9imkCFdztAvZkdHJoJ3yu5FZ5PvY6bVKRoGyJtfjawROVCPCYqvhudm5iXZPJb/bdyxZ
         p3Rw==
X-Gm-Message-State: AOJu0YyjQNOG+Wh6n2G0t8iROLgCpBz1APzaGglPeuj9rnrCMMqSa5Eu
	RWCK5F5YHBMbtGXm9GMdS67ZbTC6CpTiBM19FaVOdf4X85zUZdNwtfSZ
X-Gm-Gg: ATEYQzyd33xVLcT315PEw9dHWB9/c6ZQJ6L7N7fvp7QQgAoqMzDlnzt/vHvRPnqiAG/
	IIV3zYOVfTBgNJX50gJZVAd9bgbbe5pvaz2BBKY6OBmFqzqEZqeXxtVILBNyHHq9z2Vs9sVOnPY
	Q9XTQphOVz6wM6MC/GP+qZaaGlUrvQCLvLMuPuQM39b4JeRiZVDBr2VeLHsXG3yCzglaIAGVHIz
	zAmNf0gKqmcoAfuuKImHk/j16r6Hep/VHVfQxyljCZtYlVWmrJRp5hosseMcFMoxMTMH7MMqQiK
	Qpk4yvlBA5HQpulbeMAobcIvCTgXl8xC7CyYkYnlli07gdOEI15be8DYWErMF6SYHlaoStDk94C
	siWWT+EDOkjXvncIGwJIvAF7fQMfgxzzlfqDuUvNDeRPg21q+YTS+xEOXr1952uL2HlvhM/h6vc
	YAD59hXrrssgWcALRrxS1i9TK7Rle6nAyhI3GBkoMp5u1Heu98PT6r6VnVEl7yusjUX30hCdfWh
	g/77ln2aSu1YrYdQkLtcP1FxsI4xPj7KdihpMqpeoQ=
X-Received: by 2002:a05:6000:2f84:b0:43b:3eef:accb with SMTP id ffacd0b85a97d-43b64262dbbmr11475946f8f.33.1774128352992;
        Sat, 21 Mar 2026 14:25:52 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703343sm16204040f8f.19.2026.03.21.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:25:52 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w43mn-00000001PjM-44ni;
	Sat, 21 Mar 2026 22:25:51 +0100
Message-ID: <41a9b095-ee6c-4f91-b8d3-f15468ea7589@gmail.com>
Date: Sat, 21 Mar 2026 22:25:51 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] carl9170: phy: add periodic runtime IQ calibration
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6567EFD98F8FD6FE6511E9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6567EFD98F8FD6FE6511E9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33652-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 28F162E751E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> Add periodic runtime I/Q calibration triggered from the existing
> survey statistics work handler (carl9170_stat_work).  The AR9170
> hardware performs initial IQ calibration during channel setup, but
> I/Q imbalance drifts with temperature over time, degrading EVM
> and increasing packet error rate.
> 
> The new carl9170_run_iq_calibration() function sets the DO_IQCAL
> bit in PHY_TIMING_CTRL4 for both chains, which triggers the
> hardware to re-measure I/Q imbalance and update the correction
> coefficients automatically.  This is a non-blocking operation --
> the hardware runs the calibration in the background without
> interrupting normal traffic.
> 
> The ath9k driver performs similar periodic calibration via its
> longcal timer (every 30s).  carl9170_stat_work runs at a
> comparable interval, making it a natural trigger point.


This is interesting.

I checked OTUS and unlike the antenna diversity these definitions, the IQCAL are present in
HalPlus/OTUS_FB50/hpani.h:

| #define AR_PHY_TIMING_CTRL4     0x1C5920      /* timing control */
| #define AR_PHY_TIMING_CTRL4_IQCORR_Q_Q_COFF 0x01F   /* Mask for kcos_theta-1 for q correction */
| #define AR_PHY_TIMING_CTRL4_IQCORR_Q_Q_COFF_S   0   /* shift for Q_COFF */
| #define AR_PHY_TIMING_CTRL4_IQCORR_Q_I_COFF 0x7E0   /* Mask for sin_theta for i correction */
| #define AR_PHY_TIMING_CTRL4_IQCORR_Q_I_COFF_S   5   /* Shift for sin_theta for i correction */
| #define AR_PHY_TIMING_CTRL4_IQCORR_ENABLE   0x800   /* enable IQ correction */
| #define AR_PHY_TIMING_CTRL4_IQCAL_LOG_COUNT_MAX 0xF000  /* Mask for max number of samples (logarithmic) */
| #define AR_PHY_TIMING_CTRL4_IQCAL_LOG_COUNT_MAX_S   12  /* Shift for max number of samples */
| #define AR_PHY_TIMING_CTRL4_DO_IQCAL    0x10000     /* perform IQ calibration */

There's not a 100% match with what ath9k ar9002 is doing though. It looks like ar9002 can do more
than just IQCAL (as the matching value for AR_PHY_TIMING_CTRL4_DO_IQCAL is called AR_PHY_TIMING_CTRL4_DO_CAL.
And you need to set a separate AR_PHY_CALMODE to tell it what of the available CALs (IQ, GAIN, DC)

There's a chance that there's a benifit, if this is working.

One question about this though:

In HalPlus/OTUS_FB50/hpani.h:

|
| /* PHY IQ calibration results */
| #define AR_PHY_IQCAL_RES_PWR_MEAS_I 0x1C5C10  /* power measurement for I */
| #define AR_PHY_IQCAL_RES_PWR_MEAS_Q 0x1C5C14  /* power measurement for Q */
| #define AR_PHY_IQCAL_RES_IQ_CORR_MEAS   0x1C5C18  /* IQ correlation measurement */

This makes it look like we need to read back the results after the calibration
and put them into AR_PHY_TIMING_CTRL4's IQCORR_Q_Q and IQCORR_Q_I ... At least that's
what ath9k with the ar9002_calib seems to be doing in ar9002_hw_iqcalibrate().

In other words: Do you have some credible information that just setting
AR9170_PHY_TIMING_CTRL4_DO_IQCAL is enough?

Cheers,
Christian


> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
>   drivers/net/wireless/ath/carl9170/main.c     |  2 ++
>   drivers/net/wireless/ath/carl9170/phy.c      | 36 ++++++++++++++++++++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> index 2eedb2f..0175f8e 100644
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> @@ -605,6 +605,7 @@ int carl9170_set_channel(struct ar9170 *ar, struct ieee80211_channel *channel,
>   			 enum nl80211_channel_type bw);
>   int carl9170_get_noisefloor(struct ar9170 *ar);
>   void carl9170_update_channel_maxpower(struct ar9170 *ar);
> +int carl9170_run_iq_calibration(struct ar9170 *ar);
>   
>   /* FW */
>   int carl9170_parse_firmware(struct ar9170 *ar);
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index ebf9fa9..50c0922 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -910,6 +910,8 @@ static void carl9170_stat_work(struct work_struct *work)
>   
>   	mutex_lock(&ar->mutex);
>   	err = carl9170_update_survey(ar, false, true);
> +	if (!err)
> +		carl9170_run_iq_calibration(ar);
>   	mutex_unlock(&ar->mutex);
>   
>   	if (err)
> diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
> index c294df7..b145e9e 100644
> --- a/drivers/net/wireless/ath/carl9170/phy.c
> +++ b/drivers/net/wireless/ath/carl9170/phy.c
> @@ -1637,6 +1637,42 @@ void carl9170_update_channel_maxpower(struct ar9170 *ar)
>   	}
>   }
>   
> +int carl9170_run_iq_calibration(struct ar9170 *ar)
> +{
> +	u32 val;
> +	int err;
> +
> +	if (!ar->channel)
> +		return 0;
> +
> +	/*
> +	 * Trigger runtime IQ calibration.  The hardware measures
> +	 * I/Q imbalance and updates the correction coefficients
> +	 * automatically when DO_IQCAL is set.  We trigger on both
> +	 * chains and re-enable the IQ correction afterwards.
> +	 */
> +	err = carl9170_read_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(0), &val);
> +	if (err)
> +		return err;
> +
> +	val |= AR9170_PHY_TIMING_CTRL4_DO_IQCAL;
> +	err = carl9170_write_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(0), val);
> +	if (err)
> +		return err;
> +
> +	/* chain 2 */
> +	err = carl9170_read_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(2), &val);
> +	if (err)
> +		return err;
> +
> +	val |= AR9170_PHY_TIMING_CTRL4_DO_IQCAL;
> +	err = carl9170_write_reg(ar, AR9170_PHY_REG_TIMING_CTRL4(2), val);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>   static int carl9170_set_radar_detection(struct ar9170 *ar,
>   					struct ieee80211_channel *channel)
>   {


