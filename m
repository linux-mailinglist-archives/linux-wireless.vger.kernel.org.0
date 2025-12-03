Return-Path: <linux-wireless+bounces-29473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E9C9EF50
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD9A3A25A5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A8C8F0;
	Wed,  3 Dec 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmJayr0b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EB274FC1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764291; cv=none; b=TW8WXvO2d8+dla0SqBa26V0I3bQrW50ZtEGSYmUxlS2rVzYNgbGYAkbN75SWivbg1A+/8az2Wj5luYZSJBQu2dbrLFh7gnfM3XXe69tByMhLkFODTmLUihH0CtEL7B3SrStrJxQByyVu6X4g/+JSdtWwhrnFSQSC3yXFVpXH0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764291; c=relaxed/simple;
	bh=6ahSk7F+VUUFUUWYIqIDsEp37P1fLGYCx5xNtRNPC+E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b04UcPiO2T21L3hgF+6VTV82o2X7SL2bq0sk59CJcxwS3xwcJ8q3UkPIW55hRA/mXML7WG0o3hkpmvHZ/GNPVlnx6EWood51H7zcizsmZf6Hhza2oBujYtW7PrqjIHLNSvQHlQZ8L5DeSesnQUTZX+0cOV7V5F10cCCZuh9CfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmJayr0b; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45330fe6e1bso2652636b6e.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764764288; x=1765369088; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ahSk7F+VUUFUUWYIqIDsEp37P1fLGYCx5xNtRNPC+E=;
        b=RmJayr0bdm5CdWXWZZ89xc5KViBpNkRzIx8R8TmSWOW/GGB9BOcmBhorO94i7PIc61
         ksm5lm+3wxdVKXsDjNMRpcV7adKmSzEOFU+ab3eECGzzYV1mzem2pjxGsh2oSOPu5g18
         tZ/pWnn4r1Rti07Sj5D35OViGQgVqcuFWlF0jUpPVU1XzurOR7ZIOXA90Zf3LF+FjNBy
         nI+HURAIfhrM3ccDJdTWd6O77yGBkeT/jwfHIHmz+pyjJZuh+culMo1Ja+n+neSFvEeG
         vkG8Ss01Ms0WUAWD6foorqPmlZ6WKOvBScyLfa960cCevapDTmXUaeyEG4WGxENxmh+T
         R9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764764288; x=1765369088;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ahSk7F+VUUFUUWYIqIDsEp37P1fLGYCx5xNtRNPC+E=;
        b=tRu1abS0cCe9Kvce8VefkJYMth2mNDk3gfPEpjyLkiZC3BX2O6EXkcAU6aYW9uQRGf
         NFy5gLsH8S7KtnBLuNOddet7iin9UrKcGdMrTPJVnROJCtnGPEBIs3K0BHErpSZiT8sX
         qJtIYqlxx8+J4tDDcpZ7DJ1mjTATqbO9rGLhtfYZr1Vs0Vd2/7JxWaHON31Ik6Dsrr+q
         Yi6dytVqH3IS+n8nemGaAgDprjzoN1QOffnWpN0LtV/luV0T7IKqEmIEGiqEgKU7UfAH
         HHZ9TVgOi/2Ibf5YnULd2nRGO45SJM6T8W6S8d8BaaioYkPgYPpHYl5qT1ZJq7yF6vRr
         LmUA==
X-Gm-Message-State: AOJu0YyiyA+IaXVQru2avVg8yOP1E9CGNK1wDUJQ9QJdhlD/bR6TO61U
	8iKvimyaCN1zshN7jEtAhMXMmnh7dFF5Ap39FhtO05ogDmPuJh7aPWgr+pT+asu3isNFiidnlJC
	IXflmIXE8EHJ+zQtLOPfsNgvWxdctVTSVQnwVV/aTMA==
X-Gm-Gg: ASbGncvUUQe88Aqx1CPDYG3eVhuXuPfeb0oiTBTYWFgfLA+l656oKjsMsNiA1ON0Tx0
	MBtIEP5F694oFHvzqidOl1IxIGKnMLgiZykoAY/XNht2ayGhOEEOds4Y2awU8mk7m6f9qWGsLbt
	u3KH8f26roBiIkSddZPElfd1yblLvjfvH5jD9bh9L5PFiplSHfQeAq3FqbjbBsojmPS4tCJuBr/
	roMyBVgZ3m3rmpH+kbyKccsUl5AYanu9LGC4THXx2lmoA/HjYXlfVr9osOZrezYf+I7ryHy
X-Google-Smtp-Source: AGHT+IFK3WCIlmPOoFpjIsTUSF1acBi1n8Z2Jj9navKfNB9gNYV2RQoGieMMnlAjicyP1ytL9DQuWu6aQHor/Ryfz6Y=
X-Received: by 2002:a05:6808:4705:b0:44d:badf:f449 with SMTP id
 5614622812f47-4536e3af612mr954070b6e.1.1764764287714; Wed, 03 Dec 2025
 04:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muhammad Firgani <muhammadfirgan50@gmail.com>
Date: Wed, 3 Dec 2025 19:17:56 +0700
X-Gm-Features: AWmQ_bnSku0MzmI1mbMVRyfg2j16w4Z24dFc7IEdMNhZLV9m2scCaqtwm27_oI8
Message-ID: <CAFa2iMbgyA8Zgcncw2qgdrKpam5XoRzLqQ6SPq18wq58LCwi0g@mail.gmail.com>
Subject: [BUG] MEDIATEK MT7902 (14c3:7902) detected but no interface created
 on ASUS laptop
To: linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007b994406450b34a7"

