Return-Path: <linux-wireless+bounces-11745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A1959F15
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBC41F229FF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BB1AD5DE;
	Wed, 21 Aug 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTPzAIep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F61AD5CE
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248333; cv=none; b=rW//i6a+1ZBlPDf6jZSIOcN6WHW+ZNcq238VSgZMgpJyXc5W/XYvGWn5qhmhHF+s5uYp1jSEU7c9qXXHtmZy5/UI/bxMIjWyDTyOKfAUr985n+2oqx6VcvrcTPc5beicmZbsA0ryzx6LVHKPykpAmF3q8chgDOadkmvb2wTZnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248333; c=relaxed/simple;
	bh=cxjvDGqSiY8F9CZb+YkItJVqMsqlhR6+SRyjcob6Nus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DN2aewsIbifklV8UdnWR5qGWW2vbhn3RS/N/wu3RFiR9OQsWSPuyMJSCxa/VM0LnA30aLMf5nlLERhshgd3h8dhwGfQgr8onSR0CLDrM+IQdoOUHhWLV6mPi5yVTOl1JQB1DkKHKoSovfwnaTW8v74QR5hOcUWoGcQX1TAwX6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTPzAIep; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4989b18ee2aso467763137.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724248331; x=1724853131; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VMx6EPIh+KmrN6Ns0OCF1qTvJAnujR0Ujsq4mWzPvc=;
        b=gTPzAIep9TcvczXB2vqkiVA1BZmocXNjELeVacMNJOL4+wMNf7K+X84w47CXNGxJpR
         owNqPnZzlYvp2ttdl0OvdCqfzOjVoG+8jRAatNO9/TGZdDvIK0cSf2CsD4e+F7qQH9kV
         uu6i41j7ePZnd4rQ/r3oTGbLfyMql8WT+qLMChFgNKS9MbrAAkcNZJtLwD7Y+HRmdJoi
         /u/p0sF0ULaQQk3CXxZ9+8qWL1RJn4o2e6/HTJbG8WygULpIXxqNFWnazvShQdBStuCA
         GttFNE/JQSvxgFzWSsPF6QAu6U7Q0o4e7Royeq+Uyf17byDzn1rvQG7RwOH/2gGxgHBx
         EmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248331; x=1724853131;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VMx6EPIh+KmrN6Ns0OCF1qTvJAnujR0Ujsq4mWzPvc=;
        b=r373NecLwA95W+HtXy95C5bY0eKCEl6B3PpCaqo4qacSlNwqXo/NC4mU07b53OXaKm
         yPjKv3M+HrauVQazPbhkGpAkE5SHxlU+uP7FwT+4UWz5ssFiMHHxFREmUDCimo1qxdzJ
         BjohJz86qF+8vpVg9PJ8k+HTwSgIfFJBCelUZmci7GL9AowMZJEBhSZ4myV/KwE3j4ZO
         pmA7FY2gfiRG9drgc89aE+4b90+JGlwm0ibB58DYxa8FmOYcFk6ZZYoHrGmj1ILbUM5c
         7gTEVYGV2gWhYJeY1l1dxghjJkH4zLvQH+tYKbvUX+9ftxyRIac3V7+CyzAyZqw9OZMk
         HOgA==
X-Gm-Message-State: AOJu0YxqkTStHhtCl/g4vFonaZGDDmzuwWp+oH1d33+pLdWOVqRVET8H
	TuKLRhs4usra5MswK2fXAgFyvxeiO7fWlj8TiurtVZmd8Pbup+0N3zaHpvAUr7gvSBQeTFSUvU3
	Wsmg/kg7GrBsDLcSa923OE8N+bj5Uegja
X-Google-Smtp-Source: AGHT+IFyOvIIWIjokOXY6vL3NzC0P3K0Pyio27Ksr9VnPxCmKMsXK9EZ0LBE27I+0HnQa0iYWs2iS4vT+oAjDb4705M=
X-Received: by 2002:a05:6102:5486:b0:48d:d1bf:c92 with SMTP id
 ada2fe7eead31-498d4cc5ccfmr1148067137.15.1724248330868; Wed, 21 Aug 2024
 06:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joshua Rogers <megamansec@gmail.com>
Date: Wed, 21 Aug 2024 15:52:00 +0200
Message-ID: <CA+17n5vH_Y6Qr72DH=QgFUSO5CGn-grvcgY-i3+LPqkRzCjEzw@mail.gmail.com>
Subject: [PATCH] wifi: brcmfmac: ensure that brcmfmac pcie devices are
 properly reset at shutdown
To: linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000044476a062031d950"

--00000000000044476a062031d950
Content-Type: multipart/alternative; boundary="000000000000444769062031d94e"

--000000000000444769062031d94e
Content-Type: text/plain; charset="UTF-8"

Some BCM devices, such as the BCM43602, are left in an inconsistent
internal state upon shutdown. Normally, this would not be important as the
device would be powered down following the shutdown.

However, in an emulated environment such as Linux in a VM, the device
becomes inoperable unless a complete powerdown of the device occurs.

This issue fixes various reports online such as
https://github.com/QubesOS/qubes-issues/issues/3734,
https://bugzilla.redhat.com/show_bug.cgi?format=multiple&id=1294415,
https://www.reddit.com/r/hackintosh/comments/c38u1l/problem_with_pci_passthrough_broadcom_wifi_card/,
and so on.

