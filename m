Return-Path: <linux-wireless+bounces-22737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BFAAF871
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A65F1BA84AA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE01DF725;
	Thu,  8 May 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdR/w8kv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E1C5F30;
	Thu,  8 May 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702071; cv=none; b=ZO03KsbELUYoiVa0og5x1NkJR1rxjcBi0L1iv+8xffozdvDD9RGcXwWtYTa8DY+A2M7/79b0H44sY37y8gMeG6FNMiDL6syV4pNodMAuOdhDG4opRW9IAF6OUKPdBp4APeRFNQ87rNzsXTOaK2d61vGwZ8+m2/qo6S+S8JDdWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702071; c=relaxed/simple;
	bh=UWRZncS2QPcWGwFumX0G7GdV4/v5hWkOCQXfr5hwZLg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=BrHM6kRUhJojafRL5lOBE17fXDU4jRAyPtnnfX+OLfOKT7Hze541w23oN8oRVyT0uZ1SFYPJC2D5ZmdzPcaV+4EPvTSr9TN0CNLghQeE3N9Knucy0aTX8mGrSFg0xHwrI+yPX5NVtF+kllArlgW1vu1xqzgFkWe/ht9P737KDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdR/w8kv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fab81d6677so1538261a12.1;
        Thu, 08 May 2025 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746702068; x=1747306868; darn=vger.kernel.org;
        h=subject:cc:to:autocrypt:from:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWRZncS2QPcWGwFumX0G7GdV4/v5hWkOCQXfr5hwZLg=;
        b=ZdR/w8kvQdfkKANUhDq8Eb0uDeEAcMFQ83b0FhOaOC0q3hj29X5wrsPW2ooOyr+yZr
         lEGJv8gFnIbV03U5FyJ20j5krwlnm4XPJFHUpegTS34fTfq5f5WwRP5mPfKnCi//pIto
         oF9xcN1obioVWsT14j05lSJiMvHJmAvOj8cRiHQaAmTS54UGxi+Uwz7pKajuP5hkOc+n
         oECtcbi0WQzb+yY8ClHS0hVpZ+LcDYJIPCkgo8xskshlz6DFYV+0IZXsdjNxQdFqBM8U
         aaCMRhL/djLFdMW8vy7fBZ9qOiIznLpUIVWgob2R3HQZVrlQoZtmnvx5H8GmP+5VPfgR
         Q/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746702068; x=1747306868;
        h=subject:cc:to:autocrypt:from:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UWRZncS2QPcWGwFumX0G7GdV4/v5hWkOCQXfr5hwZLg=;
        b=gwm9w7Xu/37UTj0FkJKm4dQaTlZQBQNBAiu7RMZlxXKeS00EMlpjiy3XGtFNJhtr5a
         tp1V0miXU/EIegP1szYQJGxNs0e1PyhY4CcWuH2BYauB5g6r1AnOBivhYwXK8TXAZrNr
         KhPyqBE9uEFseOyeiIRqE0WY55HSHLTUc6Wespjeh+w0kBPKvIhrAyCWg160dP6BY5zW
         0kVHKsMbCZ4ND954KnVhzwPrjfizUI2OQHTTj/cdhTa2AwjpV19MVM3hFIt0J8kNszCI
         aTkoz576lvqxvID8L1GDLef509gwA71qMTXIrdQ4tmaYkMwGrK8Vc5ub9LxyXDjLHhnx
         CFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+LRrSKxj8qRnBwV++ldUOxrN9NJmUYyVfyI/Pp3HCM8yeKhYlRMx3STiTBAJlOjspZzwVXyF6P6pGykiwow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjEZdh9JXcnoHHX5Q+sjTrF7rW1AFd1lKSOBENZI7SWA2bKLU
	Z1jZqWl3/vF170hbYp+oNdHbIYOAGbs58y7z0h9fRHS/jE5OPK8IcgMTDgZJi+xHFg==
X-Gm-Gg: ASbGnctcj/vBPAeeWXJ/L3EHwCa2JD4NXftCnxICPUhML9+kKj1JiLRRXVL5UwBToJx
	UXg+lVdH51x9qX+onrrzk/I6OvF5xnD0MCpqkgqdF0LQxgZo9jXtYhdVh7XqQVCiWhQz46gJBHm
	PZgKlUJXXOYi29clcC7wUPrMvD1WZc+SjjxnRXpB5StGZ29BdtlZHn9BpkXirwqz5vm+QlgloOL
	YOsyr4JHUaW3Zx8ls/Oqq8/DpOH/FQaLABOSvefalM88lekxSCnjiMztH0v+Ia6T7YYKNFXCnGC
	xazGwo0G+3n86mJTl9XDZG9MU+Zw6xlW1Ql/LgaX4VLZHSUIZSQc46TJyA==
