Return-Path: <linux-wireless+bounces-12050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570C960654
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7BCB21E18
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A919D892;
	Tue, 27 Aug 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gBKq2Vc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628718D65C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752518; cv=none; b=sNfQbGbXnUr6Ikt0fPb8mbH9Se6oDJY6Vv6+VcnJzdkP13J2SS9Sb3ROohjhaDC4Cx7Crn89nJ6SE7hs1gXZw9/MfEmp1TjqDq8XqbmedxTksMh8499OMb0WhXkokT+X3zhN1ydhxMrTXpx6QBFyJn+CIhNij7jQswV59VHV3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752518; c=relaxed/simple;
	bh=S0XxveRF2iDI/aZYwPiwQMR7d90OjsEqrQpi4ZChoPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTkrKi5qGVCoo0dNFjFX9i6/g6kiXcd97m8ZUhJ2UxnG8xIUKQlZGGWrBSxFhyezvm41oc9rsrQOJ9sK4DHFLUq/X0o24jn+0eLf7kVZvIy++Luy0LUT0+x8k2hVgD1VXcceaKvSrTsKiRBYdkb4rBdfNhaO4QFHEcuxMYOkM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gBKq2Vc1; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jgc6++jZ0CKlhNJqXWO3G/2sI1Z9XrUS+vPiS8LYKrA=; b=gBKq2Vc1dSa1tlh0vfrfcs1jod
	JsxZBadD2O+/yuLNECyAZXmZK9mJERmcA7Jz1ycY/fwr12dF1CvD6lw4xblEaGZ/rLIeC2yodVbFi
	Uc15cCN1aO0kSGGUv6Qa/Htash+UhsZeJtX92NLe0vFHewzZ602SFQEszjHXqknvRZdw=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWm-004Ww8-2B
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:16 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 15/24] wifi: mt76: mt7915: reset the device after MCU timeout
Date: Tue, 27 Aug 2024 11:30:02 +0200
Message-ID: <20240827093011.18621-15-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MT7915, MCU hangs do not trigger watchdog interrupts, so they can only
be detected through MCU message timeouts. Ensure that the hardware gets
restarted when that happens in order to prevent a permanent stuck state.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0cde1b3c7d41..81375b5d0021 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -157,12 +157,21 @@ static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt76_connac2_mcu_rxd *rxd;
 	int ret = 0;
 
 	if (!skb) {
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
+
+		if (!test_and_set_bit(MT76_MCU_RESET, &dev->mphy.state)) {
+			dev->recovery.restart = true;
+			wake_up(&dev->mt76.mcu.wait);
+			queue_work(dev->mt76.wq, &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.46.0


