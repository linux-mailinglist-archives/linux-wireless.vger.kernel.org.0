Return-Path: <linux-wireless+bounces-25723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66506B0BC9A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46043BCC63
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB62820D7;
	Mon, 21 Jul 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H77zI1vl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CC283683
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079500; cv=none; b=ulovbQs47a+9/DctfcvjzvnQfgtmKJx8mDUY8gTSV0wvwtX/6OMR+kDLcYOBMwBHUgRCf+z/r+B+nkXSDAvu/BQhd6SCrQyY8Mc+Vrp20qJorXzsJoMbJ1JuZKW4Clu5DhRSxASas9H8D9gVhKL4djNPY8LarQfLK4grzBrYW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079500; c=relaxed/simple;
	bh=oVqTpyuGf3I0RDcNQa2ryHSA26LPcCE2tf1KhElZSs0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iKssC2emLeF86F6dRmrP2BYObH2aSZnuUcCum3nBOuJKzJJkHRvnNmfak+lJQ5yQ1nyaz4aqxB3vrr+C/UUhBpyO7kdqHUcrzVlMO/DbXI0Sa0hxraJ9KuV1l4vuHJzmFUyV1qyXRLHCmsBC3u1t5SFDgmHRbXpLAqeD1R3KxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H77zI1vl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753079499; x=1784615499;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVqTpyuGf3I0RDcNQa2ryHSA26LPcCE2tf1KhElZSs0=;
  b=H77zI1vlnxhHp4sSrCSqycW7Pxtn1iAh/0HZRDMUtdkWY3KLeM7ORrAi
   wedsqH4sXNyZs8sbbACsy4aXlinggFuD+rCiryd5p9KymQBPWoe5ctAfA
   IcG/sBAxGmIkRqR+LDJj9Ebap1qW7uY4fp039x4C++ulaZEaSvpxSdbOH
   wVzVLXtzUNnfWwzN5NNw6SL7CqbQu5VztDpHmCpHZeGL1BueUzIQiGaoy
   twUCPZ4MEsteSElFQtBKuNwN29UOGDDNNJcutL+TsBibv5o0m4IjmXvIx
   ZPiqG1CbLiMsxNqGvf6szXHe0pv54eZSKu1qv8KOxIP3kz+0MnCHt2fq0
   A==;
X-CSE-ConnectionGUID: mUJ/zPmkTfWBhWFzfw8vMQ==
X-CSE-MsgGUID: UTkY1ZkBTzqkMuf6p/Xmgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65851386"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65851386"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:31:38 -0700
X-CSE-ConnectionGUID: Rxq6+pkATSyT9KiUZ3FEPQ==
X-CSE-MsgGUID: sItL7vTzSuKHq6RXtnRCSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158061177"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:31:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/1] wifi: mac80211: change ieee80211_gtk_rekey_add API
Date: Mon, 21 Jul 2025 09:31:13 +0300
Message-Id: <20250721063114.82225-1-miriam.rachel.korenblit@intel.com>
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