X-Google-Smtp-Source: AGHT+IGXcnaZHYPKq/dhQC/JYTZIU8obL8FNUXc0U+57oUfGHOwcSvmEe6rWuvYCRdjllDkzevujmw==
X-Received: by 2002:a05:6402:51cb:b0:5fa:7fbb:795a with SMTP id 4fb4d7f45d1cf-5fbe9dfc028mr5763725a12.12.1746702067635;
        Thu, 08 May 2025 04:01:07 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.1.131])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777c8b70sm11395667a12.29.2025.05.08.04.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 04:01:06 -0700 (PDT)
Message-ID: <e26e4e8b-90d5-4543-af0a-ba5cebf516d8@gmail.com>
Date: Thu, 8 May 2025 12:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
To: Jeff Johnson <jjohnson@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: issue wth ath12k in ath12k_dbring_buffer_release_event
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Qn6rYSM1EZIvS2m3LJpJeqma"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Qn6rYSM1EZIvS2m3LJpJeqma
Content-Type: multipart/mixed; boundary="------------nTP9sb0YN4CarL3sB3z03t9Y";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <e26e4e8b-90d5-4543-af0a-ba5cebf516d8@gmail.com>
Subject: issue wth ath12k in ath12k_dbring_buffer_release_event

--------------nTP9sb0YN4CarL3sB3z03t9Y
Content-Type: multipart/mixed; boundary="------------Hp2MBjPY7M1eIyorSHCPT30z"

--------------Hp2MBjPY7M1eIyorSHCPT30z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkluIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvZGJyaW5nLmMgZnVu
Y3Rpb24gDQphdGgxMmtfZGJyaW5nX2J1ZmZlcl9yZWxlYXNlX2V2ZW50KCkgdGhlcmUgaXMg
YSBsYXJnZSBodW5rIG9mIGNvZGUgdGhhdCANCmlzIG5ldmVyIGV4ZWN1dGVkIGJlY2F1c2Ug
cmluZyBpcyBOVUxMLiAgVGhlIGNvZGUgdGhhdCBpcyBuZXZlciBleGVjdXRlZCANCmlzIGEg
ZmFpcmx5IGxhcmdlIHBhcnQgb2YgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIGNvZGUsIHNv
IEkgdGhpcyBsb29rcyANCmxpa2UgYSBidWcgdG8gbWUuDQoNCkFuYWx5c2lzIGJlbG93LCBt
eSBjb21tZW50cyBwcmVmaXhlZCBieSAvLw0KDQppbnQgYXRoMTJrX2RicmluZ19idWZmZXJf
cmVsZWFzZV9ldmVudChzdHJ1Y3QgYXRoMTJrX2Jhc2UgKmFiLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgDQpzdHJ1
Y3QgYXRoMTJrX2RicmluZ19idWZfcmVsZWFzZV9ldmVudCAqZXYpDQp7DQogICAgICAgICBz
dHJ1Y3QgYXRoMTJrX2RicmluZyAqcmluZyA9IE5VTEw7DQoNCi8vIHJpbmcgaXMgc2V0IHRv
IE5VTEwNCg0KICAgICAgICAgc3RydWN0IGhhbF9zcm5nICpzcm5nOw0KICAgICAgICAgc3Ry
dWN0IGF0aDEyayAqYXI7DQogICAgICAgICBzdHJ1Y3QgYXRoMTJrX2RicmluZ19lbGVtZW50
ICpidWZmOw0KICAgICAgICAgc3RydWN0IGF0aDEya19kYnJpbmdfZGF0YSBoYW5kbGVyX2Rh
dGE7DQogICAgICAgICBzdHJ1Y3QgYXRoMTJrX2J1ZmZlcl9hZGRyIGRlc2M7DQogICAgICAg
ICB1OCAqdmFkZHJfdW5hbGlnbjsNCiAgICAgICAgIHUzMiBudW1fZW50cnksIG51bV9idWZm
X3JlYXBlZDsNCiAgICAgICAgIHU4IHBkZXZfaWR4LCByYm07DQogICAgICAgICB1MzIgY29v
a2llOw0KICAgICAgICAgaW50IGJ1Zl9pZDsNCiAgICAgICAgIGludCBzaXplOw0KICAgICAg
ICAgZG1hX2FkZHJfdCBwYWRkcjsNCiAgICAgICAgIGludCByZXQgPSAwOw0KDQogICAgICAg
ICBwZGV2X2lkeCA9IGxlMzJfdG9fY3B1KGV2LT5maXhlZC5wZGV2X2lkKTsNCg0KICAgICAg
ICAgaWYgKHBkZXZfaWR4ID49IGFiLT5udW1fcmFkaW9zKSB7DQogICAgICAgICAgICAgICAg
IGF0aDEya193YXJuKGFiLCAiSW52YWxpZCBwZGV2IGlkICVkXG4iLCBwZGV2X2lkeCk7DQog
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICAgICAgfQ0KDQogICAgICAg
ICBpZiAoZXYtPmZpeGVkLm51bV9idWZfcmVsZWFzZV9lbnRyeSAhPQ0KICAgICAgICAgICAg
IGV2LT5maXhlZC5udW1fbWV0YV9kYXRhX2VudHJ5KSB7DQogICAgICAgICAgICAgICAgIGF0
aDEya193YXJuKGFiLCAiQnVmZmVyIGVudHJ5ICVkIG1pc21hdGNoIG1ldGEgZW50cnkgJWRc
biIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2LT5maXhlZC5udW1fYnVmX3Jl
bGVhc2VfZW50cnksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV2LT5maXhlZC5u
dW1fbWV0YV9kYXRhX2VudHJ5KTsNCiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQogICAgICAgICB9DQoNCiAgICAgICAgIGFyID0gYWItPnBkZXZzW3BkZXZfaWR4XS5hcjsN
Cg0KICAgICAgICAgcmN1X3JlYWRfbG9jaygpOw0KICAgICAgICAgaWYgKCFyY3VfZGVyZWZl
cmVuY2UoYWItPnBkZXZzX2FjdGl2ZVtwZGV2X2lkeF0pKSB7DQogICAgICAgICAgICAgICAg
IHJldCA9IC1FSU5WQUw7DQogICAgICAgICAgICAgICAgIGdvdG8gcmN1X3VubG9jazsNCiAg
ICAgICAgIH0NCg0KICAgICAgICAgc3dpdGNoIChldi0+Zml4ZWQubW9kdWxlX2lkKSB7DQog
ICAgICAgICBjYXNlIFdNSV9ESVJFQ1RfQlVGX1NQRUNUUkFMOg0KICAgICAgICAgICAgICAg
ICBicmVhazsNCiAgICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAgICAgIHJpbmcgPSBO
VUxMOw0KICAgICAgICAgICAgICAgICBhdGgxMmtfd2FybihhYiwgIlJlY3YgZG1hIGJ1ZmZl
ciByZWxlYXNlIGV2IG9uIHVuc3VwcCANCm1vZHVsZSAlZFxuIiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZXYtPmZpeGVkLm1vZHVsZV9pZCk7DQogICAgICAgICAgICAgICAg
IGJyZWFrOw0KICAgICAgICAgfQ0KDQovLyByaW5nIGlzIHN0aWxsIE5VTEwNCg0KICAgICAg
ICAgaWYgKCFyaW5nKSB7DQogICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQogICAg
ICAgICAgICAgICAgIGdvdG8gcmN1X3VubG9jazsNCiAgICAgICAgIH0NCg0KLy8gdGhlIGZv
bGxvd2luZyBjb2RlIGlzICpuZXZlciogZXhlY3V0ZWQNCg0KICAgICAgICAgc3JuZyA9ICZh
Yi0+aGFsLnNybmdfbGlzdFtyaW5nLT5yZWZpbGxfc3JuZy5yaW5nX2lkXTsNCiAgICAgICAg
IG51bV9lbnRyeSA9IGxlMzJfdG9fY3B1KGV2LT5maXhlZC5udW1fYnVmX3JlbGVhc2VfZW50
cnkpOw0KICAgICAgICAgLi4uLg0KICAgICAgICAgLi4uLg0KDQoNCkNvbGluDQo=
--------------Hp2MBjPY7M1eIyorSHCPT30z
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

