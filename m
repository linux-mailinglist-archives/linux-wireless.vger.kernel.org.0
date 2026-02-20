Return-Path: <linux-wireless+bounces-32055-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKpqI85tmGn4IAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32055-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D516849E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7B83066888
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30634CFC6;
	Fri, 20 Feb 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YLKOjb2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121334AAF6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597220; cv=none; b=OLgvtMu2ag1FkhL8TglpQ4XO48bBmf4FvOGB7qQG6JSrJZ+joqf6WTt/ZnkzClhijpr/uqcz1f4iG1lPdj9H+y3p4d1nhb4FHKGOesk3LjOd8eSOomtphXPouaNYhw0HkUdqSHlYKDvqG9x4kPX5h1Vrw5pYE1fYyJttbkmSsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597220; c=relaxed/simple;
	bh=5vCRI30DeMwrYJ9Tcy3iYF9BrsgJVL2HOmM97LRH0WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9x8aPmUDbgcpVIWrwYYAVIClHSsaFpLNsOQURSI2giqXTSE7uW0yiHlVAG8c9FjZSMKL1FIJMeJMx1/DhskCaP7XON1JRI6fVemT6JqI8AsILMWWqkBXfweX/epyVmpMfVaeUmqlVauvJ87vILZzlmbBH79atIVmx9Z944svW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YLKOjb2I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=s8r63PYxQgSjSKG98nVH8tJ7fEQ1QqMF4+qdy3zv5Vs=; t=1771597219; x=1772806819; 
	b=YLKOjb2IV/44z6n7AGGU/Y9vbtC4wsEj3lRjNhS7vunxTRgwP+GPEJNqjcuqBdOKleJDAQbLzJB
	CraVdLiZMRSN5KgxTBpMRDk9071Yl67dpTfah/NPTYoluem1IzQrhn/CYaWNnRsXERXzY7WCqxscL
	T7yh9krDv7h58SFvwsQC7rPnMNzWM1OS9V09P3ZPmkPhs+ekPBcc193Cs67Aom2Fe8+CJMyqHuHHP
	G2cXoIM/BHSfgKi9kVuvdliD88AkEIBQ39pclr/LfDUwJokxKGVOIbrxqIaQOqYWxAMQkTJeBhSgw
	fgo9310O7iT+8kZUdE3TxwppA+2YrGMFsJWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vtRMY-0000000ECBC-2Y6h;
	Fri, 20 Feb 2026 15:20:10 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 0/8] Adding NO_STA flag and reworking RX link resolution
Date: Fri, 20 Feb 2026 15:19:30 +0100
Message-ID: <20260220141929.206976-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32055-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: F28D516849E
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

Hi,

This patchset refactors the RX link resolution a bit to fix some issues
where mac80211 might accept frames on the wrong link and incorrectly
translate the address. It also adds a new NL80211_ATTR_FRAME_CMD_NO_STA
flag so that userspace can know whether address translation was done by
the kernel on RX and can also prevent address translation for management
frames during TX.

This together should be enough to fix the existing issues in hostapd
where stations that are still associated try to authenticate again but
hostapd for example ends up sending the frame to an old link address.

I would appreciate if you test the patches and work on the hostapd side.
Note that I have not properly verified the new nl80211 API, so it could
well be that I missed something.

Benjamin

Benjamin Berg (8):
  wifi: iwlwifi: use link_sta internally to the driver
  wifi: mac80211: change public RX API to use link stations
  wifi: mac80211: refactor RX link_id and station handling
  wifi: mac80211: rework RX packet handling
  wifi: cfg80211: add attribute for TX/RX denoting there is no station
  wifi: mac80211: report to cfg80211 when no STA is known for a frame
  wifi: mac80211: pass station to ieee80211_tx_skb_tid
  wifi: mac80211: pass error station if non-STA transmit was requested

 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  21 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  50 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   2 +-
 .../wireless/intel/iwlwifi/mld/tests/agg.c    |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   6 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   3 -
 include/net/cfg80211.h                        |   4 +
 include/net/mac80211.h                        |  25 +-
 include/uapi/linux/nl80211.h                  |   7 +
 net/mac80211/agg-tx.c                         |   6 +-
 net/mac80211/eht.c                            |   3 -
 net/mac80211/ht.c                             |   4 +-
 net/mac80211/ieee80211_i.h                    |  14 +-
 net/mac80211/iface.c                          |   7 +-
 net/mac80211/mlme.c                           |   9 +-
 net/mac80211/offchannel.c                     |  13 +-
 net/mac80211/rx.c                             | 438 ++++++++++--------
 net/mac80211/scan.c                           |  10 +-
 net/mac80211/tdls.c                           |   4 +-
 net/mac80211/tx.c                             |   8 +-
 net/wireless/nl80211.c                        |   8 +-
 23 files changed, 358 insertions(+), 297 deletions(-)

-- 
2.53.0


