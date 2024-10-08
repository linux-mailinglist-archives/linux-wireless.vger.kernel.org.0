Return-Path: <linux-wireless+bounces-13701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7849940A7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368571C23CF7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B4206046;
	Tue,  8 Oct 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fX1UqWn2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664554F8C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372302; cv=none; b=fkzuaeBWWHQbCLmQgVX62q24jq1ZgOVRXqzzCnvSY1S0lJI8LllXNIlrz5YvVbzJtLKTRpyupg9ODEoHbtXbZvD6zd02cs0Ewk6ArRWU0PMEDBr4L39pxU6HYPLovJq28ouRZ7mZxJAtMjzltV5IBhshet3KoxJ0MKeGiD2udKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372302; c=relaxed/simple;
	bh=9b1r371dXfsr5GGHdKw/qqZZEeab3yMNevt7+uxIk5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aae6hhOiTj6iQz3U8WlMooLisqnXQ6zDYxRihXU5qnjaTobXY/Qu83ejmmqHGYfkWJINrMNG72Kx8KnnIsru5uQdaNL4Fnqc9/CciyIGzQ2aFZK3WIGQvGZQH1eALZvFrr+ljcxU2Fl9Qorw0clEIXhJbSkg4NnCyCSX6YldKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fX1UqWn2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JKdxbtz294+SY4saxVNZMFSMY56j5WQ8YjlOIX5wAd4=; b=fX1UqWn20prxM/YC7FphWZqPgh
	OIyvOvFnDPYs0yoz5h9D5LEzNbON3a2+MWmr6OrIqXEb44KT9yLWPWRWbpNu6gXtfnMQxWHEsIWqZ
	lX3Cr0hCh4O6Gmbg7pI7nv4Q6IUaE/Kjogn4XzsiQtGYvLqi1i+qbH7DoRpyk07rq0kY=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZN-006H62-2s;
	Tue, 08 Oct 2024 09:23:45 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 02/11] wifi: mac80211: use vif radio mask to limit ibss scan frequencies
Date: Tue,  8 Oct 2024 09:23:35 +0200
Message-ID: <f41b5a66279c2a106f69042d64aa2bf0f9ce81c6.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject frequencies not supported by any radio that the vif is allowed to use.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/scan.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adb88c06b598..2ca75cf17242 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1176,14 +1176,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				unsigned int n_channels)
 {
 	struct ieee80211_local *local = sdata->local;
-	int ret = -EBUSY, i, n_ch = 0;
+	int ret = -EINVAL, i, n_ch = 0;
 	enum nl80211_band band;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* busy scanning */
-	if (local->scan_req)
+	if (local->scan_req) {
+		ret = -EBUSY;
 		goto unlock;
+	}
 
 	/* fill internal scan request */
 	if (!channels) {
@@ -1200,7 +1202,9 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				    &local->hw.wiphy->bands[band]->channels[i];
 
 				if (tmp_ch->flags & (IEEE80211_CHAN_NO_IR |
-						     IEEE80211_CHAN_DISABLED))
+						     IEEE80211_CHAN_DISABLED) ||
+				    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+								   tmp_ch))
 					continue;
 
 				local->int_scan_req->channels[n_ch] = tmp_ch;
@@ -1215,14 +1219,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 	} else {
 		for (i = 0; i < n_channels; i++) {
 			if (channels[i]->flags & (IEEE80211_CHAN_NO_IR |
-						  IEEE80211_CHAN_DISABLED))
+						  IEEE80211_CHAN_DISABLED) ||
+			    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+							   channels[i]))
 				continue;
 
 			local->int_scan_req->channels[n_ch] = channels[i];
 			n_ch++;
 		}
 
-		if (WARN_ON_ONCE(n_ch == 0))
+		if (n_ch == 0)
 			goto unlock;
 
 		local->int_scan_req->n_channels = n_ch;
-- 
git-series 0.9.1

