Return-Path: <linux-wireless+bounces-10870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9C94637B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 20:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EE1F23274
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A11547FE;
	Fri,  2 Aug 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVCnB6zK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFF1547D2
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624966; cv=none; b=Fjcd+RJY9sBMBCCxhNSZrIDR22f4Q4LbUoh9FAqOjjBq0vXgBbVxwYNE7k/ZJe4LWE+352DyEdS+TNou0dWVzvf9KCQx1JIZkVuVztnyDs6rqyMR8b0Pc+sHwtm7FXoiDPkwPEaHtOkNvaKoDyPqcFqBj0MIWKaPo7MFvZhD8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624966; c=relaxed/simple;
	bh=5XIIVcrtjkz1m8QUTFEwwYKiG2Gb7rDo4mN4yeogIho=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RRGWrRlhpH8wd0QQTvsw1NrDn0/Hvr2XiG5KYVsTbBO6bNl+ww2IaFKzNUvFjYZQ0ul6KhnGRvSoubruJpT+4YwrIGF/ncac6hoGgl+gQ9TI9TVuKdj9uO+kbD0HAugq8klVF+qw/jKnw4eAtJr8JOVi1R6v+dsklivvNSmbo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVCnB6zK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-268a9645e72so341798fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722624963; x=1723229763; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r8biEIuwQim/fBRxtDHfs8wQhj7hvVnO8/2VRF3PfH8=;
        b=eVCnB6zKHB0IZyteTF5HG01LubRO5eJ11x6ltTQ8Fxt6SIt20nOTrV4ENtXa+XpF6w
         fwPVbPGlxlvJnoZTniPwbZtwWJKCIOmYp3LgqMj2qI9q5wTQd08j557noQTRX5qnqsPB
         CP9E+y0Nfe0qH7RC5A320ik5YPNO3TaSXFZHUFyD1yBLxB5eGk3dkX2OMrz2lYtsdUvE
         QRNCDLZFdgG6cYev2q4PsctIBCtwSCryIXn/xHbYKYo1SjwYf5pjykbdVy3gWEm4dhId
         uD5Swem3oZ81cf94UoHfVslcsk44xRczUWT1gq2PO5eLXhjaAydaOGa9au4Uv/3e3NFh
         XU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624963; x=1723229763;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8biEIuwQim/fBRxtDHfs8wQhj7hvVnO8/2VRF3PfH8=;
        b=COoNCPlCDK6PVeq/T9qz7iP7Tv0ajxvUl3ecJ+QF1Qz23/50xgGFNDzzb6XBimg1p0
         40Ahw0tIl81hHuXtfBbIS4akKe1MdXkYqs0n14+DQHfbaFCXT6gX3ym7KXmQC7g8EKn7
         XbPhuDcs5inZvF2u8GjQ3F63ie96McyN/VPkb34yyfwHcQjJ014yKY0D5CYwPebk+/Rc
         P+UghcTjc2gt0bXVnrPmJU1Ur3ovrYpoUQvUZWtf/LF2KngJBwxBDO/AZIybr91OV9ja
         4pKtgGh4qsvlgAEzMQK1SngCpK5gOECGNJGvRvAhbco6azE+Z6XMd2eaj7+GHq7hmzZ7
         uYHg==
X-Gm-Message-State: AOJu0Yz2wa+P01/asz7Efi9j7nHL6ImXp0jxM/ckhVI7HmHT+9Gmgevt
	35s9MSQ5PlzIS80kcabLN0L6r6u/ORPyouqkcTO25am+AJO01B/nfI2nlr0qITRNlCe7eiLnxyc
	NKls8BdFRjnMEbzX1iskKAF+ME6Ft5vMa
X-Google-Smtp-Source: AGHT+IHd7V4RApIg0w4il7AXVn7aV36WD5/iOxmEVWxt93dEanAzjbD6OUIxSc0i6dbLbZKY8LSx64r8YO3vBdb1Rew=
X-Received: by 2002:a05:6870:b527:b0:261:2072:7b5d with SMTP id
 586e51a60fabf-26891d461b3mr5591585fac.29.1722624963543; Fri, 02 Aug 2024
 11:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SALVATORE BUONO <tottobuono@gmail.com>
