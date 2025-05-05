Return-Path: <linux-wireless+bounces-22502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19202AAA28D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B35B1888064
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4D2DC102;
	Mon,  5 May 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC9U6hzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F952DBB29;
	Mon,  5 May 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483706; cv=none; b=pIQcncgvZBX3Qbh4dQe9tA0b+HP1HQ0P7X6S4qfNyClA3cXwjmOccdYL8/uofQvIfZZG5WggaBwgbHiPGtkmsz7dHHT3dVUjIax9XCyjtHPK494hF9nGFhYGn8Qfd5XYE+TMvWNRGGrS92BHEZLMfr7Nims1/DQtYhF3BcoHbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483706; c=relaxed/simple;
	bh=SRz7NrtbWRELW/vyaOiWjOpUbQSA/Zt18eZ8QCFRCD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iCBNQSz5b3xteqqwb2X+9MwWeSK1VLrBGcRURlLs3vJi9FuHSrgC3dN5c5r0gbJt1LDut9iXLMnQ93BYAbYT3q8zguE6V0cIfhP9fv/ffc23YfQ9nurACN91KE7zO6CjJst9vQjC0hBRHIKtFJp1qppAaC3tcW5FD2PNQt64dbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC9U6hzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A1C4CEE4;
	Mon,  5 May 2025 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483705;
	bh=SRz7NrtbWRELW/vyaOiWjOpUbQSA/Zt18eZ8QCFRCD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC9U6hzJU6fISvT8eWJSxXjTqr3YcAwuiFqQe0aofkyHWZkbBO3Hnt/29i8YdJqZf
	 VAkPA+sMZjvMa7AdwqJ6fLNPfxC8eaozpHxslB31XZx3gUCdadzuCwEuor/Qgfj55I
	 duBYLMjoIhfBvCxoB1oByi88dU18xu15Fy/mmcR1E4is/QpCLeVeais/7jyacUHVCe
	 W5peC61hUvmTaLj19AcRtTimnaIgeoebB2Rqrn39SeI0UPVmFitS9tysZvxxOxpcqy
	 l0i3J8l99X3o1uPSdpjICPm63qoIUGt23JU9d/jMnp05DMPvnJqfE+ICisBPSIN4Pg
	 Hkg5TX//qAeiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 188/642] wifi: mac80211: fix warning on disconnect during failed ML reconf
Date: Mon,  5 May 2025 18:06:44 -0400
Message-Id: <20250505221419.2672473-188-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 0e104aa3676d020f6c442cd7fbaeb72adaaab6fc ]

If multi-link reconfiguration fails, we can disconnect with a local link
already allocated but the BSS entry not assigned yet, which leads to a
warning in cfg80211. Add a check to avoid the warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.699bd9cbabe5.I599d5ff69092a65e916e2acd25137ae9df8debe8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ca8f682a8db73..ad90803d17cd1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4298,7 +4298,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			struct ieee80211_link_data *link;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-			if (!link)
+			if (!link || !link->conf->bss)
 				continue;
 			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
 			link->conf->bss = NULL;
-- 
2.39.5


