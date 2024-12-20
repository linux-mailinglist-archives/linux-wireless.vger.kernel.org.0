Return-Path: <linux-wireless+bounces-16653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E249F97D4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2177161182
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7422B8B1;
	Fri, 20 Dec 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbvkIpur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682F22B8AC;
	Fri, 20 Dec 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714765; cv=none; b=n3cH9doeQ6IzTAscKBfVFinyAhFwIMP3h28O11Yt9g5NEHfQb7f/FYmEO+q1OM2kzWzxI7ma68V/QE4yX4bJW5CinW83XofM0ehlHiKnsDiccBcIN4DyGNQzGDhnCapafKZVBnoTXsb/XvMkv3nOmkFsgFHG+JNa9JxAj0Vxa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714765; c=relaxed/simple;
	bh=/UuesnvhJ8Sr/lox6eMNdNSo6ks3KKddWe5WqC3FOt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KM36ExIMWuOVNO+ffT3zn7h538SUlvgpWXdMEr3w0eHAzCZwcUxp8JDiRZDibvGmz3E/zTtkRYvXTy2aA+sXPxC5ce4QEWJUaNu+ckvCZ6fxUdwsTxvWuaypHDpymWg8fmSuH4EHP1zTcJA+hfraOgSYu7UmeobMCVnzz+rhG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbvkIpur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E61C4CED3;
	Fri, 20 Dec 2024 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714764;
	bh=/UuesnvhJ8Sr/lox6eMNdNSo6ks3KKddWe5WqC3FOt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbvkIpur66HA3NoTXCyM0KDTIaIzPiTd99mth17xKtGSjpmEZRM4Gh5EKYHn8IWvi
	 uPIO2MTl79B6LwefZZJYBBl80zWIycxFE19MJSpbZdc61iXr6SjMjpEgNUUQwNL/sX
	 DYqtbvoX86w565Phb68gGJctQ6WTTqbiJRps1GpmBCmjmE4kDVs7tdL6N5VFuH/0ON
	 wAhmRl0WAjXFsR8DXKEzWZS81aG88blVttTLUjw9GrfRNEmJRcoXilYrVUBbONKPfr
	 Njz12URhoO5aEBqpLi4EiIQr/R6snF4nurAZdbfyqs2x7TKLHL/o5vCZF42QXI2U3/
	 z1rf6BDKfgbDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/16] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:12:26 -0500
Message-Id: <20241220171240.511904-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 220bf000530f9b1114fa2a1022a871c7ce8a0b38 ]

In case we fail to resume, we'll WARN with
"Hardware became unavailable during restart." and we'll wait until user
space does something. It'll typically bring the interface down and up to
recover. This won't work though because the queues are still stopped on
IEEE80211_QUEUE_STOP_REASON_SUSPEND reason.
Make sure we clear that reason so that we give a chance to the recovery
to succeed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219447
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241119173108.cd628f560f97.I76a15fdb92de450e5329940125f3c58916be3942@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d682c32821a1..5617f9e32b6b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2572,6 +2572,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
 		else
 			WARN(1, "Hardware became unavailable during restart.\n");
+		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
+						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
+						false);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
-- 
2.39.5


