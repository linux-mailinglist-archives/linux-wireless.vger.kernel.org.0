Return-Path: <linux-wireless+bounces-16006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41B9E8A39
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A7A162D02
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A771156C70;
	Mon,  9 Dec 2024 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dquYRmTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43C155C87
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718047; cv=none; b=N2HMlPXsmtQ35Ct/4Fns4apvYEPA7VexA8MFQ8u3ZjdFxcxsq1WloXEt3VdBTVryJt0WRF2hlwGmPxvzT55ddTSgHyKTf+IpFNELIHUAB7AQ7PaZn1umTEQ7RVNbfRP75Xn3kehlDqInLYKuxZufeN1UxiU+Mv0aHYn9dAy6RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718047; c=relaxed/simple;
	bh=lGfr7KtA3bsyDsLD58iUkG+U5d9eEt89c+PZcrlJsQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B0rufHpp+4XqrMcfGd/2oIZcOuXY4evKQ1PdKLMWmW+HlkzcHkmE7Jt2QWsGsFmwLI0omqgnjwNIwrOrjxheRK5v4l1s4APd0uk/HRRD7WH9ZFPl6BXcGrBYKP1P94bt/kFUGkZldoSk+S+LIuYJDU8YqWZxf4/wb4r8bMIlNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dquYRmTT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B94KfMB2004744, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733718041; bh=lGfr7KtA3bsyDsLD58iUkG+U5d9eEt89c+PZcrlJsQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dquYRmTT4/V7C33zrFnv8g8WKBz8x1JQsbANwk1vFfBjmw9Qz9e01GYzMLIz9ffOV
	 eaQacOrJia/XUHCDF3pMr/lfH0U+RjGp7ROY7BudafFPEOsn63HYlXinex9AC+fuIi
	 H/j0fyugtGhikIg1DnQHfO9TQ7NKBXuGk7/dlDW/3W71Ekph/86kmnb/piGmuwGLKV
	 yR0NmIWy6rekJV/v/svWKtGDGUsrGn8cCmtXeOYgJV6pTvUs+FfERgXubnjDPyfBdo
	 EHKQUpqUHeRIGI+kBz9UXdpWTErAlpHvoX+Lky0hVltGIFWvFFyQNSZL9aOzej2ERd
	 ol3SYQiXlnyXA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B94KfMB2004744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 12:20:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 12:20:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 9 Dec
 2024 12:20:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
Date: Mon, 9 Dec 2024 12:20:19 +0800
Message-ID: <20241209042020.21290-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The channel is not possibly 0, so original code is fine. Still want to
avoid Coverity warning, so ensure -32 offset for the channel number which
is larger than 125 only. Actually, don't change logic at all.

Addresses-Coverity-ID: 1628150 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index bd17c0a1c684..b92e2ce4f4ad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1769,10 +1769,10 @@ u8 _rx_dck_channel_calc(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan)
 			target_ch = chan->channel - 33;
 		}
 	} else if (chan->band_type == RTW89_BAND_6G) {
-		if (chan->channel >= 1 && chan->channel <= 125)
-			target_ch = chan->channel + 32;
-		else
+		if (chan->channel > 125)
 			target_ch = chan->channel - 32;
+		else
+			target_ch = chan->channel + 32;
 	} else {
 		target_ch = chan->channel;
 	}
-- 
2.25.1


