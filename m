Return-Path: <linux-wireless+bounces-26688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7BB37EC7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDAD1BA16FB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C63451CC;
	Wed, 27 Aug 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JhYyWmLg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C043343D62
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286763; cv=none; b=mWVM28/zzdiF8DKDsAKutGeVEB2j7/kW6otqr0UqCLxkU7t96agsZnoFzuuuUeKFEhau6azLx0MDb/i3Nyi0C+u8Dxe2MmsOKKm0GZsmSg8HiGGpenSNTGVqj02aB/qjqsb9xbtLueiHtyYGMALo5mX2sep3yZ8k/8nVp+cwcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286763; c=relaxed/simple;
	bh=Ku9V2zxSe4fJCxz5goQM0spiyJNuSsqAN6QiiSxqlZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMkFlUfqQEWh4uCbIE/MXv84vwsiAlVv9fqZL8euSKBHHld3rb9BXN5UEySOWRF/rMA28t+Jcf7ikOFj8uXXLEpmaFQj6Sli6FtOj+PFE1AAY/MHTNO18iexrtpSLhmknnlNS7zZqW3YY7UEs7whfQAOPoFSWqLH0cAWwuKJG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JhYyWmLg; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hoMu26wxhR0no1mwczZTxKZXysfQnbMCOwmJBxZL9Tc=; b=JhYyWmLgOAT6Xw+UiyTjQ1Esvv
	EAX0huUfHhNdN7OvBp8QNpleXMZbd5ATbqpAoGerOWt5VfroQMCglYekyod4vz65z0uYb7jpnRdLq
	8Sp/zoMtz78X/VOhWUUxY+D5o/i8R0UCDEKX0Uc1tumYng+vEDSe2AVzuM6XAvWHhbEQ=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBul-00Fn6z-2H
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] wifi: mt76: mt7996: add missing check for rx wcid entries
Date: Wed, 27 Aug 2025 10:53:49 +0200
Message-ID: <20250827085352.51636-3-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827085352.51636-1-nbd@nbd.name>
References: <20250827085352.51636-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-station wcid entries must not be passed to the rx functions.
In case of the global wcid entry, it could even lead to corruption in the wcid
array due to pointer being casted to struct mt7996_sta_link using container_of.

Fixes: 7464b12b7d92 ("wifi: mt76: mt7996: rework mt7996_rx_get_wcid to support MLO")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 837deb41ae13..b3fcca9bbb95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -62,7 +62,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	int i;
 
 	wcid = mt76_wcid_ptr(dev, idx);
-	if (!wcid)
+	if (!wcid || !wcid->sta)
 		return NULL;
 
 	if (!mt7996_band_valid(dev, band_idx))
-- 
2.51.0


