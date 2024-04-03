Return-Path: <linux-wireless+bounces-5803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D1896D60
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B0290806
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F7D7317F;
	Wed,  3 Apr 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HLEam39u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187401411F0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141729; cv=none; b=eVhmz+ETWYciY+diEckwlUZSafndvZoJsUviy0jHYJZnJRocPwBD6CcGkCFl9ETp1J/Q23vMDa4pn/jfa/Su4afmLH1maWj2OCfvBycDcQYyL7ZVs5xaP3CChbaN7IgUapBNlCD+LAkm+AHUpIb9QFHnokGYvKfTL2ZPCmDB3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141729; c=relaxed/simple;
	bh=bJ4AFAATadQ6GPqVXMJVqNGm5tyyDwnYZuC1O08rHVQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q53DOUHljykboRKEgKkeJr1GNsvd7KLcZYGswgaoMxoYB93DBrBCNFzaGi2gEFEJNxcqVYJRTkBQ/ykmSTO7G7+TYXGziksRkgjzUmDSyV9nG3ySYot3gOfZyhbtz6kPf82mBi8BvewBr3E2mNAvh4PEMr01dKMUVQvncOBfDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HLEam39u; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vfYWTNhZuEn17qWNLJuZdsMFkM+isrKnXo5fuGfQGx0=; b=HLEam39u27K3okwqeh5v7h7sbK
	bn0DuBuXLaybpdTD9p3jXUHuDCogPhDFCkWAQ9jeFU7wkYutqzkI/w15UW0TEfy4spn6qQOa0WmF+
	v3blSPLQu+pLzXbAlwbWZh783w37te/+rPyNWDoFY+Z+VxdIlVXUD0M3gXShhfLO+Hiw=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt4-00CgfA-59
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 09/13] wifi: mt76: mt7915: add support for disabling in-band discovery
Date: Wed,  3 Apr 2024 12:30:28 +0200
Message-ID: <20240403103032.54823-9-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MeiChia Chiu <meichia.chiu@mediatek.com>

Send an update to the MCU whenever the settings change

Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 11f81b233d46..398afab447c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1919,8 +1919,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	bcn = (struct bss_info_bcn *)tlv;
 	bcn->enable = true;
 
-	if (changed & BSS_CHANGED_FILS_DISCOVERY &&
-	    vif->bss_conf.fils_discovery.max_interval) {
+	if (changed & BSS_CHANGED_FILS_DISCOVERY) {
 		interval = vif->bss_conf.fils_discovery.max_interval;
 		skb = ieee80211_get_fils_discovery_tmpl(hw, vif);
 	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
@@ -1957,7 +1956,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	discov->tx_type = !!(changed & BSS_CHANGED_FILS_DISCOVERY);
 	discov->tx_interval = interval;
 	discov->prob_rsp_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
-	discov->enable = true;
+	discov->enable = !!interval;
 
 	buf = (u8 *)sub_tlv + sizeof(*discov);
 
-- 
2.43.0


