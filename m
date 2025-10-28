Return-Path: <linux-wireless+bounces-28337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27FC143EE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 12:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D78625CFF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE27FB2B;
	Tue, 28 Oct 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1DM2gAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C325332E
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649128; cv=none; b=s4SdjeAWcksjWal/8zzQ2BG+sEH1c8rKIUbLxixn26yr4IQV2x0o/UnnIzqebvl7X8yJSCF7+yRG3phKTxXOC7LFrecxOESTiWUC/TkBM+vPMHj0qxMACbqsAYTWAIfnvpYbNSYTRvkJXJ1FvnQyb1kyjU4I5a9TeZ+OpYrFaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649128; c=relaxed/simple;
	bh=/yg6Jkc2vyiiA4U004CVxhgekoFPxsT9PPBznA9pmUM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pgXpGOPexUV7hBfSBDASwuKQxtAmYK9ACvgoDnGwVY+EMImzO79aIdWdwExnmQcAFzt6BgqIryd0SeZlP8rKzwbUVCT+1yap+YsGx8J6VuPAVxsuHX8x5VPwvme19/P1LY0Mwiw4MI7GITV6Nz8NEFfc4t4EUnMYAV+gMVu4QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1DM2gAX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761649127; x=1793185127;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/yg6Jkc2vyiiA4U004CVxhgekoFPxsT9PPBznA9pmUM=;
  b=T1DM2gAXzQo+7PfZqWio1H4U9MdkYXW/+9Tvz+82NLg0yIkE4O6CleyX
   PmV8/TBfPkqK5g1XWC7fCM/9I+GSnrHYxwwm5pZxDJ4zueymLsUjQeLsS
   xVFkQ47G0JUAP0QhOAY9/SK48ckcnBDY1iHUPM41UOZU/ZWb0xvGtJQnK
   pzKfZyTSLozHPl9B6a7q5r4brJSCsXLCS9aDjd0Kt8B2n8GbI4E4QbBjn
   9Y98g9IHY9knCqqWWtJForRAYjl51BDIFY1X1192xzAWvrPIA4mwSykLu
   FVMNYis0hLO9lnoMqrPIhLTzTjWTZyFDKY3xxmqfcynrtxjyu8AKf/5fG
   A==;
X-CSE-ConnectionGUID: 07/RzWI3Sd2FJewUNe8tyA==
X-CSE-MsgGUID: V4sI4eGuT+G3jCzE3v06YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89215632"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89215632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:46 -0700
X-CSE-ConnectionGUID: 6+0u4iV0RO6dH5i+w92QKQ==
X-CSE-MsgGUID: l+ml9Gh0Rc2tvTJKxpaKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184549937"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:58:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless v4 0/4] wifi: cfg80211/mac80211: add an hrtimer based delayed work item
Date: Tue, 28 Oct 2025 12:58:36 +0200
Message-Id: <20251028105840.3140483-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Apparently, the existing wiphy delayed work, based on a regular timer,
is not accurate enough.
This series adds an hrtimer-based delayed wiphy work and uses it for
several wiphy tasks.

Thanks,
Miri
---

Benjamin Berg (4):
  wifi: cfg80211: add an hrtimer based delayed work item
  wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
  wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
  wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

 include/net/cfg80211.h     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/chan.c        |  2 +-
 net/mac80211/ieee80211_i.h |  8 ++--
 net/mac80211/link.c        |  4 +-
 net/mac80211/mlme.c        | 52 ++++++++++++-------------
 net/wireless/core.c        | 56 +++++++++++++++++++++++++++
 net/wireless/trace.h       | 21 ++++++++++
 7 files changed, 188 insertions(+), 33 deletions(-)

--
v2: add the destination tree, wireless-next, to the subject
v3: fix kernel documentation
v4: send to wireless and not to wireless-next
-- 
2.34.1