Date: Fri, 2 Aug 2024 20:55:52 +0200
Message-ID: <CAH_QiWBD3DdGL-GocHjakJvwrZNMzoiJ+RfCm5iiZf8msbbJ8g@mail.gmail.com>
Subject: Problem with driver ath10k_pci
To: linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000008a1f3061eb7e1f2"

--00000000000008a1f3061eb7e1f2
Content-Type: multipart/alternative; boundary="00000000000008a1f3061eb7e1f0"

--00000000000008a1f3061eb7e1f0
Content-Type: text/plain; charset="UTF-8"

Good morning, there is a problem with this driver with new version of
ubuntu, since before I update to 24.04 it works correctly, but now it does
not work anymore after sleep/suspension. It disconnects and I tried a lot
of commands to restart the wifi module but it does not work. This is the
discussion on ubuntu forum, but no solution is found. Can you fix it?


*Salvatore Buono*

--00000000000008a1f3061eb7e1f0
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Good morning, there is a problem with this driver with new version 
of ubuntu, since before I update to 24.04 it works correctly, but now it
 does not work anymore after sleep/suspension. It disconnects and I 
tried a lot of commands to restart the wifi module but it does not work.
 This is the discussion on ubuntu forum, but no solution is found. Can 
you fix it?</div><div><br><br></div><div><div dir="ltr" class="gmail_signature" data-smartmail="gmail_signature"><div dir="ltr"><i>Salvatore Buono</i></div></div></div></div>

--00000000000008a1f3061eb7e1f0--
--00000000000008a1f3061eb7e1f2
Content-Type: text/plain; charset="US-ASCII"; name="output.txt"
Content-Disposition: attachment; filename="output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lzd2f0iv0>
X-Attachment-Id: f_lzd2f0iv0

