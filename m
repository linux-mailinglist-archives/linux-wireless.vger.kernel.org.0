Return-Path: <linux-wireless+bounces-33394-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI3WGMKdumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33394-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:42:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5B2BBAD5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 100313041290
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9F3D6CA0;
	Wed, 18 Mar 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfNsNFua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCA3D75B2
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837592; cv=none; b=B4RwGmGr7rqaWo2OnkMMokPia4tMvKp4Rys1/KaY1ZDdDyLT9ICqplzIDW0hPmsDwB07snvIGlyqbCBDd/L5gamFmXV6SXify2vkP76/L9HKwtteSX1CPv5GwUYeustpBW41R2qB85ON6QcMXDIUzmMAWMMfZGCGkjE6mmNtD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837592; c=relaxed/simple;
	bh=HSx+noQDMy1JBXVzSLlkZ3MwGYgLrwXtuY17bKRNROo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhxmPkvN9wr1qgwXB7nTsI/dK9aQcUdewiqD1KF7LDKWv3F+Fl71wi2oE7DHhhuU/dUNkw56uG506lUypy5qGs2uHfDm08C3/xt8vSScDWhGknNn1Ley61LDg/F8bYV6uVhNk+cQCEgo6UWQR61me7mxOnwi/oO00+pUCqzQT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfNsNFua; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837591; x=1805373591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSx+noQDMy1JBXVzSLlkZ3MwGYgLrwXtuY17bKRNROo=;
  b=GfNsNFua+BmDub5MgcT3iWUnOOen9+1bm354OQ1O95kYDwKn0Mw8H0Ck
   2ftYp8RlMoxucK4/biIb24jyKkAW0Yv/f5KvsDboXNAD/QEbBiG8NhYBN
   d16glss1MUEcTYlNB/906YAfIYGc0QsRj5rYl3eLF3mxUvdgLU0t9Z0mG
   TCKCDCRZI58/DiyJ/Mzg5TbX4QOeIxtiosoMk7dJxQHT/pgEx1ORUZScq
   XJ2D9sHeUjSmA4hlGE5KQ+fGchLFdzLbHa4ZRyeZE1XtAcq5Xf+Lxk9/X
   FEwco2SUZSLl151HyEo28TDl7qw5lJIhwChOxw1bFS6uQzvTA6GAy/mvv
   g==;
X-CSE-ConnectionGUID: jdg6G941QtKWYazNRN2Eyg==
X-CSE-MsgGUID: s5AVKUqNT+uUwoNUzKazxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519285"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:51 -0700
X-CSE-ConnectionGUID: QspMlE+cRaWlx9vlAZY5lw==
X-CSE-MsgGUID: Mf9cawRKRb+oawuoAfl+qA==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v5 wireless-next 11/12] wifi: ieee80211: Add some missing NAN definitions
Date: Wed, 18 Mar 2026 14:39:25 +0200
Message-Id: <20260318143604.5f6b36d2b208.I7ef571682d5add96eabfcf87f81285893021e851@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33394-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,sourmilk.net:email]
X-Rspamd-Queue-Id: 5CB5B2BBAD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilan Peer <ilan.peer@intel.com>

Add some missing NAN Device capabilities definitions.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211-nan.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-nan.h b/include/linux/ieee80211-nan.h
index d07959bf8a90..ebf28ea651f9 100644
--- a/include/linux/ieee80211-nan.h
+++ b/include/linux/ieee80211-nan.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2025 Intel Corporation
+ * Copyright (c) 2018 - 2026 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_NAN_H
@@ -23,6 +23,11 @@
 #define NAN_OP_MODE_160MHZ		0x04
 #define NAN_OP_MODE_PNDL_SUPPRTED	0x08
 
+#define NAN_DEV_CAPA_NUM_TX_ANT_POS	0
+#define NAN_DEV_CAPA_NUM_TX_ANT_MASK	0x0f
+#define NAN_DEV_CAPA_NUM_RX_ANT_POS	4
+#define NAN_DEV_CAPA_NUM_RX_ANT_MASK	0xf0
+
 /* NAN Device capabilities, as defined in Wi-Fi Aware (TM) specification
  * Table 79
  */
-- 
2.34.1


