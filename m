Return-Path: <linux-wireless+bounces-28765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F6C46946
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4AFB4E13DE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEE18626;
	Mon, 10 Nov 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/v4xoH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014252FCC0F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777590; cv=none; b=DtJTsZIS92NS+0kFtrq6Ik47+ZYHjulJOWOegBUXt6ow6+LGz7JA6e2+bPSsWaMRNJRm1f7Ix72A7LWccEfF3W3IEVnM5ijtRDXwADIqyDe30Jme9fnO42DBf49asyMJKCgnWZA7qcFn2ecYV6GJG13vGqfTWOJLNmw4mMT1Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777590; c=relaxed/simple;
	bh=DjSeQ8f9CLnoxDSsV9gEL+saXNpfPKk47Ggiflhexo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A37rruVeUZjNBu2C7fvy8RTJuyPHVr9F9noshd/+1P87EKIdvmInvF1o83HM2OAhPUYYvJx6Ib3xHsadJ6xXNATqDZ3YVatbQHXyQ+vYIKyIOCwmc/ZqRJd6cHNB2GsCZypKhNHanrAMxnMxOIotCmyM+v66ezr6YUULP1groQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/v4xoH6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762777588; x=1794313588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DjSeQ8f9CLnoxDSsV9gEL+saXNpfPKk47Ggiflhexo4=;
  b=N/v4xoH6J6E2N201HcEICEu2uz92j3Ikb6DIkDpiwtJguvYaq6DpdFoS
   MSNESGFOFyIjNS7tgrQdwHWvzwi3/biGIQUifL4QpPhdtOXAMMqbyA7r3
   d/5JXeZcbFrEEbz7B5eoLd+mfilSSux8qw0IQmaeIp0jRN10/tK9wiC5G
   MSRTP12/9cKrw5kz+IBZdjlgCpOEjtmmzKLwvJ4CcauE1acU6kTMjMqAu
   xAdo1c+oQUoU5P2f+j6xKDOXI2GsihGGPdFhojoHe01ei5sFo3zQSzGbX
   oOBxpEPSOXS7VhrsJdcetLB8Ex2zDUOPUWbPCY1HJWd/6AN4j6mls/8W+
   g==;
X-CSE-ConnectionGUID: GQDfPHFNS2+SJfVlJAU+5w==
X-CSE-MsgGUID: PLSJ3oQsTA+vEfez2JhTfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67431815"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67431815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:26:27 -0800
X-CSE-ConnectionGUID: sKN9fSXdS22VKGINlZe2Tw==
X-CSE-MsgGUID: WzEOyq7pQFudxhUQBLS47Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192921259"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:26:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: skip rate verification for not captured PSDUs
Date: Mon, 10 Nov 2025 14:26:18 +0200
Message-Id: <20251110142554.83a2858ee15b.I9f78ce7984872f474722f9278691ae16378f0a3e@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

If for example the sniffer did not follow any AIDs in an MU frame, then
some of the information may not be filled in or is even expected to be
invalid. As an example, in that case it is expected that Nss is zero.

Fixes: 2ff5e52e7836 ("radiotap: add 0-length PSDU "not captured" type")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6af43dfefdd6..5b4c3fe9970a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5360,10 +5360,14 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	if (WARN_ON(!local->started))
 		goto drop;
 
-	if (likely(!(status->flag & RX_FLAG_FAILED_PLCP_CRC))) {
+	if (likely(!(status->flag & RX_FLAG_FAILED_PLCP_CRC) &&
+		   !(status->flag & RX_FLAG_NO_PSDU &&
+		     status->zero_length_psdu_type ==
+		     IEEE80211_RADIOTAP_ZERO_LEN_PSDU_NOT_CAPTURED))) {
 		/*
-		 * Validate the rate, unless a PLCP error means that
-		 * we probably can't have a valid rate here anyway.
+		 * Validate the rate, unless there was a PLCP error which may
+		 * have an invalid rate or the PSDU was not capture and may be
+		 * missing rate information.
 		 */
 
 		switch (status->encoding) {
-- 
2.34.1


