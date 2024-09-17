Return-Path: <linux-wireless+bounces-12914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF597AF44
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A721C21DDF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404E1547F8;
	Tue, 17 Sep 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="MDzQBTaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDED26281
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571387; cv=none; b=qBKcRfR4IggyvnBBCNzqBtDpjS6H/NYyVXcdOhG9k7MlyWGXYy6d8XvzYzIeIBD3Lfn1tfi5j98snUMMY649ETcD5OD3rB+S/E111Oe3c9h3TFdFHgq12Iwga0k2Cnf+tNT+HM0NoagSwy/gnnqprih8OfxIWT3u9B4q/qemT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571387; c=relaxed/simple;
	bh=8uvE+6Hmtx0KskHmFxL6xOlr4QxpO+s1sQKUmLaD680=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f+qg6/VFKEwBcoGhLNU3qG5LbXJu6bnijnYs/CU1xT3Lq/yCc6842b2qcntgaoDt/VgBxt5ePpKsZabsxfPpZ270oqRFbBUuBBQczrwGlnXRl2x/3m2sehG2TmIIklTha5OXKC2xEfP3oqMuQtyyaWUt9BiVUM7m/S+P/h+aGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=MDzQBTaJ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TPXlaLC6uzZbFXXfV2+qatVtnIDgeOXYY8Dsppgr0SU=; b=MDzQBTaJqOtwQ01uhi2HDnEXKh
	agjDTHkR3xAQQY2rXysrAD4PvfrUSIh9K9xBzAnfX6e1tc8Db57OGIKfsq2c/1pJy6r26UbE+Z1aa
	GK3KMpOkg1Q/0rLFqe8ydKTgIsn/f9PyZDx3ZrXhRcTWzDcskRaRRgs8PzKyQiYEeRLc=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sqW5W-00ELRN-2o;
	Tue, 17 Sep 2024 13:09:42 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] wifi: mt76: do not increase mcu skb refcount if retry is not supported
Date: Tue, 17 Sep 2024 13:09:42 +0200
Message-ID: <20240917110942.22077-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If mcu_skb_prepare_msg is not implemented, incrementing skb refcount does not
work for mcu message retry. In some cases (e.g. on SDIO), shared skbs can trigger
a BUG_ON, crashing the system.
Fix this by only incrementing refcount if retry is actually supported.

Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 98da82b74094..3353012e8542 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -84,13 +84,16 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	mutex_lock(&dev->mcu.mutex);
 
 	if (dev->mcu_ops->mcu_skb_prepare_msg) {
+		orig_skb = skb;
 		ret = dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);
 		if (ret < 0)
 			goto out;
 	}
 
 retry:
-	orig_skb = skb_get(skb);
+	/* orig skb might be needed for retry, mcu_skb_send_msg consumes it */
+	if (orig_skb)
+		skb_get(orig_skb);
 	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
 	if (ret < 0)
 		goto out;
@@ -105,7 +108,7 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	do {
 		skb = mt76_mcu_get_response(dev, expires);
 		if (!skb && !test_bit(MT76_MCU_RESET, &dev->phy.state) &&
-		    retry++ < dev->mcu_ops->max_retry) {
+		    orig_skb && retry++ < dev->mcu_ops->max_retry) {
 			dev_err(dev->dev, "Retry message %08x (seq %d)\n",
 				cmd, seq);
 			skb = orig_skb;
-- 
2.46.0


