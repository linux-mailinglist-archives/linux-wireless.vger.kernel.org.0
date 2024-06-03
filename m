Return-Path: <linux-wireless+bounces-8401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B744C8D7B5C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA431F2146B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAA22092;
	Mon,  3 Jun 2024 06:10:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550A20DF7
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395001; cv=none; b=ClSkGLF2olpLN/nwO3AhtiCM8GCz8poI5y1YgW7qJjhZQmKaPXYVHPUGS+5XtXQDGYQUZiVfGdp1n0sD7lQ5WPlxzO27iGFDkN+nrRRt/LDxYUcbbFqpAifI5z1/n/viJr0xACn1pWbZ7Ra7rlvJIhFOYif/idd4VX5hHnE2Km4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395001; c=relaxed/simple;
	bh=KlW2LHE8iFbz4wDDQBEz8VPIgZ/0WdTGbOED+9IbP1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNTwU+4k23yLORvHin9wBMo44YFp8B9uN185gzx7CqQTOLDQDzkkkQIacmOhVvhC9ISmlOIwyJtyJLKgzbAbWKjbuuKdGHTv38ogDBFbgALm8oR7sH9tpIRmqq2RuXJ9Mrt/5AlVOoYc79XDOvOy9jPTF9Icl+vKenednd9lpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45369msbE2477212, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45369msbE2477212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 14:09:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:09:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Jun
 2024 14:09:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH 3/4] wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
Date: Mon, 3 Jun 2024 14:09:39 +0800
Message-ID: <20240603060939.99093-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240603060558.98791-1-pkshih@realtek.com>
References: <20240603060558.98791-1-pkshih@realtek.com>
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

MINISTRY OF TRANSPORT AND TELECOMMUNICATIONS; UNDERSECRETARY OF
TELECOMMUNICATIONS announced RESOLUTION 1985 EXEMPT FIXED TECHNICAL
STANDARD FOR REDUCED RANGE EQUIPMENT. Section j.1) describes access
equipment, also referred to as AP, must be for exclusive indoor use with
condition of Maximum EIRP of 30 dBm. User terminal devices that are
associated with low-power AP equipment must operate at the following power
levels of Maximum EIRP of 24 dBm. Devices that use internal batteries may
operate outdoors, with a maximum average EIRP power of 17 dBm.

[1] https://www.bcn.cl/leychile/navegar?idNorma=1109333&idParte=9841504&idVersion=&r_c=6

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 59d7549ce604..1999086d4694 100644
--- a/db.txt
+++ b/db.txt
@@ -395,11 +395,14 @@ country CI: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.bcn.cl/leychile/navegar?idNorma=1109333&idParte=9841504&idVersion=&r_c=6
 country CL: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (20)
+	(5925 - 6425 @ 320), (30), NO-OUTDOOR
 
 # Source:
 # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
-- 
2.25.1


