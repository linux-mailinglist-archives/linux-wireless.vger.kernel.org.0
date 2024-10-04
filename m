Return-Path: <linux-wireless+bounces-13489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D098FD00
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 07:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4307F1C2164E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5281749;
	Fri,  4 Oct 2024 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICub7Hf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C97711F
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019740; cv=none; b=B3gVco4RsbpnzrnEWeHz2g8pCYAJsIE9KFdBXcN9yjhJC7j1uufSMP+swwUUxSzIW9QcArdKWvhUgZbASD5lVpsOngMjka0q79raHRFkkbPCfXATWJRrecQ76Dfk5zxSTC7w8B/II9DdFtxo9OvznMsPPua4ImkbFyCpc8kllNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019740; c=relaxed/simple;
	bh=DmHkWN538flPL/R0llwrnnjg7FGKVJH+ymRu1pzQWSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEEScEUCLNPgCHaXD4f1tm3leLPqaLTe3Fg+L+3uASFI3FBVvc7de7ramrqYlYYqxxA2E3N1QGKyACo0oGkp31IkGmHq+/wtI9ncSrDwLv/2TgkjtNDaVQiCmars/w+peVEVQqVVGlAV41oTc24chtDian3MnFMJiv5gH0tl6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICub7Hf8; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so1557101276.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728019737; x=1728624537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltit7xt7EgZ5t1LRDJCwqpF2XUckua0qVGMLIOrP1YE=;
        b=ICub7Hf8BJ7tXpLN5UMNdUnCWGvwWsWj7u/gikhHBwg37jax8q4Iz7WsAmbzNz0yG5
         h9FOuY6mAMWSL0xnA61P1xXoJnjYThVNzLGNqEIXxZl4/ubYsV1mvkuI3W/LdLu2u/us
         YrQtPcXXiMBBHFvsNTvDDxFYT75M0rl5YZy23I//ls7LhTP6PoOG6Rzzt5tf7m8RQQYP
         9o2HrpUsPacGNw9+FMMZA0jyYkn3z4odKoBh38McZiH9YO9kETOSsCamxS0QPwyXQjNr
         ClT7RslwNej5ghRtftFDuxmyCF8R74Y8qTF9ITzfCw2t3J+8wrKxl6Viyet0+WdiCdR0
         7MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728019737; x=1728624537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltit7xt7EgZ5t1LRDJCwqpF2XUckua0qVGMLIOrP1YE=;
        b=vJkIehbtBzErCzTl3aHUKxiDD4MPnwuo/+FaC43vClNSCgDKHr7xDlVgjsVlICoKmn
         kH60ZMM/sm0xxbGqQiKRMIyK8rmJE+w18VvjmDMMU86C5AbdhtnsaMiDid49BBy2+1k3
         XAIaeGu+U5VxOaGebHPKjOfXi2JEFcGWgz3aPcVbv4u9ADSdjKUeIooXkNCvLy0+0uLr
         N87j3kqw1ZODSu44oVT6yiFLhJuU3MkfeCydfEhpV+8BCRkUcogWMSXLxTnV4DFzfG+R
         xHgJ0mrRLw20dYTGatEic1cBKr2cjrI7XVlM1GoV/6n7qLPT91wiimmCcVVG4X+djILz
         QDCg==
X-Gm-Message-State: AOJu0YwTc+EcOgIMd62/0+BN85I6edrqtYpVg3kantmvgMbIR2AVSF7W
	aSLmi8+VNGc9Wt2Xf/Qp7DPe2Y8a/jz26X4HDHzkkOWZFNU4HoIv2DgscFBpO7klA8l9evk4TXV
	erhaTxY7QyEh7Fnd51Xxsd9xbMaqP8rH3YJaM4w==
X-Google-Smtp-Source: AGHT+IGiXDK7/Pgprbe1BmvzgxQLdIIz/3ouW9nGaI6g8ULQwRw9GSn7pmD8/i1eBRmi4pa4FVKQPisphf3RFoaYiyY=
X-Received: by 2002:a05:6902:2b8f:b0:e20:16b9:ad68 with SMTP id
 3f1490d57ef6-e2893951b87mr1027773276.45.1728019736125; Thu, 03 Oct 2024
 22:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJqS-psO8ykm70VBvi_T05PhOYb4Xvs6MeEUzc2a5uq-EUhM0w@mail.gmail.com>
 <a8170d8367ff4ddeb6cc62113db022e1@realtek.com>
