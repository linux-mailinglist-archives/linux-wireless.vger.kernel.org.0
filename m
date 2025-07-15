Return-Path: <linux-wireless+bounces-25427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6542B04DB8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 04:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1337AC5C0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 02:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715182C3272;
	Tue, 15 Jul 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj2KM3qW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDA2C031E;
	Tue, 15 Jul 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545546; cv=none; b=pZSzS0uAtAvibLbefpvALXetxXfKTqpzTVBhAm/ogaBZ7ay50igWyCWUMxYYXjOhirqvXkPXxMvRg+LNujYfmy0z74X24Joxmx/Z2go3iviBR0Bigd7hwC1jL3Uq2X+QjBKRRoW2cP27WzLa4jsK+pmIgQWNosz4iGJSGHKvj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545546; c=relaxed/simple;
	bh=OL8eh+ET7ODxT9eqmQeIc1DaHSMO83XtpakOahXi1HI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YUcqouvKLpWxbaitDOl3uVkGCgjrCUXSKqVxCUSHrWZoeEmhNTxJszuI/Giawm3nPwZh/9C9sASybsBhCSXYkSAkhCHAH7petsFvrMSV2/gjmqO8kL9sjqBmt3k4j/ClHep34ZA23MB1W4h5lmKD8VFpSoBSQCYx/P6gWV8vYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj2KM3qW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e77831d68so49483907b3.2;
        Mon, 14 Jul 2025 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752545544; x=1753150344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P/kiJ0AGrl246k+hU6tFxQRZl1/F2KkE4EwQPyUtMzE=;
        b=Qj2KM3qWj2A0U38RoMxsNatdKf3Ng09JND+snq19qy1MWGKoChQInuM3Efj8PnhzoU
         x3Lk6/Q/WMVGMHiN2ImrtnNq+l3gL9XsZODSpg3PrkaKbca+Y6hn0UIio5d1Pplc7Xy3
         50tCp2mSiaTXvL8yRrR8bCEQlbrW8qK2wkhoGoOIB5of4NjSG15nxl0yxg/YPTTMlWkC
         w1eTa85JK6Tu4GIBy+wfTilrxMzdO1/2B4+oBziIUVn8MvRpZta64EMp4bJQcDtK+jFb
         dGwMA4WAmdPwZP+wRY++6Xd1mD9tfzZtjxPn4UxUaG/29LSxlX6fYuZz51RKcSAoZ6E8
         5ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545544; x=1753150344;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/kiJ0AGrl246k+hU6tFxQRZl1/F2KkE4EwQPyUtMzE=;
        b=heJQ9KFXpJvTcHvKpp/Nt/hAOY6j15XlUiEhR2Vv9JV9iLhqY27Q+Zlq1MV/9qn+LH
         Envfv9WSpen7tBMX/OEnat7uRxDFubTcecnaAQXSo7/04Ou7taOwpK5O7dk0+8KkouRg
         fYeTj3PEjFO/7IfY8Qac/nNw9jChvJCNS8e4Q8MHyhcuWSOJyRrG94SBpDDEFPal2x2t
         24yyglKR+jrYTpK5Bjzf6nsAWyCrhvRDggfkKweOdgNn4p8OD7qvzbU6cdJjsCXAdpL6
         OS50GeU/3LT98wT7YW/SIuMlm6PgjJuAHBbvExXen2aTU+iOt8MPMySZqumvWlWMUJ0b
         2UZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGnBG43aB9P9eIu1Qyebe+B2lUyNKa71iBxhU5xbY+oIvSOM1ZgNiemhGo8WzOv40CgoFG6sN0Xc61V41wGyg=@vger.kernel.org, AJvYcCWjSZa1T/fQfjHPr5VUk3ZEr3v7Px87B0a17qyWI8EQ9HPQdz/iN4IJf+jbf6Wb1wyFz84ylfsWp85bfow=@vger.kernel.org, AJvYcCXvhrAs51mA4ekXE5NjQA6r6uuVl/IL5NEGRPLxmpQDIyVIWW4iLvBI0YUvdf2V3brxU/GXQXdW@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkKk6t3D8N4GYs9iA84nFfI0bS0YB0qI8Jxt5go4phScbPvvO
	9jUuSMFAwSdtKxqJTKpMxRflvmYDxIypNB5fojyr1kjJaaLH9Yvn9dzwKdgR1Dhnf8RSz+VO0Qy
	SNlPh8R9SycqRFztZaT5CuPnbF3bOUPI=
X-Gm-Gg: ASbGncud4rZs7Y0/a+xzU5AU2mWmyCgsWcWwC5b7/NKl5Dw9Gpay7iRk5GT88bzWDBQ
	w/FG2+66+Bivqw1KK6pN+fT06uDSiN/hfbtTe3/OrFlGT7pQWWdd+kbSvJTS+7XsV2eAsJfGZZ/
	qYyM5hu1ihXC07vbYy9Utl5uhZIbWgsmwFTg8p80gdr3Zjf1Wx7tZLBV7HmHBTL2pSjZi/yiYjN
	q4SHcwUCyp/7TIeimrdJXPqq+oPVCCpPP4a/LTY
