Return-Path: <linux-wireless+bounces-2888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5781D84435B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAF1F25B02
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E191292F7;
	Wed, 31 Jan 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IQo4kARt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E81292FA
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716119; cv=none; b=tGY8W4v3RbQdTAKo9ImZGB8xdicrUmZavIWIJozVYnXwpHK1VE96xWaP1BHzOD3qwWO1NbTMaXaAGaBamdIk+wt46GJEy+RnNNRAJ+sh7fIvGza2r79qk2kDS4Ym2XUpjzaXDoEgxVwI6A9wyEjFkCftPGVVPF1Hol+eAqgA9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716119; c=relaxed/simple;
	bh=8mq72bwFpSLPu6q8M4IROLJLcwu6U/CMhIbri9P2XFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7W8RwsTSLf+zBPOywQFkpiE1TIjEUqo7S0j0MAoeKtOWfhbqBo6rOWvCnqqpUcjfHVEYb1yv+51HmdUH2qUEOMxDeTHVneuW4pSZAypEh82geR9JzPS3OzwEH+4LM8CHfTG6Uy7aIqtryFmA9iMVOi5Xu98j/7/DL7IFgNfkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IQo4kARt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=W3usA0qa80RiVziSYCJA6Y7Q+UUeSIhUAUsdtMcOK8c=; t=1706716115; x=1707925715; 
	b=IQo4kARtBC5qcZalh5SqQD0ncI/SvZF3vEee38d7fsh+DWWY7H6nL6GXB7snvxfXAZQ0XKpH7ox
	6QHOoUIoQhh+1rnZFf2j9wiSjnY38rMj9NxQ02XPnTDkmtOpbLCsJ3T+mtRHtHxtQekvTT4EQ9orF
	d6x6BcFGfMV9/lg5NeFkVgogdEKpCqvj+9s0pfILPXK1XivrNcecZ8Y153Ll2maWNesOPacAD/Wb1
	No/LFPkXbWBRb/ydTuf4F7nTjMU4BuhxmyKlyh1zYRkqnDhm3A6tx2wVynHsKyNLmH3y3aJZalHRe
	zYLagP0QYRHEWlW/ZvXkfrnYgaErEESwB5fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCp8-00000007JAi-16Y3;
	Wed, 31 Jan 2024 16:48:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Wed, 31 Jan 2024 16:48:23 +0100
Message-ID: <20240131164824.2f0922a514e1.I5aac89b93bcead88c374187d70cad0599d29d2c8@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a call to drv_mgd_prepare_tx() and so there should
be one to drv_mgd_complete_tx(), but on this path it's not.
Add it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 40de13cda92f..0349e0ded1d8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8454,6 +8454,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0


