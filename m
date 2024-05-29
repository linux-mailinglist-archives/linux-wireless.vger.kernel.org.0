Return-Path: <linux-wireless+bounces-8237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641788D2982
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C4E1F23C1D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580815A488;
	Wed, 29 May 2024 00:38:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71417E8E4
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943137; cv=none; b=FW3WYrj7QDdzzlM123C31h6L9+M1CSbpjdXeTaU4cdyI/nUjfVWulSDt40p0voLBumGpvXvPS9nOqGkuwcILVp5gJUSAJZV5WrzEpCMSJgTr6lKYgZKXHCNG5nbRO6AvhPPcXkcPNDiOFKgWjmZWgneXQK89yaVqxusg4HtmcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943137; c=relaxed/simple;
	bh=eWTc0kf+BqoQs9RR+kOq8prBHtZnn5PG+a1uYdx0ECw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XFq0fPZdBmFrtLANEZmnFX9lAyz/o3Um+Yi6h1xNDb5ZaBwpMFeXTsf1bkrC09yYxOjTFu4262gUBke51A5sw0/BmHuaBwd2HwZOXdbbVBLO6Lm6EvdbQGkYzTUpm+l7I17uGCkYmgmhwjSAmcFs5yUGzckQF8MZ7xCb83g0Xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44T0cmezF2932360, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44T0cmezF2932360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 08:38:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 08:38:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 29 May
 2024 08:38:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
Date: Wed, 29 May 2024 08:38:43 +0800
Message-ID: <20240529003843.4285-1-pkshih@realtek.com>
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

The Broadcasting Commission Television business and the National
Telecommunications Commission announced Technical standards for
telecommunications equipment and equipment for radiocommunication equipment
that uses the frequency 5.925 - 6.425 GHz [2], which section 2.1 describes
e.i.r.p. (Equivalent Isotropically Radiated Power) is 250mW and 25mW for
indoor and indoor/outdoor respectively.

[1] https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
[2] https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
[3] https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: adopt indoor power 250mW instead.
---
 db.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/db.txt b/db.txt
index 022ecb3719b6..f27dd5214630 100644
--- a/db.txt
+++ b/db.txt
@@ -1702,12 +1702,17 @@ country TG: DFS-ETSI
 	(5250 - 5330 @ 40), (20), DFS
 	(5490 - 5710 @ 40), (27), DFS
 
+# Source:
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
+# https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
 country TH: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
 country TN: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


