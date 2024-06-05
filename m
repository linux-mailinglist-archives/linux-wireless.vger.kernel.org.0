Return-Path: <linux-wireless+bounces-8583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1A8FD601
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06FA28265E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B282213A3EF;
	Wed,  5 Jun 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gejp5XcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB313A890
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613290; cv=none; b=OJPBoyQXrq9jqLI79Sd+jMUaLQvfiR+5x270KCNaY2eU1SvDcb5xJ4bZy8EU06+7kG01kEAkgZXLoLP5JdpezGZwdQCl8CoUc53YFjVDZ7fu0h1jldZvFJkUSHRD7kuzEEb/JSl/xqJ+xBYW6qKNk0M/gtiOMQ70LOqziwjJ2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613290; c=relaxed/simple;
	bh=4Kngy5kV13ZXqeEMnS0bNXe/MRNx8Ww+qyvfA1WXyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsNJGIyerVwh6Es+5+Zn9Ndhx1UNd0cA7I37IVE7KVZ2nXYfiMp7Z/3UwI4D/Mr7UHz3HnBe+bWggeNJ79JZps3AjAk0T/xvZFZ3VrQLWuG4uuvvlsCFIqzCTmw7UuI78cupVTNt9zK5Zr2zOpd+1c6qZwp1FA/viU48YJvWMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gejp5XcE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N8ysX8u8qfjL06FnkJCkxCDGjxY6B9IlU3WUADMIhyU=; b=gejp5XcErJUphH1wVAgVWoQUf4
	CzH3Vqiya1hKNiMy6cqFLyBwZDqc0fMXYO1hq0oHaV3btE2rkMUpKyKlEEC+IWinIfukCTIQYZtJI
	iGvODkoOfacbs+MoJOsNuEuknb/ZvNfbpsvwqdBeWzeZSL6dy97QczGGMJbIkqAU2hmQ=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sEvQ9-008Gwq-0a;
	Wed, 05 Jun 2024 20:31:37 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v2 0/7] cfg80211/mac80211: support defining multiple radios per wiphy
Date: Wed,  5 Jun 2024 20:31:23 +0200
Message-ID: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
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

Changes since RFC:
 - replace static per-radio number of channels limit with full ifcomb
   checks
 - remove band bitmask in favor of only using freq ranges

Felix Fietkau (7):
  wifi: nl80211: split helper function from nl80211_put_iface_combinations
  wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
  wifi: cfg80211: extend interface combination check for multi-radio
  wifi: mac80211: add radio index to ieee80211_chanctx_conf
  wifi: mac80211: extend ifcomb check functions for multi-radio
  wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
  wifi: mac80211: add wiphy radio assignment and validation

 include/net/cfg80211.h       |  40 ++++++-
 include/net/mac80211.h       |   2 +-
 include/uapi/linux/nl80211.h |  48 ++++++++-
 net/mac80211/cfg.c           |   6 +-
 net/mac80211/chan.c          | 228 +++++++++++++++++++++++-------------
 net/mac80211/ibss.c          |   2 +-
 net/mac80211/ieee80211_i.h   |   4 +-
 net/mac80211/iface.c         |   2 +-
 net/mac80211/util.c          | 114 ++++++++++++------
 net/wireless/nl80211.c       | 190 +++++++++++++++++++++---------
 net/wireless/util.c          |  29 ++---
 11 files changed, 481 insertions(+), 184 deletions(-)

base-commit: 5bcd9a0a59953b5ff55ac226f903397319bf7f40
-- 
git-series 0.9.1

