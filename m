Return-Path: <linux-wireless+bounces-29468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A7C9E984
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 10:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DA124E04ED
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68482E0924;
	Wed,  3 Dec 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIAfSWtg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB32DFA5B
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755587; cv=none; b=WMS7w5Efv00eAzb3B+D5gaOxXMwHl3zW5iSUSCuoSXAP1KlDmlTtx9Ymlmii0T+ISiMTvkf6day2CExWpnt835sYWVu2eESds4QWZUAMhR4POCs/3CYCmCZjAC7kKKUnQ7eZzHxkCNF/Q1V05/PhMPsBvc3yMp7I9AS5Mfq40BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755587; c=relaxed/simple;
	bh=LThXZQu5eGePBeSXgBmiedkpjQ/NBge+UcGDliLIYzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvVkpbk3Ysm7XXCsy9QswpwEfWMRR1DAr/4cgEqQiNtHJsX++0G2O0GScjK18WL53wgvMOnhKuog72+fjMzbdXXLG/yeczAXPFSddwdnhSa371SrxvyEkXONQDmNtYdusadDMhEwbtkxQ/CYJpDEUh4iBusTHMF5r1j9g05pOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIAfSWtg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755586; x=1796291586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LThXZQu5eGePBeSXgBmiedkpjQ/NBge+UcGDliLIYzM=;
  b=GIAfSWtgylxFKfp1Fg23bby+Yofqc+PDzMzdbBU51a7tC+YIhLKltMTN
   KH+IL7J/QQo2eAi9Ae7GUcYYJ0YECFlvJmmZ967hXlwp2sEfVxemXPvNr
   toCQMcjWtsdlQwHrChjRxVifpd65fDRK82/hb1RkKoaiVmFv0ZLb3a9oK
   CHreGL6XxPv1iATEtLXJxIbGxxJ7fqYHiLbLHfw8n6LmJOJz9wbZeIcWU
   BDFobk4tzx3nw45mDeW0wGa5JT6ULeBt6Mym08uzMKNkWY8tuwqQg6y7C
   XJsFb8ZEVhi0SBSOozGc+tSMWO2bExCyrPJdbRAvWTwWWy6KC69O5YMKT
   g==;
X-CSE-ConnectionGUID: Dji/JjgEROiidPsBLGrtvQ==
X-CSE-MsgGUID: LSHLGSdkRGSPLWRDN6zJbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931519"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:00 -0800
X-CSE-ConnectionGUID: zFlJpAKDTDKD5GCYNhOtxw==
X-CSE-MsgGUID: /KDRYNICT8iUvivtHaDQcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193916134"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:52:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [RFC wireless-next 0/4] wifi: nl80211/cfg80211: non-EDCA ranging support enhancements
Date: Wed,  3 Dec 2025 11:52:34 +0200
Message-Id: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series adds several enhancements to non-EDCA ranging:         
Reporting of more capabilities, periodic ranging and RSTA operaion.

Avraham Stern (4):
  wifi: nl80211/cfg80211: add new FTM capabilities
  wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA
    based ranging
  wifi: nl80211/cfg80211: add negotiated burst period to FTM result
  wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request

 include/net/cfg80211.h       | 33 ++++++++++++++++++++---
 include/uapi/linux/nl80211.h | 51 ++++++++++++++++++++++++++++++++++--
 net/wireless/nl80211.c       | 27 +++++++++++++++++++
 net/wireless/pmsr.c          | 27 +++++++++++++++----
 4 files changed, 128 insertions(+), 10 deletions(-)

-- 
2.34.1


