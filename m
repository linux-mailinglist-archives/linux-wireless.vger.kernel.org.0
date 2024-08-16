Return-Path: <linux-wireless+bounces-11566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8095500F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262592847ED
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A491C3782;
	Fri, 16 Aug 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="pf/yoHlD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873721BF322
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829741; cv=none; b=N9/FdQJcD9Eksv8VInXzUr81/qB0UTD2V2bdH2CdEgBk246WnT9hjGSzXXrAXS9LnDd1VHHFih/VXb9JQGkZNcFKP+1QWmfN0G5RKkHAtfPToaAHegX4mkdTR9p8fp97n/KpVn+EUOUJRdo68ZIt/iMQiN1ioQNlq39nRzTuzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829741; c=relaxed/simple;
	bh=0Y6hDijC3tNjw7UiCGwvwGdR1OnyFLEANrwMSjiUPgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuJrb4ymLtC3xiL0wUQKtu71TdlMJk25eiu0cyXixyHpDcbZbIp3tu53cLG/SUMzHZKAhPeYapWiGvqmk/tzdoaAEOy7REPnqDxVX6N6LF7DteK6/4UIfA8/PIFExJdxrJWaVIYCBY53GPja177nbu8Ke7twFdGVVA63mM8nP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=pf/yoHlD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i8IZBaIu6/BIyfADcNcV+eyVR65JB7+IivwiOtTJJjQ=; b=pf/yoHlDeEDCk2mmDTfdnkd6j4
	Rw56v6zkM23fHZT/cf5hZL8cSpNm2Pg5l1MsLpib/d74zM/2DPay5fs9W42sSi6sSA/HzCRVw5lw6
	BkCLnlSI9IRrXa+UFSl+LuU7YDTUbrLDAUFHLqwpSbq+w5t/hulmntQgOHdsBRoFPio8=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rR-000ObE-2F
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:37 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 08/16] wifi: mt76: mt7915: allocate vif wcid in the same range as stations
Date: Fri, 16 Aug 2024 19:35:21 +0200
Message-ID: <20240816173529.17873-8-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces the amount of unnecessary WTBL bank switching, while still reserving
WTBL entries for vifs.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 87a7b1589af2..34af1ea16ada 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -245,7 +245,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
-	idx = MT7915_WTBL_RESERVED - mvif->mt76.idx;
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
+	if (idx < 0)
+		return -ENOSPC;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-- 
2.44.0


