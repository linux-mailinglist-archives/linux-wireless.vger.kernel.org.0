Return-Path: <linux-wireless+bounces-25207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CAEB00B5D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A33A9A4A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36D2FCFD1;
	Thu, 10 Jul 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixhU7pN8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD32FCE2F
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172139; cv=none; b=BirifYXC5ext6/1JzQkfTfK3XjjAzb3tLRgr1BKXAcGQZt+F2g26OxLBK/nWb1Z0rCbIqf7Oqh9gon0BsjU/wlWc7zWK6Xka6VZfkLmIoS7+ENdUcWL285adt39CgjrIMFsIwNW/iz9QW1m3S/JVml1d9q7ats+cklpP417/M+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172139; c=relaxed/simple;
	bh=jfk9gvqh2Ms7ekcflGXuw/11k3Rr0QKqlQxlkLXVmys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIhWpKJdp+pGXz0lbCZTQtwRyxz28zLNKKU7GzW7ZlJjJh/e8hZcd3UDekSnnIoCqH20TresJ5gtSOlVaUZm5QxCcRchGM9CDNQhyxMNwG1zNCIWYL4jO5sUgbCsMD6Hh0phbnb4lQ486n/Al9tjmxS+30IJXOsTxVf1Et7BLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixhU7pN8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172138; x=1783708138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfk9gvqh2Ms7ekcflGXuw/11k3Rr0QKqlQxlkLXVmys=;
  b=ixhU7pN8OngCs+ruM050ap1JrTOkiIxrIEg48i3zgc2ZGq9MHlj+Og8c
   f77GN8Ng2RnweeBgOpzzRg55NMoL8G2w1tnfKrvWtSD9v8HkvPpo3NsCv
   P4rAm4E88rDgZeho6IVAGoc5zYxfi5zfQ9eRhKXhEVUQ2bAbdbAGQwCVa
   AomBI0cHamubp0VjQemEa4NW9/w0Ato81fNPCQugVsiA5C5wNzCiL1T4l
   wNcDIHlmGkjTaq/41wFRuhpuzF4scdmy0Tat7Jm1k/AqqLMcumGT9Ip9s
   mCsTlaLgw/3fN37CXgTs5N+v/u3ItfmjXoIggyO9VBSJGyJo6jrbnJpzD
   Q==;
X-CSE-ConnectionGUID: w+78pRXDTiu4UPBKICWoDQ==
X-CSE-MsgGUID: sWDpZLa7T1WWUY9GP8txfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077791"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077791"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:57 -0700
X-CSE-ConnectionGUID: 2sopeD9oR1y6qkD3MEhJQg==
X-CSE-MsgGUID: odzz8YpsRm2SVg01TfAG4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718676"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: update expected range response notification version
Date: Thu, 10 Jul 2025 21:28:20 +0300
Message-Id: <20250710212632.377d24e29ac6.I44119a4e793bba35b46e1d35e2c378ce6f901bfd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

The last version for the range response notification is 10.
Update the expected version accordingly.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index c0e62d46aba6..ff1a3b9079e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -350,7 +350,7 @@ CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
 CMD_VERSIONS(omi_status_notif,
 	     CMD_VER_ENTRY(1, iwl_omi_send_status_notif))
-CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(9, iwl_tof_range_rsp_ntfy))
+CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 
 DEFINE_SIMPLE_CANCELLATION(session_prot, iwl_session_prot_notif, mac_link_id)
 DEFINE_SIMPLE_CANCELLATION(tlc, iwl_tlc_update_notif, sta_id)
-- 
2.34.1


