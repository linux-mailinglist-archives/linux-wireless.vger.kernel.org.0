Return-Path: <linux-wireless+bounces-7311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A268BF122
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C692824D4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8E13C9C1;
	Tue,  7 May 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmLn4tPP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F613C9BC;
	Tue,  7 May 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122910; cv=none; b=Wd3roCJBh/zKbb6sxQYvqaRvSbU98uUIYTsTrjnMe5TWGIHdHv7DD0MvRCJG+UyuV1Yis5HCSys6E9A0+A70derLIsb1nZuNBkJ+Z8LXilBkHqYdmqBIrQbVWFgJ9YCNI8+bf+Feehp5X16Cj89HyM+MYdvMiSwEQ4d8cyAyr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122910; c=relaxed/simple;
	bh=YwpnpQQBUXk7BcHjciofuCpHkgngeGd/9grXi2Rmq34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZHOX3czCERkgWlpUD9kyPqpGHsJ1LSvGSeU1D0C+w74zs/FRBq4qcp2kw40cg3LplSO9YTNPpTnepyvIcDt2XNOnJCsqK1tr7XdM+dw9LoqQOx1WL6F00kvR/A0aw7OWQYZuJYAX7ARzdFpyWxN3o2NsrBueUxoswFvn+Icl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmLn4tPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D4C2BBFC;
	Tue,  7 May 2024 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122909;
	bh=YwpnpQQBUXk7BcHjciofuCpHkgngeGd/9grXi2Rmq34=;
	h=From:To:Cc:Subject:Date:From;
	b=tmLn4tPPTT8/WFLOEvuVRNLj65mBo6CqMKNRMPMKrSuRIT1jjp+OGFWpLAegrUw7O
	 G+u1fhn3ufIRfISbMJ9xmtbgoEcy0dYDsV0NAFvEOJS8zLMhWFVwhH1Xixh5Ci6Xj8
	 wiFgYOyMVF4TykZoctqRLv7aH/7ArCjZyKKW/ZWR6zjWk8aqkp4bA0CU4I9nVVeKlG
	 oU2L2U5H5iH+HlPRlNQ+a3cYp9dbTE8k3PFjWeAZqEwHA9L42qQfQ9xv45Gplfx6Pd
	 NOE0GClN9E1eIvNp5oxJ6WlxE6+WrYgLDvxwm+LY2yj8n6/+t2KuEDF7Av5lOCOFHy
	 64F66mwD0xcMQ==
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
Subject: [PATCH AUTOSEL 5.4 1/3] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 19:01:41 -0400
Message-ID: <20240507230146.391926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
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
index 8677d7ab7d692..5d2cf58fec126 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1630,7 +1630,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1647,7 +1647,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