X-Google-Smtp-Source: AGHT+IEtVr+JsxC2gJh379iPBuOZoVuruZ3Umbs9N3Juzg1W5BMxEFQML9bdmwsk2kq+ovB/XipjouSJmFQN3pe3GuQ=
X-Received: by 2002:a05:690c:f14:b0:717:c40f:be9c with SMTP id
 00721157ae682-717d5bc0652mr226143477b3.9.1752545543522; Mon, 14 Jul 2025
 19:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Mon, 14 Jul 2025 19:12:12 -0700
X-Gm-Features: Ac12FXwsgRjDPpzTojqRaKExjmsAG5iXutBqOoKqYivzz9QyVrL7TRtbrLx7q1o
Message-ID: <CAF3JpA4QvNvdx-tq-5ogMmmaOuZuYq8Q=JZjQj0egWGE-=Nogg@mail.gmail.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper
To: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000093565a0639ee4e4b"

--00000000000093565a0639ee4e4b
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
main

--00000000000093565a0639ee4e4b
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-mac80211-reject-TDLS-operations-when-station-is-not-.patch"
Content-Disposition: attachment; 
	filename="0001-mac80211-reject-TDLS-operations-when-station-is-not-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_md3w7m310>
X-Attachment-Id: f_md3w7m310

RnJvbSA2MGJjZWY2YzY3ZWRmNjZmZjk2MzY3ZTAzYWFhNzA0MjI1ODVlYTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogTW9uLCAxNCBKdWwgMjAyNSAxOTowMjoxMCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IG1hYzgwMjExOiByZWplY3QgVERMUyBvcGVyYXRpb25zIHdoZW4gc3RhdGlvbiBpcyBub3QKIGFz
c29jaWF0ZWQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFy
c2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRETFMgY2FuIGJlIGVz
dGFibGlzaGVkIG9ubHkgYWZ0ZXIgdGhlIFNUQSBpcyBjb25uZWN0ZWQgdG8gYW4gQVAuCklmIHVz
ZXJzcGFjZSAob3IgZnV6emVycykgaXNzdWVzIE5MODAyMTFfVERMU18qIGNvbW1hbmRzIGJlZm9y
ZQphc3NvY2lhdGlvbiBpcyBjb21wbGV0ZSwgaW50ZXJuYWwgc3RhdGUgc3VjaCBhcyBzZGF0YS0+
dS5tZ2QudGRsc19wZWVyCnJlbWFpbnMgdW5pbml0aWFsaXNlZCBhbmQgaWVlZTgwMjExX3RkbHNf
b3BlcigpIHJhaXNlcyBXQVJOX09OKCkuCgpBZGQgYW4g4oCcYXNzb2NpYXRlZOKAnSBjaGVjayBp
biBpZWVlODAyMTFfdGRsc19vcGVyKCkgc28gdGhlIGZ1bmN0aW9uCnJldHVybnMgLUVJTlZBTCB3
aGVuZXZlciB0aGUgaW50ZXJmYWNlIGlzIG5vdCBib3RoIGluIHN0YXRpb24gbW9kZQphbmQgYWxy
ZWFkeSBhc3NvY2lhdGVkLgoKU2lnbmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxl
ZS5jYUBnbWFpbC5jb20+Ci0tLQogbmV0L21hYzgwMjExL3RkbHMuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9t
YWM4MDIxMS90ZGxzLmMgYi9uZXQvbWFjODAyMTEvdGRscy5jCmluZGV4IDk0NzE0ZjhmZmQyMi4u
YmE1ZmJhY2JlZWRhIDEwMDY0NAotLS0gYS9uZXQvbWFjODAyMTEvdGRscy5jCisrKyBiL25ldC9t
YWM4MDIxMS90ZGxzLmMKQEAgLTE0MjIsNyArMTQyMiw3IEBAIGludCBpZWVlODAyMTFfdGRsc19v
cGVyKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJaWYgKCEo
d2lwaHktPmZsYWdzICYgV0lQSFlfRkxBR19TVVBQT1JUU19URExTKSkKIAkJcmV0dXJuIC1FT1BO
T1RTVVBQOwogCi0JaWYgKHNkYXRhLT52aWYudHlwZSAhPSBOTDgwMjExX0lGVFlQRV9TVEFUSU9O
KQorCWlmIChzZGF0YS0+dmlmLnR5cGUgIT0gTkw4MDIxMV9JRlRZUEVfU1RBVElPTiB8fCAhc2Rh
dGEtPnZpZi5jZmcuYXNzb2MpCiAJCXJldHVybiAtRUlOVkFMOwogCiAJc3dpdGNoIChvcGVyKSB7
Ci0tIAoyLjQzLjAKCg==
--00000000000093565a0639ee4e4b--

