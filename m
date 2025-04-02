Return-Path: <linux-wireless+bounces-21042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C480A785E9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0272C3AEAF7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2C17BA9;
	Wed,  2 Apr 2025 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="OpGqdC4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B5B661
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555316; cv=none; b=UMxSqPbRrLitUh9R0b5b+BSQSchTNjswdDoza7eJOlWNUV/dKSjpVHEIRL5O1H6CHIWfqnx+PpybS6kyCjr+Xq/7LWAEtjxFFerwcyQwYRoB/FILrmWA+yhI81LbDx72s2EHaTFFwgIL/AaX7cMhKVaIBhdzyvXaX75bq7qYtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555316; c=relaxed/simple;
	bh=o0+jC5T0IbMLQejhPVGo1EXsWLgoRdQKJfBR4m13l28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTGMHsSgqKD8IpoRlhFEZgC1+tX7TLdzm2OHhuqCWr6KwavOGsYyM8xC3LiEG1v0/ihuuM7K3PEn8dXPbPNdT/58tDATu+rMsOGY6oFUAQatqQhdcHLTf/msvhNj3COTqr5zC53+RgRJF4x5TiOFfhg4MkG3Ks5m3p5ruZQeCSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=OpGqdC4W; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 42B32609EC
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 02:46:22 +0200 (CEST)
Received: (qmail 23164 invoked by uid 988); 2 Apr 2025 00:46:22 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 02 Apr 2025 02:46:21 +0200
From: David Bauer <mail@david-bauer.net>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] mt7915: mcu: lower default timeout
Date: Wed,  2 Apr 2025 02:45:25 +0200
Message-ID: <20250402004528.1036715-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.999999) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=o0+jC5T0IbMLQejhPVGo1EXsWLgoRdQKJfBR4m13l28=;
	b=OpGqdC4W5ncDvQo4pt/v3IzaB2oV6KRY2hoD8pZXVBtby0ahijnFpy/vpf+yX+YQXjsdm66KtF
	dHmteresF3/GQVMSquiuhBnL+gPayZMCxXCUtqwb2MKywYZ6YHa9pXaijLjY02tY34WvXpYeM5BT
	cOP/BOQQAmUsC6WzP6tOdET3NRaMLYeL6HWV7NDWtC5uZtlT54zxEPeiJNq/1xaYRzPuZCaNU/x2
	MwSk4zeBQn0WVUtVIqG3XzMK52kR7TtehMGfHduYR+7d5wvja812NOkJ+tl48/Y6SoI/TT5zobpw
	JcR+bebkwbpytcX7Lq0XTrf5ymEs6nVLg+yaxVrTywTpjHBY6FWwn4tSBQNVq+Og+S8cLmRWBSNH
	GG+VcVQtGYjrSEX2Y8HvN+xVyrLqZ3g2hfnDcKufHcPWBQUqxhXpL+u9BeQ2eeRsfnDaHI2x8Daz
	dNYHOTxG3pOGx4AjjWxTeQwqk4AVFAPSWF5hqS4wusHoj4fY1ALqbwRq5zSJQgG8ZGcA7Um/mTeS
	Ah0/4zwnzbAfxyOK9o1fofoJXvI+CMzwRaex/q0ysefMUtY1k7l/fuMvC2bsURfClq88edPq7FYv
	RrsX4Q33ia9RFapToaXaH3TRUMKhlQH4Q4bwXeG0NCM6OKsjbLtkNySdW/9jimEPMyWcQMQ3EXTt
	8=

The default timeout set in mt76_connac2_mcu_fill_message of 20 seconds
leads to excessive stalling in case messages are lost.

Testing showed that a smaller timeout of 5 seconds is sufficient in
normal operation.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3643c72bb68d..c1c5afed571f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -197,6 +197,8 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 static void
 mt7915_mcu_set_timeout(struct mt76_dev *mdev, int cmd)
 {
+	mdev->mcu.timeout = 5 * HZ;
+
 	if ((cmd & __MCU_CMD_FIELD_ID) != MCU_CMD_EXT_CID)
 		return;
 
-- 
2.47.2


