Return-Path: <linux-wireless+bounces-33123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEbgEvTysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EF27661D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB20300B3F8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684D239C636;
	Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="jSrztf6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75C38839D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334864; cv=none; b=sZE4Qy/Tizae8zLfhhna1sJnJejldaLw6AeVALS8dP3t080PpJiMm6rAffFrfRrsAFElwZqmMnqPBxryrG347Las5qGSnJ0Sb1D9VHOD65RiKZFMFU2AwPyxA/8YGwT7Y+RPbkYKS7w1h+6hYcmRw24+t/3W5raHOIlzaVOA294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334864; c=relaxed/simple;
	bh=DSCdSK4lU5RQBZjdelV3oyF4A75rcEZSnG/xpqU1mJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSsuOJmgZ1CM6Vs0KU9u3bUz5vjP3VnhiF3ZyetLBXbiry4PBoYnRc5mNtRzJ1FiB5Cp3XHhS7aSR1bFGEB3Yqts7bcshqcSoxsLLm2chxvQPkLrna3boV2taItCJq0CWBu/RiEJxfV2j2Q1l46Pn1+Ej6zsHQrnM0yzAT8APL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=jSrztf6u; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 568A29400D1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id BFC2213C2B0;
	Thu, 12 Mar 2026 10:00:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BFC2213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334857;
	bh=DSCdSK4lU5RQBZjdelV3oyF4A75rcEZSnG/xpqU1mJo=;
	h=From:To:Cc:Subject:Date:From;
	b=jSrztf6u11QwPYr/XQKjbOdQGKAQbAbTI1GIniokbmWbxgPJUxRorWOnNlcrlb9x6
	 bqGIL3ZLTSLK/3qLQbEuRJ30zY9RLciLgH+P4wYRqd+lbI6DMoZlEFHfP5A17DPNPg
	 7baT9Vf9PFW3PCAPvp5kqDc1x/HG/hHovs04xm5c=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 00/28] iwlwifi + mac80211 stability
Date: Thu, 12 Mar 2026 09:59:58 -0700
Message-ID: <20260312170026.285494-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334861-8pLku_mG2oC8
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334861;8pLku_mG2oC8;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33123-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: C19EF27661D
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

v2:  Remove 0002 patch that did not actually do anything useful.
     Add new patch to check debugfs creation in net/wireless.  Hopefully
     this solves the syzbot WARNING that was reported.

Ben Greear (28):
  wifi: iwlwifi: mld:  Check for NULL before lookup.
  wifi: iwlwifi: mld: Add check for null vif in stats callback.
  wifi: wireless:  Check debugfs create return values.
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
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  19 +++-
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
 net/wireless/core.c                           |  11 ++
 21 files changed, 296 insertions(+), 44 deletions(-)

-- 
2.42.0


