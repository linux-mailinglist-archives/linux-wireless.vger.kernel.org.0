Return-Path: <linux-wireless+bounces-27815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B608BB9471
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D473B1898E6D
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 07:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB941E47CC;
	Sun,  5 Oct 2025 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGmR4VfZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B10186E40
	for <linux-wireless@vger.kernel.org>; Sun,  5 Oct 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759648349; cv=none; b=XW5FYT4fbf+bvjEjRdTQQRWeOXr2SHtPoaXyOfrnR6CO2qPe+yryCWoxWPhcXlwjSObTsMDz2BfY18zkAA9qxsOTSKtHn1HJja9n5oz8xO9yvYtOAggeOGkg2y7nYteGzy3fCrGPK4ZlDsg3PSisiALXocH5vsJ0f7WCG7SLxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759648349; c=relaxed/simple;
	bh=uLbCSnPzxk3Pd2cfZv75N/9WHUkvGEISioC9aAo2FWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjde96ThsuaOmUt8nOaWPOLv4scQyFgk+0PGxE2G3uNyrHUwtzeyye2WT3gHTURpfatDpl5LdLtKQX7ZkibAmdikIf1WCDcPLK2ATgggKkxiefv+4o6mmcGq1Vwai57D7q1Wzoyn+KLDgMU5bIUbY7TxKpeBzMlKiTZhOpykif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGmR4VfZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6398ff5fbd3so79123a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759648346; x=1760253146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLbCSnPzxk3Pd2cfZv75N/9WHUkvGEISioC9aAo2FWg=;
        b=ZGmR4VfZUJEYMzzDqJ9BmlhtCueDf+5p2jsHDuEAdERfjY7qLS7lVRFJEG4VFYOalb
         VBKP9HujOjbAJlLO/ZO5WCMGF57ma4BVDjVpDT91ldB6LCz2MT9BpStkLZW1rZyRDG7v
         75iMyxYNp39mcJG19J42/+FWecdYdiiAHX7fxKK6wNBl3eq6PlIc1itcn1fuONhJBCYV
         bIjPANKgcPkieWgucV0wcSc10Ji0cuaXL426BLbfNW3evcBIoHuQTEl7XtuNmf5yj45A
         kAr+/f1pFGH2kBOegKnida9oOja+iUEDc+eYuuh+/FDZ3L9xkh1qS+p16PejuEdFMlYn
         qjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759648346; x=1760253146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLbCSnPzxk3Pd2cfZv75N/9WHUkvGEISioC9aAo2FWg=;
        b=BWRrRRtQw/pr9LHa1XSJTFsmicNqr72b91odzNb4dJD1L5t6laLRTsma6sUKRG46r2
         O7RXtfvyvfZ/x+PSXRNUa5ZzI/iImH6zuUsk620/m9TaWcAllHItOunNkpoL4c7pp2/Z
         iVwiSQILfamuogssjMQuiboKIGL+eSkqy/bW/Oo8Vq4Yvg43kNfUOTJOss7YvD8aKjN4
         jf3yl9GVdRjcYjCrbP1+uiSY+Ez4crUHr+Odc1eVPk88O7PUbEM0ybCNiI6md02jS6i7
         SSrHkB5ohvD//lET27NQw15Pgw0VphDcxdDsQnKjXtwFRpeWVXgVnWUx+kO6U7go5zI7
         gJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCXxNbUQZOXZqL1OcL2lhcS+k4Sc9CybboJBnrSs5uEU/VfMAT2zLCdzXPT9WVrrshR2mFqmzQZxbdy2rI+qSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CfQCoX4EjIjQXcaCpC2MnEsaPqONoly3SjMFxh/TW7vZb+DR
	3LBmp8sPwePNJO5Ql9hCoJpEblykrNui9tTEOVBMspCPByIXzPmDpP//qAYqdR1/7HsipFYUnaw
	2YdWhsEzBHuUZ+/yxeN1rBBRTIgHIEsM=
