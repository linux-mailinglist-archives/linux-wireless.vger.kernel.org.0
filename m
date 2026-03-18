Return-Path: <linux-wireless+bounces-33385-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLMlFImdummHZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33385-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:41:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA02BBAAC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B8773033BCA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86A73CAE72;
	Wed, 18 Mar 2026 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjwsGWjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F573D6CB4
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837582; cv=none; b=uPxRDjK01HT4+R+I2yqIIumfn+G75WVIVdfr76R4kChDLzysIbsUNfb/92O6T1gnudDNJCqxVARGJBa72OlujrQ4V+RTu6WHvSgfCxHtg0BhNI07mOJ0/WU5D2h5br0PX0V9UlbaEamuuLuLEDhkOtsTDN5W6CZx3OCAgQo8CJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837582; c=relaxed/simple;
	bh=QMfBDJZsMifUs0lsimvwGHFVu6upJVgqJrcrPcrn1xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRhvZ3nWZDOyf6DKfZ5+BKt8dy0AbXB4PQdsr789RVwVgML3/RWcNn+pDfgm3uHzjC30sxbg5AUcpygaUT5Vy6E6yfW4ZtXBKfeStvljVrMdk9dJ6IHzBJ55zt9Kvo91OHmg7/yaboW68mSYmR1RV08e2FyYOl75edhr2Qo8JHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjwsGWjw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837580; x=1805373580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QMfBDJZsMifUs0lsimvwGHFVu6upJVgqJrcrPcrn1xo=;
  b=fjwsGWjw6lN0N3/3WbUmfBJtAO9V++rO8eNICGTJxAVVljXvmr0yk0Dx
   4dCXaqIFMCb3UWdO0LljPg/S+WvHe0b9FhRxSBrYtWOZ7GXm22N0ynIRW
   AMOZMSGcYlichF9MPkhfT2iM/3ii2H3oLdaWINr8sl/WKMJP4CuG3KSUU
   LA+FxlexSj4fvytXwO9v2Ibr3c/T2Z+vVtkYPqeMdApXs/BlONsx3eVx9
   txXdtMo3f/9fpPXW9N7VkAx9ablUsbpztWmp6HMwvbXMnkQOvd6ERFW9S
   LCwtq8K1xsekhVlh3hErzDAqszYYoLdszzq+yLCdlWiEzjdeuaq0HTEiX
   A==;
X-CSE-ConnectionGUID: 38dTd3RST5yVk2d5PsnAvQ==
X-CSE-MsgGUID: 9E+LEhH0RnKzyexhsqbWNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519263"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519263"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:40 -0700
X-CSE-ConnectionGUID: Oa1UtOzHST2SoH708ru5ew==
X-CSE-MsgGUID: cXA4EIOMToG91og1mrB5hw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 02/12] wifi: cfg80211: make sure NAN chandefs are valid
Date: Wed, 18 Mar 2026 14:39:16 +0200
Message-Id: <20260318123926.206536-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33385-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 47EA02BBAAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Until now there was not handling for NAN in reg_wdev_chan_valid.
Now as this wdev might use chandefs, check the validity of those.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260108102921.51b42ffc9a42.Iacb030fc17027afb55707ca1d6dc146631d55767@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260219094725.3846371-4-miriam.rachel.korenblit@intel.com
---
 net/wireless/reg.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 20bba7e491c5..4b5450aec72e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2348,6 +2348,18 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
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
 
@@ -2397,9 +2409,6 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
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


