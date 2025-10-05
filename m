Return-Path: <linux-wireless+bounces-27814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F7BB9468
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 09:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5137B3BBA53
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387B2B9A4;
	Sun,  5 Oct 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac5AlAO/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD56F9C0
	for <linux-wireless@vger.kernel.org>; Sun,  5 Oct 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759648088; cv=none; b=rTHOOQ1SuEExYnqoJiucnUhjJIN4rAeuVNUbCW9NcwAau0YMKGBJEFN898HdFpaiQ/FKX3QDHYZ353hCDAQz6bimtA8OatYM4Jy7t74L3Xujhx1lUcpaGZTn/ebHersBg5UyoHpI87IS0JqXu7gDrjhYojc/5VG1WDPLuvnO9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759648088; c=relaxed/simple;
	bh=2rzhIv3kHjvmRjTzfp0UN9G9sqr5Wz9Mq+xAzDI7Z6E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kXmJ3jNltD0Sx3Mow8szdcN7QVG8vPPD8xEQBCjy3kPVje0l8bMPWl9qGmJhw/daVbt5vsbR4fmNOv9C0Ki7FZ/E0BVU9r46fTqtgWz7dr3Dv3HFsB4HOVfKPXUtSNhqnwScO9wGihP7qp1YOPqqlJr2lnRf7zMghAhEcsgRD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac5AlAO/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so5774115a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759648085; x=1760252885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2rzhIv3kHjvmRjTzfp0UN9G9sqr5Wz9Mq+xAzDI7Z6E=;
        b=Ac5AlAO/P7o8p+0YFNoTGAWlb/6YvwjedcKonAZYF6/eSy9Cs7C28oTn1Bb3CeUEGn
         Bka8dltm2e6vqDCUkskxmH0w7ZdbY4XVqsn6BKsbQsY6+WPshXT9q9NZjy6p/RbPuVIV
         urseVsQ5FgBylI91pxzoI88QJQEgOMyASzpJj2iJoGBIGqmobP+lfpAGn4/Qgeg28F4u
         xvF20sYBUslkf8kvGvfrn/roBTBre8qXfPpdk2/U49hi360gkLMZQYFJnCNgypGhP04k
         jZAbxCm2k4mfQVUxMznzZ/eN43Yh3Rolz9/tVAd1gj/6zvrNP5V0YNCH0IMytlaA7To5
         9aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759648085; x=1760252885;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rzhIv3kHjvmRjTzfp0UN9G9sqr5Wz9Mq+xAzDI7Z6E=;
        b=Th4a0336mYJHHynfjKWo4kAsALjs5NC/tR5+uMkw6Wofb3899hnw5YqXme5ppzJH+8
         knxHNSjao5d50VIAKtDe3bgGONOnXTdM7GFSV3pRLWk4SOATvanFpekTDf2mWUWr0vgF
         DgYvGk3SiV5z2PiK2QMYtQhEmnYv7JUbFw3yXyAoxInQ3leOw31xC1PeZ8blLgeNoQya
         ES89vPeB43VRlwNI3JDtWHigpdCxOVkGgCClg2DyjRKQDxn+InHB2pYKzfnhnLPSia94
         rEhrDPi0xqgEp0QpQT4h0ZsvZwQts8+zekjxgfPeg7ZSpJQSZWe4ccZm/GUN1Z04VVMX
         AkIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1f6sze0P9+TtLLOP22AY7wZd7P0cKliK8e/Q1fVL4DDZf1mLFJA3CkJ7wLGps/RcT+bf1/3cdyvPTN1gOJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5ILeqJWqhl4gtHD4LP4G1Ir5PatCLVxkbbMouEWqg9UpIV2H
	dA4OtrZK57heDv1KcHHKpL/SLAvRIGCGc1Dp51egOFCXoaDIU2uoJCDffEVuz7ONSbqUw3KbyA7
	Rz+u0qvGoZXuyx+DD3oN57gms713UPUk=
