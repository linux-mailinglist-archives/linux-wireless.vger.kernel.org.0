Return-Path: <linux-wireless+bounces-34662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA5+DSCM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C73E3BF6
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9B8D301E992
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654C37BE99;
	Sun, 12 Apr 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FX9cWVv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F037BE81
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995909; cv=none; b=IJ9AeRsDWpRxL12QFAPWww5pk/fBlIv1/zbxyMrHzbtKCoXB+C8x5LHEmdycmFMx+1/dzjw7Jki2SQ5nabLKNuPJ3olR/bRiLwcyEYHLdfawPnbchzhdQyh4fLfRKNIK7IoDZfQ7zA1txkWsTEWyT/TZMSSdlcaMKqPiOvDWmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995909; c=relaxed/simple;
	bh=miKmvEqEdUIzwoi1c0JPrxhyYgiVCwSSfrMU9+SOb7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=colGPWwH5O0XBrVz7jYrdljBNj6efV8aXyunzlUhkolVs8THG7lWzbpqGNK1vzteJ6CZ+SwY3+NBAvEwDFftpvlL9oZ4rrs/zm2/TFVUR6UYqNaOXrM+ZZphTO0cQkDSTFP7vjTmwd7PxqSYfJDueXlah7JFw+bxo+zNwUTD7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FX9cWVv5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995908; x=1807531908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miKmvEqEdUIzwoi1c0JPrxhyYgiVCwSSfrMU9+SOb7o=;
  b=FX9cWVv5hiCawRx2EIq53J7savGxnnCNjBtl0ylr38OqRVB9y/P/XM2u
   mBM1wAmJ8UUwv5+b7pkRmTeWbbSF18NMVeVNo1xLaMNfA9FSIHhkvdybG
   d6ZG4Wkn1WY23QjdGCPY8aSOevI1dq0SCOajQBqiaRUqVUKrVE5Htyern
   4rW3VzL9WqPRH/NQJmpa2XkroYBmAatYj3+707Q0Y0W6Ckd/s1tU++lSW
   7kXI09H5vTmK6GQ7+wIQDAgqtiGAbAZLAELrNqdqSr4cSArDkfZpEsuhH
   RMODpApP8lrkf0l1wXZSOGTOoa2LIbdwmw33eRFgGTMu8b8e8KtN9bu0a
   w==;
X-CSE-ConnectionGUID: 1ljiYl8HQmmDcmyeWq8ucQ==
X-CSE-MsgGUID: rGfsMeG2S32mdAGX5X+urA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028468"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028468"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:47 -0700
X-CSE-ConnectionGUID: xO1eKBioQWyxq/8WCiSjYg==
X-CSE-MsgGUID: j+dXDvFoS/iN6GE9h/JXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411915"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: mac80211_hwsim: remove unused nan_vif struct member
Date: Sun, 12 Apr 2026 15:11:17 +0300
Message-Id: <20260412150826.cb1f62e35ce6.I35d3eae582461af7ee25c63c56b13adff17cf20f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34662-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D58C73E3BF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

The struct also contains nan_device_vif and that is the member that is
being used.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1fcf5d0d2e13..7ab0765cb482 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -765,7 +765,6 @@ struct mac80211_hwsim_data {
 	enum nl80211_band nan_curr_dw_band;
 	struct hrtimer nan_timer;
 	bool notify_dw;
-	struct ieee80211_vif *nan_vif;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
-- 
2.34.1


