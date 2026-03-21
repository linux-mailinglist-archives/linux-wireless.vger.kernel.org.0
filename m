Return-Path: <linux-wireless+bounces-33646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDZpMpvrvmn9jgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:03:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F72E6E46
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70713300A8CF
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CC2D877A;
	Sat, 21 Mar 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWgBderi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B42C028F
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119832; cv=none; b=teR+qk+ZPmUM1a5HDRX0d6sVT7jxEIW5zY2ncuFDfqU3sQRSaMHnQiu1dVEV3XB5+BidyqhPTvSkUJaOp3yM2pjfv79FRgmC6UfzzPONa+6kkypCdIBlu7aQBWmyBYDe+FEo/tvF6YbbHmA+fU806NqMZv+e3ezSqyt7YQDNvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119832; c=relaxed/simple;
	bh=w5LZ1yyJ3ChLf3RD3wb5MY/nBIo5BBrs7oQRsKPCxog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfo5S1YD/uJIRyzBpgh3sCZKr6dWmh58rX5aZlfBEaaPnHRF3q2p3KtSojK0hV/9j5UYX7hm45ft54KAskYS2Hz0I9JUYAi5bk2lsj+ZMeoyzebw8WoptCIYywG+wgXXU/LRfekczFzacNT2IEXDQ/k+70iqehM0NprtZkPdKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWgBderi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1736130f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119829; x=1774724629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEyAqA847v5oz3vvkaEyPS4jZ/8Tb/ln7PDjWvLF6f4=;
        b=aWgBderi1xsf2nHHg3W8IHVMgK4KU8vq16SpbAhhs2lR9Z/bqm8sbUH5SnBxcGybsj
         q+vfAsssLLeq0SeTpoxY+KgBS6GfO7FidDwYyWEHww/fRYd3p+mY4RJQ6vez1bCb6xXG
         wCbzXMzIgwDmqyspS6onM77BNrI7B4Uj1lr842tHA9o68csn35mT0Yr8CV6GdDXKOoEd
         DCRjJZLhfwK7rjM0XNnaIwkETCmFz23wgF3ctBOmfKz2J1C9rg/gFcy9e23DBLzwQxHh
         rfDcUvrKkZ29h+J+B7aIxNkyV73tnNguojZxBiL2I+usTCQrPOeH6ZlKa0k1hDqDgt6r
         LoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119829; x=1774724629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEyAqA847v5oz3vvkaEyPS4jZ/8Tb/ln7PDjWvLF6f4=;
        b=U1tyl7YEGB1utbI/4VU2CtxP73NTPMWpioFsytI8IJk6jcLvnJkjvl1CixAtbd4J0M
         qN5drEQwdEjPBvKFymjtxrtkxc2junJ5S66fq7o7gsu94I14UKPKpcGZ3lCmopxLShIj
         PtwKSnWCYC1aB2TI32aG/5jQ9uB8Sw3uWaReO53NvPWoTm97/njlGHAa5TczcDfIvvmR
         7z7NgwG9lijJLFkYH2J1ENKbztFPyL0bK08/v/xJhqfK2EAgQLxAIZUgaBmIcYTujU0d
         VAs9qhf5AK10Idkic2HLKCYDsRRwHIjMyp/28Uoh3jZibwWLsJSPsBJfgPvAWcsNu98r
         JW2A==
X-Gm-Message-State: AOJu0YyA/6FXPrvmafswS0scK0nO7JBhD//kqxqkvNP98Yjl/EcBo4uf
	sG+EkhRBioVE8cAFfI8tfX0vUp9IZtfnUku/oMj4eqoGU3mEl6uuGPO62E2NVg==
X-Gm-Gg: ATEYQzwJPVkChABYREUB1EEymcF2ynL5bjOLrV4zDAOQKGf8lc1sgLOcivsIi6mgCIF
	4Zu8c8t1cE0NmJU4Pu9iryZRq9aYy+RPxIp0y0H7o2kyquP9RSKIDv7Dd66EIVcQnTB0CpuoZUO
	0reOWzyihQvUqAAENjXuBM1uDXCy0M/hvtpOux16CdL3IGU6xvvQ8tWBDymO9iADwZ+eX3Hk6Fd
	z2GcAgqokiT7u5GkMi+lgMphBQ3IGSGjEXLU94ByEc+rQ/an+bd0dE3CAifBr1zB8gi2T1l/1mA
	EHt9Ay8YuaczhwS3pZ6Kifn4E4KimGzjoXHS+VDqMQniws/W+28RCQCheIQdTlgdCjOMJe0BQNO
	0EnepxupM/6PO3eGJL6y2CagTD1kGWjuK9duzmFYFHEPsB4086zTqh5HPiwXMQmIdU+JaTNm9wT
	x0vq7f3176Uqn3VYhxeH7Z05eHE91PwqazANzVJIyQsoZWZs7wZTYtH3NY5BxX+ooze4svrWOL5
	aBqBlg7pPcnthXhOqxuG6lyD97ADiI/
X-Received: by 2002:a05:6000:1845:b0:439:c799:dbe3 with SMTP id ffacd0b85a97d-43b6427d9cdmr11771129f8f.25.1774119828841;
        Sat, 21 Mar 2026 12:03:48 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm14623695f8f.11.2026.03.21.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:03:48 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w41ZE-00000001Laa-1bzz;
	Sat, 21 Mar 2026 20:03:42 +0100
Message-ID: <ad72370b-b5ea-4cc5-98b0-701ffbe15290@gmail.com>
Date: Sat, 21 Mar 2026 20:03:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] carl9170: rx: wire up dropped frame counter
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6AC8119FB64246940D3899444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6AC8119FB64246940D3899444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
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
	TAGGED_FROM(0.00)[bounces-33646-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B94F72E6E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:37 AM, Masi Osmani wrote:
> Increment ar->rx_dropped when frames with unrecognized error
> codes are dropped in carl9170_rx_mac_status().  The counter
> was already defined in the ar9170 struct and exported via
> debugfs, but the actual increment was missing -- only a TODO
> comment was in place.
> 
> This provides visibility into receive-path frame drops through
> the existing debugfs interface.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 6833430..c664014 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -340,7 +340,7 @@ static int carl9170_rx_mac_status(struct ar9170 *ar,
>   
>   	/* drop any other error frames */
>   	if (unlikely(error)) {
> -		/* TODO: update netdevice's RX dropped/errors statistics */
> +		ar->rx_dropped++;


No, that would cause it to be counted twice.

This is because in the parent function carl9170_rx_untie_data() (yes, carl9170_rx_mac_status() is only
called from there.) already has the "ar->rx_dropped++;" in the "drop:" error code path.


