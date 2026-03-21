Return-Path: <linux-wireless+bounces-33644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 57lfKb7nvmnIiwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:47:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9744F2E6D7B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EB9B300468A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2843230D0F;
	Sat, 21 Mar 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtwZJlVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279717A2EA
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118839; cv=none; b=KoBV/+UQFhVKSRxtIdpWFf3KqugJH/6fB1fZSdKa7sbg6x0EAAjxU1KzABk9uMd2x/debxUgqKoLtpCKhpuAE+DIxzXn/qH8RYicVBJjRMktidEUk02FP93I2xpypvTOEO9e1SZR6nwhepLdPlOZd2SCuXpoc7NSZEfRCYhBHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118839; c=relaxed/simple;
	bh=QyBsz001d6cFPv5PUoNXVnbUgRFgu4LbrCBnV79vmoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhzCFvslLzSC9f1FS7/fs3T8XUP1CarqdLQ0tHaPRr93Id2lxkflVfYJNQli4iTojiYdNT6VcyBWIsEYW+B4uEefIBryKEPWUXnuO/o9OACQz5MXWfK/8CaC0HQqp6zmUiKDHwU+GzqzHvZ4hOjeClJxPoQOuHPowXUILifxyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtwZJlVb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so9996325e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774118837; x=1774723637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkG6GOc81U0p8TfmbQ5qtb6l4W8oot7m5iwR3N17gXI=;
        b=LtwZJlVbTvOUyVstq5wq3oU23VBImvlVL2o/f8QtCWBVZF/X9ce7wzQcrTtvUiZcP+
         N+KR/dEVCjsobJt5a7CEVgKzqvREWM53aj6Z2qg2jUqd0U9OdUZ1ts3M6hUI5ZG8/pU4
         D8nV0t4LXs1td/MIsIIMTyuH7yEsXcHbk6i4jPsJ5vn197b9Da+UuRtFBRv/iR/napr+
         ykiGdEhtyUAqYndOnf4jOrEH/w70EMp1TzMTVTKOZ/juyFU8GW8hglXu+c564DnfEfLI
         4XkXIUihAgJEaCa7YiksNQZy9ZGv8wwX3WHE72ameEuk8H+PHk4yvHX6Y2Sgt8+VgtpS
         2EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774118837; x=1774723637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkG6GOc81U0p8TfmbQ5qtb6l4W8oot7m5iwR3N17gXI=;
        b=lVtA9xpGhE/kG88ZfbmpO/J6De02KozAARhoQRuyZn4YGUDnkzSdOScDA3MG1+n4aX
         t/UVM+BGDITKpNkeVNfqxTaMiGgFlbOFiiqaM5XGy6eH8SWWoFORaSVU/QdId3j7idHS
         lmN+/Gsv1tjm8UxJHsQH+BnXTh02tglHpJV2Znbu1NVUqdX5Uyt4NoldTmukB44vL+cM
         oyHQUYwsQHJMMWv2BtEosiPN4I3coFs4nfp6Q14GB8vhqiju5f8TqRbvCT7SHc4+7xo+
         zxtqY4R1PeZk9ZsYkcr6mjIn3pj8M/Yt1eQUsSJE9cd0NdIxKaybPr7IEAWExWtVkH/m
         dUbw==
X-Gm-Message-State: AOJu0YxYx8zPGjR2fVQT7exvOFz1OGepe8bmlwrpfyZAUYSxkQsSL/PE
	//c3c/XJwokQZyqN91tntv7TlCbLjQG7wnOvLnQb7J9jZ0BGtAj/Ds6Z
X-Gm-Gg: ATEYQzzZ5XzO+vPNz4H0AMH9UGGYuU/i+JLgwkQmznnrzgggmUNL3MwqvGpATzEXgH9
	zCDaZU9vyVcLJfoRMJ7lewTkRJALV08oMdkMW3dwRED1K61CXTG5/V1kXxx2TcWjLlL8W7Dg3zZ
	sWl1ZmXU5alLJTkVVSq1yis9MDjYgpstUIhTJ58LLoq9JhQn5Rgu+0EtebEATb5M2XpC8hPxePD
	E9wZqAAjv4fFpxWp64jpmaXMmULOSbVwr2xjkwN+EOnzWcQFYVhBe2on75/MnZpOldczOSlMOIf
	OaIFrXZq2q4d0jEAbvCXxrwMxzrfQuN4Pg+NckiEoxd4gd6YHWO64ep0DZAS818y7tPzw9VX60w
	BOWsMSyFJ7fr5a0kTLN9/abbmBYUjIsAqmDIDD+AGciU6z/RX2FpK7bsZUTATB019Ux4qXvEFUf
	Iv1PcSih6Zu4TByqe9F5jpD2XVJ7pI1CpwKBzQSjR1KIZ18Kbp9BDqz4cqf35eOkRSIKDAjNqe7
	9kpj3Z/RzXrfsj8LDjGeoI3jj1NQdUH
X-Received: by 2002:a05:600c:3e18:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-486fee0d56fmr101705755e9.19.1774118836453;
        Sat, 21 Mar 2026 11:47:16 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6cdfdfa9sm6254652f8f.9.2026.03.21.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 11:47:15 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w41JD-00000001KTD-3kb9;
	Sat, 21 Mar 2026 19:47:09 +0100
Message-ID: <8a8ad3fa-d32e-480c-a2a3-421c262023bf@gmail.com>
Date: Sat, 21 Mar 2026 19:47:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] carl9170: mac80211: advertise RX STBC capability
To: Masi Osmani <mas-i@hotmail.de>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6ACC91029B589B12E12639444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6ACC91029B589B12E12639444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33644-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 9744F2E6D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:37 AM, Masi Osmani wrote:
> The AR9170 baseband supports receiving Space-Time Block Coded
> streams (1 spatial stream).  The capability was not advertised
> in the HT capabilities, causing peers to never use STBC when
> transmitting to us.  Enabling RX STBC improves receive diversity
> gain and link reliability, especially in multipath environments.
> 
> The ath9k driver for the same chipset family advertises RX STBC
> based on the number of RX chains.  With 2 RX chains, the AR9170
> can decode 1 STBC spatial stream.


No, not that I can tell.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/common-init.c?h=v7.0-rc4#n204

|        if (AR_SREV_9280_20_OR_LATER(ah)) {
|                if (max_streams >= 2)
|                        ht_info->cap |= IEEE80211_HT_CAP_TX_STBC;
|                ht_info->cap |= (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
|        }

the ath9k driver supports this for generation after the AR9160, the AR9280

The commit message is wrong again. If you are sure this is working though,
please rewrite the commit message and put this feature after a experimental
module parameter (like for the STBC patch you proposed).

Cheers,
Christian


> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index aa7e481..6324b38 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -156,7 +156,8 @@ static struct ieee80211_channel carl9170_5ghz_chantable[] = {
>   			  IEEE80211_HT_CAP_SGI_40 |			\
>   			  IEEE80211_HT_CAP_SGI_20 |			\
>   			  IEEE80211_HT_CAP_DSSSCCK40 |			\
> -			  IEEE80211_HT_CAP_SM_PS,			\
> +			  IEEE80211_HT_CAP_SM_PS |			\
> +			  (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT),	\
>   	.ampdu_factor	= IEEE80211_HT_MAX_AMPDU_64K,			\
>   	.ampdu_density	= IEEE80211_HT_MPDU_DENSITY_8,			\
>   	.mcs		= {						\


