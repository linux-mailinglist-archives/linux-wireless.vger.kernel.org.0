Return-Path: <linux-wireless+bounces-33007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAz/ONf1sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6A26B27F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7AE0306E879
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23AE1E8320;
	Wed, 11 Mar 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="GT6vR1fq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B1391832
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270468; cv=none; b=MHUNQd1dCn316PiVMewUxGaPQ0ZBAoNVjKUFQSKkV6u07F/7/qcsT9TXeCkd5iGEp2uM/Kpgxhy0YH++X0IwVErAXS4qa4dRYwsl/GKoTJZNOrSsrgPrAryvtCabm6xLeyLp23OfOseQAD3Sq1RWOgPTEtdctIq0e0fxIKMjHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270468; c=relaxed/simple;
	bh=RrLhKJsfqnr/ebK1FdVxEJn1evpCJaRYTmc4Y+nqs20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLkFE1xRDjgh19rehApaytnUtSR5bKSRFtEyRtCAR9vadi0tiNADCGNQXxdRINDAHJz7Iwx8LQiUPmckj/O2EQVRVvSDBHkjcfkevAksUvLFk2BB6Ku6pDVKEK3/4dfSCpW0M5tcd8q0T4WnommMd6LBtRNK0kCfFtgsJz6fteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=GT6vR1fq; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BB3D3240084
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:38 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 0EC0913C2B0;
	Wed, 11 Mar 2026 16:07:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0EC0913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270456;
	bh=RrLhKJsfqnr/ebK1FdVxEJn1evpCJaRYTmc4Y+nqs20=;
	h=From:To:Cc:Subject:Date:From;
	b=GT6vR1fq2IJLH3po3s9KI78xZnxx20S3AZxweMmLmxO3/yUWAaAZadTUUJT4p1n9i
	 xeI+1bhBHPLjmOEMrK82gmeE1BVf4xjZPNyYVCRnMukrHgsTD6BZuwdTul3AwDquyu
	 dJ93bWIyQcjoqg5FBTyKD9HDKaXeI3nuPNolGVD8=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 00/28] iwlwifi + mac80211 stability
Date: Wed, 11 Mar 2026 16:07:02 -0700
Message-ID: <20260311230730.163348-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270459-rwJCGAAgBvNK
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270459;rwJCGAAgBvNK;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33007-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88C6A26B27F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

mac80211 and iwlwifi stability patches from our internal
tree.

General test case is 40 be200 radios attempting to connect and
run max traffic against an AP that doesn't really like that many
eMLSR stations.  Firmware crashes, AP rejections, assoc timeouts,
and other problems are seen often, and that seems to hit a lot
of edge cases.  Kernel has kasan, lockdep and other debugging
enabled.

This was primarily tested against 6.18.14 stable kernel, but has been
revised to work against wireless-next and it is passing at least the
first hour of tests so far.  Likely some problems still remain in
this area.

checkpatch seems mostly satisfied.

Ben Greear (28):
  wifi: iwlwifi: mld:  Check for NULL before lookup.
  wifi: iwlwifi: mld: Fix un-set return value in error case.
  wifi: iwlwifi: mld: Add check for null vif in stats callback.
  wifi: mac80211:  Check debugfs creation return values.
  wifi: mac80211: do not fail taking sta to lower state.
  wifi: mac80211: Mark sta as uploaded if single transition succeeds.
  wifi: mac80211:  Fix use-after-free of debugfs inodes.
  wifi: mac80211: Debugfs safety checks.
  wifi: mac80211: Use warn-on-once in drv_remove_chanctxt
  wifi: mac80211: Ensure sta debugfs is not double-freed.
  wifi: iwlwifi: mld: Fix stale reference in fw_id_to_link_sta
  wifi: iwlwifi: mld:  Improve logging in error cases.
  wifi: iwlwifi: mld: Remove warning about BAID.
  wifi: mac80211: Add dmesg log regarding warn-on in drv-stop.
  wifi: iwlwifi: mld: Fix use-after-free of bss_conf
  wifi: iwlwifi: mld: Check for null in iwl_mld_wait_sta_txqs_empty
  wifi: iwlwifi: mld: use warn-on-once in error path.
  wifi: iwlwifi: mld: Use warn-on-once in emlsr exit logic.
  wifi: iwlwifi: mld: Improve error message in rx path.
  wifi: iwlwifi: mld: Improve logging message.
  wifi: iwlwifi: mld: Protect from null mld_sta
  wifi: mac80211: Add force-cleanup call to driver.
  wifi: iwlwifi: mld: Support force-cleanup op
  wifi: iwlwifi: mld: Fix NPE in flush logic.
  wifi: iwlwifi: mld: Fix bad return address in tx code.
  wifi: mac80211: Ensure link work-items are only initialized once.
  wifi: iwlwifi: mld: Convert to WARN_ONCE in link removal path.
  wifi: mac80211: Decrease WARN spam.

 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  20 +++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  42 +++++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  21 +++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  20 +++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.h   |   2 +
 include/net/mac80211.h                        |   7 ++
 net/mac80211/debugfs.c                        |  11 ++
 net/mac80211/debugfs_key.c                    |   6 +
 net/mac80211/debugfs_netdev.c                 | 106 +++++++++++++++++-
 net/mac80211/debugfs_sta.c                    |  15 +++
 net/mac80211/driver-ops.c                     |  10 +-
 net/mac80211/driver-ops.h                     |  12 +-
 net/mac80211/ieee80211_i.h                    |   1 +
 net/mac80211/link.c                           |  29 +++--
 net/mac80211/sta_info.c                       |   8 +-
 net/mac80211/util.c                           |   8 +-
 20 files changed, 286 insertions(+), 45 deletions(-)

-- 
2.42.0


