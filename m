Return-Path: <linux-wireless+bounces-14557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961849B0F91
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B51F23512
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7C20EA5E;
	Fri, 25 Oct 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DloZL5F+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EB20BB2E;
	Fri, 25 Oct 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887021; cv=none; b=i562an/IScnmrB9NBxk/EwwIupOFcwrIKMn+wStaNLyzwx2zAwnbaXar7t7YXhr9vwnv01aADdsaGLRpkMK8RBzqvGx+zHZstHKZ9+ywPsEnkTESP7vTet+8xtCXy1lK0UX8EyyWY675Xate/DrYdtgNpfSk8CYSEAZ0G5hvPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887021; c=relaxed/simple;
	bh=62nxMjq1P47AEcgko0Io2GSOu6idmh2E353oi9xM8K0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qUQDtPDemPnnm9HizB2bbiSw/wWB/uDFGqyNUJkLwgnT3ecgsF3jFrbUd/trCWgIHUev73vbpZDFJWgQ5fcsbasdup/Vr8WWmqi1aZLnmj8FGB4U3X6JFX9c8xysjNwKgcg8afsZR+hPTERLaNiCXqSQ2TJYr3L/wZqmfjrwbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DloZL5F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705BFC4CEC3;
	Fri, 25 Oct 2024 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729887021;
	bh=62nxMjq1P47AEcgko0Io2GSOu6idmh2E353oi9xM8K0=;
	h=Date:From:To:Cc:Subject:From;
	b=DloZL5F+Wicx/HZARaswPjKR2NkAx6q8XGPqivSS2h8wCng1XLqbRm1WssD+pZk+9
	 q00UO9rrSvlCkX91Lcj3ZBO0cQRmXbejgg3V9DM1i+R3SaenSQlX4dd2EaHUba+RTP
	 I5bb9f0luVuPxpbG0yw+43p8njcHAG8jaDwph+3Z24RQfwsIZKKAzIxw8FspMBg5jv
	 JNjdU8Xinx6VTH1ldDPjdshN9sA98+ylNCvOzCdjfWkA72msypn83ZqNgJtLhwZSQ0
	 2TV3GpaBU4ogtRVullOjZo962NgBXmi/WDAnapE1hUvVWbd6qmjBewWxTtklYIeEbd
	 El38Rm1VhER0w==
Date: Fri, 25 Oct 2024 14:10:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <Zxv7KtPEy1kvnTPM@kspp>
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

Move the conflicting declaration to the end of the structure and add
a code comment. Notice that `struct ieee80211_chanctx_conf` is a
flexible structure --a structure that contains a flexible-array member.

Fix 50 of the following warnings:

net/mac80211/ieee80211_i.h:895:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/mac80211/ieee80211_i.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7815ffeaf30..c65adbdf2166 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -892,9 +892,10 @@ struct ieee80211_chanctx {
 	/* temporary data for search algorithm etc. */
 	struct ieee80211_chan_req req;
 
-	struct ieee80211_chanctx_conf conf;
-
 	bool radar_detected;
+
+	/* MUST be last - ends in a flexible-array member. */
+	struct ieee80211_chanctx_conf conf;
 };
 
 struct mac80211_qos_map {
-- 
2.34.1