X-Gm-Gg: ASbGncs04DemneEUuqO74dKjiuS7887QSB52t1FMPipY2dHU/25G6vCYqaNHMpYaetF
	Lj0a+Xk5KfZEbLohaNRHFDRWyeu3eyIIwYfXAyVuTY6d2IrGFh8PIyVysCcWp67FUIO6Z0MrL6x
	cieG4enO6MNQAk9wOnvRXYslC+sBgCTUyXggq/wn/u5FTYDcaEqlKx4OkNp9eQwPIY4illlw76R
	0hg491WRMs+DwPz4dRX/3IEreUsARrL8f1UwWoWTSwsMpMZFIAFaMVR49kqKovehxd4YeXrrL0T
	CiDzrpfXFy8UU8PFoN2WcA==
X-Google-Smtp-Source: AGHT+IEaPBqgxHA9mkRsw5U5GshfyfUI6tv0+FQCqIyqIgMWxhvQ3ZtfCt3ueV0hiB4VsTPxZMicA8Qi+UM3+mqAQlw=
X-Received: by 2002:a05:6402:40c4:b0:637:e490:4609 with SMTP id
 4fb4d7f45d1cf-63939c3d1c9mr9167635a12.31.1759648346239; Sun, 05 Oct 2025
 00:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxkQ2gADc+kvZhxz3ds-QSkg+c59DQdmtXLVwRF2pGFgFNL-A@mail.gmail.com>
In-Reply-To: <CAJxkQ2gADc+kvZhxz3ds-QSkg+c59DQdmtXLVwRF2pGFgFNL-A@mail.gmail.com>
From: Austin Justin <austinjustin4809@gmail.com>
Date: Sun, 5 Oct 2025 12:42:14 +0530
X-Gm-Features: AS18NWCh-Go5b09ggMRT_w8w5GXIx2rCfjQ6NaWUTEl5HGWub9C6sqG-upQZYzI
Message-ID: <CAJxkQ2iVpQBzLJcFawm9qvqQ=04=MxO9puD2ChgjyXL36h1w9A@mail.gmail.com>
Subject: =?UTF-8?Q?Fwd=3A_Request_for_Linux_Driver_Support_=E2=80=93_MediaTek_M?=
	=?UTF-8?Q?T7902_Wi=2DFi_and_Bluetooth_Chipset_on_Ubuntu_22=2E04_LTS?=
To: yder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	deren.wu@mediatek.com
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kernel-team@lists.ubuntu.com
Content-Type: multipart/mixed; boundary="0000000000009ba71f0640640e99"

--0000000000009ba71f0640640e99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Request for Linux Driver Support =E2=80=93 MediaTek MT7902 Wi-Fi and Blueto=
oth
Chipset on Ubuntu 22.04 LTS
---------- Forwarded message ---------
From: Austin Justin <austinjustin4809@gmail.com>
Date: Sun, 5 Oct 2025 at 12:37
Subject: Request for Linux Driver Support =E2=80=93 MediaTek MT7902 Wi-Fi a=
nd
Bluetooth Chipset on Ubuntu 22.04 LTS
To: <ryder.lee@mediatek.com>, <shayne.chen@mediatek.com>,
<sean.wang@mediatek.com>, <deren.wu@mediatek.com>
Cc: <linux-mediatek@lists.infradead.org>,
<linux-wireless@vger.kernel.org>, <kernel-team@lists.ubuntu.com>


Dear MediaTek Linux Driver Team,

I am writing to request official Linux driver support for the MediaTek
MT7902 Wi-Fi and Bluetooth chipset.

This hardware is present in my ASUS Vivobook X1605VA laptop running
Ubuntu 22.04 LTS, but it currently lacks native driver support in the
kernel and Ubuntu repositories.
The wireless and Bluetooth interfaces are not detected automatically,
and no compatible package is available through 'ubuntu-drivers' or
DKMS.

Hardware details:
------------------------------------------------------
$ lspci -nn | grep -i network
03:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]

Kernel version:
6.8.0-79-generic
------------------------------------------------------

Could you please advise if there are existing drivers for this
chipset, or if MediaTek plans to upstream support into the Linux
kernel?
If testing or logs are required, I would be happy to assist to help
ensure compatibility with Ubuntu and other Linux distributions.

Thank you for your time and support in improving Linux compatibility
with MediaTek devices.

Best regards,
Austin Justin
ASUS Vivobook X1605VA
Ubuntu 22.04 LTS

--0000000000009ba71f0640640e99
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
--0000000000009ba71f0640640e99--

