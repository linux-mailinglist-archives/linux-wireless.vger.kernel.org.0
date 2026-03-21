Return-Path: <linux-wireless+bounces-33650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG2TGLr/vmnmoAMAu9opvQ
	(envelope-from <linux-wireless+bounces-33650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:29:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13232E7318
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 453EC30078B1
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC07280329;
	Sat, 21 Mar 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxKA0gD8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3D2F12A5
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124983; cv=none; b=WxHq0Q4Y+oy5+BC5qVQHjyLvNSLImqwmsrkl8gC326rM96c4QmqNs9vI/9ov5Yo/XnOlN22x/dwwuDxit5lSuD6RBKNMHJmFACpR6IazRG16++Otx6R/vEj7fbd1th2ny/VRmNgryLAaQwdqhMsXZD0wbqYmzfUztTsaTqz5cAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124983; c=relaxed/simple;
	bh=dLMMfPHFavXOUqSGk9vThaxa3SiytH7g5XHIgEv81c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0M1Y8dJRpTi+eL3BVNohgJIP2VJ/1NEqyottSFWUXlK3JcOddAShTbzi4NHITwW0G5+m6kBpQni5EzHl2SUc0e3aPdsITQQ/MyITNjLJn2tXKMTNMmMxoxd9zyTHbqWp/nNAlTCgqMyNYkjRhPmQ6AXzY2GQnhlIkQAr16uang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxKA0gD8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so2729937f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124980; x=1774729780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnV6cv9KlsbiXjYswerjvya9lKYgidNE1DKNAaIyPQo=;
        b=KxKA0gD8oQzr98KNGAeia1Mem+FUhuW0nbF451VtJDBX3vzwbEahib+OcxIjq7ZS11
         MBlzdHTUVwG8P3EeXNym/1KF+JWhlFlEYKpe7fEwzSNkWscKXXFPRhizSR5BK6FHR2Yb
         VQWW15zMXHm13kjhK+fjWc8L6cOOVzlaRvmlFvtv4lz9EtPIDzXtQJyMoWXar5rTULhs
         JjPDnubS4UrQNfV5w+4Hm9xkx2A0u5rtt1lqKZ1WljjkCW8/GgK/7WNLRXrqCKzQmHuz
         9y18d8+garp76GPmqrA5MGi54lznUaeRF9sD4/YnYl/POmjCRSqNZdN9l2BOXDOJ6Hc0
         olgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124980; x=1774729780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnV6cv9KlsbiXjYswerjvya9lKYgidNE1DKNAaIyPQo=;
        b=CXLJgNZ/HkbhhxqoAiFNFpqk/gN5/Dc2JIYLd4AL5qmLoT6HZzyqQHDjUjHFF9mm7u
         xNybeMEe7Iehe4DnX8RhmwQ9gWfmf71Rd9AN2fsd91EKEJbbRFYXmTDS8MeZiUkgUYzx
         wFUBt3rqa0cdDdUEHK5u1Mu/0b0+u7P+p06rFpHZsBpmljNRUIhrwC9jNa65okTjofwO
         ctYtZSDgrpOyZ+qjA+Uw+XDuN+joEwQ7NmscrhjPQIdi8dxLPmLUD7xxi5p01TmnEO0N
         xG58/m815vp5a+GMrjhi/pzB6ILwZYNVrdwtmrLQvtrLLqnW9S2urfn8SbA/a2mQwfzi
         QZgw==
X-Gm-Message-State: AOJu0YxMaNcUypJAsJ+gPnWWmTeLiVPYDMGWHZslMxyjw2EIaXEcBlRj
	XBmLAaFM08t9I9d1f0ssiuWT7I5w6Hf15xgzoPUfmrcw3Pnhai90Rbu/m4cYMw==
X-Gm-Gg: ATEYQzyAxmTiOD1iLxftuVVJ12E5vz4PCzugj2YmQUIIHl//HcYZYgZ/WxieVt1P5AV
	I9SSDixap7u3cKowBhAn9OLzP+tOqWuBfpYRqR7iYhfWz8DH+5v43rjJIHRatnIAinHPXgkHr2D
	WE8V9h/NRg1QwriCnpfeUvlaNBECpLhxDB9baf/EkrTA+Jq60tPkgKXJO03qSeZ8+HoquIV+UB3
	42RLJm7dnihXuLGseoIpqDQWwsWIJuf6thD4Y8UbgDhaMWXGqX1CjCU0RZ7ZaXbMJy7Jw5tG5Xt
	iEXExSy4SX/tAwo2UMOjusakKPjev/uzh/Hj6d0YV3gltGicpSAd2pFGFUlACHNX4G40GL9w/Ur
	rKqwwiOlAplz2LuDVU9/aZqIMrKKQz//8kIV/HtWYY/BP7MJzTswRpMhfw4tZZ+YacRf7c70xby
	dQ8xy73PIKvMaXS5ap0M1NN+5q5z25MxYUkU+VRyipmDKSt4JSebbI44rhq3+tamQCsIl37MpSE
	viv/dLXvAM8x5ciDa07CuC5RLJq5Aa4
X-Received: by 2002:a05:6000:220f:b0:43b:7481:f899 with SMTP id ffacd0b85a97d-43b7481fabfmr255729f8f.7.1774124980216;
        Sat, 21 Mar 2026 13:29:40 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm17454830f8f.35.2026.03.21.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:29:39 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w42uF-00000001Ocj-08av;
	Sat, 21 Mar 2026 21:29:28 +0100
Message-ID: <599a32f1-5984-4884-9d91-3d881c0c2951@gmail.com>
Date: Sat, 21 Mar 2026 21:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] carl9170: rx: track PHY errors via debugfs
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6B42814E38096301FE9429444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6B42814E38096301FE9429444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33650-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: F13232E7318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> Count PHY errors reported by the hardware in the RX status and
> expose the counter through debugfs as rx_phy_errors.  Previously,
> PHY errors from ar9170_rx_phystatus were silently ignored (marked
> with a TODO comment).
> 
> The counter helps diagnose RF environment issues (interference,
> multipath, low SNR) without requiring monitor mode or additional
> tooling.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>

