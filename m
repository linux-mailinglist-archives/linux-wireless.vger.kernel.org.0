Return-Path: <linux-wireless+bounces-9989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267769276DD
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3A11F22B48
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D031A3BDA;
	Thu,  4 Jul 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="njYsd1kA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AD1A0AE5
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098595; cv=none; b=rUaTqnWSvRqroaK+K//aZeW0YeYJ2tGHpGjCaVQxCBPaDW/3tyuXOBmj6ZDoPuX/2TM0NBCDez/YWHaRAzJdYG+D214j9FWj0YkjnNCo0GOyDu3ok0yXeF5O7rOHT3+Hm6IaMUpxXcvvYqka4kngjohqh5Nv6dtceBW7SBR/9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098595; c=relaxed/simple;
	bh=7VM27pwYgz/pja4vZxlACq4MuTEFyVRdJNM1M08wawE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHIGSOpHfVTJRgRMCAX+QfB+/D7T0CqJ6kdjDwvW7wl4q+nvA8uMVOeLYbxq0rYnURuYO3G8elzjuiyMj3t4/xnJyZMrCZ0Y9QytG2ZBd9yDg0+JGpV35rSjmYd0pcIRJ5gljAWTJ2Qr+m8eGkqHbPUDDmMGREuSVWhU0GipRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=njYsd1kA; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sl4azuxpgc+EQ8MLR8Ev+3owGB0Inc1bKVqQABIB2H4=; b=njYsd1kAxNU948G34ymlAETtqx
	EEsJ8Qiyxum9BVOayux4aAcjwhCPBT0O2vYRnK6dvJa6Epk8A9M6UHTo2hwhBdX6scrHr1MK76fJn
	NzFGmDFy28I32TcWAEe8dGzKH7l0HY+utF8e1jKoUey1YTbBqB1qLSZbIfPksYHVdjXs=;
Received: from p4ff13568.dip0.t-ipconnect.de ([79.241.53.104] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sPMDc-002XQY-17;
	Thu, 04 Jul 2024 15:09:48 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2] wifi: mac80211: clear vif drv_priv after remove_interface when stopping
Date: Thu,  4 Jul 2024 15:09:47 +0200
Message-ID: <20240704130947.48609-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid reusing stale driver data when an interface is brought down and up
again. In order to avoid having to duplicate the memset in every single
driver, do it here.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: only clear data in ieee80211_do_stop

 net/mac80211/iface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6d969d9f1ac9..97aee0a1a39a 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -689,8 +689,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 		fallthrough;
 	default:
-		if (going_down)
-			drv_remove_interface(local, sdata);
+		if (!going_down)
+			break;
+		drv_remove_interface(local, sdata);
+
+		/* Clear private driver data to prevent reuse */
+		memset(sdata->vif.drv_priv, 0, local->hw.vif_data_size);
 	}
 
 	ieee80211_recalc_ps(local);
-- 
2.44.0


