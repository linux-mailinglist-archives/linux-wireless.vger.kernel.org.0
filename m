Return-Path: <linux-wireless+bounces-27079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3BB48868
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F67A1121
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CE2F4A01;
	Mon,  8 Sep 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSrSgYHs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74F2F2910
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323695; cv=none; b=m4qnVpFhmOVDZtnZnCMmV+LJdtyDWEEDyQNf1zxprjHXadZjzVvwSLaZGDJ9VWvjtqcWtA25qxVDpRlljvcEztScYH/M6je5c8ZykbWKVtqpISLEkuv3xBECy/2mF9sUGEwnEf/4Uf0ImrUP3E4jEPA9s/XK4wOu1wnVPPc01Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323695; c=relaxed/simple;
	bh=7/mDnEE2zNSecRJ7NSoScXLbdCHDkTthMaZpduEQ9PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WkhPvqzi194lFUzMiJP4446ZOBDQvntlN4Jm9Zpv2siWunwUrUzcdSBaOOAofI07f2pBp0Yx2xfk/1VsKEsYI1d69az3aaBNiZVYTEdADJsJDc4S2DwFa36TTyLgP3K3U/8z1ozP442OwIajSqFT9SwXskATiU1j5Qddv/m4gAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSrSgYHs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757323695; x=1788859695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7/mDnEE2zNSecRJ7NSoScXLbdCHDkTthMaZpduEQ9PQ=;
  b=gSrSgYHsu/GIrJXNiH9RzGYdnNn+BclKS6LjkkOqNnWP4juScd+9a9Il
   OXQnPi8IILELmJMgpTz+6pVQPSUp27Hnc87lOoOLYCqwxXy5CaWLmzN/W
   /Oqzwx+0bsZol++fmscH1NONgMji6uli6ysEyuRB9aoILgIvNNHn2QM85
   XCkfkFZ69S3k/rhMs/Ra9zXqsjRaICPv1Vp0jwFYnVdMSCOMX6+mxW00/
   KxEIMTkVQWT5uZivTjbTJ5iby934QBhMrNusvcbqwpbzZm4vsFOdc/bB4
   fws6/ihFu6GmoiumeRHSLXMqXSBIRXaCDQZL5ZtcgSRZHGWNvf3kaukk2
   A==;
X-CSE-ConnectionGUID: 1UEgqiRwTg6o9iNjYStmKA==
X-CSE-MsgGUID: GDl2tLRcRHe/oDMDdpoGVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70674240"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70674240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:28:14 -0700
X-CSE-ConnectionGUID: SIQgN+VhQJSUNKDM2Pv5rQ==
X-CSE-MsgGUID: iLnGqOJbTSKMEnd3Al1AXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="196394609"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:28:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: fix incorrect comment
Date: Mon,  8 Sep 2025 12:27:45 +0300
Message-Id: <20250908122652.7022f33b1f33.Iac0d35744df883e8b96d71bbe8da518cc5d514bf@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

As opposed to what the comment says, we don't count in the skb size of
the association request frame the length of the Per STA Profile of the
association link. Fix the comment.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f73e3222981b..43a53da42e52 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2183,11 +2183,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 			2 + /* ext capa & op */
 			2; /* EML capa */
 
-		/*
-		 * The capability elements were already considered above;
-		 * note this over-estimates a bit because there's no
-		 * STA profile for the assoc link.
-		 */
+		/* The capability elements were already considered above */
 		size += (n_links - 1) *
 			(1 + 1 + /* subelement ID/length */
 			 2 + /* STA control */
-- 
2.34.1