Sure!

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h | 1 +
>   drivers/net/wireless/ath/carl9170/debug.c    | 2 ++
>   drivers/net/wireless/ath/carl9170/rx.c       | 4 +++-
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> index ba29b4a..eaac859 100644
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> @@ -386,6 +386,7 @@ struct ar9170 {
>   	unsigned int tx_ack_failures;
>   	unsigned int tx_fcs_errors;
>   	unsigned int rx_dropped;
> +	unsigned int rx_phy_errors;
>   
>   	/* EEPROM */
>   	struct ar9170_eeprom eeprom;
> diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
> index 2d73456..0498df2 100644
> --- a/drivers/net/wireless/ath/carl9170/debug.c
> +++ b/drivers/net/wireless/ath/carl9170/debug.c
> @@ -794,6 +794,7 @@ DEBUGFS_READONLY_FILE(tx_janitor_last_run, 64, "last run:%d ms ago",
>   DEBUGFS_READONLY_FILE(tx_dropped, 20, "%d", ar->tx_dropped);
>   
>   DEBUGFS_READONLY_FILE(rx_dropped, 20, "%d", ar->rx_dropped);
> +DEBUGFS_READONLY_FILE(rx_phy_errors, 20, "%d", ar->rx_phy_errors);
>   
>   DEBUGFS_READONLY_FILE(sniffer_enabled, 20, "%d", ar->sniffer_enabled);
>   DEBUGFS_READONLY_FILE(rx_software_decryption, 20, "%d",
> @@ -830,6 +831,7 @@ void carl9170_debugfs_register(struct ar9170 *ar)
>   	DEBUGFS_ADD(tx_ampdu_list_len);
>   
>   	DEBUGFS_ADD(rx_dropped);
> +	DEBUGFS_ADD(rx_phy_errors);
>   	DEBUGFS_ADD(sniffer_enabled);
>   	DEBUGFS_ADD(rx_software_decryption);
>   
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index c664014..414d499 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -455,7 +455,9 @@ static void carl9170_rx_phy_status(struct ar9170 *ar,
>   		if (phy->rssi[i] & 0x80)
>   			phy->rssi[i] = ((~phy->rssi[i] & 0x7f) + 1) & 0x7f;
>   
> -	/* TODO: we could do something with phy_errors */
> +	if (phy->phy_err)
> +		ar->rx_phy_errors++;
> +
>   	status->signal = ar->noise[0] + phy->rssi_combined;
>   }
>   


