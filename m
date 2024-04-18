Return-Path: <linux-wireless+bounces-6508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100F8A9561
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32F2B21B6F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9C15AAAD;
	Thu, 18 Apr 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gc6oFSFF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5515AACB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430356; cv=none; b=AiqjR+0PicN29Zs2Yq4lmgLaCDn82/KfVZ/co12rwziiyue3iAWN5Yc3G8vlZTsWS2r5vjiR/rUKs45jp1lQHduWCheGKEXLLf9bwZvb0e4FWaEMklRb7N17e3joIHEgZKvJ+ER8dADyAkaJU/Hl2dy+NJYzOEVx55oy8wciy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430356; c=relaxed/simple;
	bh=vCd8u3N5w/fGbAvjU7foKfLM1z1GiDWyU5CdD4qiu2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYFBMyUmib+JjCz1/8/gbTk+4fRSbCqFhb4cJ6eGLM1/8kErjg1YQ90P/bUY3cmdchuRjuHh8sQwUOutzJA4VJOsVV48uTOgrDbLWnDU38cBQUhws5In97rgmmVdGg6Mb4CxEUv6k8SDMR2fx+I8ljOcx4LVrRVVwr1kDF+prZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gc6oFSFF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lia9aGJ7ZZV7DUgVVqlynCBBe+EaF3Gt5BYAEzt/vDA=;
	t=1713430355; x=1714639955; b=gc6oFSFFM0UaodGouasipqi4oHCKlCqZl6UUGN90h8V3Yiz
	iziDIxWblQvxrqniX+rK/4O92+iRIKwFxM2vKbzavAkGZ9KybR/ppPI9keRRfPOd3OEkOZJU98sLl
	O1AwF5NxMCiRGcuzWw+paXax6TsDKsqWHqe3Ve7a9KVAKxrTKQqS4gjodoj9hFYUOO8J0adOJy3kr
	4aMYDV5ZpzZOOBVhxbx+THgohZ93PJ5HgkqNJnyxxI+myPrwP4dxgUfCX8H0nJYNZqjDHQ1rD4fU6
	o/ut/GykA6egXH6ayV6pyjCjwYk2whNf+MlFiJ/LcX8tEjPZ2wf0T1+rcfo9urYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVK-0000000CIvO-47Og;
	Thu, 18 Apr 2024 10:52:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 5/8] wifi: nl80211: don't free NULL coalescing rule
Date: Thu, 18 Apr 2024 10:52:23 +0200
Message-ID: <20240418105220.b328f80406e7.Id75d961050deb05b3e4e354e024866f350c68103@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the parsing fails, we can dereference a NULL pointer here.

Fixes: be29b99a9b51 ("cfg80211/nl80211: Add packet coalesce support")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4edba6b0b7b..30ff9a470813 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14030,6 +14030,8 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 error:
 	for (i = 0; i < new_coalesce.n_rules; i++) {
 		tmp_rule = &new_coalesce.rules[i];
+		if (!tmp_rule)
+			continue;
 		for (j = 0; j < tmp_rule->n_patterns; j++)
 			kfree(tmp_rule->patterns[j].mask);
 		kfree(tmp_rule->patterns);
-- 
2.44.0


