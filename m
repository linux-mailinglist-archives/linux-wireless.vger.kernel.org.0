Return-Path: <linux-wireless+bounces-3115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C7849103
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6C1B221DA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0D41C72;
	Sun,  4 Feb 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo+p7G0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2441C65
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084422; cv=none; b=IGgNYxO30Qdsa5dcYASiceJPsAij2Qp0vsvry8+oJ+c5icEBmqbJtMQi0GDQxfx7/IpfLsHzCYh7lbPwbZTJwlBV24kxX7i9UYC+tARVv8Mk0An6nu/87CwsitLu5MVAfmYf/h2L7THi8WJ2SMo8DqIGRvhy18xSKLlunmd33pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084422; c=relaxed/simple;
	bh=Ki589CawWIJ7ko0US2P0pjudh7V65bHu/gWYZUBbYME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZAoSpIHv0a+O3n0SyySXqrCZAEginHVYnvMjojWOuQsrrpZlm4MZSIUgcTX/8986oMNsWY/oPt7f2NEh5UY/qWVQQdm9ly4kCLk0E98RRj+BT/JuYLh98CcFMZKETklxXo6QyEWWe/5UqzCK7QKOEWKUmUEW/w0tpQad7EQ8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo+p7G0d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084421; x=1738620421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ki589CawWIJ7ko0US2P0pjudh7V65bHu/gWYZUBbYME=;
  b=lo+p7G0dVlK3hqYmh4yTJw5YmeE9iWHuczAu2UnRYiQDVMXslI6YbkX7
   IJKDil9AQADOJ8Eg1ubwYyNXTf6rXo+qTruKDCAUzmY2ONiEutfIzzTB9
   HhDZCOgW/Su7bBwo8hBqrJ0E9PkEe+hjaFzJK5xXUkMhVl67Oxo7Ym+J8
   szbO1zNDO3ZuapUSgOh90kJ/wQ2Kjqx8xqIskGd5GrcNLIn+xFNcDUbc1
   eVwcQk3Hc3+IB+P/aMoLzfQ02EaKqfzhvHz5RdhtxEjoIgxlvkirC1ltP
   yAGzUxWwqPkswNCUQbejpa0LyWr43Anna/0LCVsHfxx3GMRIruZSro2Pv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869398"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815923"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: clear link_id in time_event
Date: Mon,  5 Feb 2024 00:06:16 +0200
Message-Id: <20240204235836.c64a6b3606c2.I35cdc08e8a3be282563163690f8ca3edb51a3854@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Before sending a SESSION PROTECTION cmd the driver checks if
the link_id indicated in the time event (and for which the cmd will be
sent) is valid and exists.
Clear the te_data::link_id when FW notifies that a session protection
ended, so the check will actually fail when it should.

Fixes: 135065837310 ("wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 60ec5ca6927c..be823c85c39d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -972,6 +972,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 	if (!le32_to_cpu(notif->status) || !le32_to_cpu(notif->start)) {
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
+		mvmvif->time_event_data.link_id = -1;
 		iwl_mvm_p2p_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
-- 
2.34.1


