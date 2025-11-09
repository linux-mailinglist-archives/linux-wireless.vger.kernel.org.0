Return-Path: <linux-wireless+bounces-28707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F790C444DF
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 724684E1159
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CF1F4180;
	Sun,  9 Nov 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alt1N6b6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9B1F4174
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711711; cv=none; b=W6i+6ShIZ72FYlgz5fWszzLxvO7UC3CoqmruS34PGjTooLWS26ewlX7o9+xTCWKS5paep6jk2gOKUiOlqYnxQXRqGwcqGDnmB2/Jg6viPuAJE5d+Ts1ei8VCkaTtSnybKpQnAoUAjYtIRyMDW1yFBM2dMMaIx9egR4riXi931u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711711; c=relaxed/simple;
	bh=CyerTHMjEJ8+owBnpxcJ1soUt0S6OXRutGOfwbOBt4g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lEInjXG36F5YnWdLxU5J0MWMevD02syJbTqsnbwTj+1VyK98YJKeeYU6p0m78GnmR7yq6xSPGR+jUC6WLcKba9TQ+S1eO96kOVPJdr08WSTLmaT+U5DAbjLsS3RlmUlIsVfGYRZBtJ5h+57Sx3a09cYQrEXo0J6ylKPY9thwc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alt1N6b6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed917b5b18so22696741cf.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Nov 2025 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762711709; x=1763316509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17uy7/r8DFyNelm2MX1mDDCEQ4FT1zUkD8brnWvpR7U=;
        b=alt1N6b6KpQ3QUDWHGy3zbl4U5H+Ca8uYhtMeCZv5m25u51kabhomXPebV+4iEbStO
         YL6MDLwpD0IqN0tO9JMHjmVj4sSHntBqI48/+xWqTU3dgytXBIbgMch6fbbgsd22CJ9f
         bMnR8uCBSf7ylAFwAxFSIQRNpV6DZRkKrqjz9aa9VUPXXmN6codjixxOSIcZAKG9tEaY
         b25f1OeoJutPze6nEZ7arTf0dxmnZKmf0v9p6Ee9wIMoibfmbrwDyWkh5kQ7VPgeIv60
         f0Py/SA/jLKjVNr4tKiGbRCsuQl2X7BKxcIjPE5dxJOCtstnLjuCJibpA93bgA4VrDf3
         TxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762711709; x=1763316509;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17uy7/r8DFyNelm2MX1mDDCEQ4FT1zUkD8brnWvpR7U=;
        b=uKM5Z+FnoH7YNPugXSiqeusuhy7NtcIzTFgifju+wZYRpIZAgMVOZYK+GhYuambzZh
         /WaGoUIUqtGoi4iYNQLqm+H2x2xn6I8uYc0v5Z4QdmKl5h2Uu1RsaG7ilNGTeCtIcQCi
         QVwIjHiJ3R/t/7VXwHc+3agXymJzVqpIKG4T5ankJ60C/WaC/k11ylhwLq9iYvWsPxT1
         21Vkd2TsU93RgyD+raHw0AgrQdkvzAfUHQOlVabI9SXNU3oBA15Sop+NfSEdCNgmzAHl
         CH5oNIJtLCUSiCxbI47k2a5C55i2QkVOlQAmafas1Dxx1JhsmK9hcjJxFbmcDPnrzCVp
         mzbQ==
X-Gm-Message-State: AOJu0YxbILgBoe+jSv+F7JQskh5j60ueYIIdye05+ie1y5ctkRDuLPoy
	QdcGPb30v7VGH6cJ3UKsJchy2DgldYpxX0XFr5WbhrZcOhweE5+2S1b64O+Qr5QOyNl/15uSump
	z8K4k1erFSco+8iFLX6cJjFXjKZM6M8YPOsMIl/M=
