Return-Path: <linux-wireless+bounces-6565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32808AADCD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E701F216E7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7381720;
	Fri, 19 Apr 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jzuyv2KN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508F80029
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526776; cv=none; b=WL6IXfDB26pF3Qycite863jbaMS85gOy5jZ6eHQj1ZJ74KY1g/KjijnWjD5dXgKDoc/rJeIa+9VwiReobnqLmrl0F2cZv23EW/RgWaCjInwnbZJMYehw+Qxw23bqKrSVnoKix2wcn8Wd5qQT7c7rqDmjtZPDeDuP0OX+Ij27KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526776; c=relaxed/simple;
	bh=iutJjHzWwNYeCETsgcYlzGjvH+rF+BSND5PHGc0Ip/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RyMAqfiBezs2+nX3cDsmHJo/wfCg7GzmI/G9XfrSrwkryuPake+k6B3N3nLZikL9AuUtyz0yBNc5U4RBSBau+iEFxs8yUuo5yHdJETYVlAfN9jNN0G6Sx/X7n8d52tiCz2nKEVY4v8IXyJW1oSU8MXrpBjha6n4UWfg2N5163fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jzuyv2KN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JDKWmQjc2NpF791qfMsHZv9DPQTzSECdJZmWRVxgEWw=; b=jzuyv2KNJGG1nyDmxliDj1LvXC
	17OMTk82rXT8+L5Q7TM7x0h/VarJ9nxybRgf9rGfL3KsC9B8iIlIagkQN1g6/ACRc19EY1aLigleb
	boCGLEHui3Y4P3bmFJ5kkPhnn7wWQRt543C/4uTWKpjaVrXulMlrlCPHDk0e5K+rEXQc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rxmaZ-003di0-1l
	for linux-wireless@vger.kernel.org;
	Fri, 19 Apr 2024 13:39:31 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: enable spectrum management
Date: Fri, 19 Apr 2024 13:39:30 +0200
Message-ID: <20240419113930.26002-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is supported by all drivers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 068206e48aec..e8ba2e4e8484 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -465,6 +465,7 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
+	ieee80211_hw_set(hw, SPECTRUM_MGMT);
 
 	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD) &&
 	    hw->max_tx_fragments > 1) {
-- 
2.44.0


