Return-Path: <linux-wireless+bounces-8519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67C8FC4CD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC981C21097
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894A18C331;
	Wed,  5 Jun 2024 07:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137018C357
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573375; cv=none; b=SJRLovPq03QZVhWmF68ILS/JtBAj2fHa9A2N+NcbtvBSW6uiDmHv8KYlAGIBy4l4qC5FGqMKCgCrd9eYg1EU3qzNtIwb9gIPbxWAqOIz1Nu87IrXBhmH1m2PkTPRLjOuQV3sHMEE+0oR6f6G/GHhWOqZbJUsNBMoGd/wITNYbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573375; c=relaxed/simple;
	bh=b2A/PcdrrKccrtsXeG6QXAENACXO2gJKvxnCfGcp650=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8W0QrAIuoUzhIrB9BvA0iog+oEtVVwc5ktKHpznKic1xMrvkuAZmWanNaqa2hinfTIa1nmT4ZQkFdNeXlevzX+qYthNJOr3Qp8iLYOS/pacvs6YE3lhHfPheJeoXFwm9dKNmqGZGHvF2FQC+SEzpfDPbvcKC4dp5PLtHgPKTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4557gWSX11236949, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4557gWSX11236949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 15:42:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:42:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Jun
 2024 15:42:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v3 2/4] wireless-regdb: Update regulatory info for Morocco (MA) on 6GHz
Date: Wed, 5 Jun 2024 15:42:07 +0800
Message-ID: <20240605074209.8713-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605074209.8713-1-pkshih@realtek.com>
References: <20240605074209.8713-1-pkshih@realtek.com>
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

The publication of the Decision ANRT/DG/N07/2021 of May 2021 amending
and supplementing the technical conditions for the use of radio
installations composed of low power and short range devices [2], which
ANNEX 5 defines p.i.r.e. conditions of 5925 - 6425 MHz are 200 mW and 25 mW
for indoor only and indoor/outdoor respectively.

[1] https://www.anrt.ma/en/lagence/actualites/wifi-6e-now-authorized-morocco
[2] https://www.anrt.ma/sites/default/files/decision_a2fp_-vf-_mod_07.05.2021.pdf?csrt=14818568393101165775

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: no change
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 8773de6ed6a8..99d3f61092b7 100644
--- a/db.txt
+++ b/db.txt
@@ -1133,10 +1133,13 @@ country LV: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# Source:
+# https://www.anrt.ma/sites/default/files/decision_a2fp_-vf-_mod_07.05.2021.pdf?csrt=14818568393101165775
 country MA: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 # MC as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


