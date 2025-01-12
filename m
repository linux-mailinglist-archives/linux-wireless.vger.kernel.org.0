Return-Path: <linux-wireless+bounces-17363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C07A0A6E2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 03:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92D5167A96
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BC10F4;
	Sun, 12 Jan 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NOs/SYLK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAE440C
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647223; cv=none; b=Ueg3r5uTVeT6hILW63f2ZzbbaXH/j4exan0EXbk94uRrVA5HpYrT2lROsYB9TI3SaG7nd03PX3GxgFmpRxLSP7u42grfkpdmYe5/wtXXg4mnESmcXurgYVHOriBI/sSVRA4s3kyPf1lxdbrtFuOBU6XbXfGk8mU7aGuVBVJGOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647223; c=relaxed/simple;
	bh=+pv14WSbUAA2bIaG1GT8uMRo57vOWnRU/5MuEwISskE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=TBK79emWcY1HQN7SOgjQOwNXrTCbCEOHaQhTb9odhHxcom7Ww4cihJOciYjFL9ip6JHqbDMFARUI3Ldmur/kmW7wiQtxNo45qp30hkQj1Bfqx8yYLwBCmQ7QwPk2FPpC9/gsexj4vsbXtRxMjKHI02H4JDf5BeTyuONE9+J6KJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NOs/SYLK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C20HDq81602413, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736647217; bh=+pv14WSbUAA2bIaG1GT8uMRo57vOWnRU/5MuEwISskE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=NOs/SYLKxX94CIdKRM1AOV3wkQNXlvF6yTWCyhAxyo3vUn19RgkdMTkthFp7GcDY6
	 WrYV3TtX1ERwQf74JlZcSPCfilj6FSeWrtYoCNclZbtZlkykh3v6qGFbGnWdjqIaM1
	 42MNTIzxC5lB7l7hsxyST6u15/JhkYDHasZ/hOWTwI+py8VOWh5GGpqXRjoPC3ZCjh
	 Ttbe2BSnZxdHFQd+Xz74ZfEAx0Xu6X0Ql3zWSUsRXqzOAswNjoQL5wENfk/MBO+03h
	 9xupfGiOyBu0Z9enceKlZ5OV+lFSlaWJqEYmsEgDW7kF3CCpHMReSudXAZcljual6O
	 Hffy0UsCk9/KQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C20HDq81602413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 10:00:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 10:00:17 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 10:00:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: Delete rf_type member of struct rtw_sta_info
In-Reply-To: <b80f7904-c6b4-4d12-a5f9-69ab9b965732@gmail.com>
References: <b80f7904-c6b4-4d12-a5f9-69ab9b965732@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bff3dd9f-b7ec-4cf8-b059-2af8c942c792@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 10:00:17 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> It's not used for anything.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5ad483955acc wifi: rtw88: Delete rf_type member of struct rtw_sta_info

---
https://github.com/pkshih/rtw.git


