Return-Path: <linux-wireless+bounces-33658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PlMKyodv2mKuwMAu9opvQ
	(envelope-from <linux-wireless+bounces-33658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:35:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4A2E77CA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA78300D451
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749F30DED1;
	Sat, 21 Mar 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk/rpBg1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445E30E0D4
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132501; cv=none; b=uHg3+eqHXAUnpW7h1LKhTCDeWwQYzoZ3aYUFQ18g8pT4A3D/Q+2paAsTmxRG/5sZdYcSR69BxZMK0e9Soq/kNIQxmeqsaVd9HG4UeGMCA3yAeEqXooiNJyNS8/v9MvI136Z1gsSH5KxrKxNYz6Ju7L2Ucm9ngSRZX1BJmtb9jsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132501; c=relaxed/simple;
	bh=tuxXV45cldk3Ast855geZqdpgz4Fum+20pKRQJ64huY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=He2PEk78YApF55VcdvTxlaE9O1ZKnyhAmriWkdxCkRRsiejYJjat323pOAirdF/hHMDQCtT+V++GsHp5jfiYpRi0QLPHzAvuk0aI3D6wLgEzmbuAlz5nnr2haxWHCeoQ6xf5sLIHka9eaDd79cZIDy4pS85f9ThP757H5Ig5LMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk/rpBg1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so2977171f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774132498; x=1774737298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SesUAHYe1dq4PCMwuGKORKPfGdU1hKTUS6x12440RM=;
        b=Pk/rpBg1xBYivZ/OhsDqC6aVTrngSj/9ii9X4bu8BA2Y7yG7jM7aI7/4gV4Veg99Ed
         lZayqNRARg1Qqp+VTLoeLvqXX00sk5Cs6METvR8V6m3zLDFhEKwh5tO9EQBjMm2adquA
         6LH8ST6n6fNhGT4vguMKD6fUjISGEb6knVgpfXUjT2wR5AQjSs9AyRYCHVRc2GoeWYwO
         /1A2ig06bFP0hKxNZBfyABd9ygGYxJM1DvMF2AAICUYmG/ptClZHsBNWZvImo9S11pTu
         XO7z7XkSGZAnuwWoamw19x3VKM6y8opcS8Jjd9bIh0gYpisMuLuPQrL4x9dzow8KZvgO
         HfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132498; x=1774737298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SesUAHYe1dq4PCMwuGKORKPfGdU1hKTUS6x12440RM=;
        b=oVadnTzbf/EenD0Id8DD/hF6AXxAnDMp26YbI+A9MP8iFJ9AxMhvU21l+PTOdNV0+C
         k2LqqQkYep4/+Bc26ugWLobQEPPh0m9GaO0TAqoMf4qa372QAQ4vLSuo/SCxNPpJc+UN
         y6iDOYsfH2eJAg2r8sX7k5LTNIXqimhlz5Hx98tooNtXxTtqnTa/ljEvE2s34QUdckTm
         4OmQSyIeQl/7WkKKzy3OzbqWXffbQr4z2F0x56QcJgl2BXok1gE8R3N63RidCC59m030
         y0CasfEoOkDmNvwhj9MJdzazcSROOwUb4ILov06igzfd9xBYN7t3jKomPzUV+GIRY5JP
         GpaA==
X-Gm-Message-State: AOJu0YxdJsEn+/0o3epiBTo4eEfJ3zsEiNm4X43xGeKwcbe9t2Mu+1a5
	sQKpYbQka+7DQYpWAyi4CiemppeeLRwMvlmMkzdLBjs5J5Zv8034Ct/h
X-Gm-Gg: ATEYQzxOpAxNVeIcQyxQeSV/ZrWPu1fW8Yty3U3Pf3kV0Trc2axTSGFosTazzBySnYV
	pttX/56S2ffABjgtuSvaeEtHM+2UcUGj6f8lb0mRnuHqBeGb9fas/mrKR+rMfAWwQr1u8GI7zrH
	upE9+VBhxs/rrl+u1HDNlZs+unGTDxR3bPkP/UrjvGTO3gDCMegDMcjqLeiCp24P5L6rqZYL+jx
	5GqxUcNILD6ciXWAhvKQ1HrHQ1wvYQJnXvcAma4bfG8EzxzEcqiNTfS6JZ08hxUMhKtUfuJwfDG
	TfEjog1OkGZsl4mup5YUFibdzd2eMiAtvT+Y5YKpcWA/QZ9lQE5Mvf88C+QOCqwG9GkV0mkWsOl
	iAJLsEvDXyJMSQfa6OyWOqKfQkuWU/9akn6h/UXZbZXz8BaYHNyMe2cWIt+gVQYOA/m3yULO/NH
	GnvJ1I8vffaoJSLqOqo9NPPkW+/ZSyv7PP0Ga9Q5M6+wgzxWNXge43ugjh0hXVSSJx0Ud5U+r6T
	eszuEDWHAqNh5X1KgCPxBSNcwHCtkStMQ2ZypdGA+4=
X-Received: by 2002:a5d:5f53:0:b0:439:be82:1fd9 with SMTP id ffacd0b85a97d-43b6423b821mr11360301f8f.12.1774132497872;
        Sat, 21 Mar 2026 15:34:57 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm16932615f8f.2.2026.03.21.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:34:57 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44rf-00000001QXT-01Xk;
	Sat, 21 Mar 2026 23:34:56 +0100
Message-ID: <17fe2464-e8a1-4f2b-a024-a78bcf460bcd@gmail.com>
Date: Sat, 21 Mar 2026 23:34:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] carl9170: rx: gate data frame delivery on STARTED
 state
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
References: <AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[hotmail.de];
	TAGGED_FROM(0.00)[bounces-33658-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 15C4A2E77CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:06 PM, Masi Osmani wrote:
> Do not deliver data frames to mac80211 unless the device is fully
> started.  After carl9170_op_stop() the driver state drops to IDLE,
> but the USB RX path can still receive frames from the hardware.
> Without this gate, ieee80211_rx() may reference station data that
> sta_info_destroy_part2() is concurrently freeing during interface
> teardown, causing a use-after-free kernel panic.
> 
> The race occurs when ieee80211_handle_reconfig_failure() clears
> IN_DRIVER flags without stopping the hardware: cfg80211 then tears
> down interfaces via ieee80211_do_stop() which calls sta_info_flush()
> while the driver's RX path still delivers frames.  This was observed
> when carl9170 firmware deadlocks during a restart attempt and
> ieee80211_reconfig() fails at drv_add_interface().
> 
> The gate is placed in carl9170_rx_untie_data() just before the
> ieee80211_rx() call, not in the USB layer, because firmware command
> responses (including CARL9170_RSP_BOOT needed for firmware upload)
> must still flow through the shared RX path via
> carl9170_handle_command_response() which returns before reaching
> this point.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 683343013..19c6bd418 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -676,6 +676,14 @@ static int carl9170_handle_mpdu(struct ar9170 *ar, u8 *buf, int len,
>   
>   	carl9170_ba_check(ar, buf, len);
>   
> +	/*
> +	 * Do not deliver data frames to mac80211 unless the device is
> +	 * fully started.  After carl9170_op_stop() the state drops to
> +	 * IDLE, preventing a use-after-free when sta_info_destroy_part2()
> +	 * races with ieee80211_rx() during interface teardown.
> +	 */

If what you write is true for an up-to-date kernel, this needs to be addressed in mac80211.
Under no circumstance should mac80211 behave that way... for any driver, in any case.

Can you please post the panics/errors/warnings?

> +	if (!IS_STARTED(ar))
> +		return 0;
>   	skb = carl9170_rx_copy_data(buf, len);
>   	if (!skb)
>   		return -ENOMEM;


