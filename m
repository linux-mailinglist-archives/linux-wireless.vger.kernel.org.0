Return-Path: <linux-wireless+bounces-16159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E19EB1FA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 14:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517DA16954A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7D1A08A0;
	Tue, 10 Dec 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q75z1BSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653F19DF4B;
	Tue, 10 Dec 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837661; cv=none; b=bvb8t9jSKTO8PPrCyJbvXHa5651pTKwL3KkSKs4a2U40V9HPg+kjqcQLHcu0I7cyRsgFlwIDvudNmbcy5yOphrCs810rR/2EgtPVKTMq2id7DjWIwd15fx77PKaA7UdNYdCUAhQIqBPdUz+mB+i1ZpLveP9t1VxUHO/pMO9Zo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837661; c=relaxed/simple;
	bh=g3iQbcQOr7dyQ3EfYALIA3Med08yMRWpX7nADQuGN3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRjC9Bt6/HfFbntutvDCo56XWhvFw8KR6zSmWbZaj3QGZdnN60OkE3YS+7wrTH2hFKd+/cLJymb0uhpAE+6O9uzVHnpflZlYOtcl0HMCNdytkOsJeE/Oe7BIw/vz00pzQays/u1CBmyQiXNtqyEHvLQMAPcUoVFI9YclmsP/Lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q75z1BSq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZA0Z+XbKwoZy17m9SInn+B77xWbHgPSpbFAiZ9LdHZ0=; t=1733837660; x=1735047260; 
	b=q75z1BSqZQTtrTdSG/K6tsgS6gcd4NbyZreGx6YLD5H/jDocC/uUKa32qgi8jxhnJyrAOmPPj2L
	WeMZhj/yWM9wQLEDXHe27srPWzElFvCk+TplU5nBe85//9nY0NF24xmQrgwd/gPKYJuPyvXLlUocR
	wdstqDP7Gk/iyOVtnqNaeWIgp2jOFJC3xRFLcyzRXUIyPN5uMBqB6R+wqbXLLCER3u4OLk5UGFMpS
	He04w85WTk744DuJzxfJLhIxte5osEcMVzkQqS2XB/w97iC/+WvQtwwWhMyqxt3dudBD4TL1QBOEr
	tu2ghB5gyECPBvKcplVzTR1OBB6s9h2NiUFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tKzs4-0000000CMeq-2ebh;
	Tue, 10 Dec 2024 14:01:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-12-10
Date: Tue, 10 Dec 2024 14:01:04 +0100
Message-ID: <20241210130145.28618-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

For now, we have a reasonably small number of fixes :)
FWIW our tree was based on -rc1 but net only pulled it
later, but it should now pull only wireless into net.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-12-10

for you to fetch changes up to f1d3334d604cc32db63f6e2b3283011e02294e54:

  wifi: cfg80211: sme: init n_channels before channels[] access (2024-12-06 10:45:22 +0100)

----------------------------------------------------------------
A small set of fixes:
 - avoid CSA warnings during link removal
   (by changing link bitmap after remove)
 - fix # of spatial streams initialisation
 - fix queues getting stuck in some CSA cases
   and resume failures
 - fix interface address when switching monitor mode
 - fix MBSS change flags 32-bit stack corruption
 - more UBSAN __counted_by "fixes" ...
 - fix link ID netlink validation

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: cfg80211: clear link ID from bitmap during link delete after clean up

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Emmanuel Grumbach (2):
      wifi: mac80211: wake the queues in case of failure in resume
      wifi: mac80211: fix a queue stall in certain cases of CSA

Felix Fietkau (1):
      wifi: mac80211: fix vif addr when switching from monitor to station

Haoyu Li (2):
      wifi: mac80211: init cnt before accessing elem in ieee80211_copy_mbssid_beacon
      wifi: cfg80211: sme: init n_channels before channels[] access

Issam Hamdi (1):
      wifi: mac80211: fix mbss changed flags corruption on 32 bit systems

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                            |  7 ++--
 net/mac80211/cfg.c                                | 17 +++++---
 net/mac80211/ieee80211_i.h                        | 49 ++++++++++++++++++-----
 net/mac80211/iface.c                              | 23 ++++-------
 net/mac80211/mesh.c                               |  6 +--
 net/mac80211/mlme.c                               |  2 -
 net/mac80211/util.c                               | 26 +++---------
 net/wireless/nl80211.c                            |  2 +-
 net/wireless/sme.c                                |  1 +
 net/wireless/util.c                               |  3 +-
 11 files changed, 76 insertions(+), 62 deletions(-)

