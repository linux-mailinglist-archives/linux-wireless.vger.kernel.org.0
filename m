Return-Path: <linux-wireless+bounces-20286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B429FA5E95D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281313A5484
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DFB610C;
	Thu, 13 Mar 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PzRk8xuD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B92E3391
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828657; cv=none; b=GWZB9ce68fnyH/DbM1Eif1o4I7PNreO3iveuffF+ubAtPgQeySVxxXpKqFmUGZaWcpkhnwcpCl94BGwMVHVwYnDhS0oU+iidvum3p4ub6jtygTCKyO2wXv2Wcz5fmPRWsQV8csM5dkSKeCFMbx1KPsx+d7bz6r4Wios4ibEl354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828657; c=relaxed/simple;
	bh=6DoN/9PEqn+KliiDiRnSxVz4o/eZdV4BMKKFszsVATs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=BKPk9/pggnRsDsNL7OpivlMhJjvwLqtfdJ4TPvRw9LGttc7xnstVxqrH8pv5wXdgR+W7nVPV3eY8xGlhhUMLqIWhyPvfMmnQviJ2i8c5AnkkotxudXyRLTzwByikYMWM4udAzYgTICTp9fUC+SwKCqhlozcVfE0/oTEIeQZpLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PzRk8xuD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D1HUfW4260593, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741828650; bh=6DoN/9PEqn+KliiDiRnSxVz4o/eZdV4BMKKFszsVATs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=PzRk8xuDN4m0GACaleihh6h8fFFm/Fw5Kfec3LmlF4+1qnrflS9KX4/s5iWzAmMvO
	 sWRvfdQIJHrkzQeTCEQCLpUX/JuwKAPmre68kvj8bq2UpxS6tFZtls4F+DoVWmWwoS
	 2QXjW8UK4mVleyGJoZ1nElcg4dVqonHk9BacadyTi7KUH/6xmi4c6+KVPMFoxFCIop
	 apLpPiXGK4omQ0XsLT8zd2x5OAVM/rGVhFzv3E4w6pHZMLvhQt/ZYa5EIBXk1z/D8h
	 C+PTGlTajHIkbMDboHB9QLngropiMbajY8tUQve9yp9WYi2HO01Q1xmq2X0bHNNX8L
	 48TJhhoV6oDxA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D1HUfW4260593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 09:17:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:17:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 09:17:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/7] wifi: rtw88: Add some definitions for RTL8814AU
In-Reply-To: <1dcb5abb-26f8-4db5-be36-057de56465e5@gmail.com>
References: <d25331f4-653d-4ab1-b3dd-0ec1a73209e0@gmail.com> <1dcb5abb-26f8-4db5-be36-057de56465e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9e29db20-32fe-4772-bb5f-c6535241d8f9@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 09:17:30 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Add various register definitions which will be used by the new driver.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

679ec431477c wifi: rtw88: Add some definitions for RTL8814AU
f4debfcb1b3c wifi: rtw88: Add rtw8814a_table.c (part 1/2)
e38246889cc9 wifi: rtw88: Add rtw8814a_table.c (part 2/2)
1a7545784642 wifi: rtw88: Add rtw8814a.{c,h}
dad8e8793102 wifi: rtw88: Add rtw8814ae.c
bad060e8a425 wifi: rtw88: Add rtw8814au.c
deb3ddeb1865 wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

---
https://github.com/pkshih/rtw.git


