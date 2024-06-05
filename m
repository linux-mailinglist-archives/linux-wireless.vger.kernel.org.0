Return-Path: <linux-wireless+bounces-8516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8A8FC44B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957061F2542B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D436191489;
	Wed,  5 Jun 2024 07:15:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910D19148A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571756; cv=none; b=fWeMNI0O3JQKgM3O96G8XFUf+2SyqZWZSQ6O/37rBSZOzbBQodI6Pf0ebOa28hW9QBTS4GoVzqfII9bqO8cyyjtrPS7VsDJZUv7xAB35QLjRTzpzsA4BKUoyH2njSuZtI4gDCerzeXKgX0pyA0GJsAZ7TtBc8C9MLKROA89kQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571756; c=relaxed/simple;
	bh=lA9yLlo0mMWoGNbYEqfuTlsP3RwfkbduWOsZ4Z7fqrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh+VM8eokbjgKjv/4E3rshVvjy/PPN8PoZgztjXMPjjk7uJVRsZXZ2GmsQRElPbZZXCtfLKvbWUnYVtQ5WMkg0b9hvU2U4f6yKUa9R6k7j4/Ja2bHgLRPUIPXgsOAPZY5JxysFp3LfWy3qhDhNY9vWxaFp4hF5l4bkOn90ldLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4557FLvJ41207312, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4557FLvJ41207312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 15:15:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:15:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Jun
 2024 15:15:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <wens@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: [PATCH v2 4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
Date: Wed, 5 Jun 2024 15:14:53 +0800
Message-ID: <20240605071453.8091-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605071453.8091-1-pkshih@realtek.com>
References: <20240605071453.8091-1-pkshih@realtek.com>
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

The Plenary Session of the Federal Telecommunications Institute (IFT)
determined, in its IV ordinary session of 2023, to classify the
5925 - 6425 MHz frequency segment as free spectrum and issued the
technical operating conditions that allow coexistence with the existing
services in the country [2], which [1] is the entry page.

Within the operating conditions of this band as free spectrum, its use was
determined for low power indoor and very low power indoor and outdoor
systems.

In the agreement [3] of section Single Annex 2. Low power systems operating
indoor is
	30 dBm (5 dBm over any 1 MHz bandwidth) for Access points
and
	24 dBm (-1 dBm over any 1 MHz bandwidth) for Client computer

Very low power systems operating indoors and outdoors is
	14 dBm (1 dBm over any 1 MHz bandwidth) for User terminal

Considering -1 dBm/MHz for Client computer and smallest channel is 20 MHz,
limit 12 dBm is adopted.

[1] https://www.ift.org.mx/comunicacion-y-medios/comunicados-ift/es/el-pleno-del-ift-clasifica-la-banda-de-5925-6425-mhz-como-espectro-libre-comunicado-132023-16-de
[2] https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comunicados-ift/comunicado13ift_1.pdf
[3] https://www.dof.gob.mx/nota_detalle.php?codigo=5681829&fecha=07/03/2023#gsc.tab=0

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: update reference [3] to have power limit values, and consider -1 dBm/MHz
    to set 12 dBm.
---
 db.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/db.txt b/db.txt
index d3b106526252..c4f5e995e422 100644
--- a/db.txt
+++ b/db.txt
@@ -1293,12 +1293,16 @@ country MW: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comunicados-ift/comunicado13ift_1.pdf
+# https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/consultaspublicas/documentos/20210119-cpi6ghz2020-162.pdf
 country MX: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
 # https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
-- 
2.25.1


