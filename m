Return-Path: <linux-wireless+bounces-19869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C034A547FE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F3E18957A5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAA208989;
	Thu,  6 Mar 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwZA91Kz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78E18A6B5
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257493; cv=none; b=hy4wEKhpEqz50bdnekUiJj/vGkmmWcIM6xoMbzVQ+3COD9PV7M+u8NttLgVIB1f09cqlRAfD73AS6wKODmVrE/0PhzE6b5fdZ/DGGj7NtZE3l2msGyCarAJe3qw+n5K43rIf0ouD1XsTNUiBlTfeFnIbr38MdwpdTK0hLfp+YVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257493; c=relaxed/simple;
	bh=iLMe6PTJCUBRMgUeebj+rUnb5S/RnmW+U7nEP7gkNzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFINbxrg0p72CCbteOxB+IxBvCwgwUPaHhYCaNrZUBdncNYYx/WFurazRGC6QVFsiEYSR1/fFRxTueb3hlLvJj0wuQBfi1X2pGpm9gH2TDDTiH0SnED6/RwY9DHyQiyHCkHrnxwrbnx++kisc3xTtpCS2O7C/bELERnrakZl7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwZA91Kz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257492; x=1772793492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLMe6PTJCUBRMgUeebj+rUnb5S/RnmW+U7nEP7gkNzM=;
  b=EwZA91Kzl9E0O6soq/5oQSIq1Oc8QYqyrQuDidZDUFXK1299QNJJlizx
   1lSr+sz1X3q700z4Vgo6ySTfbAF6mF+utLbIE/mjOMjXRdKPWwr1LY4yO
   BOY/F/4T1VMk+IjSixAKT34vHccFCq+EseyNz6juxhHN4+LEpuxZJxMqP
   Aa9Imi8IUC2NaoZdA3H9Z+FxM9bjTCpsglKhkibog4JMVTDlB7d4FzWr6
   NKTxrY8PpZ10tTiiU2CMSamWLCoz1DbSvg11pLKIvRzuChWH1RTIlQawu
   jBInE6cPP3SyNbUjN6J+nUqNdW6XXaQSMtnqhNps6UvfKOt4MqnXdHpD8
   A==;
X-CSE-ConnectionGUID: 5kmjm7qAT8askHHWj8RcPA==
X-CSE-MsgGUID: pTGKFBrNQT+e96gZ3jS6CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915010"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:12 -0800
X-CSE-ConnectionGUID: 3ZKYRbt5Tm2IQCqpyWCYHA==
X-CSE-MsgGUID: T3tLrpjdR5eOcfZxy4D8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138371"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless 0/5] wifi: mac0211/cfg80211: bugfixes - 2025-03-06
Date: Thu,  6 Mar 2025 12:37:54 +0200
Message-Id: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

A few bugfixes from our internal tree.

Thanks,
Miri
---

Emmanuel Grumbach (1):
  wifi: mac80211: flush the station before moving it to UN-AUTHORIZED
    state

Johannes Berg (2):
  wifi: nl80211: fix assoc link handling
  wifi: mac80211: fix SA Query processing in MLO

Miri Korenblit (2):
  wifi: mac80211: don't queue sdata::work for a non-running sdata
  wifi: cfg80211: cancel wiphy_work before freeing wiphy

 net/mac80211/rx.c       | 10 +++++-----
 net/mac80211/sta_info.c | 20 +++++++++++++++++---
 net/mac80211/util.c     |  8 +++++---
 net/wireless/core.c     |  7 +++++++
 net/wireless/nl80211.c  | 12 ++++++++----
 5 files changed, 42 insertions(+), 15 deletions(-)
---
resending with the tree name in the title
-- 
2.34.1


