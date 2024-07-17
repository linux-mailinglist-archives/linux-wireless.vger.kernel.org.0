Return-Path: <linux-wireless+bounces-10281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F040933600
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCCD1F232CC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 04:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44E748A;
	Wed, 17 Jul 2024 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jdsFBbjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF5469D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190236; cv=none; b=hRfd1kSd5qjFOVxYDIoALhnS3OAYClTel+cp2rngWKPBrUQa+d9xR3WdK8hbW3pS4dByVv9uyArqPZV89bWXBWiUCZM81g08aD8xMpZGQsqMG1YJnPJKlCSixlTPwR/ftTotMbtmpmvq4deGGoeKAZ+PBQLfQuSrR4KElLj2G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190236; c=relaxed/simple;
	bh=AVqmKxmJrbrX3Ms+JDKJ1KdrvsspveburUXwEdRmnEo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=jVU791+55yjGQr28YxJ+ae0l7wXDW3Yoiv05Ne/m3eRw2EarOf/q6iGrfYPsKPRlw0VHDAbld4XKmsi5YxtLVX4JZApGooc7CN1bM0rdwblmSMnsa+9e/qdfAC6UBVOAT5eDFZcj7ArJbqGoEx8HZPQynaQh7OBvNoAGAH5PW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jdsFBbjn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46H4NaAwA1707173, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721190216; bh=AVqmKxmJrbrX3Ms+JDKJ1KdrvsspveburUXwEdRmnEo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=jdsFBbjnMJnZuJNDtLsQJ0NOMCQ63i+U0LSA/BKaG0KCvECN79un+YJzxQSvkU8X4
	 xQXQXs1sDsTCGsctGQQRCY0MBsA56sz24uzY0Ga+qCCQ1CkICKrwu5DTpJi5uKjBOa
	 nmZJY9l4ghNTofDGB8sUTEucsEYdCzuaojtVoYoxXAkr9zqiYUwdlJ270ukj8aosaT
	 BdrxS1MNPrG6lGrJjce3jTbMrZylOPm90aGhxotfrdr1fOsXOtZh7rL/ZZeuymcAKM
	 hGMLHGvwSJCdegAtp7BIHxMuaes0HFEzK6olbZXp+5sgaDLmCDBvLO/UxP5/Dczit+
	 7Erv3vDHHRdPA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46H4NaAwA1707173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 12:23:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 12:23:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Jul
 2024 12:23:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "Sascha
 Hauer" <sha@pengutronix.de>
Subject: Re: [PATCH v2] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
In-Reply-To: <77906c62-5674-426f-bde1-1b2a12a0339d@gmail.com>
References: <77906c62-5674-426f-bde1-1b2a12a0339d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <63bbe01f-ccc3-4f5d-b04a-0d32609e43fd@RTEXMBS04.realtek.com.tw>
Date: Wed, 17 Jul 2024 12:23:37 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The Realtek wifi 5 devices which support USB 3 are weird: when first
> plugged in, they pretend to be USB 2. The driver needs to send some
> commands to the device, which make it disappear and come back as a
> USB 3 device.
> 
> Implement the required commands in rtw88.
> 
> When a USB 3 device is plugged into a USB 2 port, rtw88 will try to
> switch it to USB 3 mode only once. The device will disappear and come
> back still in USB 2 mode, of course.
> 
> Some people experience heavy interference in the 2.4 GHz band in
> USB 3 mode, so add a module parameter switch_usb_mode with the
> default value 1 to let people disable the switching.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

315c23a64e99 wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU

---
https://github.com/pkshih/rtw.git


