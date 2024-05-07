Return-Path: <linux-wireless+bounces-7312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1028BF12E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99C71F2222D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0712AAF9;
	Tue,  7 May 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQL7O/oS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF881205;
	Tue,  7 May 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122922; cv=none; b=VA7J8PiUvqa0wbnpVJ2GNpKyhHIPumF2ec6NCMdzOqVF2/4nXNGLGS3o4o2l7IpMPUwQj75emP2ZsXi3InwxZbLVufRwQaZna1ooWp3qOWGloOx7pwsk5TvqzvN7jzF8LShV2Py/HRAqLWQLeTP6JIRoJZyr8lwqXdnFvxrxYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122922; c=relaxed/simple;
	bh=fr8H+7F/SOuz60ZDoNwcnUe+qkYwjSIJBBYn3IJQwao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lykvIBMI7mIhMsp9Li+63H/C4TCLYufDukGNBbLbxmvuz2/8k6Y8rBb0Ij08CXmEPv9cY2bqPiEVfe+mtaAq7xE8KtyCZgXubN6qS0AAxXh+A4AwQ1BIPQcn1Js8IJ8d6NB2UnJXWRBy48vtogAb5zfzdK/hG/ca9MTAI3q769A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQL7O/oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF330C2BBFC;
	Tue,  7 May 2024 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122922;
	bh=fr8H+7F/SOuz60ZDoNwcnUe+qkYwjSIJBBYn3IJQwao=;
	h=From:To:Cc:Subject:Date:From;
	b=BQL7O/oS+IamjWP2EbJFiDuqQQ73vHou8jGH36iQZ/bLj50a/hpyiKbtHcCQy4hgq
	 C8FbaD11e+TX1T1qsVXlTkD8X358fPz78FMyerUUUj49eO9M+KPhPV9fznQa03/I9x
	 Q4lTj4lzNZ+uShHL15PlVpxUlFCrgAj8S9VIpzBQvuKEPEfE9408agV3CwjsJt05S8
	 +m9wk/oTL1Zx1IWCovAkIBJVQ9bKyKD+9aXi+l+t/6/BdmQdEmWKwnhRK7niXtriJT
	 Xx57l1IZNqEB7IEQsLtbW6/Gp1bblNhX62P+MPONTyEEpDkYJwiHoykL4sz2tFLWOm
	 jl879qMyFVjHw==
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
Subject: [PATCH AUTOSEL 4.19 1/3] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 19:01:54 -0400
Message-ID: <20240507230159.392002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
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
index 54b0bb344cf93..68d547a4a5a53 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1591,7 +1591,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1608,7 +1608,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


