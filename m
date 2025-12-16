Return-Path: <linux-wireless+bounces-29770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 546ECCC0B00
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 04:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 012753021987
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 03:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FD2DFA54;
	Tue, 16 Dec 2025 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO72bJlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0730BBAB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854731; cv=none; b=cP6bgz4rJ1qTZXdRx7TGjjuLa5RR/XGYR79QbIDDdRUmn9S47fn0Jcv3dMVZoqNt3a36IT4H9OuVV/+h9oFMq1NYtFqXjKkzlZzBbWEvokVJLcQDuePUB8MaZiU2aOHISvijtLu02bCJ8RbjU+3CsHA55NJhLlUOpsYPE3x6SJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854731; c=relaxed/simple;
	bh=iQmxm0djq24+dQscJhL0ForU9FpsRolrvAnU9DdLBek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rs+aHTxSKq0G/v89TZMm7b8uvw8taN4v3nALNcua0KqbhTjWR/DbjNxgtJREwKY1fyGOvBd/Ls6yo2QBF/JD8hrVgvZ8wbzPb8NCu1jkhhwx4ogfAah9suwELV0U5M9xBSOnnjDz1+jZiDB8RKeLxbCXnoeqrGufeIbLFBoMN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO72bJlh; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78c8d74bf4cso34917197b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 19:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765854729; x=1766459529; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxBmymWbq42pbYHpVMadjTjXtAOmytXTfzCe3e9J3KU=;
        b=dO72bJlhzC+DoItn/Pu3jzZpzIbsBTzX4EZnUxIlxydeqPaGa1LOXxZ/aOYB7SrPpE
         jHCKUHS9TXqbY/9HXlZ+meesUUF4sDK7ZGNndgEK7+M+nRfYl0DZUjYv4XJxi1w3tsux
         U7eH7WW0vX6FrGQ1UNc/Fotc0cAc+skZgxOylgzU90FMm0knZygH+LHoiF2Fwfg8+ybw
         UrYKfji9bowOonPETyC8jyXXNurgEaoKJFYUsNEQJYMu8DlQHoIi5vTdAhLceK0MMf3n
         ZY8bRVlLoKu/o+5mv/JuwBfbXPliNthyqsm7rxPSxz8jITxtsv0VkHA30qT7j2QJ7NrW
         wLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854729; x=1766459529;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxBmymWbq42pbYHpVMadjTjXtAOmytXTfzCe3e9J3KU=;
        b=UTesAl+Bp1OXpWtb9uLX2JJmZ8E4x6qqgcTz9QIv82WzW2uHg7BBAPo362t1kXJf6s
         sn7FXqhwcZtdaGwe0qnApeNgpmMl7RnEi2jeqst2oI85ycP/IPemcGwB+sS+b8n3MM4O
         pNxXjNDOuatAhs0Y2h5XgOc7qboMQUVqVD8nVlX/2drCtyiqSGqPwPvI2hhiwmR2RlU7
         eTUizEkSrD31tWt3Nwzt/XCSu9fItt3aFwsscLzMLCUBXO9vUfW6czf909+/fSEl50Wi
         X2ZwIKuIA2pzdL5O28B8dg7oGcgeLC/ALMS3Zdo/zbjTVsrYqSHtsRXgbqndNq17Y2sb
         t67w==
X-Forwarded-Encrypted: i=1; AJvYcCXM2E0A4BEou+IAqtyrKHDUgHDScbiV5FeiSSZBt20ird7f8PQ0UbaxaYJ28c0MA72J3aof/LIx2O5VUg15EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNy2NFq6+voNNoMBI0Umf4iCHYbetCjAJb0F22wUv+g0CMrs0Y
	0pUJfwJsBbGTUfjwOC0QtzFvE9cZZnZfICjMwA8fjwbN2bA5DQX7LF2ZHWkY2RO+ZguhqCmhf7A
	1v3NHQOvvtoE2wn43Mc9yRM3YzARNbrae3A==
X-Gm-Gg: AY/fxX4BWvmeoWHZpWd7Rpx6iunlj120QUtS4USD9PLeCnWva42bj3BiVelR87T9yUb
	RHO2Gl761Jic1Er8R9bF2AqyOTLqhq4OlR19Y3DoSlJn9FiuwR8wTyog51+74/mjluHPvAZT/Ib
	6hGNCRLYg+T0/2L3QAtB3yg4CCnp6Ob+/iyWaXKtxYwE3Y6wB6rb+zvAkVBPR8xQ+FCv8C589TT
	Z7C4JvEYnNoM3s7VuPKUmNVp0SnpWSJn+LFfuB/XTl/S2m4diZ6fTeVM663SUKPWtkjv/4=
