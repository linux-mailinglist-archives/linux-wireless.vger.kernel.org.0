Return-Path: <linux-wireless+bounces-10014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52B928813
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 13:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70631F23A18
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D55146D45;
	Fri,  5 Jul 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e1EJTAHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C691146A96
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179579; cv=none; b=GL6bLVR8exxIT5S80OceC+8D3dfY27fAvKQbfbOoNn0fodmeI7CjqRNtxs3fZnBLUkbkxLCZMZ26ttQhlsK2DyMqT83ZRo50wkZ2+0Yl76XNQf9spw9lEkmadQ6CcAMoP+TfWkZh6L8h6JAn9nbO7dKsWA4ngaIVd34BRYLot/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179579; c=relaxed/simple;
	bh=hnbQ3/cMChL1R12L3g0SYELb3uTG0lRbmU2DJajQJpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtZDBPnU8GGAwmeNoUpC+p/7/54Z2vgo3M3e3o49L1d1aVUDuOezaVFtbx2xLnbnG336fS14zkEdv7zlBcLFitABhLFQxB94y8EhH82Rc9JlXp61Kd8pSd9LDzI8QpQmSzDUKUYcg/bPidKESVOE46L8o9XgKX3W5HIHtNvuAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e1EJTAHD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wuQvy33/ZAy56i5yb5hvccQvQA0wBBMG9fD+NmyEK9s=; t=1720179575; x=1721389175; 
	b=e1EJTAHDkyCVaQGC9+ns6wTV+4J8pIVrglXGYpZvn9UsPzndddmQ6Ul5f+VMbKCN2AhJS8Vp43g
	8DbvAsyHlSJT92FOv7q8tCmVW7LNd3ZjAi6SIvCs2kgJAg23/Xg1FJN/6ex/YWGng8wxlhGl0vDmi
	P9moOqPlDasve0yD2leCIpYrUOi7VGe9LH0fwSPMd1ket0Q+YnjxjvEVeBlG6lVTrUQtxHxTb4SeK
	6ima8zogOYwPb/bWp8zyxKnK6BEA2MD/WSJKLEaqZAgeNuXEjoKLTGIUZjeAHlk2t6B0Y8l+aVfNv
	90gPZHnjdN2o2B/q/koWH6PSGbHl4L9OkC3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPhHg-0000000GF42-1Nj2;
	Fri, 05 Jul 2024 13:39:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211_hwsim: fix warning
Date: Fri,  5 Jul 2024 13:39:21 +0200
Message-ID: <20240705133921.a50aa5b15ece.I9a25b7448b0498c0c2e503986978dae165c8bdf8@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

WARN_ON("string") will unconditionally trigger a warning, but
not really do what it may look like. Use WARN(1, ...) instead
and add the mode number as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 8491eb32f760..d60c780d4e8a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3261,7 +3261,7 @@ static int mac80211_hwsim_switch_vif_chanctx(struct ieee80211_hw *hw,
 			hwsim_clear_chanctx_magic(vifs[i].old_ctx);
 			break;
 		default:
-			WARN_ON("Invalid mode");
+			WARN(1, "Invalid mode %d\n", mode);
 		}
 	}
 	return 0;
-- 
2.45.2


