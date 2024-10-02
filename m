Return-Path: <linux-wireless+bounces-13410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9A98D251
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10EC1C21503
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6316F84F;
	Wed,  2 Oct 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="m9usIuWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF167DA81
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869522; cv=none; b=SO9q5nfEgm8eAJNuVfb+FA+D2bcko5kyqLlXSiHafHDzljPW3QwPihs8w8okV/xIfj8q4DZOpseZTWlaH7EmskxFH3d7qWM5XHsxaOjhlkE0XB8KllB1ELFpaMAv1Ymf16y8E+lmzhpCpGzU++8dGOg9Gn8XLJzj2Q9XVKhfEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869522; c=relaxed/simple;
	bh=M2wfzZF5AIA32pJsIcHAGu7UkB3eBEE5rGzMrySODos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+Hp5jmQgh0gTPSaIIczGTYtq+5WgbfyHUW8Cr7bS/ATXK6vixPaB3HUxQxH3joR4qxlCuwewhz2Y5L7cPVI36dV4dQlwQd0TeyFl7AWnDCyB3mHZLpsm0UJ1Oq+EysyemikYsMMT2C7ALfSrgbfB4NaBcfVIWhjqpEs5yIjDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=m9usIuWJ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fVk+NGWzlqynA2fGxfPlosGQpmk77cREH3bKeJVExzU=; b=m9usIuWJSW3mzCE5C9/CDmb2ta
	Hx1q26o3EsT5HMnKgLut10hw7qTxSZm/kA6s2blbyJBOZiA1E1cX8DPzLPUOoIxDQtqzZvTHTzQ8S
	ZMrpS/aWVXOhKqLHlHy97nQkRfNqPxqfpNwNTUdcta8TlZNwvzii5L8kpMcie1aDANTA=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnC-003vyr-1k;
	Wed, 02 Oct 2024 13:45:18 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 02/11] wifi: mac80211: use vif radio mask to limit ibss scan frequencies
Date: Wed,  2 Oct 2024 13:45:08 +0200
Message-ID: <fa77d4843c4e986db81960c7f859d0750e2b9e8d.1727869380.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
References: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
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
 net/mac80211/scan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adb88c06b598..8b77b782696c 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1200,7 +1200,9 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				    &local->hw.wiphy->bands[band]->channels[i];
 
 				if (tmp_ch->flags & (IEEE80211_CHAN_NO_IR |
-						     IEEE80211_CHAN_DISABLED))
+						     IEEE80211_CHAN_DISABLED) ||
+				    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+								   tmp_ch))
 					continue;
 
 				local->int_scan_req->channels[n_ch] = tmp_ch;
@@ -1215,14 +1217,16 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
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

