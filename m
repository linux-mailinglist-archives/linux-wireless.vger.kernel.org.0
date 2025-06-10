Return-Path: <linux-wireless+bounces-23937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2082AD38C9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C3A20052
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8E246BB9;
	Tue, 10 Jun 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KFY3o43w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049B246BB6
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560503; cv=none; b=kkjs+YgH1N6RvGXUrsdOfLhxzS+7a/Kffv0Ipvq66NDpedAekBEk8uUAsWGI4/kZRgGA87iYq0jyP09oUKjWUNEf/Lc9hCzVSjPX6zNz3FsPJHPrZhtB11j7s+VnMfbg9wpjWKe/HuFNHYicypUEwzfEG7WagLG3XPUYMnIFyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560503; c=relaxed/simple;
	bh=SKQu4Cvf/d5hU3GArWwbK/H6vjhd1bdu1fSIpodek38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9w9z1RkW0IInjFjaQ3GB01no87bJORCKj7hhymxHzQ5sa+ot/paani8KcLL/DEfDZFJULstdvuTdxoD0DH5IsRwQfo/byq8RVI1wHx0vNt1I0fYEtPGjTc5PLqbpXZ6JS1c/lVjFhP8GD3qvKa9jkT5jKOGgE5tuZyJXC4ygHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KFY3o43w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1dcuE2995826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560500; bh=0HDr1Fu9mhxpJcRXbqmbq7yd/0A7YC+zsTe1/TAVC+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KFY3o43wnhkNBPUhMDaOuf3tNOEup4v+eaRB9nxWh5HhW13GCZntwTjszcEGe0gt2
	 tGMIHGQtMSP8fzmYdWWTFcsGdYNxbJ2pUXS8EIOOhxrWfhddylWzzfdrRvkpPKNN7L
	 GHykzu9V7QI2TPyfvXNSP8GmTmkKNUMYl0MfGTAyHwp81l1EvkmWoflffgLTxlO1TR
	 FDyl0EHd5M5a4XvLti4tfV4b+rVYmFbhKjdv88lz1g8sorZ0860HCzpYxpOL6c/TD0
	 mZB4dpzK+oAtWi1kQEmtCX/J3unpdiwH9D4/dF59rXTBUESJHkuXDS+V4gRcBC11Cq
	 sys6wyvDIPBTA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1dcuE2995826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:40 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of tob
Date: Tue, 10 Jun 2025 21:00:32 +0800
Message-ID: <20250610130034.14692-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

When the beacon offset is less than minimum of auxiliary tob
(aux->duration - aux->limit.max_toa), the upper bound of the reference
toa might be negative and lower than the lower bound, which causes the
auxiliary result to exceed the NoA limit. Therefore, in this case, the
anchor pattern is used for calculation.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index c83c4036151d..2a77b1978c38 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1273,6 +1273,8 @@ static int __rtw89_mcc_calc_pattern_anchor(struct rtw89_dev *rtwdev,
 
 	if (bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
 		small_bcn_ofst = true;
+	else if (bcn_ofst < aux->duration - aux->limit.max_toa)
+		small_bcn_ofst = true;
 	else if (mcc_intvl - bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
 		small_bcn_ofst = false;
 	else
-- 
2.25.1