In-Reply-To: <a8170d8367ff4ddeb6cc62113db022e1@realtek.com>
From: Sanjay Bhattacharya <sanjbh@gmail.com>
Date: Fri, 4 Oct 2024 10:58:44 +0530
Message-ID: <CAJqS-pvwUVjf=jrbdd18y1DbnMV2jgzfc5R_krjMGjhc6NPOQg@mail.gmail.com>
Subject: Re: Problems with rtw89_8852be driver in 6.11.1.arch1-1 kernel
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information. I will try the patch later today. For now
here's the output of lspci -vt and lspci -x

lspci -vt
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
Root Complex
           +-00.2  Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMM=
U
           +-01.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-01.2-[02-2a]--+-00.0  Advanced Micro Devices, Inc. [AMD]
500 Series Chipset USB 3.1 XHCI Controller
           |               +-00.1  Advanced Micro Devices, Inc. [AMD]
500 Series Chipset SATA Controller
           |               \-00.2-[03-2a]--+-07.0-[04]----00.0
Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless
Network Controller
           |                               \-09.0-[2a]----00.0
Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express
Gigabit Ethernet Controller
           +-02.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-03.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-03.1-[2b-2d]----00.0-[2c-2d]----00.0-[2d]--+-00.0
Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600
XT/6600M]
           |                                            \-00.1
Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP Audio
Controller
           +-04.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-05.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-07.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-07.1-[2e]----00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Function
           +-08.0  Advanced Micro Devices, Inc. [AMD] Starship/Matisse
PCIe Dummy Host Bridge
           +-08.1-[2f]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Reserved SPP
           |            +-00.1  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Cryptographic Coprocessor PSPCPP
           |            +-00.3  Advanced Micro Devices, Inc. [AMD]
Matisse USB 3.0 Host Controller
           |            \-00.4  Advanced Micro Devices, Inc. [AMD]
Starship/Matisse HD Audio Controller
           +-08.3-[31]----00.0  Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
           +-18.0  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 4
           +-18.5  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 5
           +-18.6  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 6
           \-18.7  Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer
Data Fabric: Device 18h; Function 7


and

lspci -x


              =EE=82=B2 =E2=9C=94
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Root Complex
00: 22 10 80 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU
00: 22 10 81 14 40 04 10 00 00 00 06 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 00 00

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge
00: 22 10 83 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 2a 00 d1 e1 00 20
20: c0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse GPP Bridge
00: 22 10 83 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 2b 2d 00 f1 f1 00 00
20: 90 fc b0 fc 01 00 f1 0f 7c 00 00 00 7e 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00

00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B]
00: 22 10 84 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 2e 2e 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse PCIe Dummy Host Bridge
00: 22 10 82 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B]
00: 22 10 84 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 2f 2f 00 f1 01 00 00
20: 60 fc 80 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B]
00: 22 10 84 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 31 31 00 f1 01 00 00
20: f0 fc f0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 61)
00: 22 10 0b 79 03 04 20 02 61 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00: 22 10 0e 79 0f 00 20 02 51 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 0
00: 22 10 40 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 1
00: 22 10 41 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 2
00: 22 10 42 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 3
00: 22 10 43 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 4
00: 22 10 44 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 5
00: 22 10 45 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 6
00: 22 10 46 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD]
Matisse/Vermeer Data Fabric: Device 18h; Function 7
00: 22 10 47 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 500 Series
Chipset USB 3.1 XHCI Controller
00: 22 10 ee 43 06 04 10 00 00 30 03 0c 10 00 80 00
10: 04 00 ea fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 21 1b 42 11
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 00 00

02:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] 500 Series
Chipset SATA Controller
00: 22 10 eb 43 06 04 10 00 00 01 06 01 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 e8 fc 00 00 00 00 21 1b 62 10
30: 00 00 e0 fc 50 00 00 00 00 00 00 00 ff 02 00 00

02:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] 500 Series
Chipset Switch Upstream Port
00: 22 10 e9 43 07 00 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 02 03 2a 00 d1 e1 00 00
20: c0 fc d0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 03 12 00

03:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
00: 22 10 ea 43 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 04 04 00 e1 e1 00 00
20: d0 fc d0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

03:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
00: 22 10 ea 43 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 03 2a 2a 00 d1 d1 00 00
20: c0 fc c0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE
PCIe 802.11ax Wireless Network Controller
00: ec 10 52 b8 07 04 10 00 00 00 80 02 10 00 00 00
10: 01 e0 00 00 00 00 00 00 04 00 d0 fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3b 1a 70 54
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

2a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev
15)
00: ec 10 68 81 07 04 10 00 15 00 00 02 10 00 00 00
10: 01 d0 00 00 00 00 00 00 04 40 c0 fc 00 00 00 00
20: 04 00 c0 fc 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

2b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Upstream Port of PCI Express Switch (rev c7)
00: 02 10 78 14 07 00 10 00 c7 00 04 06 10 00 01 00
10: 00 00 b0 fc 00 00 00 00 2b 2c 2d 00 f1 f1 00 00
20: 90 fc a0 fc 01 00 f1 0f 7c 00 00 00 7e 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 01 12 00

2c:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Downstream Port of PCI Express Switch
00: 02 10 79 14 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 2c 2d 2d 00 f1 f1 00 00
20: 90 fc a0 fc 01 00 f1 0f 7c 00 00 00 7e 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

2d:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c7)
00: 02 10 ff 73 07 04 10 00 c7 00 00 03 10 00 80 00
10: 0c 00 00 00 7c 00 00 00 0c 00 00 00 7e 00 00 00
20: 01 f0 00 00 00 00 90 fc 00 00 00 00 43 10 d5 05
30: 00 00 a0 fc 48 00 00 00 00 00 00 00 ff 01 00 00

2d:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi
21/23 HDMI/DP Audio Controller
00: 02 10 28 ab 06 04 10 00 00 00 03 04 10 00 80 00
10: 00 00 a2 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 28 ab
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 02 00 00

2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse PCIe Dummy Function
00: 22 10 8a 14 00 00 10 00 00 00 00 13 10 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 00 00 00

2f:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Starship/Matisse Reserved SPP
00: 22 10 85 14 00 00 10 00 00 00 00 13 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 00 00 00

2f:00.1 Encryption controller: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse Cryptographic Coprocessor PSPCPP
00: 22 10 86 14 06 04 10 08 00 00 80 10 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 70 fc 00 00 00 00
20: 00 00 00 00 00 80 80 fc 00 00 00 00 62 14 56 7c
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 01 00 00

2f:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB
3.0 Host Controller
00: 22 10 9c 14 07 04 10 00 00 30 03 0c 10 00 80 00
10: 04 00 60 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 7c
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 03 00 00

2f:00.4 Audio device: Advanced Micro Devices, Inc. [AMD]
Starship/Matisse HD Audio Controller
00: 22 10 87 14 06 04 10 00 00 00 03 04 10 00 80 00
10: 00 00 80 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 56 ec
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 04 00 00

31:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 51)
00: 22 10 01 79 07 04 10 00 51 01 06 01 10 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 f0 fc 00 00 00 00 62 14 56 7c
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 01 00 00

Thanks,
Sanjay


On Fri, Oct 4, 2024 at 8:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Sanjay Bhattacharya <sanjbh@gmail.com> wrote:
> >
> > However, on downgrading the kernel back to 6.10.10.arch1-1, my wifi
> > interface seems to be working fine. Can you please help?
> >
>
> We have found early chips have 36-bit DMA interoperability problems with
> certain platforms. Could you share your PCI host vid/pid by outputs of
> 'lspci -vt' and 'lspci -x' ?
>
> And, please try patch [1] to see if it can work to you.
>
>
> [1] https://lore.kernel.org/linux-wireless/20240924021633.19861-1-pkshih@=
realtek.com/
>