X-Gm-Gg: ASbGnctrnC37JtncuInLkZaOUCX3Hq6qsQmUfONbSkbDY2hHySgm/PrtLE4eG8wVHi2
	VOLLnzLRzdKk1HFfMcfcAfHEdEaje9FbK8uy9FmYwpaRqozhKGFJIa7D6XIAWa+sZq4qRGDhipW
	WkkXymsNywMZRN1svti4OE34Gd1BxjNZoVPhvr9iMzu14ialFSTg5X2X1qe/zLPGFP5ZULoIvaQ
	BwH2xEhZpV5c8IcAIsBR72DOFHIwgrUTL/hHAjF8McaUxnkGe/I4I7QYiPCxAR9/4hcohto7yD7
	xO3hdMkQKB1ekm4TAISOfQ==
X-Google-Smtp-Source: AGHT+IEshoAfy/yakgYrojNRF9LjE8GnB1X5cIz8cUzPwfQrxCqLu45KB3zleEQDTfpY3GBBX42/W30qCna1VzUA9LQ=
X-Received: by 2002:a05:6402:5202:b0:62f:aaf6:3ea9 with SMTP id
 4fb4d7f45d1cf-639348db458mr8898553a12.12.1759648085175; Sun, 05 Oct 2025
 00:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Austin Justin <austinjustin4809@gmail.com>
Date: Sun, 5 Oct 2025 12:37:53 +0530
X-Gm-Features: AS18NWAed7g4XqYPIsBby0A0p1gyTQlGukdYh-Q5utUJ-KA4c5YPegDZPveKUxI
Message-ID: <CAJxkQ2gADc+kvZhxz3ds-QSkg+c59DQdmtXLVwRF2pGFgFNL-A@mail.gmail.com>
Subject: =?UTF-8?Q?Request_for_Linux_Driver_Support_=E2=80=93_MediaTek_MT7902?=
	=?UTF-8?Q?_Wi=2DFi_and_Bluetooth_Chipset_on_Ubuntu_22=2E04_LTS?=
To: ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	deren.wu@mediatek.com
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kernel-team@lists.ubuntu.com
Content-Type: multipart/mixed; boundary="0000000000000c740a064063ffad"

--0000000000000c740a064063ffad
Content-Type: multipart/alternative; boundary="0000000000000c7409064063ffab"

--0000000000000c7409064063ffab
Content-Type: text/plain; charset="UTF-8"

Dear MediaTek Linux Driver Team,

I am writing to request official Linux driver support for the MediaTek
MT7902 Wi-Fi and Bluetooth chipset.

This hardware is present in my ASUS Vivobook X1605VA laptop running Ubuntu
22.04 LTS, but it currently lacks native driver support in the kernel and
Ubuntu repositories.
The wireless and Bluetooth interfaces are not detected automatically, and
no compatible package is available through 'ubuntu-drivers' or DKMS.

Hardware details:
------------------------------------------------------
$ lspci -nn | grep -i network
03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]

Kernel version:
6.8.0-79-generic
------------------------------------------------------

Could you please advise if there are existing drivers for this chipset, or
if MediaTek plans to upstream support into the Linux kernel?
If testing or logs are required, I would be happy to assist to help ensure
compatibility with Ubuntu and other Linux distributions.

Thank you for your time and support in improving Linux compatibility with
MediaTek devices.

Best regards,
Austin Justin
ASUS Vivobook X1605VA
Ubuntu 22.04 LTS

--0000000000000c7409064063ffab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear MediaTek Linux Driver Team,<br><br>I=
 am writing to request official Linux driver support for the MediaTek MT790=
