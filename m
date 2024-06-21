Return-Path: <linux-wireless+bounces-9414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE6911E3C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E461C221CE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F623176239;
	Fri, 21 Jun 2024 08:05:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F416EC0E
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957157; cv=none; b=DLUZATSkGP53LcLNqwdbDnLOHvOD2pNAtkhMLBRRjz9zr0BkoYQFRsYhGUNHI5Wu/z4I8By4cpoiwD3bpJI7zDOrJPJcEOI4SWRyGHc/6XsHKK3KobJEhJMcnYsosbmyxajixMerZPljd5miUylNG+P29WX6G1XLwO4rkg61S84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957157; c=relaxed/simple;
	bh=uOnOLnElCPh+ckiH+s22lZWD7uM8BT9h2D8AsdE+Qs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXRG/NXpn1JY4WR7vxUPc7pT9vjOszo5DyMpLbNSaeLCqZmxFC3jlAEcndjLwZ+QCh1OtxfPq7SbUgj0kCD0B2bPn9A8L1Ah3NMKmzHsvWU13wKR12fFzUh2fjRsQsEK1w1krNXCSfL0gS/AzX+Z85urHS91uU9XYostRqsOrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L85aSC23890756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L85aSC23890756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:05:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 16:05:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 16:05:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 5/5] wireless-regdb: Update regulatory info for Dominican Republic (DO) on 6GHz
Date: Fri, 21 Jun 2024 16:05:29 +0800
Message-ID: <20240621080529.55698-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621080348.55504-1-pkshih@realtek.com>
References: <20240621080348.55504-1-pkshih@realtek.com>
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

The Dominican Institute of Telecommunications (INDOTEL) announced
RESOLUTION NO. 082-2022, which the equipment and systems that use the
5925-7125 MHz frequency band, and that adhere to the requirements:

 - For indoor access points, the maximum power spectral density must not
   exceed 8 dBm/MHz of Equivalent Isotropic Radiated Power (eirp).
   Furthermore, the maximum eirp over the operating frequency band
   should not exceed 30 dBm (low power).

 - Very low power (VLP) devices whose maximum power spectral density does
   not exceed -8 dBm/MHz and the maximum eirp over the operating frequency
   band does not exceed 14 dBm, may be used outdoors.

 - For client-type devices operating under the control of an indoor access
   point, the maximum power spectral density should not exceed 2 dBm eirp
   in any 1 MHz band and the maximum eirp over.
   The operating frequency band should not exceed 24 dBm.

Considering 2 dBm/MHz for client devices, 15 dBm is adopted.

[1] https://indotel.gob.do/wp-content/uploads/2022/10/res_082_2022.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index ddbf484ef0ad..02a7760f197b 100644
--- a/db.txt
+++ b/db.txt
@@ -576,11 +576,14 @@ country DM: DFS-FCC
 	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://indotel.gob.do/wp-content/uploads/2022/10/res_082_2022.pdf
 country DO: DFS-FCC
 	(2402 - 2472 @ 40), (30)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (30)
+	(5925 - 7125 @ 320), (15), NO-OUTDOOR
 
 country DZ: DFS-JP
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