--0000000000007b994406450b34a7
Content-Type: multipart/alternative; boundary="0000000000007b994306450b34a5"

--0000000000007b994306450b34a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a MEDIATEK MT7902 (PCI ID 14c3:7902) Wi-Fi adapter on an ASUS laptop=
.
The device is detected by the kernel (appears in lspci), and firmware files
are present,
but no wlan0 interface is created =E2=80=94 even with kernel 6.17.9 and mt7=
6-dkms
installed.

Driver modules (mt76, mt7921e) load without error, but there is no
initialization log in dmesg.

I have disabled Secure Boot, performed cold reboots, and removed pci=3Dnocr=
s.

Attached is a full diagnostic log.

Thank you for your work on Linux wireless support.

Best regards,
Muhammad Firgan

--0000000000007b994306450b34a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br><br>I have a MEDIATEK MT7902 (PCI ID 14c3:7=
902) Wi-Fi adapter on an ASUS laptop.<br>The device is detected by the kern=
el (appears in lspci), and firmware files are present,<br>but no wlan0 inte=
rface is created =E2=80=94 even with kernel 6.17.9 and mt76-dkms installed.=
<br><br>Driver modules (mt76, mt7921e) load without error, but there is no =
initialization log in dmesg.<br><br>I have disabled Secure Boot, performed =
cold reboots, and removed pci=3Dnocrs.<br><br>Attached is a full diagnostic=
 log.<br><br>Thank you for your work on Linux wireless support.<br><br>Best=
 regards,<br></div>Muhammad Firgan</div>

--0000000000007b994306450b34a5--
--0000000000007b994406450b34a7
Content-Type: text/plain; charset="US-ASCII"; name="mt7902-report.txt"
Content-Disposition: attachment; filename="mt7902-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mipz2mng0>
X-Attachment-Id: f_mipz2mng0

PT09IEtlcm5lbCB2ZXJzaW9uID09PQo2LjE3LjktYXJjaDEtMQoKPT09IGxzcGNpIC1ubmsgKE1U
NzkwMikgPT09CjAyOjAwLjAgTmV0d29yayBjb250cm9sbGVyIFswMjgwXTogTUVESUFURUsgQ29y
cC4gTVQ3OTAyIDgwMi4xMWF4IFBDSWUgV2lyZWxlc3MgTmV0d29yayBBZGFwdGVyIFtGaWxvZ2lj
IDMxMF0gWzE0YzM6NzkwMl0KCVN1YnN5c3RlbTogQXp1cmVXYXZlIERldmljZSBbMWEzYjo1NTIw
XQoJS2VybmVsIG1vZHVsZXM6IG10NzkyMWUKCj09PSBsc21vZCAobXQ3NiBtb2R1bGVzKSA9PT0K
bXQ3OTIxZSAgICAgICAgICAgICAgICAyODY3MiAgMAptdDc5MjFfY29tbW9uICAgICAgICAgIDk4
MzA0ICAxIG10NzkyMWUKbXQ3OTJ4X2xpYiAgICAgICAgICAgICA2OTYzMiAgMiBtdDc5MjFlLG10
NzkyMV9jb21tb24KbXQ3Nl9jb25uYWNfbGliICAgICAgICA5ODMwNCAgMyBtdDc5MnhfbGliLG10
NzkyMWUsbXQ3OTIxX2NvbW1vbgptdDc2ICAgICAgICAgICAgICAgICAgMTUxNTUyICA0IG10Nzky
eF9saWIsbXQ3OTIxZSxtdDc5MjFfY29tbW9uLG10NzZfY29ubmFjX2xpYgptYWM4MDIxMSAgICAg
ICAgICAgICAxNjc5MzYwICA0IG10NzkyeF9saWIsbXQ3NixtdDc5MjFfY29tbW9uLG10NzZfY29u
bmFjX2xpYgpjZmc4MDIxMSAgICAgICAgICAgICAxNDI1NDA4ICA0IG10NzYsbWFjODAyMTEsbXQ3
OTIxX2NvbW1vbixtdDc2X2Nvbm5hY19saWIKcmZraWxsICAgICAgICAgICAgICAgICA0NTA1NiAg
MTAgbXQ3OTIxZSxhc3VzX3dtaSxibHVldG9vdGgsY2ZnODAyMTEKCj09PSBkbWVzZyAoYm9vdCAr
IG10NzkpID09PQpbICAgIDAuMzgwODc3XSBwY2kgMDAwMDowMjowMC4wOiBbMTRjMzo3OTAyXSB0
eXBlIDAwIGNsYXNzIDB4MDI4MDAwIFBDSWUgRW5kcG9pbnQKWyAgICAxLjgyMTAwMF0gdXNiIDEt
Mi40OiBNYW51ZmFjdHVyZXI6IE1lZGlhVGVrIEluYy4KCj09PSBGaXJtd2FyZSBmaWxlcyA9PT0K
LXJ3LXItLXItLSAxIHJvb3Qgcm9vdCAwIERlYyAgMyAxNzoxMyAvdXNyL2xpYi9maXJtd2FyZS9t
ZWRpYXRlay9tdDc5MjFwcjJoLmJpbgotcnctci0tci0tIDEgcm9vdCByb290IDAgRGVjICAzIDE3
OjEzIC91c3IvbGliL2Zpcm13YXJlL21lZGlhdGVrL210NzkyMV9yb21fcGF0Y2guYmluCgo9PT0g
TGFwdG9wIG1vZGVsIChpZiBrbm93bikgPT09ClZpdm9ib29rIEdvIEUxNDA0RkFfRTE0MDRGQQo=
--0000000000007b994406450b34a7--

