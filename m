Return-Path: <linux-wireless+bounces-24343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A59AE3852
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 10:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB13A7657
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4E1FF1B2;
	Mon, 23 Jun 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcZNUct1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE41FE44B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667054; cv=none; b=dwiCH1CA5ls8VXBBAMt3jGE4U6TZfRs25Zwkd6dP+66lo+Cdkj7/vYKWRDWcFVMf3xc/I0s7jGNXO3qYJExDr/mtrDZDfyNL7amqiVw7Mw0T9H812l2f5wjLI5l/K1Zox1WXZTidx7Ui7aKMvKbl7vBOIYE9CKUfnlXEobcfpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667054; c=relaxed/simple;
	bh=JJqiGF+/vjxFtubOfBn1pTIyavxGVNp+PjDGiovVZuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyvEq5B03zYP6lDhIvFbRVgjewK4bvr46XKoioHgNX+H656yBk2dplMEiXcqLEXxqHXNYJmLfgw+i1yiBdeLvBb+7ihWpBVArZcruF8r6dxY/hXWR7Jt9rGPzSV4mdHIeDoTtqdifXV/veQzAdMmkkBvjQtefQEdTE46WTsP0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcZNUct1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45365b1a897so17230695e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750667051; x=1751271851; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJqiGF+/vjxFtubOfBn1pTIyavxGVNp+PjDGiovVZuM=;
        b=QcZNUct1xG8txJiIojDXOWbRN+0tBBguGWynV1u7YlGB8J00EMhxJTtUNQhw4F3VTP
         aiaLCq09++vsfiqlPgPjVQdahXp9S3d1v8YTDRT4lNkGBev/G6ynwrVMfdf9m9xaMTu0
         JAQDitSPHWF4luqT4QFoFgOUSCNCnzfJdCoV1a7/q2CMV3V1DLa7gaNqq3LZgx0hBAnl
         7BQYizlqvKUg5qD1BBiMsWPJ3bAAd7Ggj5z5oEKgEDTO5+3dIJkYn5/zUQxsKREqU6JL
         cYSi800D8easBOhG1WGHvk+u1uZMQ61E2ce7WqBScDWALccJSuqFf1Nat4bzbbkzxUPU
         Rdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750667051; x=1751271851;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJqiGF+/vjxFtubOfBn1pTIyavxGVNp+PjDGiovVZuM=;
        b=vB2V4QFwjj2UsPZ4WcGA8c/Tf3eb3GMX4WGAEIw1OpKq46uKfjGCy/cJ1Beqgs5LRS
         63y3o75yNVE64+S+fRtf8guQxifrXmJbT4c5dmdCaSpyuPhkvfOF9RmO0KpZpvfLj249
         VsEhnFt0lOGQtaJiVUDNijd+Wuut8vOQ5bA2YSC/qpC42M4+myEEH+gYl2PAdG15m2nd
         W0kdTuT7xp6MZXcAOAIb3txupoMrb+6nmmPL93wpazsQwln/rTGAg9UslaRfqPV7WZ+Z
         eNXlqxHTzImttJixeUinh2TmoVLVwSeIU++rzrddDQDvQW0kqM701APjyUys43u3Z7MN
         NfzQ==
X-Gm-Message-State: AOJu0YzGSC56qkhLhQb0YIA6SK4+XWmJDgOkpSl9arRWjV/YZMsVvjOz
	hgbNdQ6aG5J/0SJyahHwMtCwD5Js0tZihOFVrCc7tA00tEknIXjxG5+D
X-Gm-Gg: ASbGncsq1Cm5lFUH+F/Fr8vgMYkCtWbKUXHYW0hhMhNEn6duF8hiXV9s7uh8oyAPNuo
	+tobsJR1XvKJsxS1SnSnK3d4+bCYE+Wv8bWUR1IlSdbtjq4Gi/1I3p6GLf2B54VfMKNUwoBl9O+
	rvceA7m5CTQp7UFUK1iyUonX3nesLuk6RHMfQ/PU8cs38frh2NO6hxeheBAPTzBB8X9Q/hTyRvu
	wk78K8sUQHXLRGeHGecrRaN7jL4mkTC9ES/dUEo0m7O91Ac7OCA0LFFd9dMAohjl/IbhLpSBmRu
	t6/IJ3wo8zybQo6ZqLAui4yDy4OC9WCsSrdQq2aW4Uw4765JxJKHKgw4EnmADklplEeQ
X-Google-Smtp-Source: AGHT+IG8yn1uTQ266iugDDdZrGh7NQN+dBpWpqN9CU5XTI0zixWTIHIm4Nk2+9t80k7ZqhKfw2pinA==
X-Received: by 2002:a05:600c:34c4:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-453647921f8mr127887855e9.0.1750667050960;
        Mon, 23 Jun 2025 01:24:10 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453646cb5ecsm105367775e9.8.2025.06.23.01.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:24:10 -0700 (PDT)
Message-ID: <61cae2d3-d4a1-4715-8b63-0738e9ad5353@gmail.com>
Date: Mon, 23 Jun 2025 09:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION v6.16-rc3] Commit 83f3ac2848b4 breaks WiFi on Intel
 AX200
