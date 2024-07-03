Return-Path: <linux-wireless+bounces-9933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BE9264B0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB71F211C7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825D1DA319;
	Wed,  3 Jul 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="o9TwALlA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F517A5A8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019858; cv=none; b=Sy1Iq8wXPMvD53U5SdDIUbaSvMZGcL0BTTNXiqVNvcMJ+J+6cn1AXUYO9fuhbhj3CvCTtW/jeFrdo2ujtC6JSZDrMSAJwdxo5ca1Lu+VdLhrtgRMQPZ/8aIyMNG+r9YcUE6IoQvO+Y+8E8zbeS86KMDcJDnZO4JAuumHc9I+RDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019858; c=relaxed/simple;
	bh=N+UTnb2jfxzOxs/IjGIaGGuBJH/zr7JcN8DBKWBih9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7d6mc5n6fVU0wdHXmtN93UTZO50vQTIt64GUQALAcviTDu4rzIaZl7ZtZ1ypVHR6YXpNiMi+ORfTnqQsUI++bphhT1pGjTtZnOvrTCn9TggZ6iiAooSxw3owVpxz5rls7hU9bB/DqGoMF/XU8Zu9Fj4B3pwnTxxjOXikxlzNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=o9TwALlA; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EPas5XS8c26GUymz8BcyRCRYGxDMU6e5XPumpTem6vs=; b=o9TwALlABm/pdQAKF9HYA7dcfB
	Ko1/FPiUNWehRPY7kY5smQVrQiOAOxBdHZ/35jQJF3UiOye/pWwt5qJeu558Jzr2JRq4eXVcehK+k
	CsUwL/w2aRw51DxeC9tPyMh67/R9PiYuGugAfGAbfoPAyFJN7p6i8+42zBc8HP6geOoU=;
Received: from p54ae9766.dip0.t-ipconnect.de ([84.174.151.102] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sP1jc-002FzE-0w;
	Wed, 03 Jul 2024 17:17:28 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: clear vif drv_priv after calling remove_interface
Date: Wed,  3 Jul 2024 17:17:27 +0200
Message-ID: <20240703151727.26447-1-nbd@nbd.name>
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
 net/mac80211/driver-ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..afdf0a19a88e 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -121,6 +121,9 @@ void drv_remove_interface(struct ieee80211_local *local,
 	trace_drv_remove_interface(local, sdata);
 	local->ops->remove_interface(&local->hw, &sdata->vif);
 	trace_drv_return_void(local);
+
+	/* Clear private driver data in case of reuse */
+	memset(sdata->vif.drv_priv, 0, local->hw.vif_data_size);
 }
 
 __must_check
-- 
2.44.0


