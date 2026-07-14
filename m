Return-Path: <linux-wireless+bounces-39017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cpHmFKDyVWq0wgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:26:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9C7525E4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 10:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=hH4NZUNP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39017-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39017-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEECC3011871
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85C3FD126;
	Tue, 14 Jul 2026 08:22:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD173F210C;
	Tue, 14 Jul 2026 08:22:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017345; cv=none; b=R7yj2MQR4NSySOYeTv364qzCB52Sh+yWDmP4IKrgboshNE13li9qAlubPdbPBMbDL1/LAzRtNh/wpJXX6uAJ3jPWwKmtXYodc1EPtiX4hpCne3YN3rb8e1NEkV+nekUHdwVspxHFPJ3nxnox3tc7rvl/HxDFJvMOIo2jKJO6pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017345; c=relaxed/simple;
	bh=/aAao8KbeMGjrRsPvmBfJ7JE4JAtEfFcaMI2EW93LWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU9Af8X1RAWUYv6FY/Mpkn8yqjKAf9s4DgvFjcSY2QkH0tWZfX4CNn/dFDSqva/yBvacb7PFHJr6CM666H/ycx6LmFxjGTxuiE1TtRP7+i9C1+XmWz3xuniIg0e8A+9l82rGYKNCReJQNv6nu2ZcFC1T+Yc2sYJccCKSFSwjQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hH4NZUNP; arc=none smtp.client-ip=80.12.242.17
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.64.95.99])
	by smtp.orange.fr with ESMTP
	id jYO2wyCTId4ZljYO2wcJMY; Tue, 14 Jul 2026 10:21:06 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jYNswQfQaajQCjYNtwI5ec; Tue, 14 Jul 2026 10:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784017259;
	bh=R/ZP/NLJuU34Qnz9im12DTJ/ZIfKJhQvmYHzhR/bf+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hH4NZUNPqlzQYA6nExHZ7RByXB997hb5lmB2rrI71E8Xwy/poMLdtFEwS/QATlJcV
	 3Dr//lU7SDtCyRkZLJzaR3K9A1YLTvPbfb1SQJmJMLoxpNxWS5fEv92/uMe0SL9dF8
	 +wezz9o8g9npusxGIERR2JhXpwsuMPfRCrdzb0hZn/AjYlnOIAkaI1FdF/Yz7PqNas
	 kBRQ7RoeyOBVB8fnoLVuvcu9PhcbN51G5HTfTSgVv2vWoiHVt7qnyFh9BlIWezkmeI
	 6LB71eU6nVkBaH/sJjgbKpueJt8yuQDIRX1tDYPzLRJEb+HMpAkFnuevC6TeGVnjjj
	 tQxvrdMaf2TvA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 10:20:59 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <04521906-da94-466c-b7c1-7d119eca9508@wanadoo.fr>
Date: Tue, 14 Jul 2026 10:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Constify struct ath12k_dp_arch_ops
To: Ping-Ke Shih <pkshih@realtek.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <469d732e2c6f159e1a05e89c7e417c3a10db5fdf.1784010931.git.christophe.jaillet@wanadoo.fr>
 <2efa694140ce418c8d83a62d3f7b5309@realtek.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2efa694140ce418c8d83a62d3f7b5309@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39017-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E9C7525E4

Le 14/07/2026 à 08:57, Ping-Ke Shih a écrit :
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
>> @@ -139,7 +139,7 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
>>          return tot_work_done;
>>   }
>>
>> -static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
>> +static  struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
> 
> Did you miss 'const' here?
> 
> My bad!

I reverted the change to compute the size before/after and forgot to add 
it back before posting.
Sorry, I'll send a v2.

CJ

