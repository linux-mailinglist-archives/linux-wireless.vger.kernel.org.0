Return-Path: <linux-wireless+bounces-5856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61046898285
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 09:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9530B21E0B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B915B1EB;
	Thu,  4 Apr 2024 07:53:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1D45970
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217228; cv=none; b=FUwRCrVETLe97W1JdmfUjddaq2L84PqFVYPnHggdI8DbFJx83KFoMulZjefz9x+JeN4GHz513tVBXDqkemThY9lUKRYUDl+wIBLAagqnNwNr649RY9lE3i4z6MRkqHkPLhHzBptmVM24flXwMnGlbHIv4fIH9R/LzAnicexokTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217228; c=relaxed/simple;
	bh=0igG3BM/3bHRNyjWqSIfXyYYXYSF2hgI8oWsQlW1RUI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=mqLijZuKnryOspVf2uyRyEaj1UooYq142rDg4d8V50YkIpcpFOAE8DakZvqQMCC6JYXPHZB0I+LvmD7Gh2MPhuEDSOsOyjctRHC4De06ZCw6jY/cKCi9fKg0GGRUYGsE8dTBJ57EmII0jd+Vu6EubnfNEJ696tH95mJD3nGWkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4347rgAyB1764979, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4347rgAyB1764979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 4 Apr 2024 15:53:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 15:53:42 +0800
Received: from [127.0.1.1] (172.16.16.152) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 15:53:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: Re: [PATCH] wifi: rtw88: Set default CQM config if not present
In-Reply-To: <20240401033019.9664-1-pkshih@realtek.com>
References: <20240401033019.9664-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ec106a51-1b91-485b-a875-be0a24478872@RTEXMBS04.realtek.com.tw>
Date: Thu, 4 Apr 2024 15:53:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> When wpa_supplicant is initiated by users and not by NetworkManager,
> the CQM configuration might not be set. Without this setting, ICs
> with connection quality monitor handled by firmware won't detect
> connection loss. To fix this we prepare a default setting upon
> associated at first, then update again if any is given later.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2710c919dfb4 wifi: rtw88: Set default CQM config if not present

---
https://github.com/pkshih/rtw.git


