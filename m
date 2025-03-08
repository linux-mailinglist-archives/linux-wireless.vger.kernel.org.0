Return-Path: <linux-wireless+bounces-20044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FCA57E65
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832F43B0A15
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D31A8F63;
	Sat,  8 Mar 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUV8rbb5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA519597F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468055; cv=none; b=BIeViJa4JG+og26NHjEuPG4t/ffB7Ojcpanu8yBmcOm5XBxaPJfjRSVyc/RWN+KAWr9s5W1/Xtg8bqnjBOmnifR9tenaj8rklOjVO8Y+1qvG/xIAoVwQ7+L0AJgzGstBMsrjOgHsDK2R7/rkOkB7soVF3e0zuTIfc8AgiTcq0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468055; c=relaxed/simple;
	bh=Ahn5E1O+YZWIExufykAoRH9acLYKWhB95qDTpXsUrl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgN+UOYDstlnXdrg8318Vq0iD3D6CVx+fc9NwXt3vO7SelkyesZICg4uLbr8/Xg8zwOdw5dxMDEXgpzwleu4wY49Fasb6aaUv+jW1qDVl78lwkcsiXPWulFftzr/tWDYXVpzTybU8tceCByfWOulSif+t7BfipO0mKs6HfxhXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUV8rbb5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468054; x=1773004054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ahn5E1O+YZWIExufykAoRH9acLYKWhB95qDTpXsUrl4=;
  b=RUV8rbb5emOf7Ht/E+Jwxkt7jMRGtllfSaA//gTvEHxZpbPuFiv0EhaG
   hNyRm6qL4anwlWYWxFQVr/t4b/yBxDwoOPKmxrBAmf9QlvHDrY0f9a6EM
   sHecclIpzZ9Wn37q5H+o0qxfUUWwJxsQtW5JM2zwZnop3K7sAE3jzLEvc
   oUp9QTdAQRC+0PbNkCQjY7VrSX/X+dN9+NQPVPVkWjVN1BiAb2jNjMuET
   IjMSziDymaeTUt/iAl0af7ZA0ulFcS2J2qkzxy8rtGOxKdWMv09JRbuEg
   lbQZLsERWYa1QA4kJ3Ov0G0k+40uRLhnw2F3XAQkQVXxUV1fDzm5IiLox
   Q==;
X-CSE-ConnectionGUID: rClbsEZKRDqfVeNUWT7fjA==
X-CSE-MsgGUID: 4qH1RxoOQJOJ1cVmg1+cOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413141"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413141"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:17 -0800
X-CSE-ConnectionGUID: mtTiz4PVT7m/3b+k0DlFZw==
X-CSE-MsgGUID: dVj7INEiSzSQFXD2DKsiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644503"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH RESEND wireless-next 15/15] wifi: mac80211: set WMM in ML reconfiguration
Date: Sat,  8 Mar 2025 23:03:41 +0200
Message-Id: <20250308225541.59902f783420.I362c3101d3f523a8db37c16cd7b5f573d76a36e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the per-STA profiles for added links in multi-link reconfiguration
the WMM element should be included. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 94d9d9ca42fe..bfd3653a5b84 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10435,6 +10435,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			return -ENOMEM;
 
 		data->assoc_link_id = -1;
+		data->wmm = true;
 
 		uapsd_supported = true;
 		ieee80211_ml_reconf_selectors(userspace_selectors);
-- 
2.34.1


