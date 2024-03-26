Return-Path: <linux-wireless+bounces-5261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A597F88B6D9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 02:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A72E1F380D6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE41CD16;
	Tue, 26 Mar 2024 01:29:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E21CAA2
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416549; cv=none; b=mewIZMw+TsOrHZF6YQWBNAg9IUQecFWaoOBxkGKZ9wYZp15a3Ylpf35axKlJQr/KSJl6qU8caaV+wL9i+Fa2EPeNcROGNnTz5ewG6EsxhvXbB1lxOHL1kQPbhIgirnHdEZj1JaghlvMBvzn9iMDgCSYnrmVoeC11eyeJpuqP5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416549; c=relaxed/simple;
	bh=1HhH/9sPP9K286u0W/ZuSY4mXQ8UJqDvMhkNpbUPrxw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=G4NHNTw64H0YrRiTq0r/nOKMaXQxd2pVFvGrpcJOaLVpnvVlYwkSNO8rh28FrHT7zAIwzudaOtBudnm9Ne/lq10mvVbyZuakGLQOTxvCEMpcjJpzbB3PrihvqKppJjxh7Iuwh3uQQZnMxaJ2O7q+QZB559D7NA0GyXAUb4bC2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42Q1T0Y503437603, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42Q1T0Y503437603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 09:29:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:29:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 09:29:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
In-Reply-To: <20240321025603.20614-1-pkshih@realtek.com>
References: <20240321025603.20614-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <2a914a14-7fe3-4c74-87ed-4855db5c4843@RTEXMBS04.realtek.com.tw>
Date: Tue, 26 Mar 2024 09:29:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> The hardware command parser of txptctrl (TX protocol control) has overly
> stringent timeout conditions, which results in false alarm. So disable it.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

209621a8f0cf wifi: rtw89: disable txptctrl IMR to avoid flase alarm

---
https://github.com/pkshih/rtw.git


