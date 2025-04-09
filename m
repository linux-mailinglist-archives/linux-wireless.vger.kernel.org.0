Return-Path: <linux-wireless+bounces-21287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F4A81ACC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6302B4C004D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81E78F3E;
	Wed,  9 Apr 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T+bltvVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2118F49
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744164613; cv=none; b=ACcCBb26H8MNVkEtjwQTe9QhmcqxC0R8xE3xJ8yMIUe6p1DbwgyZx7Pqoi50fl7OWBFEn1DbUzpGZpMKXG/pFzZUEb50JJDEWbhldEANlivyMfr+ICVndX1b7P8/vEk4x9Z1zZWTRQ4NTp0I77pdGaqIHltBl07Ya4U+B2tfljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744164613; c=relaxed/simple;
	bh=Uou+ET49cUARAIvSXcjIO1emCCxmMjHYb/D+NMK+ivE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=n736WO40Yc38EOWXmn6VZvDypToBdNhhJHcw5E5kEJviyn+naepRCYDSrsx8tQNce70J7dDWbUKkXFoB6IifNj5ec8rIkedG619LbxaMYDZMM+JN1leXjLb3m4uxppOf3s+YKSGsd0KcMqTQ5gAaY2uyrPfweNdm5JlOu6N6c5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T+bltvVF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5392A6Vt8457215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744164606; bh=Uou+ET49cUARAIvSXcjIO1emCCxmMjHYb/D+NMK+ivE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=T+bltvVFJM0cW+4p8TZG5gPYLgnvOIDoeuG8cq4ZuNkhmKGnQNSnKlpkCdaXeNnp2
	 7Z/U72F5f6Fcvk0iu0I35us4//Wih3HFh4rb2220FXxWqK9EL9pk55rXsmPjBBgK7+
	 1VMglp0k2BNtDo2Xj7869fQoMHT38w64i/sOUTbzFNMNDo4I6EEQr1iVih5sbz3+gO
	 Ml0Dq7CCLLziI89vK0t2V4FLJw0o3TrHilG47HkWV6nbNNsjvl+NSasFBzb+8KjOWS
	 /CXj5v005UnkgCZuNc/XavGaAir8Px+TuRDCa2AxHdaXIqozPYWJJE9uta1FmxqOGP
	 rBkmvTb/M7x5w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5392A6Vt8457215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 10:10:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Apr 2025 10:10:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Apr
 2025 10:10:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Fix the module names printed in dmesg
In-Reply-To: <29cd29ba-bc51-4d5b-ad48-a43c6ce72d56@gmail.com>
References: <29cd29ba-bc51-4d5b-ad48-a43c6ce72d56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <62b01dba-f840-4c2c-82e9-a28db410e7e5@RTEXMBS04.realtek.com.tw>
Date: Wed, 9 Apr 2025 10:10:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The rtw88 module names all start with the "rtw88_" prefix, but the
> messages in dmesg mostly use the "rtw_" prefix. The messages from
> rtw88_8723cs don't even have the underscore.
> 
> Use the KBUILD_MODNAME macro in every driver. This ensures that the
> messages in dmesg will always use the module name.
> 
> Before:
> 
> Mar 17 15:54:19 ideapad2 kernel: rtw_8814au 2-4:1.0: Firmware version 33.6.0, H2C version 6
> 
> After:
> 
> Mar 17 16:33:35 ideapad2 kernel: rtw88_8814au 2-4:1.0: Firmware version 33.6.0, H2C version 6
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

581cf3a9cb61 wifi: rtw88: Fix the module names printed in dmesg

---
https://github.com/pkshih/rtw.git


