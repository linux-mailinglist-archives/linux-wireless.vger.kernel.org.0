Return-Path: <linux-wireless+bounces-13406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6F98D095
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023891C20D5A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E51A2561;
	Wed,  2 Oct 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Z4cYYkpe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242714F9F1;
	Wed,  2 Oct 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863003; cv=none; b=ltUasV6MzdBFMf0DLiKpvKD8VE+XGsiwfb90fGIv+rAd66USirTiWzZwZflNZqcYhbOVSoYhl+m4VcpmIZ3L4nIQpE7MUfezYfnZARr4nD38t6Mgy1v0LLlz+bB/wThFEGVA9WQV6Dr38cQ5WzibF7Kw5CyUiVWfFOF24ABVXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863003; c=relaxed/simple;
	bh=wv3ptkp3nCM2ASRaxT6Iz6eTJJsmy9OWJXR51XZ7HhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4jeSmzuLO/qbSZO3cGpgU4IkbFv9wuGNQGN14Nu2CmQU/OYAwAotcsc+42p4e9lrAKTVTFBmkdi2Jvx+T6Lwv7YP/v7wKqezSjtQxsKjA3LIeVqDmjoh4IljJMVj854WwfKDdW/OHA3SYsAmFYtDDb7nLGJkJ2FqYXEvZdO0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Z4cYYkpe; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qlZRhiL5o4h9Z4dnlRu3QrGjEdy02pHZZosTMhv0wZc=; b=Z4cYYkpe3mhjwWS2HtbqMb1/D1
	36nvPwtbvceF5NlwisN6rsrYPDbfOxpqxoUQ5CGIUMtQpPWVntm+oE0EWWq6w+9TbKnC2a78Yh7lq
	LlEdoiLjd7lsCOmMUpDgJyoeAxq0BHi3BIGPPIMyNJyUDPH48k5tq458pW84fmXKkFRA=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svw5u-003tXI-2l;
	Wed, 02 Oct 2024 11:56:30 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower
Date: Wed,  2 Oct 2024 11:56:30 +0200
Message-ID: <20241002095630.22431-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid potentially crashing in the driver because of uninitialized private data

Fixes: 5b3dc42b1b0d ("mac80211: add support for driver tx power reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 847304a3a29a..5f855e94aeb4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3138,7 +3138,8 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	if (local->ops->get_txpower)
+	if (local->ops->get_txpower &&
+	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		return drv_get_txpower(local, sdata, dbm);
 
 	if (local->emulate_chanctx)
-- 
2.46.0