c2FsdmF0b3JlQHNhbHZhdG9yZS1JbnNwaXJvbi01NTE1On4kIHN1ZG8gZG1lc2cgfCBncmVwIGF0
aDEwawpbICAgIDMuNTA5MjA2XSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZW5hYmxpbmcgZGV2
aWNlICgwMDAwIC0+IDAwMDIpClsgICAgMy41MTEwNDNdIGF0aDEwa19wY2kgMDAwMDowMjowMC4w
OiBwY2kgaXJxIG1zaSBvcGVyX2lycV9tb2RlIDIgaXJxX21vZGUgMCByZXNldF9tb2RlIDAKWyAg
ICAzLjczNDA3MV0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IHFjYTYxNzQgaHczLjIgdGFyZ2V0
IDB4MDUwMzAwMDAgY2hpcF9pZCAweDAwMzQwYWZmIHN1YiAxMDI4OjAzMTAKWyAgICAzLjczNDA4
MV0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGtjb25maWcgZGVidWcgMCBkZWJ1Z2ZzIDEgdHJh
Y2luZyAxIGRmcyAwIHRlc3Rtb2RlIDAKWyAgICAzLjczNDQzMl0gYXRoMTBrX3BjaSAwMDAwOjAy
OjAwLjA6IGZpcm13YXJlIHZlciBXTEFOLlJNLjQuNC4xLTAwMzA5LSBhcGkgNiBmZWF0dXJlcyB3
b3dsYW4saWdub3JlLW90cCxtZnAgY3JjMzIgMDc5M2JjZjIKWyAgICAzLjc5OTQzOV0gYXRoMTBr
X3BjaSAwMDAwOjAyOjAwLjA6IGJvYXJkX2ZpbGUgYXBpIDIgYm1pX2lkIE4vQSBjcmMzMiBkMjg2
M2Y5MQpbICAgIDMuODgxMjIzXSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogaHR0LXZlciAzLjg3
IHdtaS1vcCA0IGh0dC1vcCAzIGNhbCBvdHAgbWF4LXN0YSAzMiByYXcgMCBod2NyeXB0byAxClsg
ICAgNS44MDQ1ODldIGF0aDEwa19wY2kgMDAwMDowMjowMC4wIHdscDJzMDogcmVuYW1lZCBmcm9t
IHdsYW4wClsgIDM5NC45NjQyMzldIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBBTUQtVmk6IEV2
ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBiIGFkZHJlc3M9MHhmYjI5NGY1
MCBmbGFncz0weDAwNzBdClsgIDQwMi44NDMwMzhdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBw
Y2kgaXJxIG1zaSBvcGVyX2lycV9tb2RlIDIgaXJxX21vZGUgMCByZXNldF9tb2RlIDAKWyAgNDAz
LjA0NTc3Ml0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IHFjYTYxNzQgaHczLjIgdGFyZ2V0IDB4
MDUwMzAwMDAgY2hpcF9pZCAweDAwMzQwYWZmIHN1YiAxMDI4OjAzMTAKWyAgNDAzLjA0NTc4OF0g
YXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGtjb25maWcgZGVidWcgMCBkZWJ1Z2ZzIDEgdHJhY2lu
ZyAxIGRmcyAwIHRlc3Rtb2RlIDAKWyAgNDAzLjA0NjM1M10gYXRoMTBrX3BjaSAwMDAwOjAyOjAw
LjA6IGZpcm13YXJlIHZlciBXTEFOLlJNLjQuNC4xLTAwMzA5LSBhcGkgNiBmZWF0dXJlcyB3b3ds
YW4saWdub3JlLW90cCxtZnAgY3JjMzIgMDc5M2JjZjIKWyAgNDAzLjExMDYxNl0gYXRoMTBrX3Bj
aSAwMDAwOjAyOjAwLjA6IGJvYXJkX2ZpbGUgYXBpIDIgYm1pX2lkIE4vQSBjcmMzMiBkMjg2M2Y5
MQpbICA0MDMuMTk3NTMxXSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogaHR0LXZlciAzLjg3IHdt
aS1vcCA0IGh0dC1vcCAzIGNhbCBvdHAgbWF4LXN0YSAzMiByYXcgMCBod2NyeXB0byAxClsgIDQw
My4yNTk3MjJdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wIHdscDJzMDogcmVuYW1lZCBmcm9tIHds
YW4wClsgIDQxOC41NDUwNzVdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiB0aW1lZCBvdXQgd2Fp
dGluZyBwZWVyIHN0YXRzIGluZm8KWyAgNDIzLjUzNzEyN10gYXRoMTBrX3BjaSAwMDAwOjAyOjAw
LjA6IHdtaSBjb21tYW5kIDkwMTEzIHRpbWVvdXQsIHJlc3RhcnRpbmcgaGFyZHdhcmUKWyAgNDIz
LjUzNzE0N10gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGNvdWxkIG5vdCByZXF1ZXN0IHN0YXRz
ICgtMTEpClsgIDQyMy41NDkxMzJdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBjb3VsZCBub3Qg
cmVxdWVzdCBwZWVyIHN0YXRzIGluZm86IC0xMDgKWyAgNDIzLjU1OTY5MV0gYXRoMTBrX3BjaSAw
MDAwOjAyOjAwLjA6IGZhaWxlZCB0byByZWFkIGhpX2JvYXJkX2RhdGEgYWRkcmVzczogLTE2Clsg
IDQyNi41ODc2MDZdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gcmVjZWl2ZSBp
bml0aWFsaXplZCBldmVudCBmcm9tIHRhcmdldDogMDAwMDAwMDAKWyAgNDI5LjYwMzgwN10gYXRo
MTBrX3BjaSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byByZWNlaXZlIGluaXRpYWxpemVkIGV2ZW50
IGZyb20gdGFyZ2V0OiAwMDAwMDAwMApbICA0MjkuNjAzODI0XSBhdGgxMGtfcGNpIDAwMDA6MDI6
MDAuMDogZmFpbGVkIHRvIHdhaXQgZm9yIHRhcmdldCBpbml0OiAtMTEwClsgIDQyOS42MDY2NDdd
IGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gZGVsZXRlIFdNSSB2ZGV2IDE6IC0x
MDgKWyAgNDI5LjYwNjY1N10gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBzZXQg
MmcgdHhwb3dlciA0NjogLTEwOApbICA0MjkuNjA2NjYxXSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAu
MDogZmFpbGVkIHRvIHNldHVwIHR4IHBvd2VyIDIzOiAtMTA4ClsgIDQyOS42MDY2NjRdIGF0aDEw
a19wY2kgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gcmVjYWxjIHR4IHBvd2VyOiAtMTA4ClsgIDQy
OS42MDY4NTVdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gZmx1c2ggdHJhbnNt
aXQgcXVldWUgKHNraXAgMSBhci1zdGF0ZSAyKTogNTAwMApbICA0MjkuNjA2ODk4XSBhdGgxMGtf
cGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIGZsdXNoIHRyYW5zbWl0IHF1ZXVlIChza2lwIDEg
YXItc3RhdGUgMik6IDUwMDAKWyAgNDI5LjYwNjk1Ml0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6
IGZhaWxlZCB0byBkZWxldGUgcGVlciAwMDphYjo0ODowYzoyMDphNiBmb3IgdmRldiAwOiAtMTA4
ClsgIDQyOS42MDcwNzZdIE1vZHVsZXMgbGlua2VkIGluOiBhdGgxMGtfcGNpIGF0aDEwa19jb3Jl
IGNjbSByZmNvbW0gc25kX3NlcV9kdW1teSBzbmRfaHJ0aW1lciBxcnRyIGNtYWMgYWxnaWZfaGFz
aCBhbGdpZl9za2NpcGhlciBhZl9hbGcgYm5lcCBiaW5mbXRfbWlzYyBzbmRfYWNwX2xlZ2FjeV9t
YWNoIHNuZF9hY3BfbWFjaCBzbmRfY3RsX2xlZCBzbmRfc29jX25hdTg4MjEgc25kX2FjcDN4X3Bk
bV9kbWEgc25kX3NvY19kbWljIHNuZF9hY3AzeF9ybiBzbmRfc29mX2FtZF9hY3A2MyBzbmRfc29m
X2FtZF92YW5nb2doIHNuZF9zb2ZfYW1kX3JlbWJyYW5kdCBzbmRfc29mX2FtZF9yZW5vaXIgc25k
X3NvZl9hbWRfYWNwIG5sc19pc284ODU5XzEgc25kX2hkYV9jb2RlY19yZWFsdGVrIGludGVsX3Jh
cGxfbXNyIHNuZF9zb2ZfcGNpIGludGVsX3JhcGxfY29tbW9uIHNuZF9zb2ZfeHRlbnNhX2RzcCBz
bmRfaGRhX2NvZGVjX2dlbmVyaWMgc25kX2hkYV9jb2RlY19oZG1pIHNuZF9zb2Ygc25kX2hkYV9p
bnRlbCBlZGFjX21jZV9hbWQgc25kX3NvZl91dGlscyBzbmRfaW50ZWxfZHNwY2ZnIHNuZF9pbnRl
bF9zZHdfYWNwaSBzbmRfc29jX2NvcmUgc25kX2hkYV9jb2RlYyBrdm1fYW1kIHNuZF9jb21wcmVz
cyBhbWRncHUgc25kX2hkYV9jb3JlIGF0aCBhYzk3X2J1cyBrdm0gc25kX2h3ZGVwIHNuZF9wY21f
ZG1hZW5naW5lIHNuZF9wY2lfcHMgdXZjdmlkZW8gYW1keGNwIHNuZF9ycGxfcGNpX2FjcDZ4IHNu
ZF9zZXFfbWlkaSBkcm1fZXhlYyBzbmRfc2VxX21pZGlfZXZlbnQgc25kX2FjcF9wY2kgdmlkZW9i
dWYyX3ZtYWxsb2MgaXJxYnlwYXNzIGJ0dXNiIHV2YyBncHVfc2NoZWQgc25kX2FjcF9sZWdhY3lf
Y29tbW9uIGNyY3QxMGRpZl9wY2xtdWwgdmlkZW9idWYyX21lbW9wcyBtYWM4MDIxMSBzbmRfcmF3
bWlkaSBidHJ0bCBzbmRfcGNpX2FjcDZ4IGRybV9idWRkeSBwb2x5dmFsX2NsbXVsbmkgdmlkZW9i
dWYyX3Y0bDIgYnRpbnRlbCBkcm1fc3ViYWxsb2NfaGVscGVyIHBvbHl2YWxfZ2VuZXJpYyBzbmRf
c2VxIHNuZF9wY20KWyAgNDI5LjYwNzE4OV0gIGJ0YmNtIGRybV90dG1faGVscGVyIGdoYXNoX2Ns
bXVsbmlfaW50ZWwgdmlkZW9kZXYgYnRtdGsgc2hhMjU2X3Nzc2UzIHR0bSBkZWxsX2xhcHRvcCBz
aGExX3Nzc2UzIHNuZF9zZXFfZGV2aWNlIGRybV9kaXNwbGF5X2hlbHBlciBzbmRfcGNpX2FjcDV4
IGRlbGxfd21pIHNuZF90aW1lciBibHVldG9vdGggYWVzbmlfaW50ZWwgdmlkZW9idWYyX2NvbW1v
biBjZWMgZGVsbF9zbWJpb3Mgc25kX3JuX3BjaV9hY3AzeCBjZmc4MDIxMSBzbmQgY3J5cHRvX3Np
bWQgZGNkYmFzIGNyeXB0ZCBzbmRfYWNwX2NvbmZpZyBtYyBlY2RoX2dlbmVyaWMgbGVkdHJpZ19h
dWRpbyBzbmRfc29jX2FjcGkgcmNfY29yZSBlY2MgcmFwbCBkZWxsX3NtbV9od21vbiBzcGFyc2Vf
a2V5bWFwIGRlbGxfd21pX2Rlc2NyaXB0b3Igd21pX2Jtb2YgaTJjX2FsZ29fYml0IGNjcCBzb3Vu
ZGNvcmUgbGliYXJjNCBzbmRfcGNpX2FjcDN4IGkyY19waWl4NCBrMTB0ZW1wIGRlbGxfcmJ0biBh
bWRfcG1jIGpveWRldiBpbnB1dF9sZWRzIGFjcGlfdGFkIHNlcmlvX3JhdyBtYWNfaGlkIG1zciBw
YXJwb3J0X3BjIHBwZGV2IGxwIHBhcnBvcnQgZWZpX3BzdG9yZSBuZm5ldGxpbmsgZG1pX3N5c2Zz
IGlwX3RhYmxlcyB4X3RhYmxlcyBhdXRvZnM0IHZpZGVvIGhpZF9tdWx0aXRvdWNoIGhpZF9nZW5l
cmljIG52bWUgdWNzaV9hY3BpIGNyYzMyX3BjbG11bCBwc21vdXNlIG52bWVfY29yZSBhaGNpIHR5
cGVjX3Vjc2kgeGhjaV9wY2kgaTJjX2hpZF9hY3BpIGxpYmFoY2kgeGhjaV9wY2lfcmVuZXNhcyBu
dm1lX2F1dGggdHlwZWMgaTJjX2hpZCBoaWQgd21pIFtsYXN0IHVubG9hZGVkOiBhdGgxMGtfY29y
ZV0KWyAgNDI5LjYwODQ2MV0gID8gYXRoMTBrX21vbml0b3JfcmVjYWxjKzB4N2EvMHgxZDAgW2F0
aDEwa19jb3JlXQpbICA0MjkuNjA4OTkzXSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogY291bGQg
bm90IHJlcXVlc3Qgc3RhdHMgKC0xMDgpClsgIDQyOS42MDkxMDhdIGF0aDEwa19wY2kgMDAwMDow
MjowMC4wOiBmYWlsZWQgdG8gcmVjYWxjdWxhdGUgcnRzL2N0cyBwcm90IGZvciB2ZGV2IDA6IC0x
MDgKWyAgNDMzLjk5NTAxNl0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byByZWNl
aXZlIGluaXRpYWxpemVkIGV2ZW50IGZyb20gdGFyZ2V0OiAwMDAwMDAwMApbICA0MzMuOTk1MDQ1
XSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIHJlc2V0IGNoaXA6IC0xMTAKWyAg
NDMzLjk5NTA1NV0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IENvdWxkIG5vdCBpbml0IGhpZjog
LTExMApbICA0MzcuMDQ0OTI2XSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIHJl
Y2VpdmUgaW5pdGlhbGl6ZWQgZXZlbnQgZnJvbSB0YXJnZXQ6IDAwMDAwMDAwClsgIDQzNy4wNDQ5
NDRdIGF0aDEwa193YXJuOiAxNiBjYWxsYmFja3Mgc3VwcHJlc3NlZApbICA0MzcuMDQ0OTQ5XSBh
dGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIHdhaXQgZm9yIHRhcmdldCBhZnRlciBj
b2xkIHJlc2V0OiAtMTEwClsgIDQzNy4wNDQ5NThdIGF0aDEwa19wY2kgMDAwMDowMjowMC4wOiBm
YWlsZWQgdG8gcmVzZXQgY2hpcDogLTExMApbICA0MzcuMDQ0OTY2XSBhdGgxMGtfcGNpIDAwMDA6
MDI6MDAuMDogQ291bGQgbm90IGluaXQgaGlmOiAtMTEwCgo=
--00000000000008a1f3061eb7e1f2--

