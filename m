Return-Path: <linux-wireless+bounces-11562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1995500B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA12854BB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64A1C2317;
	Fri, 16 Aug 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mcPoQ0O6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8E8175F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829740; cv=none; b=nW/HW3hjkNO66z3bfuloGU4gpZdG9mPCMOzgFP/Ik1etRCF1E1xC01wOnFthyHb7POKain0DjSRP54zbmEWMiTWe1YJJdSMNxjJRLyL3HSsaNv1On2ufeeBKAl13yVrvDUW07VUGUAz+RRW8jHf5db0wegTAwj6QPfe0XjBkY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829740; c=relaxed/simple;
	bh=LCQMqIPb/L60gi61KF6b/wJru/QTfExH99NmDFLPc9w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aS7482ABU6uPUNGHoCLccfYgdPpMuGoPxafQGpQUS+W4GAc5XcMQGtGL4d3QIjIhkfvpBYl+TRUyz4O6k/H7SFiS7rayUy3kf3t0bp2zdiK8NOQPKByHZJbsbnEOKrQl9rweLomCnK9wYBcuBI4Ze/hZ4lffQ9dFufuG/LnRUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mcPoQ0O6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=934qWVOGO4/RmOjkbRq5WcgD/kEgc45lkCSk57VnCD0=; b=mcPoQ0O6wwRtb3IJMUo89z/1tM
	0d72bunUKDSfHEfN8+iphGsGPGhAJ/1IZ81DBpp6BnSxDIFkNWO+1yPqxMQKl79Mk3aZ36C0gG8Hb
	jRiD/xOnpcjNQRepQiKIHZqKlZj6AKlIQVhOzCgbc2y/7GT74QUbtK2EEuro/rCyDryc=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rP-000ObE-3D
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 01/16] mt76: mt7603: fix mixed declarations and code
Date: Fri, 16 Aug 2024 19:35:14 +0200
Message-ID: <20240816173529.17873-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the qid variable declaration further up

Fixes: b473c0e47f04 ("wifi: mt76: mt7603: fix tx queue of loopback packets")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index ea017f22fff2..863e5770df51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -29,7 +29,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
-	u8 tid = 0, hwq = 0;
+	u8 qid, tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
@@ -57,7 +57,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
 			 IEEE80211_QOS_CTL_TAG1D_MASK;
-		u8 qid = tid_to_ac[tid];
+		qid = tid_to_ac[tid];
 		hwq = wmm_queue_map[qid];
 		skb_set_queue_mapping(skb, qid);
 	} else if (ieee80211_is_data(hdr->frame_control)) {
-- 
2.44.0


