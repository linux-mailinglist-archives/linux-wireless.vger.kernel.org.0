Return-Path: <linux-wireless+bounces-9104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78590B151
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDF2B2F2A1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711881849D4;
	Mon, 17 Jun 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhSkeLgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B61849CD;
	Mon, 17 Jun 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630737; cv=none; b=R6/Mp8IHXVa9D+fvuF8C2zpmjIgHpXuLevb1MFj9hOqbgJvNTk91Nmcr4VyhxU9cG1a75ThbJyYq07cYY0ykF9CXV5QCKIvS8G5GCHGj27lAVnHglNTqGu5dwLM0pCZSkF+ukx5Dd7dWAk0/e8RcfOiKptedWRJZUygQ7gN3cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630737; c=relaxed/simple;
	bh=Eo3V4jSPlpaQPRt1kZP3S1ORy65YI2GBpz+FaCrKQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgeENcHUo1hkxqlOPuFLOSeSl82u0A5J68TthsmgCiSYku6FltHECWZQkp2xDiYbo9G+khLSKBZPhctn66/mdb3HXPVgG2zWMfC38/6Gyx32aptQseaHryVig8i0z8oOYj91v6mWejMFdSTIEa+E7bnfFFp6ntwbBmMvhLRNsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhSkeLgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBDC4AF1D;
	Mon, 17 Jun 2024 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630737;
	bh=Eo3V4jSPlpaQPRt1kZP3S1ORy65YI2GBpz+FaCrKQGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhSkeLgt/550Yj5s+94DGRY7BRSHWUYg6AFPR029lslYLs0uGUijGL7buKX380wFJ
	 SsUzIjGCI7GUjFAYvItA8zEs5yscgvMZsPtv+HjyUJbtJ0Rh6lTj8T7dccdjqcAZ9h
	 yiWEM0lYJMWjqZao1LbaLv666SYXSI9XDxRdH2mMjBjnI8agVgmcRRGCzpwkzldHx/
	 UzW2thJttjk6nLUpYllLBJKFjXALuNhr3kfSWujBfL2QTV7BAaRXY3gWLhSRkVSJd/
	 DTcltWHTYRzwb9Bw62gQeQCTfyJqfDzwhSN1zCu0v3ocJS6RZJjA19W/Z7z0BUYaKI
	 Vsr+UvL7lunvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/29] wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()
Date: Mon, 17 Jun 2024 09:24:23 -0400
Message-ID: <20240617132456.2588952-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 92ecbb3ac6f3fe8ae9edf3226c76aa17b6800699 ]

When testing the previous patch with CONFIG_UBSAN_BOUNDS, I've
noticed the following:

UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:372:4
index 0 is out of range for type 'struct ieee80211_channel *[]'
CPU: 0 PID: 1435 Comm: wpa_supplicant Not tainted 6.9.0+ #1
Hardware name: LENOVO 20UN005QRT/20UN005QRT <...BIOS details...>
Call Trace:
 <TASK>
 dump_stack_lvl+0x2d/0x90
 __ubsan_handle_out_of_bounds+0xe7/0x140
 ? timerqueue_add+0x98/0xb0
 ieee80211_prep_hw_scan+0x2db/0x480 [mac80211]
 ? __kmalloc+0xe1/0x470
 __ieee80211_start_scan+0x541/0x760 [mac80211]
 rdev_scan+0x1f/0xe0 [cfg80211]
 nl80211_trigger_scan+0x9b6/0xae0 [cfg80211]
 ...<the rest is not too useful...>

Since '__ieee80211_start_scan()' leaves 'hw_scan_req->req.n_channels'
uninitialized, actual boundaries of 'hw_scan_req->req.channels' can't
be checked in 'ieee80211_prep_hw_scan()'. Although an initialization
of 'hw_scan_req->req.n_channels' introduces some confusion around
allocated vs. used VLA members, this shouldn't be a problem since
everything is correctly adjusted soon in 'ieee80211_prep_hw_scan()'.

Cleanup 'kmalloc()' math in '__ieee80211_start_scan()' by using the
convenient 'struct_size()' as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://msgid.link/20240517153332.18271-2-dmantipov@yandex.ru
[improve (imho) indentation a bit]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 933d02d7c1284..62c22ff329ad4 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -733,15 +733,21 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 			local->hw_scan_ies_bufsize *= n_bands;
 		}
 
-		local->hw_scan_req = kmalloc(
-				sizeof(*local->hw_scan_req) +
-				req->n_channels * sizeof(req->channels[0]) +
-				local->hw_scan_ies_bufsize, GFP_KERNEL);
+		local->hw_scan_req = kmalloc(struct_size(local->hw_scan_req,
+							 req.channels,
+							 req->n_channels) +
+					     local->hw_scan_ies_bufsize,
+					     GFP_KERNEL);
 		if (!local->hw_scan_req)
 			return -ENOMEM;
 
 		local->hw_scan_req->req.ssids = req->ssids;
 		local->hw_scan_req->req.n_ssids = req->n_ssids;
+		/* None of the channels are actually set
+		 * up but let UBSAN know the boundaries.
+		 */
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		ies = (u8 *)local->hw_scan_req +
 			sizeof(*local->hw_scan_req) +
 			req->n_channels * sizeof(req->channels[0]);
-- 
2.43.0


