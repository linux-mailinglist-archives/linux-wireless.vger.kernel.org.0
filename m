Return-Path: <linux-wireless+bounces-2703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B78412EC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7201F2246E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05829241EC;
	Mon, 29 Jan 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DURfftgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6F2E85E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554866; cv=none; b=SU9zF1InKb+qruZzGAQOeX3rcwEKTLQ4FxoFdoqGIGCNA0F1kHT+Jh9w8z4ZCYcghAKXEbCiLZpy3F1ACusk/nq0K318bNTYB5PgGO9apoivGwnlMBa63nwnFdKn2zT5JXFmSrTS4D6y05VMTekcy5mFoc3dWiJu4cHF/22PiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554866; c=relaxed/simple;
	bh=CvN1ySvJLuu4RN0j4uTOxpixHqUEdlGl1jjaOMa3GPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQwi05JmyKu6oBZGrYlW4ZeVaHVNbY28QgTXrNVJCinvTj+Y8q+dFwsNjrEnVQGkBJldPtUTKEh0k7japbSyAjpBjcGio/BqKCU6RzRe6t/+eLjjVffeMK723lYMDJ/vj2Sy+L0it8gokMwlm1n0TBWMRPZ/O2HLFUb6VwOZT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DURfftgS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TRS0TwZfnpIzABYziayrMWmZOvf0lrRT2IIV8nc+K+U=;
	t=1706554861; x=1707764461; b=DURfftgSEqWGk1lB9BA88RSRRPrypnwjpUfawbGfClYdAqK
	Nee9XzpjilW0w9vw7VErhOQwZu8VdryH2OPAZoHiljriklwwok1oMYDkp7Q6L0sHvJvyhWvZ2mwXr
	/Uv9DgVeiVLk1/j7NyhP5NwpTx0+GOL+XgEZ9j4HGCtk4pLW5S3lK54OtWkA0oFA9yINpRR86sRsA
	pgjXD41cRyEWDjKAiCckm7l5KfJjKaQ52MKppMV482fOI58yCPKocEdrLu/3UNjAS8bmvCIROvEW8
	iKbnwiCrh7UV1U8QJyzy+51u8wO36IQeIYiHTfLXKrwzV6CQ5izEpP5gzwzlsszw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWsM-00000004zxs-3wLJ;
	Mon, 29 Jan 2024 20:00:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: don't allow deactivation of all links
Date: Mon, 29 Jan 2024 20:00:53 +0100
Message-ID: <20240129200054.e3c113f94508.Ia35f927f914bf98dd8f9350dd4f78b1d901b1c1d@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129200054.f5459f6c29c8.I397814449e17950fcf882ef44a1e790a71aa1dce@changeid>
References: <20240129200054.f5459f6c29c8.I397814449e17950fcf882ef44a1e790a71aa1dce@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The set_active_links API is intended for link switching, so switching
to no links at all is not supported.
Add a warning to check that.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 79bda7184fe8..4f19d6479bef 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -445,6 +445,9 @@ int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(!active_links))
+		return -EINVAL;
+
 	if (!drv_can_activate_links(local, sdata, active_links))
 		return -EINVAL;
 
@@ -473,6 +476,9 @@ void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
+	if (WARN_ON(!active_links))
+		return;
+
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
-- 
2.43.0