X-Google-Smtp-Source: AGHT+IGF4iw0eMVT0qB8Rqb2/V88dVdoZtjzlWdTdwpVCH+UwTUUlZKOdiMTIrXl3igXC2i7+6CpqaNxeal2mT5aFlU=
X-Received: by 2002:a05:690e:16a0:b0:645:5413:f782 with SMTP id
 956f58d0204a3-645555cdbf2mr9811003d50.16.1765854728785; Mon, 15 Dec 2025
 19:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Mon, 15 Dec 2025 19:11:57 -0800
X-Gm-Features: AQt7F2oRBJRbC_70WyQF5RC9wQcDC4FaGz_qowmfR_f-OE8n9-YoUFojS7vrVKM
Message-ID: <CAF3JpA4Yk03Zeju9Y4MMSS0ynAP+qrk1fXiu_CGV1G+ffC-NiQ@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta (2)
To: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d61efc06460917ef"

--000000000000d61efc06460917ef
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000d61efc06460917ef
Content-Type: application/octet-stream; 
	name="0001-mac80211-ocb-skip-rx_no_sta-when-interface-is-not-jo.patch"
Content-Disposition: attachment; 
	filename="0001-mac80211-ocb-skip-rx_no_sta-when-interface-is-not-jo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mj806iiv0>
X-Attachment-Id: f_mj806iiv0

RnJvbSAyNDIyNzc1YTBjZGM1MDQwMjhiMTk4MGQxODE5NjhkMjgyYTY5ODMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNb29uIEhlZSBMZWUgPG1vb25oZWUubGVlLmNhQGdtYWlsLmNv
bT4KRGF0ZTogTW9uLCAxNSBEZWMgMjAyNSAxNTozNzo1MCAtMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IG1hYzgwMjExOiBvY2I6IHNraXAgcnhfbm9fc3RhIHdoZW4gaW50ZXJmYWNlIGlzIG5vdCBqb2lu
ZWQKCmllZWU4MDIxMV9vY2Jfcnhfbm9fc3RhKCkgYXNzdW1lcyBhIHZhbGlkIGNoYW5uZWwgY29u
dGV4dCwgd2hpY2ggaXMgb25seQpwcmVzZW50IGFmdGVyIEpPSU5fT0NCLgoKUlggbWF5IHJ1biBi
ZWZvcmUgSk9JTl9PQ0IgaXMgZXhlY3V0ZWQsIGluIHdoaWNoIGNhc2UgdGhlIE9DQiBpbnRlcmZh
Y2UKaXMgbm90IG9wZXJhdGlvbmFsLiBTa2lwIFJYIHBlZXIgaGFuZGxpbmcgd2hlbiB0aGUgaW50
ZXJmYWNlIGlzIG5vdApqb2luZWQgdG8gYXZvaWQgd2FybmluZ3MgaW4gdGhlIFJYIHBhdGguCgpS
ZXBvcnRlZC1ieTogc3l6Ym90K2IzNjQ0NTdiMmQxZDRlNGEzMDU0QHN5emthbGxlci5hcHBzcG90
bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogTW9vbiBIZWUgTGVlIDxtb29uaGVlLmxlZS5jYUBnbWFp
bC5jb20+Ci0tLQogbmV0L21hYzgwMjExL29jYi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvb2NiLmMgYi9uZXQvbWFj
ODAyMTEvb2NiLmMKaW5kZXggYTVkNDM1OGYxMjJhLi5lYmI0ZjRkODhjMjMgMTAwNjQ0Ci0tLSBh
L25ldC9tYWM4MDIxMS9vY2IuYworKysgYi9uZXQvbWFjODAyMTEvb2NiLmMKQEAgLTQ3LDYgKzQ3
LDkgQEAgdm9pZCBpZWVlODAyMTFfb2NiX3J4X25vX3N0YShzdHJ1Y3QgaWVlZTgwMjExX3N1Yl9p
Zl9kYXRhICpzZGF0YSwKIAlzdHJ1Y3Qgc3RhX2luZm8gKnN0YTsKIAlpbnQgYmFuZDsKIAorCWlm
ICghaWZvY2ItPmpvaW5lZCkKKwkJcmV0dXJuOworCiAJLyogWFhYOiBDb25zaWRlciByZW1vdmlu
ZyB0aGUgbGVhc3QgcmVjZW50bHkgdXNlZCBlbnRyeSBhbmQKIAkgKiAgICAgIGFsbG93IG5ldyBv
bmUgdG8gYmUgYWRkZWQuCiAJICovCi0tIAoyLjQzLjAKCg==
--000000000000d61efc06460917ef--

