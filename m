Return-Path: <linux-wireless+bounces-7242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9EC8BD54F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA1B22269
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7393159203;
	Mon,  6 May 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vN+GJ2OH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657E1591E4
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023144; cv=none; b=YO2lt7kdS3/tKvAD8bcCpN8tTgj1v3Q4MZstrGoHlvgomhw0giRh5LX/E0ZfeCHDHIDiFTz4EHiPp5xT61ZlmncRXCgKp/iFJx96oeBdiTAhcAR/MYlDRl9uFYa2ZjRUHa70Hy6sct5VwpActmougfvf4t+qcRj3lQ3AZBruTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023144; c=relaxed/simple;
	bh=v1ZbPn7B2x+hnCMrV6R7ZP2Ps24/nnaxdX/6sG2BG+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIZ3c+RcG7o7yOY7PmAibuqZe4k2OmX3GufPcyShHEPe9AfCUG9eaLrqulEUDUPjGQcdw6jcYQtgKePrjA9lC9CP3xLVr0vdG2F6BlX/DjEG6PkLd++ZXcpxEi68Np6lBfnRWQZDU9lprqoytAtnYc8F+7C+93w1LZo2PAV8ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vN+GJ2OH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jpSFNwTmbLX2wsjdnKzd+NP4e0clrQLbzCZlLB9vEFw=; t=1715023143; x=1716232743; 
	b=vN+GJ2OHaGKXROcyqZn0AibiTnrYD2CgPXQE+2hX+bnzbtKukZtzdWXDPC9wa27LZJe9I0d/al3
	dVgUdh/d1QzTsHhf4sHE3lPWKOBWalJKrRT3bd/8hxGTe6O5U0twBCLU4jSEJ929ggkEyOABsIQAX
	OKNseNbD0BF70cUrxfusx0YMeebiZxJzagGrU3uaoq+eiGSbAw4qrtwBey7F+gEJ6/dHuQAGHaxoO
	G97kokUdjBVTk2TMP6buxdricdOsabqfjpQNjybwI/e1bgpvhAEjybsiARM1/chIAcSV7Kvrxau3W
	btIBonRp9KDucruD3j2MMKZjsaA/yoM5Qt4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43rY-00000008AMz-2HHD;
	Mon, 06 May 2024 21:19:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: reset negotiated TTLM on disconnect
Date: Mon,  6 May 2024 21:18:59 +0200
Message-ID: <20240506211858.04142e8fe01c.Ia144457e086ebd8ddcfa31bdf5ff210b4b351c22@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The negotiated TTLM data must be reset on disconnect, otherwise
it may end up getting reused on another connection. Fix that.

Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4493e63e3722..f026623c057b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3286,6 +3286,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	       sizeof(sdata->u.mgd.ttlm_info));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 
+	memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->neg_ttlm_timeout_work);
 
-- 
2.44.0


