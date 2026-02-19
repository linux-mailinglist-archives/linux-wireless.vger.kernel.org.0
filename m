Return-Path: <linux-wireless+bounces-32017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJhSE5jclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F0A15D84B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B394430602DD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A63191BB;
	Thu, 19 Feb 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5YHDYRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252B2ECE91
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494466; cv=none; b=dL7/0AU3SB84QdlJggCaioIJ/bFhnAby2hNqIyMRre6CblMRGfL7UZjsSwo8sBQQXA/b6Az6dsLoR6tXrqR5owAYDmdvhCcO1fiqqp7fzMJNDizlN289YkJS9nXEX/qBe1a/DaHenLXMKtXKGMWHN1LrixrMm5y4EvmLkZZ4V0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494466; c=relaxed/simple;
	bh=ipfSXeXk+s0MH/s/viVQdzrTBN3RsrzjB5ZONf0Q10M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXKeHJxONrFHegfoyLRigiA17G9g3HMPFUILA6HP+3XKgNmLSIh1Agy6YL8I2adGGFcp7DugvOH5sOED0gBSj7N+d6B8v3MXDvnAdSC3X0+LEfAybvsmLLjjYRUIHfIaDIstThIIndabP6yOrqMlD11OEfC61Te7wGR3k1u30L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5YHDYRk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494466; x=1803030466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipfSXeXk+s0MH/s/viVQdzrTBN3RsrzjB5ZONf0Q10M=;
  b=m5YHDYRkssDm4494N2PlGCXtNYtvu26A7VheLlItfp//i7SU8jl7ssBy
   fi5oteFRb614lOi4usILo11tCxlnENmSZ0vp3jCqiqVeQMKU1elqD7dDD
   WHxJfW6bMtGcKgY81PW8yzfmQIVxcxycCLgKifY9CFv9lqe8W4ad1yMtE
   m9JID949+VRVxqLWy1VpUBj03ORtCja/yEUUzYNGfta2nFedY+S4ejLly
   LvQifpdxqCihzRQuqtLJHWd4yXDjg4PWIIwgW5EJslBX2SQVGtYenMXtV
   i6iNKU3L1KSO2WISThhyFqoPOK+2zUUZ38xCeAFz0k73eIs2BtyQYKjtD
   A==;
X-CSE-ConnectionGUID: 2U49uC/ESCGYXTZxMNpfWw==
X-CSE-MsgGUID: 7KIAI79fS4adzwnUK+LFKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680092"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:46 -0800
X-CSE-ConnectionGUID: RtFaGtSTTvGfTXGh4GwTfA==
X-CSE-MsgGUID: /T/tOvtQQlWZeBN/3iA7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989013"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 07/15] wifi: cfg80211: make sure NAN chandefs are valid
Date: Thu, 19 Feb 2026 11:47:17 +0200
Message-Id: <20260219094725.3846371-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32017-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: A6F0A15D84B
X-Rspamd-Action: no action

Until now there was not handling for NAN in reg_wdev_chan_valid.
Now as this wdev might use chandefs, check the validity of those.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260108102921.51b42ffc9a42.Iacb030fc17027afb55707ca1d6dc146631d55767@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/reg.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 139cb27e5a81..43c5193a6ed9 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2361,6 +2361,18 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	if (!wdev->netdev || !netif_running(wdev->netdev))
 		return true;
 
+	/* NAN doesn't have links, handle it separately */
+	if (iftype == NL80211_IFTYPE_NAN) {
+		for (int i = 0; i < wdev->u.nan.n_channels; i++) {
+			ret = cfg80211_reg_can_beacon(wiphy,
+						      &wdev->u.nan.chandefs[i],
+						      NL80211_IFTYPE_NAN);
+			if (!ret)
+				return false;
+		}
+		return true;
+	}
+
 	for (link = 0; link < ARRAY_SIZE(wdev->links); link++) {
 		struct ieee80211_channel *chan;
 
@@ -2410,9 +2422,6 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
-		case NL80211_IFTYPE_NAN:
-			/* we have no info, but NAN is also pretty universal */
-			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
-- 
2.34.1