--------------Hp2MBjPY7M1eIyorSHCPT30z--

--------------nTP9sb0YN4CarL3sB3z03t9Y--

--------------Qn6rYSM1EZIvS2m3LJpJeqma
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmgcjucFAwAAAAAACgkQaMKH38aoAiYR
rw/6Avd32kw4+viZjrWh4EQmlhgo/uFTUZ3lju2FbH5O5Z6833NYL1ep/XQAVE8XrktAMwyTeUd4
y6vF0ugQoALPqVNSIay9O0WQPj0Xi0v++awByYuG+UtTm94WfrgzSpI8fRgbcWCg2HuzHYad0gWZ
VE+xTo9BlF2wQM+iCcnj/cmr1+qEdp5EKeftOnykFG7q/emwGhAoWCkwy1//GgK+kgInlYtiPv8p
qLJdvaeBsS+OrxxXg6+ZuHweCmg3TXNo769UnPbLAOqsCrVAblDVtuckEo07ekrBqP51rrTuLO+B
pXRPD71XrGJ0MIyEAZnBRNPIpGiGkZLkR7iIEShwQoRj4PEgob7nsbJgMk3fKx3jILESafZ9zDDX
eoZXvIRLdZMHSt9wZcCAwii24Dwgb72xvuz8WvixlFoAIItaaXCM34qA9LW35gn9kni2vGjICC4d
LLGgN77lpFeyhBFV/VwLGBhGq98tiv4QkNY1eqdRT5DpNOvmocbyiG4cybfN3yM6Jd9Z58eZ6Rp/
PY+akf17eX2QlgQiOPQNJ1oriknEyK3D5YzoWxrXnLJbhf6/R54JB96gHKIYDVi/F/rTb/558g8K
Btolw98Gvfcek4LcV0Ixrxg6JYM0XWuS9lw1MUoxtcsijkdNKcrtk1Gyy98blACAyTTxV5c/ORN6
v0U=
=U6bF
-----END PGP SIGNATURE-----

--------------Qn6rYSM1EZIvS2m3LJpJeqma--

