Return-Path: <linux-wireless+bounces-27309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C11B57223
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFF317DB90
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F622EBB9B;
	Mon, 15 Sep 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CfS+aryo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44892E9ECC
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923163; cv=none; b=gGfE1+2AL8BdvjEfw8BJsKl7nHx1AMz5A8kwsRIFB1Tjd7AgmE0brHamFvNqFPomuyWEsGU64cbCksyOKxdEGK4Ab05te5WnLvRXWhhtni5ZtpBhODUnQT+7DDlRbx7uzNaYwayi7skIo6rzGH0Gv+C7OC31LCRKpMbJvnJofP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923163; c=relaxed/simple;
	bh=hCI279A9L1bRfFNxsebVd64MDgsOtquHQIIm7Wn3NTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My/JTkofypMCENckRTuDK7wcLj5U1gZCRT8dyy5xX5mmQZMxdWc6SkV1fjxewCh4pb2tABEhFejrbYhCGAubhZceKrvFQet0snOOOUwYlSxxsqHibANXuiMaqeHG10YE90BM6ya0wR1x8nVeft8bNBF15YJ5jpwJpj8dXFKlKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CfS+aryo; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4GObwF9ohv+2aqD7SJFd4pzmMEyN0roav8OqTM7VWsU=; b=CfS+aryo8iZ6NQg2rjhqp317NB
	iFR2kTzqGe+kDHpmmNKKW0qvaoHEOwSIQC5HJbiNvxxyC/pEN1Qz0Yh5a9WzdskNiMXvkMUodB+v6
	mzPDB2NQkZsxRNQDDxewuz8e4/H7+uEl6RAcY+ufRqgNggeFEJ9k0To9fMGUSJV5oH48=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47F-0078GN-1D
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 13/15] wifi: mt76: mt7996: fill User Priority in skb->priority for rx packets
Date: Mon, 15 Sep 2025 09:59:08 +0200
Message-ID: <20250915075910.47558-13-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Set UP in skb->priority to allow DSCP Learning at upper layers

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6ef186107782..cc7da3d5ab08 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1235,6 +1235,8 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	mstat = *((struct mt76_rx_status *)skb->cb);
 	memset(status, 0, sizeof(*status));
 
+	skb->priority = mstat.qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
+
 	status->flag = mstat.flag;
 	status->freq = mstat.freq;
 	status->enc_flags = mstat.enc_flags;
-- 
2.51.0


