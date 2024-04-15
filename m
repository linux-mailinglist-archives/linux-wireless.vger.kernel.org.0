Return-Path: <linux-wireless+bounces-6302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF18A4A48
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2351AB24DEF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08438390;
	Mon, 15 Apr 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLDh4fig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E138389
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169647; cv=none; b=iwHdXIdPOc9EXfWllowkkEMldRzjnegjHsaMa0eztvpUfdWR84LewvPfyC6Tb6ZXV2kk0mLFfNbzhHF2/n9vDAnN9cYKFnndEvbO1za5jTxIitlnlMbkzI3VQZ1UOzCuMY5vFFBEC5zVaLcQQQKG4iA9JkuexOhCQ7DO5WRZw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169647; c=relaxed/simple;
	bh=rnGBCp5TL700GlzcOAfxW2dk2cCWM7JPxr9wNhHmaI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrRHr+9UIPKMdxvkFzKrYAJmXBGtCYgD7kImmhbkaE1ReaKHC+f3MUWqxBMWBlcU5OpXgCtNJj3Kok3pwCAYiNuxB7fTNEPfq4NwPXqV1AIlwvwrmRR6Ii+ghA8G0XGKev7UHUQLhj3bsrjuRkJLe776j8wUh07DD7o60uzQkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLDh4fig; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169645; x=1744705645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rnGBCp5TL700GlzcOAfxW2dk2cCWM7JPxr9wNhHmaI8=;
  b=DLDh4figYu9lRq36nKboZIJ1I679x/WlQl0tYJGCh4FT98EH5p/IFYLm
   iM3pZ5qeZvTDNsfjchSUzyf/4ndyEEkU3bAbLz37WnB6dIKdtWGEf6f9c
   CUq90qKtgNMuVkwTfdpfXtEJwn5MqP9sEDD4xm6G5xn4V01a0SRM4XNNc
   08zTiX46+RGKd8ppIlm+kOhflrACndj2JCa6oc442yC0c0GUyQhcSshV/
   X36+DAo3c8UxecncFzdAxhqyANuLKQKxUyYym9cpdnL8vIkwj+pk2IbCd
   UxD8xmxD08x9ZaJFhrTHlvDm50Gozo/Vihlo35Q/rHOnxUcknTIHf8BPz
   g==;
X-CSE-ConnectionGUID: 3Xuwz34lTWKpsj31bBpBXA==
X-CSE-MsgGUID: Kr4pyT3OSomPGrnJ2V8wNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9097269"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9097269"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:24 -0700
X-CSE-ConnectionGUID: HGQSRgVtQSG3gA8DMZykiA==
X-CSE-MsgGUID: Hzd9C240RmS+AIfe0xBlOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26403224"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] cfg80211/mac80211 patches from our internal tree 2024-04-15
Date: Mon, 15 Apr 2024 11:27:10 +0300
Message-Id: <20240415082713.3822598-1-miriam.rachel.korenblit@intel.com>
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

A few patches from our internal tree with mac80211 changes.
It's the usual developement:
features and a bugfix.

Thanks,
Miri


Johannes Berg (2):
  wifi: mac80211: mlme: handle cross-link CSA
  wifi: mac80211: transmit deauth only if link is available

Miri Korenblit (1):
  wifi: mac80211: defer link switch work in reconfig

 net/mac80211/cfg.c         |  12 +-
 net/mac80211/driver-ops.h  |  12 +
 net/mac80211/ieee80211_i.h |   4 +-
 net/mac80211/iface.c       |   9 +-
 net/mac80211/link.c        |  12 +
 net/mac80211/mlme.c        | 523 +++++++++++++++++++++++++++++--------
 net/mac80211/util.c        |   7 +
 7 files changed, 461 insertions(+), 118 deletions(-)

-- 
2.34.1