2 Wi-Fi and Bluetooth chipset.<br><br>This hardware is present in my ASUS V=
ivobook X1605VA laptop running Ubuntu 22.04 LTS, but it currently lacks nat=
ive driver support in the kernel and Ubuntu repositories. <br>The wireless =
and Bluetooth interfaces are not detected automatically, and no compatible =
package is available through &#39;ubuntu-drivers&#39; or DKMS.<br><br>Hardw=
are details:<br>------------------------------------------------------<br>$=
 lspci -nn | grep -i network<br>03:00.0 Network controller [0280]: MEDIATEK=
 Corp. Device [14c3:7902]<br><br>Kernel version:<br>6.8.0-79-generic<br>---=
---------------------------------------------------<br><br>Could you please=
 advise if there are existing drivers for this chipset, or if MediaTek plan=
s to upstream support into the Linux kernel? <br>If testing or logs are req=
uired, I would be happy to assist to help ensure compatibility with Ubuntu =
and other Linux distributions.<br><br>Thank you for your time and support i=
n improving Linux compatibility with MediaTek devices.<br><br>Best regards,=
<br>Austin Justin =C2=A0<br>ASUS Vivobook X1605VA =C2=A0<br>Ubuntu 22.04 LT=
S =C2=A0<br><br></div>
</div>

--0000000000000c7409064063ffab--
--0000000000000c740a064063ffad
Content-Type: text/plain; charset="US-ASCII"; name="network_info.txt"
Content-Disposition: attachment; filename="network_info.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mgdd105m0>
X-Attachment-Id: f_mgdd105m0

ICAqLW5ldHdvcmsgVU5DTEFJTUVECiAgICAgICBkZXNjcmlwdGlvbjogTmV0d29yayBjb250cm9s
bGVyCiAgICAgICBwcm9kdWN0OiBNRURJQVRFSyBDb3JwLgogICAgICAgdmVuZG9yOiBNRURJQVRF
SyBDb3JwLgogICAgICAgcGh5c2ljYWwgaWQ6IDAKICAgICAgIGJ1cyBpbmZvOiBwY2lAMDAwMDow
MzowMC4wCiAgICAgICB2ZXJzaW9uOiAwMAogICAgICAgd2lkdGg6IDY0IGJpdHMKICAgICAgIGNs
b2NrOiAzM01IegogICAgICAgY2FwYWJpbGl0aWVzOiBwY2lleHByZXNzIG1zaSBwbSBjYXBfbGlz
dAogICAgICAgY29uZmlndXJhdGlvbjogbGF0ZW5jeT0wCiAgICAgICByZXNvdXJjZXM6IGlvbWVt
b3J5OjYwMC01ZmYgbWVtb3J5OjYwMDAwMDAwMDAtNjAwMDBmZmZmZiBtZW1vcnk6ODA4MDAwMDAt
ODA4MDdmZmYKICAqLW5ldHdvcmsKICAgICAgIGRlc2NyaXB0aW9uOiBFdGhlcm5ldCBpbnRlcmZh
Y2UKICAgICAgIHBoeXNpY2FsIGlkOiA5CiAgICAgICBidXMgaW5mbzogdXNiQDE6MQogICAgICAg
bG9naWNhbCBuYW1lOiBlbngyZTQwNzc2ZjBkNjMKICAgICAgIHNlcmlhbDogMmU6NDA6Nzc6NmY6
MGQ6NjMKICAgICAgIGNhcGFiaWxpdGllczogZXRoZXJuZXQgcGh5c2ljYWwKICAgICAgIGNvbmZp
Z3VyYXRpb246IGF1dG9uZWdvdGlhdGlvbj1vZmYgYnJvYWRjYXN0PXllcyBkcml2ZXI9cm5kaXNf
aG9zdCBkcml2ZXJ2ZXJzaW9uPTYuOC4wLTc5LWdlbmVyaWMgZHVwbGV4PWhhbGYgZmlybXdhcmU9
Uk5ESVMgZGV2aWNlIGlwPTE5Mi4xNjguMTYwLjE5NiBsaW5rPXllcyBtdWx0aWNhc3Q9eWVzIHBv
cnQ9dHdpc3RlZCBwYWlyCg==
--0000000000000c740a064063ffad--

