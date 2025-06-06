Return-Path: <linux-wireless+bounces-23786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64576ACFB14
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E439717035D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB35329A2;
	Fri,  6 Jun 2025 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bLyiub7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB911DE2D7
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175415; cv=none; b=APUHBcI3+98ZA8l72Ttb+ogybE5Zdb6LQKsoGLuHofBeEe0M4VkNwKcjWxw5o4eK4/9tj9rwme5sWwN0AN2TweeBH+qAoQMyOwvtHz52aHdFBUZddiHochi767qRNyXS6HKOEstiGiBZSVzpyIqM04aZRX8mlACgEqF7PL+sXFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175415; c=relaxed/simple;
	bh=EMC+MFyQWDbNdCYxyrzXhUd4fSQuMPJo6FSbfqZgmz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eArWQTCQsBjs4CRmnoOIVYmEHGKpcdmiVVCP8T+oYAZfGOZQEHIH5tUVRhgbRDVCXcB+W5QIOVeB+ORIMREqntuP3wISJdG0Zlo2sJ7onWqY7mCrTc85Tf0K+VqgOUXGVXoZgbvmAFGcDhnFrfm3AN4d2L4Iz5QZm9uGpOnSQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bLyiub7L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55623Vs342620775, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749175411; bh=9uy6Qx1zbqbfMcM5E+QStlcCrdYCx2aJGjM19Upm0aQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bLyiub7Ljx132vTD9E7cNWL8hDO2eVbaQXTKUbK8fh7OTKXzv4F5JgjLnouEVbkPy
	 BBnOYYDdGsAxHK64ok6UaMYrwuFIC8QA9V0EAL+htkH6m/JfbCRtbC8rAe2K0eMJyf
	 gRi/EA6lg2+RwYp9sWxg8of9JWmP5vPu+C7ZeqojHdnbqt4KlzxSUxFLPcEsb+uagm
	 gq40d0/rY62kB5cquFUhnvLAWwHvrTFw/l4KpbkArofXwv8muV5bG9KHoSWvwstTmT
	 gwk4gxswpLcapfjkxWlSJ/SXgpMhb5a8ZtEGDcF/5z7m52o6yw2tQYbD7rHnJ1Xwua
	 ATPBENc9Vnr5w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55623Vs342620775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:03:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 10:03:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 10:03:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/6] wifi: rtw89: mac: add dummy handler of MAC C2H event class 27
Date: Fri, 6 Jun 2025 10:03:00 +0800
Message-ID: <20250606020302.16873-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606020302.16873-1-pkshih@realtek.com>
References: <20250606020302.16873-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

The newer firmware add new C2H event class 27, which is to report WiFi
role status. Since rtw89 doesn't use the status yet, add a dummy handler
to avoid warning:

  rtw89_8922ae 0000:03:00.0: MAC c2h class 27 func 0 not support

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 1 +
 drivers/net/wireless/realtek/rtw89/mac.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9f0e30e75009..4bd5e2728ce5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5717,6 +5717,7 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			handler = rtw89_mac_c2h_ap_handler[func];
 		break;
 	case RTW89_MAC_C2H_CLASS_FWDBG:
+	case RTW89_MAC_C2H_CLASS_ROLE:
 		return;
 	default:
 		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8013c852d5be..c1cbc53b16a7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -469,6 +469,7 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_MLO = 0xc,
 	RTW89_MAC_C2H_CLASS_MRC = 0xe,
 	RTW89_MAC_C2H_CLASS_AP = 0x18,
+	RTW89_MAC_C2H_CLASS_ROLE = 0x1b,
 	RTW89_MAC_C2H_CLASS_MAX,
 };
 
-- 
2.25.1