X-Gm-Gg: ASbGncuAjWU616eXrqnSEYme6o5t/3ZQMyASz14FiWFQLZEmNx49dhlTU+qBM8oqbQh
	O1ZeddDrxhRPLpuGLdolPGLA1fk9U8EZGqDV/OH3ERkJPltG4Dq3+I9fih6p4+8nSQpp2X12OSs
	Ox8IVq+AjZzQFjJuVFaCy0IzWlspM67gXzN5z+/1O2G8PTzvO9JnlMLqs47dsUk3mT11gUjvbei
	5Lg4OH+fyOHYjyynMgG6HH1fvdrQH2rwmPsEZK9SeR7bZP6miT2s2p6Mpe0qliekgCvh67I5Vnm
	H8IbLWNKG9SJyx8RzTUbjimuPew=
X-Google-Smtp-Source: AGHT+IFnrm8u5EMWfRVBrWwKuYqW7hKNgIF6wC/k2hh2eY1SWNCeunqTOP/xleUA55px5GxnEEJym3NVs0cohUDLNIA=
X-Received: by 2002:a05:622a:11d5:b0:4ed:bbca:fe00 with SMTP id
 d75a77b69052e-4edbbcb08f3mr12782981cf.4.1762711708720; Sun, 09 Nov 2025
 10:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jory Pratt <geekypenguin@gmail.com>
Date: Sun, 9 Nov 2025 12:08:17 -0600
X-Gm-Features: AWmQ_bk1rm8LcOjmUFnQE0NnHmr0i3AhpeWGSB52rLNJe39bAVi2lbz3Is1TtJc
Message-ID: <CAOufY68pkXkQo2OVPDMtMrRd5H5xx9MHqMBkT8Swzzd3cXBOSw@mail.gmail.com>
Subject: [PATCH] wifi: mt7601u: ignore invalid per-rate power entries
To: linux-wireless@vger.kernel.org
Cc: sgruszka@redhat.com, lorenzo@kernel.org
Content-Type: multipart/mixed; boundary="0000000000003d92ea06432d4de1"

--0000000000003d92ea06432d4de1
Content-Type: multipart/alternative; boundary="0000000000003d92e906432d4ddf"

--0000000000003d92e906432d4ddf
Content-Type: text/plain; charset="UTF-8"

Some MT7601U adapters ship with placeholder values (0xf4) in the per-rate
power table. Feeding those bytes through s6_validate() triggers its
WARN_ON()
because bits outside the 6-bit range are set, splattering a stack trace on
every probe and needlessly tainting the kernel.

The driver already falls back to safe defaults when an EEPROM entry is
invalid, so we can simply skip per-rate values whose upper bits are set.
Mask the value locally and pass the sanitized result to s6_to_int(), keeping
later fixups working while keeping the probe path silent.

Thanks for taking a look!

Jory

--0000000000003d92e906432d4ddf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Some MT7601U adapters ship with placeholder values (0xf4) =
in the per-rate<br>power table. Feeding those bytes through s6_validate() t=
riggers its WARN_ON()<br>because bits outside the 6-bit range are set, spla=
ttering a stack trace on<br>every probe and needlessly tainting the kernel.=
<br><br>The driver already falls back to safe defaults when an EEPROM entry=
 is<br>invalid, so we can simply skip per-rate values whose upper bits are =
set.<br>Mask the value locally and pass the sanitized result to s6_to_int()=
, keeping<br>later fixups working while keeping the probe path silent.<br><=
br>Thanks for taking a look!<br><br>Jory</div>

--0000000000003d92e906432d4ddf--
--0000000000003d92ea06432d4de1
Content-Type: text/x-patch; charset="US-ASCII"; name="mt7601u-silence-invalid-power.patch"
Content-Disposition: attachment; 
	filename="mt7601u-silence-invalid-power.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mhs114140>
X-Attachment-Id: f_mhs114140

