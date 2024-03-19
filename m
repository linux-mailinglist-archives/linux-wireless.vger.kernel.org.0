Return-Path: <linux-wireless+bounces-4872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10187F4E7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C588E282179
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5A63B9;
	Tue, 19 Mar 2024 01:20:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E90539C
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811247; cv=none; b=d5wXL5bukGhENG+0uZp0S9DjBEDsamaVnmecGMBA/sg+taS+YnE7Xdgit+ZVzHstn4Qf67k1BVF9NKVBaNMuAT3i4Q1676aKMy8tc4MO+iq/Po678FVvcwb3M4s+wtCGjUTL47KmqusYlL/XyNqBPfsR6l0SIVizSY/ve9SMB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811247; c=relaxed/simple;
	bh=+LNUJsuWZoRjoiE7tEjEcBh6QsHKuTQZeVabwGB+bAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pOmZDCffSKwQL8p7bHO5pqbmleukJnQTNhSbzeDScPAq8ZUA0PuTgkWA7l68BN9i0tV96O0d5MQD0YAdIRe1I49eIfQVUPxJhN3BnKzhDwsKE55Rzod/zqiX3owAhdzie2N8Qo1As8trY2D8kowlS6gENTA/PUBHnrDQaYEmk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42J1KSedC3679512, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42J1KSedC3679512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 09:20:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 09:20:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Mar
 2024 09:20:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless] MAINTAINERS: add git tree of Realtek WiFi drivers
Date: Tue, 19 Mar 2024 09:19:25 +0800
Message-ID: <20240319011925.6855-1-pkshih@realtek.com>
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

Add git tree to manage all Realtek WiFi drivers except to RTL8180 that is
old and orphan.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd66be5046f9..a6a94d7b3b14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18574,18 +18574,21 @@ REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtlwifi/
 
 REALTEK WIRELESS DRIVER (rtw88)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtw88/
 
 REALTEK WIRELESS DRIVER (rtw89)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtw89/
 
 REDPINE WIRELESS DRIVER
@@ -19107,12 +19110,14 @@ M:	Hin-Tak Leung <hintak.leung@gmail.com>
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
 RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
 M:	Jes Sorensen <Jes.Sorensen@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
+T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
 RTRS TRANSPORT DRIVERS
-- 
2.25.1


