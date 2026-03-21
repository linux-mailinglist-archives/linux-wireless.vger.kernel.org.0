Return-Path: <linux-wireless+bounces-33648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FouBT33vmmFmQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:53:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96A2E714C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3AB300D6AC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06F35C19B;
	Sat, 21 Mar 2026 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7FEWGiX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807C35A397
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122805; cv=none; b=mcaPZugtfTPRpscyV1H2WLB/j7uK0s/g+cGUU1lWFjrsQcIThXfB5FILeNqaZb5pBQRbBO8CMhJ2YZpqmjKNR6/jN33KcIKkevMlz66x7+ttO/rGwiEn+7cCyx3hcW8+0N5DEV5EcX7cPmybDrPmGAqgSkVC2+xQ30hMmI8feVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122805; c=relaxed/simple;
	bh=rDOCgPteM6TTfYDf1LRsHenu5dlLPKhzMVaEHhMWwYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqmEJh//XaIn+7TkY01+BUvP3t7kHvob23HWtdZr9cugXoWUdXJidD+dSSTkJ/3+CUsAIhsBytsIljnesLxcsPm2x/PYiyvadNgRT6gvOfec6iPZb9NckU2ewBkdI/NlMz0wXCRjtmKSssDvcltir5iCFdwGM1afPWc2cDS6V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7FEWGiX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so12183935e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774122802; x=1774727602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1dlVIx15gjsKJLQ9KZvIUV9xECqc7wV00dn76mdAGU=;
        b=R7FEWGiXj0HWWFBrUsQl8DHna7/Xx2PvRHihb2Mw9+x5ogHjFQHFS1JWvFDHXAgsv+
         8+9LCOFLZZxD7veQ99gFjnFIB4vxXHYSzw01Kd1tLf5e0WcHqki5tv2iIvO05lEI4awr
         tp5SqR/EY0f3jujpJREqk91jIXn6rGpL0pUxYIItbWzAy/LsUKY6MBr5UkDW1KIAl0rN
         Psv4Qo4ZYwJDVCwX/QM0vfVhIBrbdG9z3/uyS6H6oVFerC1PCUwrCDpfF3aTEFJ0Nhtp
         nOWsSqMQidbGaUoXP6Mw3B++8kTeKZXTxqZEtr+Ax776TXpIU4mJoihMK+RuKH9eqam/
         Oifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774122802; x=1774727602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1dlVIx15gjsKJLQ9KZvIUV9xECqc7wV00dn76mdAGU=;
        b=h7LGTW4QoCt1Vc7XYhNZwj7O5/JGV64bXMmmJC9LmwVkubuakHvO/6FO8FPdj5/avd
         7HbtgfVYBwOpOp2W2K8S32NR6N5tt8Ts4Ip/NS2um7nilnR+LFPhv8arNPbd20ZaAV9Z
         lU1QkCvSkjBQqcIaevmvyKwcJ5XSR9qKWTUvrqFfnOuMe3AwmIDJ5Waxt9pKgYVVcjj6
         6xDYKsr96Als2XDW7RhTzQEUl5GNZhM5O0OrktkonqpTUsUysOHtMMs3bq4QwmZ3wCD7
         4wDvHav0umLSnvuKhxQCWn1oVrero0YV3S1DedufULU8VIhUqeRca7SfCm+k1xFgweA5
         HvGw==
X-Gm-Message-State: AOJu0Yxqo+Gfe/UIbHmeJvYUcbrZk8F9R3S6cQD2KaOq0P6pGaIkGlDJ
	P807SpLMsXIXFJrOi4DQddlmeQMgf4SA9QeFqWtDpjy4UwrSkuxiOHbE
X-Gm-Gg: ATEYQzx5GEja9QH9mjITdE7i/DvnMh/QURdY7Iw5hErXlpapiJeKAXEOHbxT4Z359jw
	DyLQ8zhNFdRM6vZeYCsZ1DNRtu4wKpiTe7tKnLJEjerA22vfpgv9brbm8VurWgnWXRk+XQWBUJJ
	oUnk+bWWKt8o+odB3HvJWdAPfGXTPria7XaxnGzoKxJBrT36Pq2ehk1lVv30ZAXxLnSCE/RoBxH
	BhhiR22v0hfnRyNgBJL421oQWXlqCB/DB+RX7nNA9IU8PEaIAIfEqyhRORiPCwkEFaI9to1G4Oz
	zPGjMJgC3ypgV2L7spRdU4ykKokbbSZ2w+Gwb/MOyn2AbLSTpIgBetL/tElgj47S/MswfWhIFU+
	/CDJWad9oBsJyDxlIejtumWExUop5A0O+nyXnHnlgejY1rmP+wvH6c2tczJ805Gc3hm+o1StRZj
	ybJxS9VeaA/IiKbxRFisuoxux0FHEaQSjfvrPd4GKquNGpGX3qeKxhyLnatueoeHVhuaqAmmYrv
	caN6oZPQm3wGBAf5eRNxLOEmlHWQjyz
