Return-Path: <linux-wireless+bounces-20131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD5A5B5E2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 02:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E0188C33C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249891B423C;
	Tue, 11 Mar 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGevNZVh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0332AD04;
	Tue, 11 Mar 2025 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656734; cv=none; b=cn3gcJ32vvzt5cizSs8gBcztNpqRZYFoMEeGQk50qSJk4kudau/OQEe0uB6qe/14oBq9rg1z9OI7VKg6F7f/1/PeXjjLRt0P/Vl/VVMY/yFk1bd97tFURBhOslkikdDiIm+S8YgI0HjNEne+KFF40N7YdB/s41TW01acrtUrgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656734; c=relaxed/simple;
	bh=Cz/8z4ogsB2e4LZuFVFwDmgAExkUr/0BAjvdTwGLBSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mMYRj1ppSi7+UNmHYiOXTM9SEDCgSXqtxtDZlYrkN6FHjEKqCnuNEwosBCwVCNgDYECJg3g4S7AEgjKr6HjNops7oFMwOFxXgVGfNi/NoIeitr56TGMbB/VxIR1dB4Wr9mGWh9YvcNcoPvj1dNk1pqYxOsWTyCbF9pZfYOgxqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGevNZVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF150C4CEE5;
	Tue, 11 Mar 2025 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741656733;
	bh=Cz/8z4ogsB2e4LZuFVFwDmgAExkUr/0BAjvdTwGLBSc=;
	h=Date:From:To:Cc:Subject:From;
	b=NGevNZVhCBAzAZdPxfwRXUp4qN2wF2NFBlwriw4EhwJaTEIq22tch3HJ3vvHzS+FL
	 sUmcNnshcN0+uPMz12AXaL5lQmI5i3iuV0z6yi7cqijt/+ITKnyvFj83dINEoMVHpB
	 7gZQrGs/fX7GXnL3+XLHXL+PBVZza4f4iPtFly6TdTNuZsKt+AQ/X9evhbHNy+xG1p
	 OmVzfGhvyNXcNGee6xRCfOvBsi1rjoPAuYIN5JYhwGClA5x+BxPa4swBrZdoSyEoM+
	 4UC7+33P2VZUgRdgya0KP9tpPVtR/Uil631qChEyj/OlOsMQVrizq8PL33YXbFluyU
	 b/O0oLa7B4kXg==
Date: Tue, 11 Mar 2025 12:02:15 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: ath12k: core.h: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z8-Snz86Xfwdlyd7@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct ieee80211_chanctx_conf` is a flexible structure --a
structure that contains a flexible-array member.

Fix 30 of the following warnings:

drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3fac4f00d383..d6b4c4d2c400 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -295,7 +295,6 @@ struct ath12k_link_vif {
 	int txpower;
 	bool rsnie_present;
 	bool wpaie_present;
-	struct ieee80211_chanctx_conf chanctx;
 	u8 vdev_stats_id;
 	u32 punct_bitmap;
 	u8 link_id;
@@ -303,6 +302,13 @@ struct ath12k_link_vif {
 	struct ath12k_rekey_data rekey_data;
 
 	u8 current_cntdown_counter;
+
+	/* Must be last - ends in a flexible-array member.
+	 *
+	 * FIXME: Driver should not copy struct ieee80211_chanctx_conf,
+	 * especially because it has a flexible array. Find a better way.
+	 */
+	struct ieee80211_chanctx_conf chanctx;
 };
 
 struct ath12k_vif {
-- 
2.43.0