RnJvbSA4ZjlhMGI5ZTBkOGMyYTg3YWQ0ZWVjMWM1YzU0ZDkzOTY2NDFiMmYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3J5IEEuIFByYXR0IDxnZWVreXBlbmd1aW5AZ21haWwuY29t
PgpEYXRlOiBTdW4sIDkgTm92IDIwMjUgMDE6NDA6MDAgLTA2MDAKU3ViamVjdDogW1BBVENIXSB3
aWZpOiBtdDc2MDF1OiBpZ25vcmUgaW52YWxpZCBwZXItcmF0ZSBwb3dlciBlbnRyaWVzCgpTb21l
IE1UNzYwMVUgYWRhcHRlcnMgc2hpcCB3aXRoIHBsYWNlaG9sZGVyIHZhbHVlcyAoMHhmNCkgaW4g
dGhlCnBlci1yYXRlIHBvd2VyIHRhYmxlLiAgRmVlZGluZyB0aG9zZSBieXRlcyB0aHJvdWdoIHM2
X3ZhbGlkYXRlKCkgdHJpZ2dlcnMKaXRzIFdBUk5fT04oKSBiZWNhdXNlIGJpdHMgb3V0c2lkZSB0
aGUgNi1iaXQgcmFuZ2UgYXJlIHNldCwgc3BsYXR0ZXJpbmcgYQpzdGFjayB0cmFjZSBvbiBldmVy
eSBwcm9iZSBhbmQgbmVlZGxlc3NseSB0YWludGluZyB0aGUga2VybmVsLgoKVGhlIGRyaXZlciBh
bHJlYWR5IGZhbGxzIGJhY2sgdG8gc2FmZSBkZWZhdWx0cyB3aGVuIGFuIEVFUFJPTSBlbnRyeSBp
cwppbnZhbGlkLCBzbyB3ZSBjYW4gc2ltcGx5IHNraXAgcGVyLXJhdGUgdmFsdWVzIHdob3NlIHVw
cGVyIGJpdHMgYXJlIHNldC4KTWFzayB0aGUgdmFsdWUgbG9jYWxseSBhbmQgcGFzcyB0aGUgc2Fu
aXRpemVkIHJlc3VsdCB0byBzNl90b19pbnQoKSwKa2VlcGluZyBsYXRlciBmaXh1cHMgd29ya2lu
ZyB3aGlsZSBrZWVwaW5nIHRoZSBwcm9iZSBwYXRoIHNpbGVudC4KClNpZ25lZC1vZmYtYnk6IEpv
cnkgQS4gUHJhdHQgPGdlZWt5cGVuZ3VpbkBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3NjAxdS9lZXByb20uYyB8IDcgKysrKystLQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2MDF1L2VlcHJvbS5jIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3NjAxdS9lZXByb20uYwppbmRleCA0YTEyMGU4MzAyYzMuLjdmZmQ4
YmExYzdmMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3NjAx
dS9lZXByb20uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2MDF1L2Vl
cHJvbS5jCkBAIC0yNTMsOCArMjUzLDExIEBAIG10NzYwMXVfc2V0X3Bvd2VyX3JhdGUoc3RydWN0
IHBvd2VyX3Blcl9yYXRlICpyYXRlLCBzOCBkZWx0YSwgdTggdmFsdWUpCiAJLyogSW52YWxpZD8g
Tm90ZTogdmVuZG9yIGRyaXZlciBkb2VzIG5vdCBoYW5kbGUgdGhpcyAqLwogCWlmICh2YWx1ZSA9
PSAweGZmKQogCQlyZXR1cm47CiAKLQlyYXRlLT5yYXcgPSBzNl92YWxpZGF0ZSh2YWx1ZSk7Ci0J
cmF0ZS0+YncyMCA9IHM2X3RvX2ludCh2YWx1ZSk7CisJaWYgKHZhbHVlICYgfkdFTk1BU0soNSwg
MCkpCisJCXJldHVybjsKKworCXJhdGUtPnJhdyA9IHZhbHVlICYgR0VOTUFTSyg1LCAwKTsKKwly
YXRlLT5idzIwID0gczZfdG9faW50KHJhdGUtPnJhdyk7CiAJLyogTm90ZTogdmVuZG9yIGRyaXZl
ciBkb2VzIGNhcCB0aGUgdmFsdWUgdG8gczYgcmlnaHQgYXdheSAqLwogCXJhdGUtPmJ3NDAgPSBy
YXRlLT5idzIwICsgZGVsdGE7CiB9Ci0tIAoyLjQzLjAK
--0000000000003d92ea06432d4de1--

