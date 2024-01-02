Return-Path: <linux-wireless+bounces-1407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2C82222B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A982B21BDB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D6168A2;
	Tue,  2 Jan 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzVPaioW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA9168AA
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224200; x=1735760200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSBaMXyQ4oMd7mA9OG4M1bJBj2/VqGTmQkMmfnj/gyM=;
  b=BzVPaioW2e3L7yY86B6LIeI66I5jfPG5ieMePD+LxmYqGXtVR4JaVWvg
   BKk0WnMNhXn/fisrkI8aLLbwBsjwWEnIU+IOjOBMs3IUdy7/Ym86w79kB
   mx1TfRty2e84DKyhSqSiNmAoGZo0WpAJI9cRRbjyIseWmJOZKZQ1UtdYF
   duA12y7ldm1Uo8SRoQ0cz6G9IoQb5jwOIz9O6NKmRaZyU9zVw0bI3NTTr
   fZJ4VPw/HlzH0hr6+ILpSceOg4dhNfCLoeIlL3reFbX4+PHZcA2Y900r/
   uc7NkrdJx0z/jiWVmnb3T1k/nEnxGX8xqqNcOOaF/9GehYny4eXlBwW+2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314339"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314339"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624594"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624594"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: mac80211_hwsim: advertise AP-side EMLSR/EMLMR capa
Date: Tue,  2 Jan 2024 21:35:41 +0200
Message-Id: <20240102213313.dc8786efa787.Ic460c13a91d770c208ac16d0b3e94941bab9b8eb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Advertise EMLSR and EMLMR capability on the AP side to be
a better compliant AP MLD.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 2b7c9368e96c..304dc96fc3bb 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5003,6 +5003,8 @@ static const struct wiphy_iftype_ext_capab mac80211_hwsim_iftypes_ext_capa[] = {
 		.extended_capabilities = iftypes_ext_capa_ap,
 		.extended_capabilities_mask = iftypes_ext_capa_ap,
 		.extended_capabilities_len = sizeof(iftypes_ext_capa_ap),
+		.eml_capabilities = IEEE80211_EML_CAP_EMLSR_SUPP |
+				    IEEE80211_EML_CAP_EMLMR_SUPPORT,
 		.mld_capa_and_ops = MAC80211_HWSIM_MLD_CAPA_OPS,
 	},
 };
-- 
2.34.1


