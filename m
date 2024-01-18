Return-Path: <linux-wireless+bounces-2217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE283207A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7461C2219D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4D2E63A;
	Thu, 18 Jan 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CJ4b1r0x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9672E638
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609481; cv=none; b=IQxI23RLC+K6oUqsPv2eMTZwXoj8HZ6ys2dejbCWlMDOqvYTepPFGFARuSnAkEc7VLvD8WErLT9liSFypQq9VUb0l68Wt0WL1hyklrmgPhoNjagjOi/6bdyDY4shzdNJgu3m6TdZ1WMPESuOZfk3rVLCm7pveBCAFycNdVn//sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609481; c=relaxed/simple;
	bh=RI1aKO6DhMyb5MqETo1O88T+LB4RYxLVROc+0gI05zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1wAOA5ZIpBfGXltMNTO3eVNJc8ENZiwd48IPPauI++IykMLd7TjPUUSM7ncSN3CGR8/tgzWdyVdHhRO7Rppzpp8r+Op6TisDYsicFcTYDl2hwyGoNxC77MJ10RINa+A4bsUuhLjY4fo7bYW6dScpy2lmquaS77W6qyq54f3BJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CJ4b1r0x; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6tkEcJFhqIhXum4DqljO2a94J18fHHSMslWTe3EccPw=; b=CJ4b1r0xPn1GWWa9R+46crsZ0K
	H4vZGf9TrHVvHHjkYJltbAxPNIT0BcNT74nTK1enu4GYYp4W4L7/KZtefikqIUjkbOs1+fTfOwp/W
	8unoU3C/OWxDmk9LVGOMM7uHutf2HJn+dW5Kod5JN2Z4aua2QeQPE/Jvyg0Ve2ylY378=;
Received: from p200300daa7090900680536e7cb8d8cd3.dip0.t-ipconnect.de ([2003:da:a709:900:6805:36e7:cb8d:8cd3] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rQYQy-0054tJ-LJ; Thu, 18 Jan 2024 20:52:16 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 1/5] wifi: mt76: disable HW AMSDU when using fixed rate
Date: Thu, 18 Jan 2024 20:52:12 +0100
Message-ID: <20240118195216.80974-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

When using fixed rate, HW uses txd DW9 to store tx arrivial time if VTA
is set. It would overwrite the msdu_id in txd and lead to token pending
if amsdu is enable.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c7914643e9c0..630c6402ec25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -544,7 +544,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	val = FIELD_PREP(MT_TXD5_PID, pid);
 	if (pid >= MT_PACKET_ID_FIRST) {
 		val |= MT_TXD5_TX_STATUS_HOST;
-		amsdu_en = amsdu_en && !is_mt7921(dev);
+		amsdu_en = 0;
 	}
 
 	txwi[5] = cpu_to_le32(val);
@@ -579,6 +579,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				spe_idx = 24 + phy_idx;
 			txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
 		}
+
+		txwi[7] &= ~cpu_to_le32(MT_TXD7_HW_AMSDU);
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
-- 
2.43.0


