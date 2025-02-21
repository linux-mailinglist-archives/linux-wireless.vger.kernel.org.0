Return-Path: <linux-wireless+bounces-19233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23349A3E9F7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 02:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BFD1708F1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 01:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237A282F5;
	Fri, 21 Feb 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="d7xBmvYA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F2288B1
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101288; cv=none; b=f4FZf5HUbqbtcJbF15JY5eIR0fOxyuV/rIeIEtc7yfpPg6BVo4Hf6eO+Ltil1TTs66FgABUadrAx/Ms3ygDMgX1i0xXt/DnPRJDXJRcJPApsx7mwHa/0rHbHuMi2m7zzEUxWjecm5urvNd+ri9hQhZqmDLVatMDOKT8iYDJWbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101288; c=relaxed/simple;
	bh=PJsgyHKtOAH16zLiawK0vugNWRm7nv+0IROj6DviDqc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=VzkmvUNgKP47hpGAXw1RWfC6mYFYmJ+r/SOyRmauAOG7BDDXOGwoQk0FpIVZwnkFPmShK8Ia0KIZEfFEMsPY/OjV6kBreV2HwkaF5kPS6mB0Vu4vMtXay/qsx5i6MxgxMPD6OuyBw1abAp6QCGdbHcrKR0YshOi6Mm+bvIBq6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=d7xBmvYA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L1RwzO6778052, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740101279; bh=PJsgyHKtOAH16zLiawK0vugNWRm7nv+0IROj6DviDqc=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=d7xBmvYAmHg9fSNjO7U5Fh4LlfSQkBjCsTTl2RjExcknsYe4SzII66i+HaxAwz4a9
	 1M5GoXYdkuQiHr6v/UWRzn8Xn8w0U3m66iYuxAVWqsK8WS5Sl4ObzfCQtEW0JqQKTN
	 L+Y46ypN1IpC/zEq594O4A3FfeHGGGK6tpRWaSDZ7OpgSsVEiJ0GsXnfiGG6xkvzMn
	 5jMzx9nBwBqaXjfa3fGg+0o/HBlTmaA8gISTA1Hgo+Ik8IRAjF/aqe0e/H++CFMm6O
	 JJgta2gOoVMqHqoaA4Na8uP+2v9xyml1lrN1P3ItzuTH4MKhUoiqfN/PvaEPsMs4xO
	 NkKEnEBgrybZA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L1RwzO6778052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 09:27:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 09:27:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Feb
 2025 09:27:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>,
        Zenm Chen
	<zenmchen@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
In-Reply-To: <20250210073610.4174-1-zenmchen@gmail.com>
References: <20250210073610.4174-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c70713ab-77dc-477e-80d8-a1bb2f2dbd94@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Feb 2025 09:27:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Zenm Chen <zenmchen@gmail.com> wrote:

> Add two more USB IDs found in
> https://github.com/RinCat/RTL88x2BU-Linux-Driver
> to support Mercusys MA30N and D-Link DWA-T185 rev. A1.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

80c4668d024f wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1

---
https://github.com/pkshih/rtw.git


