Return-Path: <linux-wireless+bounces-9039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB790A26F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 04:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AE11C20C1E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678E176AC6;
	Mon, 17 Jun 2024 02:29:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03ED16DEA6
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591351; cv=none; b=JFo561jMs1jisVVlE89JLnaXQZPFoSPi+jjSBxmu7ogUGO5xWLYjfWOgid6GffYNyAkcPID5GHBdb9fZw11gucYG5PE4NwDaa/68XZVbYMt8D0kdwr44wzYM89QX8cy6aJYPhfI1uslxNu0pMngRQDU/MCf4wMIzwBqOZmUDBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591351; c=relaxed/simple;
	bh=CRVYZNFDRz8GaT6whkc38d1P7ZJOXYCqYSncHQRCB3c=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=ECEsAkj/QEfSeiNt2m1nx7JhnQ4k8cuWnVGbcna3R4TgSzhilBakOC3VAaUQ515tdIFhW9cCZQmFbtGTMsAlPIK4gOENWd5fhO3LV2irw8NDeO3Scdq/heFmXLde5mxw9Q+/8gx++RiUUd7BOOB7s9Dyq/yhE5+JonJuXNFrU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H2T5wE42594041, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H2T5wE42594041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 10:29:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 10:29:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Jun
 2024 10:29:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
In-Reply-To: <20240607070659.80263-2-pkshih@realtek.com>
References: <20240607070659.80263-1-pkshih@realtek.com> <20240607070659.80263-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ae016b4e-01ad-49fb-8624-fb3e231474a6@RTEXMBS04.realtek.com.tw>
Date: Mon, 17 Jun 2024 10:29:04 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> New upcoming chip is RTL8852BE-VT (or RTL8852BTE; 8852BT PCIE interface),
> which is a variant of 8852B, and many codes excepting to RF calibration
> can be shared, so move common code to an new kernel module named
> rtw89_8852b_common.ko.
> 
> No logic change.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

5a72e198a6e9 wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
2ab298cf638c wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
190dc12d0649 wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT

---
https://github.com/pkshih/rtw.git


