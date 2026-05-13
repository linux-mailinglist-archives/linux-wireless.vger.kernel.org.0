Return-Path: <linux-wireless+bounces-36388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIgMLTSdBGr3LwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 17:48:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8E53671B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 400E83013EF9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8238D3E4;
	Wed, 13 May 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9pdqBR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B440B6C5
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686034; cv=none; b=BxlvIKklccFF6KIC+z3PF1DKzOL9542EhspNKzjVK/F2gLaNYKG9nT5Rqint9Sh+q6M3bGOUa6oRpaN7AfYCsydDhLW+OqQwQ3E+hGl64sAVtGv3VEy5JggFepKxi4aManwpR3or9qwwPvq0/n26GdvxJbAwrv+/kHbDpwC1q0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686034; c=relaxed/simple;
	bh=Kk76HFcwFNIDtzPxH2/h3k9TiI68XiaWNbmm/qnytto=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LGH092x2VwIDaWJYO6Gn6tqostaAXY+WTos77g2/vNrIA6+4Ng2eZNlEkZiM140kdtIl+vwa+3K5dVKVDZiRYI5LnfaXeFcMfAAjpgSo0zRYycyV5WaNVT/G/luP2v7pTgsRmaBsKsxMdj6dIOZy6yLrfJnQwSI6Mjx4EcphOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9pdqBR3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778686032; x=1810222032;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kk76HFcwFNIDtzPxH2/h3k9TiI68XiaWNbmm/qnytto=;
  b=F9pdqBR3M1gnDoDHc/i3dQAGBv8n1pIP1lWy+uAmYO5ZzCTMmLiaMz1N
   wuNJ1g21wAK32al1aZO79PkIyN7fBvXOG9R10fCGJUyOEiaRDB0OoygcV
   hWMmfeAxw5Z872CNCXXOT0rfO4syCJu8R1UpWgSbyYdMAY+8IooFR+XO+
   ChYel3fcxlyPRsH3ZWJA0iUitDTT8es8H+E6+ETRizFYdGkUvaLhxWLgK
   75Q2CiPY/jlj0tny90bB3edgGuq+LsU/1zM5Y8NJxswGIpeyC/5H3PfT4
   R7CHNMipn0B1eXuxu34r+rnOC2hIBj+sgkCNE6Nblwqi5WvyknXgdEvy7
   A==;
X-CSE-ConnectionGUID: TOiM1EzUQbS8eEhlvNyNIg==
X-CSE-MsgGUID: l0RnB1ziSGKi8eWE+Q/pYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90719298"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90719298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:27:12 -0700
X-CSE-ConnectionGUID: L0zcZa/ZQhyP77RcqIFgSQ==
X-CSE-MsgGUID: 5i6WOkx5Sqa+mcUomKBGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="276218872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:27:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed
Date: Wed, 13 May 2026 18:26:56 +0300
Message-Id: <20260513182548.6a25f3a0a6ec.I83d1f2a7eed20200a78a62757c6b193e3bab892b@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CA8E53671B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36388-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In case reconfiguration of NAN fails, we call
ieee80211_handle_reconfig_failure, that marks all interfaces as not in
the driver.
Then, at the error path of the reconfig, cfg80211_shutdown_all_interfaces
is called to destroy all the interfaces.

If we have any other interface but the NAN one, for example a BSS
station, then when its state (links, stations) will be removed, we
won't tell the driver about this, because we will think that the
interfaces are not in the driver, and then drivers might remain with
dangling pointers to objects like stations and links (at least for
iwlwifi this is the case).

ieee80211_handle_reconfig_failure is meant to be called after we cleaned
up the state in the driver, there is no reason to call it for NAN
reconfiguration failure.

Fix the code to just warn in such a case, as we do in other error paths
in reconfig where it is too complicated to rewind.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2529b01e2cd5..dd2ba0fa0331 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2200,11 +2200,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			}
 			break;
 		case NL80211_IFTYPE_NAN:
-			res = ieee80211_reconfig_nan(sdata);
-			if (res < 0) {
-				ieee80211_handle_reconfig_failure(local);
-				return res;
-			}
+			WARN_ON(ieee80211_reconfig_nan(sdata));
 			break;
 		case NL80211_IFTYPE_NAN_DATA:
 		case NL80211_IFTYPE_AP_VLAN:
-- 
2.34.1


