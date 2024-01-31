Return-Path: <linux-wireless+bounces-2889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D34844361
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB2B25F00
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE5129A8E;
	Wed, 31 Jan 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wLa2C/ri"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944101292FD
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716148; cv=none; b=uD7KpRK0C+25pcPZ8dhGgYq7htoVT2cDGdjBMFEmRbvuLKW3hQUh7qMIVZ3SIHi1Rup5GbEJ91KqE0ZttdVLFWi8NFd4I+zc5rOwS5an8Ns5ZmOSBJn30dTxhYpiSmfYEg19EN8rfBV1DM89n8ATD2aLk0RlOPaIG4AKp0A0L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716148; c=relaxed/simple;
	bh=Nk/Qqn0NGXcQr9/zVaqv8TH8phnYaLE8obPdL6q1glU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUQ/huMcghizClRaJKX6Y7YQk0nyDpL7N+hCgh8t0o/x2UBgRU38knwpbMpOGWQv0+P7gywhPFF7HEhya1BXixrNaPaEJxJcLoIz2s0cvmR/ppUN9hHc+lRWGdfEMuq23JsfW+10Os11J6WjrQjYvpzzEfkXlm5GJV1FezhUVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wLa2C/ri; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Voxl96dFgNyUuFbAafrUG4XxixnaLGrtz8TT51bpzFg=; t=1706716145; x=1707925745; 
	b=wLa2C/rimamREHFGroUblzp2YFrdiwA/zfgmJ6v6CyMeO1YmcOVapWgllx4zcCFdxkqZVD/V56H
	EAlmD8XSaJF9Q56uOHjasaapsoCKVvToHrdDTNC/6j8O0M4pn6OREkTkSnwI4Ifdwqe0r9LY0i6r+
	ufCa10r0fs3BAYNIrjbo9Z1nVrwu4u6XgSxr4FW3ioWLtb19F1+/H/TR3VsKniHoGdcfacGJv/bAZ
	JFL9BgY5dkRWlEM7IKchcJvpgFKlJkqgCNoN0H9vKf3hyTWmg8QhMu47PceOIRVrIN/SkRdN/y5PQ
	IHew6MGuNdW9ybpN4oiJPv+pa60YyLvtVkeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVCpi-00000007JBm-0kly;
	Wed, 31 Jan 2024 16:49:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix waiting for beacons logic
Date: Wed, 31 Jan 2024 16:48:56 +0100
Message-ID: <20240131164856.922701229546.I239b379e7cee04608e73c016b737a5245e5b23dd@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should be waiting if we don't have a beacon yet,
but somehow I managed to invert the logic. Fix that.

Fixes: 74e1309acedc ("wifi: mac80211: mlme: look up beacon elems only if needed")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0349e0ded1d8..dd97f402a624 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8372,8 +8372,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		rcu_read_lock();
 		beacon_ies = rcu_dereference(req->bss->beacon_ies);
-
-		if (beacon_ies) {
+		if (!beacon_ies) {
 			/*
 			 * Wait up to one beacon interval ...
 			 * should this be more if we miss one?
-- 
2.43.0