X-Received: by 2002:a05:600c:a08:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-486fee2b3e1mr104963465e9.29.1774122801859;
        Sat, 21 Mar 2026 12:53:21 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48703e26408sm103516245e9.11.2026.03.21.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:53:21 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w42LG-00000001NlI-15jS;
	Sat, 21 Mar 2026 20:53:20 +0100
Message-ID: <46d3a248-bc59-4c60-85ba-88d80afa8dc3@gmail.com>
Date: Sat, 21 Mar 2026 20:53:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] carl9170: phy: enable antenna diversity for 2-chain
 devices
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6344DB5885359FAFC80D69444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6344DB5885359FAFC80D69444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33648-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F96A2E714C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> Enable fast antenna diversity on devices with two RX chains
> (rx_mask == 3).  This programs the MULTICHAIN_GAIN_CTL register
> to configure main/alternate LNA settings and enables the
> CCK fast antenna diversity bit.
> 
> The AR9170 hardware has antenna diversity registers inherited
> from the AR9285/AR9287 family, but the carl9170 driver never
> programmed them.  For dual-chain devices this improves receive
> performance in multipath environments by allowing the baseband
> to quickly switch between antenna paths.

Oh, no. It does program them! It's part of the ar5416_phy_init array in phy.c.

So. From what I remember, this was the reason why I copied the definitions
over from the ath9k driver to carl9170. Because this register must be important
if they are part of the init values. But I don't know if these definitions
are the same for AR9170 and AR9285. That's why the AR9285 is there.

As for ar5416_phy_init values. They came from the original OTUS driver.

Hope this helps.

If possible, this feature should be governed by something like the experimental
module parameter?

> 
> The diversity configuration mirrors what ath9k uses for the
> AR9285 single-chip design:
> - Main LNA: LNA1
> - Alt LNA: LNA1+LNA2 (combined)
> - Gain table: table 0 for both paths
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/phy.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/phy.c b/drivers/net/wireless/ath/carl9170/phy.c
> index 290c336..bcd9066 100644
> --- a/drivers/net/wireless/ath/carl9170/phy.c
> +++ b/drivers/net/wireless/ath/carl9170/phy.c
> @@ -536,6 +536,31 @@ static int carl9170_init_phy_from_eeprom(struct ar9170 *ar,
>   	carl9170_regwrite(AR9170_PHY_REG_RX_CHAINMASK, ar->eeprom.rx_mask);
>   	carl9170_regwrite(AR9170_PHY_REG_CAL_CHAINMASK, ar->eeprom.rx_mask);
>   
> +	/*
> +	 * Enable fast antenna diversity for 2-chain devices.
> +	 * Configure main/alt LNA with both chains for best
> +	 * multipath performance.
> +	 */
> +	if (ar->eeprom.rx_mask == 3) {
> +		val = carl9170_def_val(AR9170_PHY_REG_MULTICHAIN_GAIN_CTL,
> +				       is_2ghz, is_40mhz);
> +		val |= AR9170_PHY_9285_ANT_DIV_CTL;
> +		SET_VAL(AR9170_PHY_9285_ANT_DIV_ALT_LNACONF, val,
> +			AR9170_PHY_9285_ANT_DIV_LNA1_PLUS_LNA2);
> +		SET_VAL(AR9170_PHY_9285_ANT_DIV_MAIN_LNACONF, val,
> +			AR9170_PHY_9285_ANT_DIV_LNA1);
> +		SET_VAL(AR9170_PHY_9285_ANT_DIV_ALT_GAINTB, val,
> +			AR9170_PHY_9285_ANT_DIV_GAINTB_0);
> +		SET_VAL(AR9170_PHY_9285_ANT_DIV_MAIN_GAINTB, val,
> +			AR9170_PHY_9285_ANT_DIV_GAINTB_0);
> +		carl9170_regwrite(AR9170_PHY_REG_MULTICHAIN_GAIN_CTL, val);
> +
> +		val = carl9170_def_val(AR9170_PHY_REG_CCK_DETECT,
> +				       is_2ghz, is_40mhz);
> +		val |= AR9170_PHY_CCK_DETECT_BB_ENABLE_ANT_FAST_DIV;
> +		carl9170_regwrite(AR9170_PHY_REG_CCK_DETECT, val);
> +	}
> +
>   	carl9170_regwrite_finish();
>   	return carl9170_regwrite_result();
>   }


