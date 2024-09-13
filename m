Return-Path: <linux-wireless+bounces-12825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8A97792F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67F8B2406B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08B1AD26C;
	Fri, 13 Sep 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XMojTVQy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD691BA894
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211663; cv=none; b=ELb1fbYCypNMhKIAapks9UJwD8YHJMyi2veI48k0Q37HljVDhJmeg9igAfCJ5HMzYJAdq7eUYJZYYmeuGB/Ri42QSJAc08LSrmdrH/mxb+EjZCUbVsF5NFqiHOlyEsUCi0i88woQMV3zJFiUBV0Tsj/M3UWXlpiQa7TTmWpw718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211663; c=relaxed/simple;
	bh=KoUWRW2m0tIuG0n+zIOiG4CKOAv4NcSBzHPh66Q/5AU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M51tJpJvRcSTXl3RtV+KD+LuzO9YEY0CRBnumpHY3aP1to5ef3I4zv70QALC1zRSlmtSEzjD23B++CD0yotw85YQrLfCA4kHrCmNYtV4J5ZaBkyGCY+vtnVreqExp3/h/x+uSLyerp6FxJK9MpWK67jIzEf+F+Q1Y+dPRVLs07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XMojTVQy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7EHQC02542220, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211657; bh=KoUWRW2m0tIuG0n+zIOiG4CKOAv4NcSBzHPh66Q/5AU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XMojTVQy48KGToUN1mnO7PmtsZaiCAW4xXE1j8fkZ2OMHy+eMCsMx43g8bxCHnlhb
	 +XACYxtwwIsA88NHuwvy8I6xMxzZaTW4zvibeCX6tiFEELkoUo9eNgIE4PBYV2u59M
	 OVjhNPyQGNmOrh9d4xcjtyhlDTX0IfAuWJXzpH6wHFfIXLuE0g1UrT3eo/XytIl8es
	 tIR4+nj4ZVIcs8XIx/m0fJwUl7CTXqGmjK59XNXtCEf/GNM4H9vbMfN8voV2XubO5M
	 f3z1nrJOW2DOvQg8uOF7V9FFdV/BsaVim48viO8GPo07UStkk+FjJJLi3L79Doc3CH
	 J9nn0ED7ENGjA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7EHQC02542220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
Date: Fri, 13 Sep 2024 15:13:36 +0800
Message-ID: <20240913071340.41822-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913071340.41822-1-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com>
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

Firmware needs more time to execute TSSI calibration command. Enlarge
timeout time accordingly, otherwise driver throws messages:

   rtw89_8922ae 0000:03:00.0: failed to wait RF TSSI

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 63b1ff2f98ed..fb422bff4912 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2035,7 +2035,7 @@ static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtw
 	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
 	rtw89_phy_rfk_txgapk_and_wait(rtwdev, phy_idx, chan, 54);
 	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, chan, 84);
-	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_NORMAL, 6);
+	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, RTW89_TSSI_NORMAL, 20);
 	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, chan, 34);
 	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, 32);
 
-- 
2.25.1


