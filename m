Return-Path: <linux-wireless+bounces-7623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624528C4AF4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932051C21C14
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49817C2;
	Tue, 14 May 2024 01:37:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619CA94C
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650639; cv=none; b=FFRuRbenCPeyEoKp+iTNrWz7yBhrmV7EFqXu6sJ11GZjPfH32vpoCp4Q22XG5lHIHLywPVNOpWE2hGRfIpGutTgEhx6eiqwhdHrLSUpnGZIzTXX4SZREmSNbbmSJFETBq5mZCuxXRrbnXr+dqZN/UG72oD4o/AwhzH4+N7I1zlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650639; c=relaxed/simple;
	bh=6qL3PUBOF2DuB9dEmZfdEOiv/Mgb13SQqR1TqHQNwAg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=b8EAreXCm62mzB/tFbQ3n+nuN57tBsdCHwaI+6Pu4jocd6/oSuRj9gyiAaA81nBMgFD3mlEEkJBkm+uJeRDCe9HY14V4EvsHCKiRFjzOtQV5WKxhdOY1faRSC4z5BFvbmKzAuzOteNFCPFpIwm3DvsAa8HP/S/dShlcyJNhNybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44E1bCxU52244152, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44E1bCxU52244152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 09:37:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 09:37:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 14 May
 2024 09:37:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/4] wifi: rtw89: ser: avoid multiple deinit on same CAM
In-Reply-To: <20240509090646.35304-2-pkshih@realtek.com>
References: <20240509090646.35304-1-pkshih@realtek.com> <20240509090646.35304-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <548799df-8652-44ca-ac96-183d5f90bd90@RTEXMBS04.realtek.com.tw>
Date: Tue, 14 May 2024 09:37:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We did deinit CAM in STA iteration in VIF loop. But, the STA iteration
> missed to restrict the target VIF. So, if there are multiple VIFs, we
> would deinit a CAM multiple times. Now, fix it.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

cea406658830 wifi: rtw89: ser: avoid multiple deinit on same CAM
0448c65af921 wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
e9f1a901c9cc wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
578bdd984f45 wifi: rtw89: support mac_id number according to chip

---
https://github.com/pkshih/rtw.git


