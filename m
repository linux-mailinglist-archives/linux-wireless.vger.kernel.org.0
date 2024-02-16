Return-Path: <linux-wireless+bounces-3658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF268573FF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 04:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F393F1C21169
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECCFBEB;
	Fri, 16 Feb 2024 03:40:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879EFBE9
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054836; cv=none; b=CE0VjXJtXgjovxbU4zw64W0mImEFRgNbV2gu2JsdY2S3cGcxOoy3NBtObeRT7mbtEBxHZEhT2WvkPhNHgfQ0cqQCB1OyZkChzsrbaEukEsBESY6cktfMFWKvb4AuqxwYltsENc8zBKoJ/9X/pNvhewqLml54aI3FMKD/uEQe9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054836; c=relaxed/simple;
	bh=JaNlrt99jNuGGWlLsHoNrOzjmXZPT3SYqyOR7UVVIhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hjpS4hskswqTSxmvbZ1VeHsCULxZY9aqpp2FBONIMNB10eoEkai02fq2WczqoTOcK3g0KnytO1WoI2TH0bS1mvlEQj+lFD5irD2wCp3jGcLAsRaSZt0U1SN/Ir5XOwifRo1JLZoQU1gbgABaBFWpTOLURmq96aRC1PjE4utgN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41G3eSTw92751851, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41G3eSTw92751851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 11:40:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 16 Feb 2024 11:40:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Feb
 2024 11:40:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtlwifi: set initial values for unexpected cases of USB endpoint priority
Date: Fri, 16 Feb 2024 11:39:49 +0800
Message-ID: <20240216033949.34765-1-pkshih@realtek.com>
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

Map USB endpoints to hardware and AC queues according to number of USB
endpoints. However, original only give a warning for unexpected cases but
initial values are not given. Then, smatch warns:

drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:642
  _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuelow'.
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:644
  _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuehi'.
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:649
  _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuehi'.
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c:650
  _rtl92cu_init_chipn_two_out_ep_priority() error: uninitialized symbol 'valuelow'.

The regular selection is high and low queues, so move default (unexpected)
case along with that.

Compile tested only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 5ec0eb8773a5..4217c9a08d01 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -622,6 +622,9 @@ static void _rtl92cu_init_chipn_two_out_ep_priority(struct ieee80211_hw *hw,
 	u16 valuelow;
 
 	switch (queue_sel) {
+	default:
+		WARN_ON(1);
+		fallthrough;
 	case (TX_SELE_HQ | TX_SELE_LQ):
 		valuehi = QUEUE_HIGH;
 		valuelow = QUEUE_LOW;
@@ -634,9 +637,6 @@ static void _rtl92cu_init_chipn_two_out_ep_priority(struct ieee80211_hw *hw,
 		valuehi = QUEUE_HIGH;
 		valuelow = QUEUE_NORMAL;
 		break;
-	default:
-		WARN_ON(1);
-		break;
 	}
 	if (!wmm_enable) {
 		beq = valuelow;
-- 
2.25.1


