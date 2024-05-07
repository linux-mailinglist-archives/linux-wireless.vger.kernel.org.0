Return-Path: <linux-wireless+bounces-7302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A068BF014
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFA2824B7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2779B8E;
	Tue,  7 May 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtMWdllR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184238248D;
	Tue,  7 May 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122656; cv=none; b=GgXF8nFnCUQYl7lFca6nMjnX2trNEsvH1tjZoN9+ra7S8u3nzg6NP4iRbJk3qhyC4IRLIlr62pKgEYbUfv69iIjfcYH+q2ouNqTCMgLRUJ5CU3Y+6wqdfC12zKWjFlBINqoa7anTeZJbjO44ZhjEiXDRNcD07+vkZlWj+UMkGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122656; c=relaxed/simple;
	bh=MFDIxyrj2O52D2KjEO2iKcVJp7Hkty/SGnMIhwLGNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbgQeTMIlqbHVPcWOZyOsuq7CNy7zTgKFSEV/9nYktr3uR1kqjOJp5WTpUpvqiY5uPhrA0H++AxFPoroGYeT/2MqoWJL9Kv9o5GBE92Mv94XDJL5my34xdfpILzp4qMsZLcE7rwx+8RXI41dCRW/f0ctrwGlr1guSxaShfAuxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtMWdllR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48861C3277B;
	Tue,  7 May 2024 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122655;
	bh=MFDIxyrj2O52D2KjEO2iKcVJp7Hkty/SGnMIhwLGNMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtMWdllRVfK7564Q1uGBh6O0Rb6Ed3ECho1nT3aGz6WB+7aAJimSRXUBEZ3fROX41
	 HBAyanLwy93FOUAPsBVVBa3rsyuh8A5YSMMExiB2fp7XrMRmUFsR9znIIXtYfSW69j
	 6FWBzrXK4TW3HS44lUtL08KBpddHofxR5rZ4X9eaaKa/L68w8G+E/6PUv6GqxYavpj
	 8gE/DphpkTV4uR3r3gQUppoMgk1c5jZ4ekAOqICzW0jwdTuvVqaV7EUd02ajQqkLTJ
	 NLyfoWphYEKjTPEObhC5WzRGh+TWcFEzjAdrfjcaquHCzvPZ4BgxG1kp4a5BL71wzF
	 weGB2P6eMJDmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 05/23] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 18:56:31 -0400
Message-ID: <20240507225725.390306-5-sashal@kernel.org>
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

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit 9ef369973cd2c97cce3388d2c0c7e3c056656e8a ]

The declarations of the tx_rx_evt class and the rdev_set_antenna event
use the wrong order of arguments in the TP_ARGS macro.

Fix the order of arguments in the TP_ARGS macro.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240405152431.270267-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a50..54303d6b7994e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1747,7 +1747,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1764,7 +1764,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


