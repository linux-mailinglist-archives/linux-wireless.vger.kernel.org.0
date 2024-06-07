Return-Path: <linux-wireless+bounces-8711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F59009FB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08807286981
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958619D08F;
	Fri,  7 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nwfhEr9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFA19A297
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776358; cv=none; b=rEU/Vsp/f1qN1UEVjv3rZQbxILH3wPh9XdToO/Tijmvgradz9rmjrPCTlM6uHOA/nerChSqT8FcQSQIdhOkPvLhynUdhf1J98QCxBZbMHSBXcj8OZnaqq8O3z7WEynLSN6cKPIdvEzp4h0cW/MBZhWUfdA2UBOPhiGUopw9OlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776358; c=relaxed/simple;
	bh=JzD/t95YbJcvN601o3J6jZei3N5ar5pOgAGAlWxVlyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBlrtNe14d+RV7S6NvBCVZ1mijaxDgz76/sGLoYX6Okj9VWxqOcQrxuQTpjsgAMPx38Kg6/iQ5Wr/yLqx1kHlYU/LJL3FS5a9++I15o7+5OaZGOgvk3SMl8CiOI/cEaugnFuw/zcvdMs9IJAbXdEeBYpFxt9FfPfFjCsoUM7NyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nwfhEr9s; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P9bW8YE3ERqwkPgGvO1IAlC1dNoSvZrIQuSqO0M2FTA=; b=nwfhEr9skVuLCLufX+xnVd6cl8
	tnBkUd5tSwIqSmtYy/d2uHRZodT+k0pFSfZeQOSGbI+h5dc5V0jIHsD+YMSHoVTcc7jBfT4oNLRpe
	TdUvcyMiHwiut5mIoLbGjQCyrvS6q2ltpY4eJPjQhWyyDAznsdu0vzFC1cbUab6Gg0N0=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFc69-008xPc-20;
	Fri, 07 Jun 2024 18:05:49 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v4 0/9] cfg80211/mac80211: support defining multiple radios per wiphy
Date: Fri,  7 Jun 2024 18:05:39 +0200
Message-ID: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
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

With this change, supported frequencies and interface combinations of each
individual radio are reported to user space. This allows user space to figure
out the limitations of what combination of channels can be used concurrently.

Each mac80211 channel context is assigned to a radio based on radio specific
frequency ranges and interface combinations.

Even for non-MLO devices, this improves support for devices capable of
running on multiple channels at the same time.

This is loosely based on Karthikeyan Periyasamy's series
"[PATCH 00/13] wifi: Add multi physical hardware iface combination support"
with some differences:

 - a struct wiphy_radio is defined, which holds the frequency ranges and
   a full struct ieee80211_iface_combination array
 - a channel context is explicitly assigned to a radio when created
 - both global and per-radio interface combination limits are checked
   and enforced on channel context assignment
 - improve comments/docs and attributes
 - add cfg80211 helper for checking radio freq range

Changes since RFC v3:
 - fix __ieee80211_get_radio_mask to return per-vif radio mask
 - fix params->radio in ieee80211_check_combinations()
 - fix indentation
 - pass radio_idx in struct iface_combination_params
 - improve get_radio_mask callback

Changes since RFC v2:
 - fix uninitialized variables
 - fix multiple radios with DFS
 - add support for per-radio beacon interval checking

Changes since RFC:
 - replace static per-radio number of channels limit with full ifcomb
   checks
 - remove band bitmask in favor of only using freq ranges

Felix Fietkau (9):
  wifi: nl80211: split helper function from nl80211_put_iface_combinations
  wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
  wifi: cfg80211: extend interface combination check for multi-radio
  wifi: cfg80211: add helper for checking if a chandef is valid on a radio
  wifi: mac80211: add support for DFS with multiple radios
  wifi: mac80211: add radio index to ieee80211_chanctx_conf
  wifi: mac80211: extend ifcomb check functions for multi-radio
  wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
  wifi: mac80211: add wiphy radio assignment and validation

 include/net/cfg80211.h       |  51 +++++++++-
 include/net/mac80211.h       |   2 +-
 include/uapi/linux/nl80211.h |  51 +++++++++-
 net/mac80211/cfg.c           |   7 +-
 net/mac80211/chan.c          | 210 ++++++++++++++++++++++--------------
 net/mac80211/ibss.c          |   2 +-
 net/mac80211/ieee80211_i.h   |   5 +-
 net/mac80211/iface.c         |   2 +-
 net/mac80211/main.c          |  32 +++--
 net/mac80211/util.c          | 127 +++++++++++++++-------
 net/wireless/nl80211.c       | 190 +++++++++++++++++++++++----------
 net/wireless/rdev-ops.h      |  17 +++-
 net/wireless/trace.h         |   5 +-
 net/wireless/util.c          |  68 ++++++++++--
 14 files changed, 579 insertions(+), 190 deletions(-)

base-commit: 5bcd9a0a59953b5ff55ac226f903397319bf7f40
-- 
git-series 0.9.1

