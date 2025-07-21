Return-Path: <linux-wireless+bounces-25760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D67B0CAAF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA15401EF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0A21D3DD;
	Mon, 21 Jul 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUgs207s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69210DDC3
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123874; cv=none; b=fgczC55j/mfbTxiA842d1UHhTaTJltjZ2ZGr58XpmqJf0KzGtaxUW+7KDKCiSJEk5W4mmOloySJAaYiICC69n209fv3qkzm1TPDcLDDQi0Oof+qT8QJnHJ4FFaVlBTpttphi42khkD11JFpOns4DpEmwWkGclBsZAtnQMDuroOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123874; c=relaxed/simple;
	bh=oVqTpyuGf3I0RDcNQa2ryHSA26LPcCE2tf1KhElZSs0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VJ1YyQXGY9+LHrMZBZ4Jms4GtsdPCKvU0Vge14iIIlFZNkkmYKpgH+ShTY/h98ZAITC0X1Q/IwtfAxrBmYggwtTmPn74eAjIaQiwhbRpkGlflkteO33G+es4qWS134tJ7tpY+3dG2HnfSkBNyaCwuew0j8y7epxN416IoVxboLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUgs207s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753123873; x=1784659873;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVqTpyuGf3I0RDcNQa2ryHSA26LPcCE2tf1KhElZSs0=;
  b=gUgs207seQLnpkOwpiHRcVA2ZM5wVz4iecVawFxw5LxV6sONaZGz6qMV
   LP2oqEDpeni0bid7dBsiKuo43Ghsl2e1wrFNH4lI4TG8v8aJOwggJbLDl
   Wu/QOrP/TGGaNzUxCtFZG93pSYXlH99Dn8KgVJM9iGfOSfYBPy9Qxk9DA
   3BKg23d901FoOVWXfwQlxMeKJGzBAZzO05JCeBCUdm1z47rJjfPuNd6uq
   DfNdxuFub39BxgEqkafM3ctnMtQzuYEueCWItNfuBQn50PJ57J410nIMa
   Zr37q+0coV0c1qlY2v8EzuYUWpCCVXyAkx8BOGzeiMjL0FZv/qlXsEh7y
   g==;
X-CSE-ConnectionGUID: xKcfdxuUSK23FR74vbKUIw==
X-CSE-MsgGUID: 3rBPz5ixQlWNgQj3P1ymyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55230076"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55230076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 11:51:13 -0700
X-CSE-ConnectionGUID: hA90NIiQS32KF86E3pNEgw==
X-CSE-MsgGUID: u38Xra7nQg+dn0ZM0Q5EfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158699819"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 11:51:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 0/1] wifi: mac80211: change ieee80211_gtk_rekey_add API
Date: Mon, 21 Jul 2025 21:50:48 +0300
Message-Id: <20250721185049.634010-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to make the drivers' lives easier, change this API to receive
only what it really needs and not an entire ieee80211_key_conf.

As the cipher (and therefore also the key length) remains the same upon
a rekey, there is no need for the driver to send this information —
mac80211 can infer it from the old key.

This will spare the drivers from looking up the key's cipher.

Note that this patch makes only the necessary changes without any
cleanup of the drivers' code.
Those can be done later.

Miri
---

Miri Korenblit (1):
  wifi: mac80211: don't require cipher and keylen in gtk rekey

 drivers/net/wireless/intel/iwlwifi/mld/d3.c |  7 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 11 +++++--
 drivers/net/wireless/realtek/rtw89/wow.c    |  7 ++--
 include/net/mac80211.h                      |  7 ++--
 net/mac80211/key.c                          | 36 +++++++++++++++++++--
 5 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.34.1


