Return-Path: <linux-wireless+bounces-25129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD39AFF323
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9DD17299F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15023F40A;
	Wed,  9 Jul 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0NMLqSg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789D202F8F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093506; cv=none; b=T/vCbrbJhkmHddCyYZznE4sJ5in4CkLv6EE6yYWyLDjuxxc9YhGTTxRJ+lia4Xw2OrXx1nIpbsuONLuH2V+U7JLqFzmAH3Vc8xlpPatMcwaD5DNCsQjkvalteNrj9Hyw4etzs9NSBj+/tU/uSFK/eYxqY0DN/705g+q8etkIrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093506; c=relaxed/simple;
	bh=QCoLYzDQ95tK9tWXaQKKJebeJHvQeQmL5Fswgu2liu4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nKinGtkVN3dLRF0yF36iT3iSw7Pjf5i4KBRprXneTzSh3TPYPHPP/OvwBdY6s01PQk25mBZsVoiAdgjX3yXUyLt9e2IfmvkBdfuWoSQVY34s+ywR0czvHFav347NmN6d0aC6dFkFULquKMuUM3pD4H5aaVVmNH+HkFQPpv17cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0NMLqSg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093505; x=1783629505;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QCoLYzDQ95tK9tWXaQKKJebeJHvQeQmL5Fswgu2liu4=;
  b=X0NMLqSg3YCifl3It5HiHwd+MpUlxCaQWY5cLjI9FzQkEvKraPP7ZDSw
   44ng3x2FP3qjFGveFNJ6geUS1EOw26MD1G8iNNmcHftMZy81XZXUf+PFB
   9QaJ4w5+DLDkFhUz/0u+6DZmcluaNSFWE5fkqeoW3cSRSyjE7X+VAPo+H
   rCfUN9GHsfMBTI7PeBahMqtZvp6BXIAu9ANi4JN3BHy+2CypX0COJMm+t
   GsPkUYfxr66xLnhQQ1cG5gWZ2tYAf4rjaZnYeUOdNQ02AHpszw7JEJsaG
   Cg/Cu3+vzPxm36XC3Wjf04Sk5U6Ekqy2FhTB/maPacRGWLQpc9zZtVzIA
   g==;
X-CSE-ConnectionGUID: hlUhwSklSHeP+claMT+C3A==
X-CSE-MsgGUID: QMUMjjy8QiSN/sFj20H76w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974428"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974428"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:24 -0700
X-CSE-ConnectionGUID: iaohBtiSTHiydbLIVDrM6A==
X-CSE-MsgGUID: 4WlerrP/TeiemhuIpzrvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532530"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/11] wifi: mac80211/cfg80211: updates - 2025-07-09
Date: Wed,  9 Jul 2025 23:37:52 +0300
Message-Id: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
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

Features, fixes and cleanups from our internal tree.

Thanks,
Miri

Ilan Peer (2):
  wifi: cfg80211: Fix interface type validation
  wifi: mac80211_hwsim: Declare support for AP scanning

Johannes Berg (6):
  wifi: mac80211: don't unreserve never reserved chanctx
  wifi: mac80211: remove ieee80211_link_unreserve_chanctx() return value
  wifi: mac80211: don't send keys to driver when fips_enabled
  wifi: mac80211: clean up cipher suite handling
  wifi: mac80211: simplify __ieee80211_rx_h_amsdu() loop
  wifi: mac80211: don't use TPE data from assoc response

Miri Korenblit (3):
  wifi: mac80211: only assign chanctx in reconfig
  wifi: mac80211: don't mark keys for inactive links as uploaded
  wifi: mac80211: handle WLAN_HT_ACTION_NOTIFY_CHANWIDTH async

 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 +-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/chan.c                           | 18 ++---
 net/mac80211/driver-ops.c                     |  5 +-
 net/mac80211/driver-ops.h                     |  4 ++
 net/mac80211/ht.c                             | 40 ++++++++++-
 net/mac80211/ieee80211_i.h                    | 10 ++-
 net/mac80211/iface.c                          | 29 ++++++++
 net/mac80211/key.c                            |  3 +-
 net/mac80211/main.c                           | 69 +++++--------------
 net/mac80211/mlme.c                           | 36 ++++++++--
 net/mac80211/rx.c                             | 58 ++++------------
 12 files changed, 158 insertions(+), 119 deletions(-)

-- 
2.34.1


