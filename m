Return-Path: <linux-wireless+bounces-31938-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEIIO4tXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31938-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528114BA7A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2E0430387FB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0972F3358C4;
	Tue, 17 Feb 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xcdmn/7h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAB33508F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329398; cv=none; b=pvq6wyGwKP8vxh0g9Gveoo8JGpS6DTR5TQ0fOdlaaLZlKwoX1/W0zoGV30D7A8GWNWnqZa3t/0m8n2xyrr1bSXboKxvJReO01rwGeFDstc1Nz407JSBoD0YzmNw/YUwB/XV5E3iF7v/intb9rGGZLMzTLskVynH0DptyeTSK6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329398; c=relaxed/simple;
	bh=ipfSXeXk+s0MH/s/viVQdzrTBN3RsrzjB5ZONf0Q10M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnmnhWSdMiRkaaJkWvZb0JuULC/D1RwKeCqNNIv7kjB1Dnc92JUJTAtG0/qMiGkUlRGdSKUvOp3wtm1CMe6MCeWBUXTWmKAxlsdGHjmBoqMe2qMqxMS803D3845xmCMOy1Y0RKJyNBHrUm1OJbCjSpy/qQ1faHBxKCuHzqPvGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xcdmn/7h; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329398; x=1802865398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipfSXeXk+s0MH/s/viVQdzrTBN3RsrzjB5ZONf0Q10M=;
  b=Xcdmn/7h/omsis7WXOhSH4xI4IawdgvUpp8O6+JwgQKhbQMg1VnSMKRu
   uTTf8+QhSaRVriZyBVRnoxWZ189XYrjhRm1p4Jc9LeErmISiGbNh8fqAc
   Mf1RqKUR8qLXWNTWA+Fa47Sv9TE/6q2cEZ7aEC2jTsP4deMQDa6PTo9Ll
   fECHuEOCYk+3B8z5ZDa1I/2pJKyYEN2jffKyBmdBSnL9IYuYkBmxLz4WB
   qPPCalc9vbieTncBmtgCipto/3+Hqt+Xdl+0eX44ukImvPmbepXgmfjE6
   +0L8brmwO7s1NDlPFQWm8pyR0kSrUTbGN68W6oylzEbCUXarUjE+7fpvu
   g==;
X-CSE-ConnectionGUID: RXykw0u7Qj2Eg3CXLUf2iQ==
X-CSE-MsgGUID: HzKjCEwTQ7+x2eXSHUXsvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495869"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495869"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:38 -0800
X-CSE-ConnectionGUID: 87yr+FIOQrK4NDQ5a9Y/mQ==
X-CSE-MsgGUID: IsBZkh/zTbyP6myq+X+e0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547131"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 07/15] wifi: cfg80211: make sure NAN chandefs are valid
Date: Tue, 17 Feb 2026 13:56:10 +0200
Message-Id: <20260217115618.2066972-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31938-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7528114BA7A
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


