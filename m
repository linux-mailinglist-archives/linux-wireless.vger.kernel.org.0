Return-Path: <linux-wireless+bounces-7301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2938BF00D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E50281CBE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614981AB5;
	Tue,  7 May 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjsG8HRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369638175B;
	Tue,  7 May 2024 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122654; cv=none; b=W4enkcNyNUixViFV5vyn05tuGUdY+UwSEMzTM4C997DskSJDtLkSWQsKguv/vTYG9PTV87hn97/kyn6H6KiyGVqwmJHkqZbsQHiAMHDwg+2OeILxYyz96v26DGbsDx723SpCfYU1TVysfrjwp432o609IVzssRVfcX+6182DoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122654; c=relaxed/simple;
	bh=FhyjxnH6GMBnLfmuyX/WnOdyUktXpZl3xW1/NXLH9xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gApMmB6f3ks2h98IRIT3skLkzB/yLcVSsf5P9DYqJFJNkmj7fJIsbZzG4FsooL6R3hoLExDrsJJsdHBSRJiGbZYVIurHNA0cIntDfa/GaMlQCNCdpffOXg4J60lwqeS6d3zE93EzptfHV74vMyLSzSGQ9upw4H4mZaYgrj8gkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjsG8HRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85182C2BBFC;
	Tue,  7 May 2024 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122653;
	bh=FhyjxnH6GMBnLfmuyX/WnOdyUktXpZl3xW1/NXLH9xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjsG8HRcDi01dW7hwk+4x8Wv8q8xOwh28OdfWIRV3+/dZDvfFqpZWv7w6yp5SHJ1g
	 Lz3L2mnX+d1u07z57ZV2BSjOADcCa42Vaqu5vfd1WxBprVpFm4xivOzXZPVxotj4to
	 YiGvoncbVvKhQiqMT2IDVrCA8twaHlzn0TJCAY4ecNlyPpZKFPYgW+KuTK3qESNt2s
	 KdeniEna9xkzcaH8d41TPBiCiSgRV1z6ctEXIOT4jS/S3U1ssdsfJ1aj2HQAOBiTTd
	 xwSX6ol5OhzNTtex0alYuiwlnxfBTtEObmmO3egMOgEbfK+UAq0+kPsFi7meveZqQ6
	 +0jh/v2UG5foQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Kinder <richard.kinder@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/23] wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field
Date: Tue,  7 May 2024 18:56:30 -0400
Message-ID: <20240507225725.390306-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Richard Kinder <richard.kinder@gmail.com>

[ Upstream commit d12b9779cc9ba29d65fbfc728eb8a037871dd331 ]

Logic inside ieee80211_rx_mgmt_beacon accesses the
mgmt->u.beacon.timestamp field without first checking whether the beacon
received is non-S1G format.

Fix the problem by checking the beacon is non-S1G format to avoid access
of the mgmt->u.beacon.timestamp field.

Signed-off-by: Richard Kinder <richard.kinder@gmail.com>
Link: https://msgid.link/20240328005725.85355-1-richard.kinder@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 94028b541beba..97ce3214650d2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6184,7 +6184,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 			link->u.mgd.dtim_period = elems->dtim_period;
 		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			link->conf->sync_device_ts =
-- 
2.43.0


