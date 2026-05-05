Return-Path: <linux-wireless+bounces-35924-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBAuOP8d+mmaJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35924-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:42:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D54D1813
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7942E300E146
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD036EA8A;
	Tue,  5 May 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqWIKBpo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041C48B36F
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999355; cv=none; b=X8EzGmhqz4g++fK+j46ftkd7nlTu8vLnTkkEewjgP/jqHlAwD6A56KqQvmfDyloZTU7SrKpnjbo0phRUw8wrFu7yVggoR4rdKGG2MXRV5PhchfR/QmPsEh3Onx6CfNqZkjeQ/R74RKu0JzrUTnk2F4cVc/OxxAojaAbfj+a1TP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999355; c=relaxed/simple;
	bh=f0/wjtPRGBCtbVubOmRC/U4tGUm40oLTJmoLI5LSlwQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=b6ywDM3IklAhHHYe1BoKQtI6HVHdBGEgVhO1bUpVQpmSMIo9g4wsRS5Jo7XqZ+fjeMCD9uaypiXqQE0e7rly2dAznWDMGBmABJSV8OabXC5e9sW0j5dTxYpLkn5jrkSBUUuXhFbQ1ACt2CVBDa70hyXCQ4UKBD6+fpqdOn2QvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqWIKBpo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999353; x=1809535353;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f0/wjtPRGBCtbVubOmRC/U4tGUm40oLTJmoLI5LSlwQ=;
  b=AqWIKBpoqFpOABS5/B7ILquTmjJx7Yp+SMkOcoT/QWVHP1zHYj3EU9Ri
   DguircSbVnza8yio90aqXp1ZMI4ya5JdGQfOV9JJ/HiKP+T+PfDXF45Sf
   IEswVtjThGGp94v9Qzbq2e+opQxDgi+6edQbV3MoomUBUAGWi7HqWsze1
   DsvtMf+y7wKqE+Ag05d46x3piEfnANNcCZy6YzdIKIie3DXyaqHii3DOn
   Pddy1l9Gll13pYZZJ67NNekiVuE45kVMKYiVonoggJJ9b2g3d+iYEuDxK
   gqwQJEXrN1F/UUY1vZ/H6/IKSAj4sG4xVHYZQt4WfyaYxxbiqhLQIpZB8
   A==;
X-CSE-ConnectionGUID: WJCLY2QYRPy5unj/1JWV7g==
X-CSE-MsgGUID: XdKVVaesT7uYvNBBqQ8IMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898956"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898956"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:33 -0700
X-CSE-ConnectionGUID: PrhNG0Y0SbyrFiYyhoZMuA==
X-CSE-MsgGUID: wvfIqF7iT1W0MHZ5ytwbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206315"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/14] wifi: mac80211_hwsim: some more NAN patches
Date: Tue,  5 May 2026 19:42:05 +0300
Message-Id: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 899D54D1813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35924-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi,

This series completes the hwsim support for NAN.

Thanks,
Miri
---

Benjamin Berg (5):
  wifi: mac80211_hwsim: limit TX of frames to the NAN DW
  wifi: mac80211_hwsim: select NAN TX channel based on current TSF
  wifi: mac80211_hwsim: only RX on NAN when active on a slot
  wifi: mac80211_hwsim: protect tsf_offset using a spinlock
  wifi: mac80211_hwsim: implement NAN synchronization

Daniel Gabay (7):
  wifi: mac80211_hwsim: add NAN_DATA interface limits
  wifi: mac80211_hwsim: add NAN PHY capabilities
  wifi: mac80211_hwsim: implement NAN schedule callbacks
  wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
  wifi: mac80211_hwsim: add NAN data path TX/RX support
  wifi: mac80211_hwsim: Declare support for secure NAN
  wifi: mac80211_hwsim: enable NAN_DATA interface simulation support

Ilan Peer (2):
  wifi: mac80211_hwsim: Do not declare support for NDPE
  wifi: mac80211_hwsim: Support Tx of multicast data on NAN

 .../net/wireless/virtual/mac80211_hwsim_i.h   |   33 +-
 .../wireless/virtual/mac80211_hwsim_main.c    |  263 +++-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 1191 ++++++++++++++++-
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   74 +-
 4 files changed, 1454 insertions(+), 107 deletions(-)

-- 
2.34.1


