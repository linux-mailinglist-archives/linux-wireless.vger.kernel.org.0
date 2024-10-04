Return-Path: <linux-wireless+bounces-13529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AC991082
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E711F25DAC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801E1D8DE1;
	Fri,  4 Oct 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="g55GCEis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F31D89FE
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073333; cv=none; b=QIblE1yYm1d/TUW4qbNfFYvhDxo+jm7u9BDJwYEImNqRfcfyR+7ztf98bBRlZtWJ9nnDZlKaUUvAnmpbe7RpdE5MOYdaJIoF6P5M4Uwc7TwMsnk5ljzQG1LwlwSPQM+gPSPtbav7B0PAzDRRcwTfZxq4Lvr4jSvAfJpY1/uk5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073333; c=relaxed/simple;
	bh=9b1r371dXfsr5GGHdKw/qqZZEeab3yMNevt7+uxIk5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stDZorzCxJFGsue/FuRPpWHRGEeG3SF5cDAf11Ma9YmjaZAJzm3gVfq3R+DnSNvfArHd11a1t6UTgGcaPfrmxTuHkGBqvRaCJtNh5vyoxMoTCYxG7QGOvmRUmvJ6EAM7z3lMi5WDzwf0VXGHQkyriv/0QP/kSioMj9LPLAV0Ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=g55GCEis; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JKdxbtz294+SY4saxVNZMFSMY56j5WQ8YjlOIX5wAd4=; b=g55GCEisSg2rlMHoy8/1IBlB8K
	nTXJC/E0AGV6cGnzhcwEsr4a0tCcnlSjIxbEP8zo4ohBVmPne5b/dQ79QNAY3CaQ/KCVziaDgTAA2
	TE6vvLaF7trG9BRn8emHxSmkQkSPDz3heHjoRvFTBTxUbZ08qurlvV+MwIuteeBm4+08=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooM-004jVl-1b;
	Fri, 04 Oct 2024 22:22:02 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 02/11] wifi: mac80211: use vif radio mask to limit ibss scan frequencies
Date: Fri,  4 Oct 2024 22:21:52 +0200
Message-ID: <f41b5a66279c2a106f69042d64aa2bf0f9ce81c6.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
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

