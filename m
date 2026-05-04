Return-Path: <linux-wireless+bounces-35841-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF0LHc2Y+GmcwwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35841-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:02:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921A4BD5CC
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BACC3025F46
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFB3D812E;
	Mon,  4 May 2026 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGxgXcMF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA63D7D91
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899526; cv=none; b=AtQLcTbzgQLRCsvcKOKaxSSlUO7wWOAylLTVRkcm9OzuAqLkPMf2eknIDK3i3FnE67qFNR1Q6Nj+9UzrAOscHdkLS3xoBvdAQVeDBB3Ge0M1Rw8uYNI9Ud0Cq0SSrVYQA55cLOdkj3GXh6Qn9pGpEDOLf4hQEWdUlW4oUYwZ4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899526; c=relaxed/simple;
	bh=NmoK00K18ee0KWR0BRNW6Sy1q35LGoXy6wYg8Lac6Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go29a6npZOSvfv0G/wcZFZcmivKqvxqYmZ8qwtkNXnDRb2Sto/a85Wh4AzZZsDlUOaWYs/VUqtlPk8S39hYJvHmV276NgbIheXkbVxl8F6Nq4mQmjGX9LjpVILhPIMR7Xy9xKgFF2CkHVKaGuQ4Tmos38t0+t3bJKZdmiUBAmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGxgXcMF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ee63e91acfso309199285a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899523; x=1778504323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ypd1QBD8IL5nEI5wKW5JxIvcEM/x3rJY8yhwAEDZ758=;
        b=jGxgXcMFQYkTOXfAZCzIdJyr2IXdpGEw92l5CjA9XZNUnMhxhXH/LYIPsmMOl2FYhl
         X7CgKOkL3SKD/83wujPXWnPASXjH0uFdb+SDexSlkXLswQiJFe8kzjjYAhd9UdK3ptxq
         H2x/bX+WAxMkh0AGMpEYK/v+8L2NO/NIEeUAV5WYvFtJThvZh6Tw+dUQEgCS92ismGws
         a6XriNoomevi8IIYK3rpMwysiky28dnzQZC8hm80kuO8cJ2WG0MqgvLcGJqdO3+/PN/i
         XBf2p4yUMwEygnaB23AU5PMkqXQlOjGFnn7a/tpExw3e507jE+WW4wB3B4fA/VBpTtLx
         PFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899523; x=1778504323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ypd1QBD8IL5nEI5wKW5JxIvcEM/x3rJY8yhwAEDZ758=;
        b=NVLoItrqQjpv8DPyqMu7aQUDBNwwQ3yhLjag2PTEJzhkCc7/Slva7szKnwBksEhVLr
         fQQY7As8Payb6IewXHlgBEu2d1Vi/MGEIlLm3g6x8YcHJdExFJJO1CmyTGoTi/rE+mBc
         y9BSCjolurS9Bfwycjf93w6hq7pUicMrqADZrx3SABS7ZpI4jMKoZthMGPKwHbLbmBkw
         zxGTN7g/YGIoyJJrHuPBEvD+2HAzqAUf5RJuZdMWydtu/OSWkLKY/3ORHqBXpOUeqlK+
         BaLHikD0G6fpMoJrTBhK+OIoAF2NjVZz/kpbnwicg85DOAnX/87AAyiGM0vQ7gN0sp0Q
         OILw==
X-Forwarded-Encrypted: i=1; AFNElJ9Tgt29/Ntyb6HamL59d+SdRHEPGKPpa6oiIvRcl+z9GeyaGitCfhlNlmt/ZLMXJ72xN/K4KvHjI/jTwz2jsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFUU41HAjHJY8RT6c3fSi8s5DTLpl+mc7Kryv/7eQRLoKmYGG
	5GgSkibECS4NR2hosIytTjr70ktaBMCR8N9lurkxUr1Wo314XnI95qD3
X-Gm-Gg: AeBDietmF0MDKqtPwpfOMn4aYMKZPsJQE1457m42QVWupYpIDzxhBJXImOouzEGcbi8
	f7jsSpJK3Raeqd9WSY4uDwLI/rRdv5pVLU+EHIs2p1HdV0Zt+mrjXI97JoOhrL1+OHUg+vr6drt
	9LnggXYU3zeiTf9vPEZb8Fymx+YlLQ/6/i+6J0TyCZMnMPRcF5rKafx0v6ktf2hJNQ+l3uuvILo
	X4AAhiTLyljADUGcH5YzPUOq78wfEp3cW6HJKBNWn47oKQBQg7z9SH1ptbmZck4hTlh2Dd4TzjK
	iRW141SLK3mY7fHaVIgEHhtTh7by/vORPfyShsJ+QtQPBpsZvKfs0SrxK9anJsQ0xH/Zc7aZfGY
	OSDHsS7nnzKOa/YT4qQ197wTtMUkDExtE+J4UuOss+G16vmcjmb/dKbLUlwenMG1CMzROMyFzGJ
	17fjTBdzleOZrgnASbbmaCRMfvDJAcnT7eFEfZCqP3KH4T/dlDscAroWWT/a1a+IIDbs46D4R3C
	JRlr1A=
X-Received: by 2002:a05:620a:4010:b0:8ed:c0bf:2c24 with SMTP id af79cd13be357-8fd19122e53mr1413514585a.62.1777899522542;
        Mon, 04 May 2026 05:58:42 -0700 (PDT)
Received: from [10.100.121.202] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd7dsm1031615585a.37.2026.05.04.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:58:42 -0700 (PDT)
Message-ID: <bcbbef00-5881-421b-8892-7be6c04b832d@gmail.com>
Date: Mon, 4 May 2026 05:58:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Complete list of AF_ALG algorithms used by iwd
To: Eric Biggers <ebiggers@kernel.org>, iwd@lists.linux.dev,
 Marcel Holtmann <marcel@holtmann.org>
Cc: linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260504045007.GA2289@sol>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260504045007.GA2289@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2921A4BD5CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35841-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Eric,

On 5/3/26 9:50 PM, Eric Biggers wrote:
> With AF_ALG being on its way out due to its frequent vulnerabilities,
> iwd will need to be fixed to follow the standard practice of using
> userspace crypto code (for example, libcrypto) instead.  In the mean
> time, AF_ALG is at least going to need to be hardened by removing
> unnecessary functionality, for example unnecessary algorithms.
>
> Based on the iwd and libell source code, it appears iwd is relying on
> the following algorithm names from AF_ALG.  Please confirm that this
> list is correct and that these are the ones we need to keep for iwd:
>
>      cmac(aes)
>      hmac(md5)
>      hmac(sha1)
>      hmac(sha224)
>      hmac(sha256)
>      hmac(sha384)
>      hmac(sha512)
>      md4
>      md5
>      sha1
>      sha224
>      sha256
>      sha384
>      sha512
>      ecb(aes)
>      cbc(aes)
>      ctr(aes)
>      ecb(des)
>      cbc(des)
>      cbc(des3_ede)

This looks correct from IWD's standpoint, but ELL does support 
additional checksums:

- sha3-224
- sha3-256
- sha3-384
- sha3-512
- hmac(sha3-224)
- hmac(sha3-256)
- hmac(sha3-384)
- hmac(sha3-512)

Marcel may be able to comment on what projects are using these, if any.

>
> Also, does iwd always hold CAP_NET_ADMIN?  We're also considering adding
> a privilege check to AF_ALG.  (It's TBD whether it would be
> unconditional or controlled by a sysctl.)

Yes we require CAP_NET_ADMIN:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.service.in#n15


Thanks,

James

>
> - Eric