--000000000000444769062031d94e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Some BCM devices, such as the BCM43602, are left in an inc=
onsistent internal state upon shutdown. Normally, this would not be importa=
nt as the device would be powered down following the shutdown.<br><br>Howev=
er, in an emulated environment such as Linux in a VM, the device becomes in=
operable unless a complete powerdown of the device occurs.<br><br><div>This=
 issue fixes various reports online such as <a href=3D"https://github.com/Q=
ubesOS/qubes-issues/issues/3734">https://github.com/QubesOS/qubes-issues/is=
sues/3734</a>, <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?format=
=3Dmultiple&amp;id=3D1294415">https://bugzilla.redhat.com/show_bug.cgi?form=
at=3Dmultiple&amp;id=3D1294415</a>, <a href=3D"https://www.reddit.com/r/hac=
kintosh/comments/c38u1l/problem_with_pci_passthrough_broadcom_wifi_card/">h=
ttps://www.reddit.com/r/hackintosh/comments/c38u1l/problem_with_pci_passthr=
ough_broadcom_wifi_card/</a>, and so on.</div><div><br></div></div>

--000000000000444769062031d94e--
--00000000000044476a062031d950
Content-Type: application/octet-stream; 
	name="0001-Ensure-that-brcmfmac-pcie-devices-are-properly-reset.patch"
Content-Disposition: attachment; 
	filename="0001-Ensure-that-brcmfmac-pcie-devices-are-properly-reset.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m03wxgm10>
X-Attachment-Id: f_m03wxgm10

RnJvbSA4YTQ0NTZiYTNkMTczZjBhZjhkZTQwODgyMmZkZjcxMDFlNWViOGY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3NodWEgUm9nZXJzIDxNZWdhTWFuU2VjQHVzZXJzLm5vcmVw
bHkuZ2l0aHViLmNvbT4KRGF0ZTogV2VkLCAyMSBBdWcgMjAyNCAxMjowMDoxMyArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIEVuc3VyZSB0aGF0IGJyY21mbWFjIHBjaWUgZGV2aWNlcyBhcmUgcHJvcGVy
bHkgcmVzZXQgYXQKIHNodXRkb3duCgpTb21lIEJDTSBkZXZpY2VzLCBzdWNoIGFzIHRoZSBCQ000
MzYwMiwgYXJlIGxlZnQgaW4gYW4gaW5jb25zaXN0ZW50IGludGVybmFsIHN0YXRlIHVwb24gc2h1
dGRvd24uIE5vcm1hbGx5LCB0aGlzIHdvdWxkIG5vdCBiZSBpbXBvcnRhbnQgYXMgdGhlIGRldmlj
ZSB3b3VsZCBiZSBwb3dlcmVkIGRvd24gZm9sbG93aW5nIHRoZSBzaHV0ZG93bi4KCkhvd2V2ZXIs
IGluIGFuIGVtdWxhdGVkIGVudmlyb25tZW50IHN1Y2ggYXMgTGludXggaW4gYSBWTSwgdGhlIGRl
dmljZSBiZWNvbWVzIGlub3BlcmFibGUgdW5sZXNzIGEgY29tcGxldGUgcG93ZXJkb3duIG9mIHRo
ZSBkZXZpY2Ugb2NjdXJzLgoKVGhpcyBpc3N1ZSBmaXhlcyB2YXJpb3VzIHJlcG9ydHMgb25saW5l
IHN1Y2ggYXMgaHR0cHM6Ly9naXRodWIuY29tL1F1YmVzT1MvcXViZXMtaXNzdWVzL2lzc3Vlcy8z
NzM0LCBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2Zvcm1hdD1tdWx0
aXBsZSZpZD0xMjk0NDE1LCBodHRwczovL3d3dy5yZWRkaXQuY29tL3IvaGFja2ludG9zaC9jb21t
ZW50cy9jMzh1MWwvcHJvYmxlbV93aXRoX3BjaV9wYXNzdGhyb3VnaF9icm9hZGNvbV93aWZpX2Nh
cmQvLCBhbmQgc28gb24uCi0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgw
MjExL2JyY21mbWFjL3BjaWUuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2Jy
Y21mbWFjL3BjaWUuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9i
cmNtZm1hYy9wY2llLmMKaW5kZXggY2U0ODJhMzg3Li44NjVhMmYyNWMgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9wY2llLmMKKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL3BjaWUu
YwpAQCAtMjcxMSw2ICsyNzExLDcgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGJyY21mX3Bj
aWVkcnZyID0gewogCS5pZF90YWJsZSA9IGJyY21mX3BjaWVfZGV2aWRfdGFibGUsCiAJLnByb2Jl
ID0gYnJjbWZfcGNpZV9wcm9iZSwKIAkucmVtb3ZlID0gYnJjbWZfcGNpZV9yZW1vdmUsCisJLnNo
dXRkb3duID0gYnJjbWZfcGNpZV9yZW1vdmUsCiAjaWZkZWYgQ09ORklHX1BNCiAJLmRyaXZlci5w
bSA9ICZicmNtZl9wY2llZHJ2cl9wbSwKICNlbmRpZgotLSAKMi40Ni4wCgo=
--00000000000044476a062031d950--

