Return-Path: <linux-wireless+bounces-8631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0568FF442
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD39828A324
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89744199250;
	Thu,  6 Jun 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="K04SaZHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6B16FF26
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697239; cv=none; b=pA0blF95Z4zmepthvTajTuCUsmLDg2/Sr0wweRPhecOXOEUZkxFTn/EGKP2iW7XXBPF5XRtKwJFOy0SnkOM6QCWXyY5rklV4GqivjLLriULEvMYUeZKTmlYavDcNsmTz0p/nn+fgCwNIScnYQaTnVA3VmPN+CbI0h+WNgx9lBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697239; c=relaxed/simple;
	bh=ypJAjcNfQaML1Sw6psCg1bQPD5VRSPgXt99ZN4xlttA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5EYa/merGis0NYpcKRHup+//N7BCwcadLQ57WdaDf8XyctEGFIiwlyIwSdy0KBSn8DMCSKlwkHtO+J+nksQTgpr95/gv8YEuj7uNgQESJq5itbvgyYw6Z0O7R4El8RDhxCgC/YbUJYAXGF9smmIVDo6ivtkwlAHCbWkCwQ1M2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=K04SaZHN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CqwUBAgIy/bF068vQeu7eSci844EoGdF2SscwS3MCvs=; b=K04SaZHNg9fE2Pg0a3GDLStAjS
	5z5ItaJ1IgYqpvrTT+l/bxtbiZ6r2tQtS7qRNdAbYxtqwFXAvDTWESnR966ljWE2yQmztTNdsaqxN
	LVfTnD0xPtqL8mL1VZkV/FIAMiNSg7+azZjPCazr2rHeC4EczRWy26FRiKi1Qa90mmoM=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFHW5-008aic-32;
	Thu, 06 Jun 2024 20:07:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v3 0/8] cfg80211/mac80211: support defining multiple radios per wiphy
Date: Thu,  6 Jun 2024 20:07:05 +0200
Message-ID: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prerequisite for MLO support in cfg80211/mac80211 is that all the links
participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
expectation, some drivers may need to group multiple discrete hardware each
acting as a link in MLO under single wiphy.

With this series, the bands and supported frequencies of each individual
radio are reported to user space. This allows user space to figure out the
limitations of what combination of channels can be used concurrently.

Each mac80211 channel context is assigned to a radio based on radio specific
frequency ranges and interface combinations.

This is loosely based on Karthikeyan Periyasamy's series
"[PATCH 00/13] wifi: Add multi physical hardware iface combination support"
with some differences:

 - a struct wiphy_radio is defined, which holds the frequency ranges and
   a full struct ieee80211_iface_combination array
 - a channel context is explicitly assigned to a radio when created
 - both global and per-radio interface combination limits are checked
   and enforced on channel context assignment

Changes since RFC v2:
 - fix uninitialized variables
 - fix multiple radios with DFS
 - add support for per-radio beacon interval checking

Changes since RFC:
 - replace static per-radio number of channels limit with full ifcomb
   checks
 - remove band bitmask in favor of only using freq ranges

Felix Fietkau (8):
  wifi: nl80211: split helper function from nl80211_put_iface_combinations
  wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
  wifi: cfg80211: extend interface combination check for multi-radio
  wifi: mac80211: add support for DFS with multiple radios
  wifi: mac80211: add radio index to ieee80211_chanctx_conf
  wifi: mac80211: extend ifcomb check functions for multi-radio
  wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
  wifi: mac80211: add wiphy radio assignment and validation

 include/net/cfg80211.h       |  43 +++++++-
 include/net/mac80211.h       |   2 +-
 include/uapi/linux/nl80211.h |  48 ++++++++-
 net/mac80211/cfg.c           |   7 +-
 net/mac80211/chan.c          | 228 +++++++++++++++++++++++-------------
 net/mac80211/ibss.c          |   2 +-
 net/mac80211/ieee80211_i.h   |   6 +-
 net/mac80211/iface.c         |   2 +-
 net/mac80211/main.c          |  32 +++--
 net/mac80211/util.c          | 131 +++++++++++++++------
 net/wireless/nl80211.c       | 190 +++++++++++++++++++++---------
 net/wireless/rdev-ops.h      |  17 +++-
 net/wireless/trace.h         |   5 +-
 net/wireless/util.c          |  36 ++++--
 14 files changed, 560 insertions(+), 189 deletions(-)

base-commit: 5bcd9a0a59953b5ff55ac226f903397319bf7f40
-- 
git-series 0.9.1