To: Eric Naim <dnaim@cachyos.org>, miriam.rachel.korenblit@intel.com,
 regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qPviwUcSIkGQeCmqbcZuYb66"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qPviwUcSIkGQeCmqbcZuYb66
Content-Type: multipart/mixed; boundary="------------D9cxZZ9H6GlVFzkhaCqn0fHj";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Eric Naim <dnaim@cachyos.org>, miriam.rachel.korenblit@intel.com,
 regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Message-ID: <61cae2d3-d4a1-4715-8b63-0738e9ad5353@gmail.com>
Subject: Re: [REGRESSION v6.16-rc3] Commit 83f3ac2848b4 breaks WiFi on Intel
 AX200
References: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>
In-Reply-To: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>

--------------D9cxZZ9H6GlVFzkhaCqn0fHj
Content-Type: multipart/mixed; boundary="------------xsWVvgjAVcKf85bDxgeibONn"

--------------xsWVvgjAVcKf85bDxgeibONn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Q0MnaW5nIFllZGlkeWEgQmVuc2hpbW9sIDx5ZWRpZHlhLmJlbi5zaGltb2xAaW50ZWwuY29t
Pg0KDQoNCk9uIDIzLzA2LzIwMjUgMDk6MTQsIEVyaWMgTmFpbSB3cm90ZToNCj4gSGkgS2Vy
bmVsIE1haW50YWluZXJzLA0KPiANCj4gQWZ0ZXIgdXBkYXRpbmcgdG8gNi4xNi1yYzMgdG9k
YXksIFdpRmkgZnVuY3Rpb25hbGl0eSBvbiBteSBBWDIwMCBkaWRuJ3Qgd29yay4gR2l0IGJp
c2VjdCBwb2ludHMgdG8gODNmM2FjMjg0OGI0ICgid2lmaTogaXdsd2lmaTogRml4IGluY29y
cmVjdCBsb2dpYyBvbiBjbWRfdmVyIHJhbmdlIGNoZWNraW5nIikuIFRoZSBwYXRjaCBpdHNl
bGYgbG9va3MgY29ycmVjdCBzbyBJIGhvcGUgeW91IHBlb3BsZSBjYW4gZmlndXJlIG91dCB3
aGVyZSB0aGlzIGlzIGdvaW5nIHdyb25nIGFzIEknbSB1bnN1cmUgbXlzZWxmLiBJIHZlcmlm
aWVkIHRoYXQgSSB3YXMgb24gdGhlIGxhdGVzdCBmaXJtd2FyZSAoMjAyNTA2MTMpIGFuZCBh
bHNvIGNoZWNrZWQgd2l0aCB0aGUgcHJldmlvdXMgdmVyc2lvbiBmcm9tIG15IGRpc3RyaWJ1
dGlvbiAoMjAyNTA1MDgpLg0KPiANCj4gQXR0YWNoZWQgYXJlIG15IGlueGkgYW5kIGRtZXNn
IGxvZ3MgaW4gY2FzZSB0aGV5IGFyZSBoZWxwZnVsLg0KPiANCg0K
--------------xsWVvgjAVcKf85bDxgeibONn
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------xsWVvgjAVcKf85bDxgeibONn--

--------------D9cxZZ9H6GlVFzkhaCqn0fHj--

--------------qPviwUcSIkGQeCmqbcZuYb66
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmhZDxUFAwAAAAAACgkQaMKH38aoAiYV
bQ//eIkBmGYlwHaRSPGC41J4bLlNbDJJilTEQSj3hXaAmixAfcc36CDaPMCkPo2s4h5abrtVG8/c
L9AHHgKv6xh3lKX6+M6hW7CNdqf09zZvffNz1kMF3f+waQExVzLBxi6VGBLDdaoy9HPbe2M6EbmF
GrEmOJ6NDEseJstYmtKfJsMK+znvnAIS3rkuY3lZgfNIaqVAxeNt1Mlx7VfyzbBM0egMH8DdGonT
5Yx0S3XkRjd4V7LgwV9W23xSS5OdragSLJa4LsHTUBip6eGU4TezuPyWfv9dSOutmRTtHMLHbfHf
OvQTwp+CM0MlVj3E+p2TUXMSU6wmlRazlGHQlOQ5wt9FTs6t6rhlh7LqkwRKx/gEMmrfcE3YH8eh
fw+c6iCImJk6BOPv8UOEkYWr5hf297v1gHHLAhHX1oZLx0+ld8ezNMQdBDTyHeUX+RmIHeYaYQpd
xXQCkEuXhwmNGcz33VcLVBVLBpjgTEinm1gCxD77OUgLEmZVgvr85aHZI+6ob4i4ITgSmVtVn1TE
9KUB5JO56cAZi2VTxODmf+UnwE3rMZ8EeC1ByBcdaKVYSA59aVSmocNn+odk1e/ig2SKuNlalu4C
sC+Sbt9EPtnkdY4T4+V1Gpp4Bxf31MixRpCkUirI8/oJZ5gLcRZJjfMXJurouSWUFU3D5jpqTFh5
PNU=
=Cugs
-----END PGP SIGNATURE-----

--------------qPviwUcSIkGQeCmqbcZuYb66--

