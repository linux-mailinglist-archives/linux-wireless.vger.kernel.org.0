Return-Path: <linux-wireless+bounces-4307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA286E896
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60C1B2C4E0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F538DCD;
	Fri,  1 Mar 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YfV5eTvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698C16FF21
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318216; cv=none; b=dgrMtO0fZoXsYo5AB5t4tb9RhAjp/oIHxG1GtachpVNDkir681569i/RPXcqAuyqwtOFAmmVZvECYugGkWkIuEyPbFlSkGKjDzBhys8GDZbX79nNvb9CaHDD/l+5VHOGdpA2AaoeoZ03zi8ozVrkpui0TDhkbK3m0E4n0UfbHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318216; c=relaxed/simple;
	bh=3iz7XtdjERYQ2R9RcAmUy1GRR/7Ka1HMePpBpUmZrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cILJCvQtgJnVC97eGVuMtPIxxHQlxYDyF8iHzpN7M/hK8kLsnFQvAe1VfRG/Q2VCksHqsk5a8jIxuz8m56lfYWBNn6km4zVh5WiHT9lpWeAyRpNWNDVUE6uKHUPEJ5tHGAIoFurOB399MPxljySDX2X76k7jekKJa0kbFHTvCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YfV5eTvx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iXBnj+gC3QiogAq6En1XKOLj+1HgkAQZB9y1wnw24Bw=;
	t=1709318213; x=1710527813; b=YfV5eTvxi5Avd0sa5ZRavsDyawFNddOlp4kTe9rkWCgDHzm
	6o9vDd0wtbuMmW//cPjab6dW3ilU1fpSwxmaPFQz77TXRw32As31lFcXB3kBWXU2n9ZWXCv2e/JtH
	/UlDzuwBoEb/KWU/ig/DoWvWAkp0WVLXcKeCCe8JGwPL+GoWtos6EwUf6DqE1ww5CJj4No4qn8/LL
	udWreZ3D4LAUJqoLQ6nTSitdEfamY2WkUotf4Ogju5SR8Z3QOZT42mzmUeLdZUGJJmMdnzSgFZ2bk
	0t6PKc9Tw/7C6Y660OooaFpx1ZouPJZuy3HMtRViGclR/Q9hrNQbQ1/lJ7XAcb/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rg7kY-0000000FC4Q-0oxm;
	Fri, 01 Mar 2024 19:36:50 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: check link exists before use
Date: Fri,  1 Mar 2024 19:36:33 +0100
Message-ID: <20240301193633.c886d300e90a.Ie1d5e23b2a033d934d343c37249f6f4dfddcc5fe@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301193633.1a3fc370f211.I979dd222b3b5eb5e1437886e5f7c2355eeccb9f7@changeid>
References: <20240301193633.1a3fc370f211.I979dd222b3b5eb5e1437886e5f7c2355eeccb9f7@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the assoc link doesn't exist yet at this point, we
cannot use it yet. This isn't normally the case, but
e.g. in case of FT-DS (or just broken userspace) the
link might not be set up yet and will only be created
later in this function. Check that the link exists.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/3151f5d0-c18f-413d-b34b-b94f095b947c@moroto.mountain
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 89c4165f2753..c60d23da91fe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8173,7 +8173,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 				eth_random_addr(assoc_data->link[i].addr);
 			sband = local->hw.wiphy->bands[link_cbss->channel->band];
 
-			if (match_auth && i == assoc_link_id)
+			if (match_auth && i == assoc_link_id && link)
 				assoc_data->link[i].conn = link->u.mgd.conn;
 			else
 				assoc_data->link[i].conn =
-- 
2.44.0


