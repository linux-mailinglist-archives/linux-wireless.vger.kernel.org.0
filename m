Return-Path: <linux-wireless+bounces-7304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD28BF069
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A3C1F22E5C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8584A51;
	Tue,  7 May 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIQdVn1H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AD84A32;
	Tue,  7 May 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122755; cv=none; b=j4Ujr8BckWIsVPsvhEY9xGa5SKxtyNV99nEEMd4WTnvWc80U36JkCkimDI+AThwABYeEC/Jdxnu+mskloO01/o0/c9JXQJCr9XjXKccjo3yexnnV8QjZNi05VRl4bAWPVd4c1LHVwYeZMVxQ/fDMhgYDkmD+dLJuIOeX8tGa8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122755; c=relaxed/simple;
	bh=UCdu6kAAABF7VcY6I5vb40khncf1hdL6/CsH1NWkxRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq9htqhLmQVe8hqNUx/8P2kdZC2B1tfKiT5ahOFxVDTYt7sUZG9wEXXPid/Fc8RkiLFtVoc+oCrxwiL3/4LJfAjC9C3G7x+rCDl9Nh6mpaRATID6NQDMh+CZny4xK6ZUx8hTIaSBKcuUn8czeCuwKKZoFpHJL/9/PHn48ddC6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIQdVn1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E9C3277B;
	Tue,  7 May 2024 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122754;
	bh=UCdu6kAAABF7VcY6I5vb40khncf1hdL6/CsH1NWkxRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIQdVn1HHaKSzNi5gM/cIW6wzb4BQAgZv0kmWs4igXOxrXVray8IXyaB7jqgBdIVw
	 ebtC/Id8B7G/N+DZlCQ/Vm7bai1odvIBQMUhl7h7w4VhxACAXNNE0aOxmezLB/tuVP
	 Z2iIPAYcIZqDkxd2WSwXmW88UpGeH1nm5drVeU/XIIDd7fJ6Tndo/fGmBVthGuAy5S
	 TWZ9QJCBrBGyf09ehjApdgklqxZHpHhkWU6MMtUhrHWbbg+Ofic7+3McY7EHjPMLpU
	 u1/VPAA2wFOqY8pJBbdRogCIrYoBoNhA9iHt9sPUYyi3eZ4IdNkr3luON9U21zmcsV
	 iSpZIwPSbLHwA==
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
Subject: [PATCH AUTOSEL 6.6 02/19] wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field
Date: Tue,  7 May 2024 18:58:24 -0400
Message-ID: <20240507225910.390914-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 6e574e2adc22e..f07bf15179e18 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5979,7 +5979,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
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


