Return-Path: <linux-wireless+bounces-24667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26090AEDF24
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EFB188352F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656624DD10;
	Mon, 30 Jun 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jlzurC55"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B17284B46
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290355; cv=none; b=fHNGqNQk8hOYVjUg+Gf6kVUiuDKdwY73D8sQUrFuaPvvFBgpOCavK/43nMxsCS0X/ZFAG+mS/59pn+qO0M/rqT8tbnEHiN01UgboYQioboP9Lv+alc3cHYcvF01gBpuOdZzJbCv27s4OxKhe8/6q9pp0/YKe7LhCMxeShkxZwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290355; c=relaxed/simple;
	bh=pr0UzuS8TM2phG7bs0dPhOijt2v4pxisNU13qN2uR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geGGmdFSbfaJFJNBe7jtlvfmM7Numy3a2he6bqRU0OI2e795QGZBGC74hqBGjacfYxUAJ91cU8GHmEMDN9rjMSWuDjcW2KQEjtvpjFQfk6nklrqrrxvoFIwJWbKx7NLxrslFYAtwalqs+vlrwGtRz2M7tSEAlOlSv8/gD/hf/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jlzurC55; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=E/ZT0kSiN7FSi22KlpvKAJMShb1/WXB+AVTDL5LxOOI=; t=1751290353; x=1752499953; 
	b=jlzurC55+wFfg35knxoeXwXnFea0t38Hk9fMeHVfxS5BRUk/4H2DTULmDi8R5YlSPyotm0yYB1N
	UGiFT7B0OcmQuyAQK/vRiqGcAWtAraqMxF5FtLRrDcXrnBIHQtwlGnG4VLMvDZr63PBRop1PZs/WP
	MyzRYKkuVP8gGjjT9yzanTM6nQKt1TFm9zLBiEdnofTD4T5w1gF0yhMtOaXMRTc0ULdbeiWdMk1tK
	ZUd9gDqVwnPkOxX/som2B4lgXbOZsAGUXUlNVP+/maZJzVtAckDTAvdGa/syA4Xl7SsvqHtuEJkLx
	x3iM5nrCfRqMgvhNUavrxijv7dJOPHbBCPdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWEcX-00000001MaR-2hjD;
	Mon, 30 Jun 2025 15:32:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>
Subject: [PATCH wireless] wifi: mac80211: clear frame buffer to never leak stack
Date: Mon, 30 Jun 2025 15:32:27 +0200
Message-ID: <20250630153227.4c5640a33305.I7ab6b75e486b98435151d06ffe0d0c2acb2f41c3@changeid>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In disconnect paths paths, local frame buffers are used
to build deauthentication frames to send them over the
air and as notifications to userspace. Some internal
error paths (that, given no other bugs, cannot happen)
don't always initialize the buffers before sending them
to userspace, so in the presence of other bugs they can
leak stack content. Initialize the buffers to avoid the
possibility of this happening.

Suggested-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..402c5a9e8c94 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3934,6 +3934,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (frame_buf)
+		memset(frame_buf, 0, ieee80211_set_disassoc);
+
 	if (WARN_ON(!ap_sta))
 		return;
 
-- 
2.50.0


