Return-Path: <linux-wireless+bounces-37018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M/bC04kF2qu6wcAu9opvQ
	(envelope-from <linux-wireless+bounces-37018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:05:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06925E8236
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFADF301D58D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861743D4EF;
	Wed, 27 May 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="qcIFRMu4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341439B498
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901515; cv=none; b=NKDeItCtkd3KkgKyZpaunyZgbqB6Rumz1UQ6131+W6mAruJdTg3fHVHwkU3GaWZeF8w9mTs2r2Z6m1caBd9URw57ooTkeiP0mIYUbAPJ5DsFxHSUII5gJe3l4e8Ff1vF1iIQMD/zKgFpeSTzB9MTyi0Wwn6N3qMnZCgC7PHnN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901515; c=relaxed/simple;
	bh=AHwrOyMcjOU+TKZ/ei9ohjaLiam4EHbLaLXCi9V69LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAWWMYcOHcxBmB7pC2LJHIyF1HlzT/FwTemHONi1RUXmbThpxChGmTMySXb+jTBIPhN2UQTkxhouGXXGjb9IIO6uFrEMmfnR4B1JxlGcjhZnyk5gOZug9WHECoz0RZZptoJS1ntvxQWnfM0z0rMPsxtMa/UMKmn0791qNqgUX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=qcIFRMu4; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 712AE1801E4
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:05:03 +0200 (CEST)
Received: (qmail 28769 invoked by uid 988); 27 May 2026 17:05:03 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Wed, 27 May 2026 19:05:02 +0200
Message-ID: <370e76e3-1d41-469b-8e50-8ace6b5622d2@david-bauer.net>
Date: Wed, 27 May 2026 19:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76] wifi: mt76: mt7915: configure noise floor reporting
 on reset
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260516144944.2574053-1-mail@david-bauer.net>
 <a83c9aca-da9e-4a5e-a364-382910388a68@nbd.name>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; keydata=
 xjMEZgynMBYJKwYBBAHaRw8BAQdA+32xE63/l6uaRAU+fPDToCtlZtYJhzI/dt3I6VxixXnN
 IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD7CjwQTFggANxYhBLPGu7DmE/84
 Uyu0uW0x5c9UngunBQJmDKcwBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQbTHlz1Se
 C6eKAwEA8B6TGkUMw8X7Kv3JdBIoDqJG9+fZuuwlmFsRrdyDyHkBAPtLydDdancCVWNucImJ
 GSk+M80qzgemqIBjFXW0CZYPzjgEZgynMBIKKwYBBAGXVQEFAQEHQPIm0qo7519c7VUOTAUD
 4OR6mZJXFJDJBprBfnXZUlY4AwEIB8J+BBgWCAAmFiEEs8a7sOYT/zhTK7S5bTHlz1SeC6cF
 AmYMpzAFCQWjmoACGwwACgkQbTHlz1SeC6fP2AD8CduoErEo6JePUdZXwZ1e58+lAeXOLLvC
 2kj1OiLjqK4BANoZuHf/ku8ARYjUdIEgfgOzMX/OdYvn0HiaoEfMg7oB
In-Reply-To: <a83c9aca-da9e-4a5e-a364-382910388a68@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.227727) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.817727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=AHwrOyMcjOU+TKZ/ei9ohjaLiam4EHbLaLXCi9V69LQ=;
	b=qcIFRMu42+I0Ni21+8xZaHHyCeHpIE4Cf8Fq5BOPMT269ZD3lmB/68KUY92pSII+pL/ntO/NyQ
	Ae/mxFx+6nnOFcBydRVvDfKlH4vyEQeToFhY5Xbujjp+Ww+50DyB30XSEIbwyE9b/ehtnsSuBSNN
	dozEZ75VrWANephLvAODrR0qasgpf+r1m+TIthC3S2pmxGDNjv36VPbTLuVMn3sxGvJrNvS1Q7Vi
	3CgmEcFbwgJjr/OR/sxmtEiHBraMLiOKy0XNB9N06YglHqpd3W+1lCzY6jxVrVJpa3WJ6A4T19kA
	IbygySrlpJ+/K0HgZSqjQ3RuA75HhQaJpuzZdvS88TS5WmqKl4AVzgzJCdw+BEf3nKp5KCV/lP5/
	PrX9wx6ijo+CT6XU7PjL4MM0kaBRBYkVrm7zN0G5tL7AdNQf9UD60hGXq7JUgXNcTEsyy5o7hW1b
	2U4bKIVCIhxaEuY6MJ00bFOsJykWYDHM+GPEukmPxNENVzAd0ibJ8aNh65YY4JA17Ifpq7kgBU83
	dLfwWDJtS6+EkikEvgQPkd7WGTYf8hcN1BJtZ1Iz4ddov0rUmVv/qEb3VZRvKfVCY5yjtA6mjZOv
	bZFMbVX+976dLOMsmHPuhTrMP5TLBMRDucr19hmJaXt8WhTMIp7ALFXsl1KzrxEhIDfIV2SNqavl
	U=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[david-bauer.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[david-bauer.net:s=uberspace];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-37018-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[david-bauer.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@david-bauer.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,david-bauer.net:email,david-bauer.net:mid,david-bauer.net:dkim]
X-Rspamd-Queue-Id: C06925E8236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Felix,

On 5/27/26 15:56, Felix Fietkau wrote:
> On 16.05.26 16:49, David Bauer wrote:
>> When performing a full system recovery of the MCU on a dual-phy
>> platform, band 0 (usually 2.4GHz) stops reading correct noise floor
>> data.
>>
>> This is due to noise floor reporting only being configured correctly
>> for the second device PHY.
>>
>> Configure the respective registers correctly after restarting the MCU
>> firmware to fix reported noise-floor values.
>>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
> Have you considered clearing MT76_STATE_RUNNING in mt7915_mac_restart instead?

The call to mt7915_run is guarded by MT76_STATE_RUNNING being set per-phy.

I think this is to not start the second PHY in case it was never started due to
it not being present. We could in theory remove this check for the primary PHY
and clear the flag prior calling mt7915_run.

This seems a bit more hacky to me. Alternatively I can also refactor the entire
mechanism to make it easier to understand and resolve this indirection in the
process.

What do you think?

Best
David

> 
> - Felix


