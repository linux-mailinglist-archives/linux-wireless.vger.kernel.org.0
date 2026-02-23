Return-Path: <linux-wireless+bounces-32125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHHtEsnRnGlLKwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:16:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52117E221
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1BD31F18D3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891D37AA74;
	Mon, 23 Feb 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxCyI3oZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365537E303
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884171; cv=none; b=Fdrw+RAH7dokV1tCZcq9Jv2/B6gd6G+LcONpqljphQv5+WORjAQARJx5rdSQVN8Ys5OQANuswksHBhWw+RF9pwVxlRSVO9dkwOSaaFtgkQJHf7NbdSNYy0W2MVbvrLSLcUbDxjK1ctwkqb0f7ckCh+fhD2Wimosih2J8kuwDVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884171; c=relaxed/simple;
	bh=bc05mw0i7gs472XuGzp1/FEhAgd/dPBBMguKFi86Jfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKjILK+6iomK+w6s4Fw1rtakahkj9YwTibCvXazf+/XSWn8HrZXw5XvTsnSOSqZ9B4kQZ7Ev72DrqpEidxZsIMzFv3pBi6C5iRJPyiWBjW2iWOQL5f5Rb7cQMWTvSf/EHnGVNZqERfUTG5KJ+FtJ9L7f7ylhSMOJY15FkMYgYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxCyI3oZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on9JfmNlKlenkFNVsBtq1GjslYxyN91VrFDl2aDiUNA=;
	b=PxCyI3oZPlz8offAVGjLfyeMrkhjh/9w6nHjpG671nfxGDBs08hU+VyJ9Wk2D3liWoKewF
	Baxsp11KnrGif2BQROFED9yG2p3/WtgyBCUVVMx3XPxlNGyWOAcB0PxsiIlN8fqlj5ub8O
	VDOANq+UCpKT53i3MSTVI8rHCnMDOco=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 24/62] net/cw1200: Fix locking in error paths
Date: Mon, 23 Feb 2026 14:00:24 -0800
Message-ID: <20260223220102.2158611-25-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32125-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bart.vanassche@linux.dev,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeaurora.org:email,acm.org:email,sipsolutions.net:email]
X-Rspamd-Queue-Id: EA52117E221
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

cw1200_wow_suspend() must only return with priv->conf_mutex locked if it
returns zero. This mutex must be unlocked if an error is returned. Add
mutex_unlock() calls to the error paths from which that call is missing.
This has been detected by the Clang thread-safety analyzer.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/wireless/st/cw1200/pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/st/cw1200/pm.c b/drivers/net/wireless/st/cw1200/pm.c
index 120f0379f81d..84eb15d729c7 100644
--- a/drivers/net/wireless/st/cw1200/pm.c
+++ b/drivers/net/wireless/st/cw1200/pm.c
@@ -264,12 +264,14 @@ int cw1200_wow_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 		wiphy_err(priv->hw->wiphy,
 			  "PM request failed: %d. WoW is disabled.\n", ret);
 		cw1200_wow_resume(hw);
+		mutex_unlock(&priv->conf_mutex);
 		return -EBUSY;
 	}
 
 	/* Force resume if event is coming from the device. */
 	if (atomic_read(&priv->bh_rx)) {
 		cw1200_wow_resume(hw);
+		mutex_unlock(&priv->conf_mutex);
 		return -EAGAIN;
 	}
 

