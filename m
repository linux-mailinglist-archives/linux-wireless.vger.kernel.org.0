Return-Path: <linux-wireless+bounces-14489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275939AF74F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 04:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF022825F3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0936AAD;
	Fri, 25 Oct 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NzQ4Bp7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C93FC2
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822675; cv=none; b=VfRcHDrIoOBFFA9oS+o6IknKZeiJlga0QnsaHfxntqizOsxyO4J9n0542YRcaj/CzRXdHfd27j3eSgRos/ZB7ZzczgOSKICMwphPN1RMbOVh9f5HJljZuK87pukLi6Tz9X1IK/GFy+i35pUES8rw8o/8RbZ+ndEROPnnT2eTJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822675; c=relaxed/simple;
	bh=znDQJ7TC18Z3hWIfja3tYulSA7t/h3fgaIxdHen7xrc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=V2oDgiTMfAFp+EBfJ+vLdbDAG4Gz+niVrF9z6R7lpj2xKNFoqIcVsnBiYPQgJKqU+cBg+xQ6aTGSgt9gh9g/L/YTOO7M3KvsdpCiHayDU5py5br8fOFtqkcHE3gvoCl7ENnCZyIh1GGIRkBAhFdTkW1SJ3H0yXNvFmp+699kZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NzQ4Bp7e; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P2HpPzA4086830, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729822671; bh=znDQJ7TC18Z3hWIfja3tYulSA7t/h3fgaIxdHen7xrc=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=NzQ4Bp7e0192gyVF/5FUE0DNY/ixvSy2iFMZ/5AYXz3qPeRtUnHx5feLn0J2zgYni
	 bw1M7CIlveM4lLnywfSMP/mFsikpgBZNquf92BkJvq06DREj/YeERF2ysGmedHztoN
	 iD2pAA1vZ1moZ9VNRBZ62EiRWs4WULjveOJXgcuit/z5itodsMexu9Q3VIdkPUrOfj
	 oqbOWHAGQc7tKmThN8P+XaqwGuwkR7eHyIMnXAPd3uXQqiuamWdqtt7Bn+wOBvC3f4
	 iBZlQ1C4NvWGT0BkkCMx3KoNv+nHUydDaSLS8eGLVwzsVSu0Hk/HjdIyMn7nExzOcG
	 cIQ15D0uH30fQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P2HpPzA4086830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 10:17:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 10:17:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Oct
 2024 10:17:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware
In-Reply-To: <20241018055651.21166-1-pkshih@realtek.com>
References: <20241018055651.21166-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <07735ffb-c9ad-4655-9677-abe4f79f08a1@RTEXMBS04.realtek.com.tw>
Date: Fri, 25 Oct 2024 10:17:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Some used firmware are missing to be added to MODULE_FIRMWARE().
> Add them accordingly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

142c062d5814 wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware

---
https://github.com/pkshih/rtw.git


