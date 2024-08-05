Return-Path: <linux-wireless+bounces-10968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035294823C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11971C21AE4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D616B386;
	Mon,  5 Aug 2024 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JE4t/HK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC39364AB
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885819; cv=none; b=cLGPbz1IeT7I6fQbXeQoHRmSmGQsf/DBsC4I1DBN76OzRAu22gxzBoTu+YfMoRZBo9qT+MV59xnrEu7FaEY5QJZMU3IhsneDuWgKemJVoratkjfcuQ5YBgLXiQFj1jtRAejvi5ULhqgGEcYSGPdIqV+ckzDeNTVRTuDhYbVX0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885819; c=relaxed/simple;
	bh=gQ43/Idc26J/RSCvUhwd+UCpAf9IxdDpJUnZJuAMC7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHaImOpqeTWCuJspUmrjnijJrO7zu3c+ilkEBRbOH9lbFP/o8lJfObvj3NcM1aFVOPRhjJTiTn13D+JrxVnK2swlgPD0dh7k16jIegNgF+rDf7zlK45n0SdQ8jMIsqTNPmR4vp2rGWhC9EdWzbTEWs03jw1PSsG6fJhfMRgskWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JE4t/HK9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JUXZnlGwHtcRul1l7rlbyzRCBDJ9h+era+3YyOYp6DQ=; b=JE4t/HK9meEYbsiG28TknepUql
	6VALIKG+cmp95oN431jgoupqZTNTHK7+99+yAgJuvYT3hnx/gKwQcc6yvrAnY8BmaSs8g1SWXLeSs
	h9gbu8m9VEHui8Cu5U0DOqoj3g6+1iWyY87Y/IDKRm9VlyP+eE6SATLGQwEQaydaRkc0=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3It-00EHlS-2Y;
	Mon, 05 Aug 2024 21:23:35 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 0/6] wifi: cfg80211/mac80211: improve support for multiple radios
Date: Mon,  5 Aug 2024 21:23:28 +0200
Message-ID: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for restricting vifs to a set of radios.
The allowed radios mask is used to restrict scanning, off-channel activity.
This is also used for per-radio start/stop ops, monitor state and filter
flags. It can also limit per-monitor-vif rx to specific radios.

Felix Fietkau (6):
  wifi: cfg80211/mac80211: add option for vif allowed radios
  wifi: mac80211: remove status->ampdu_delimiter_crc
  wifi: mac80211: notify driver about per-radio monitor enabled state
  wifi: mac80211: support per-radio driver start/stop calls
  wifi: mac80211: support per-radio filter flags
  wifi: mac80211: check vif radio_mask for monitor mode rx

 include/net/cfg80211.h       |  14 +++-
 include/net/mac80211.h       |  33 +++++--
 include/uapi/linux/nl80211.h |   5 +-
 net/mac80211/cfg.c           |   7 ++-
 net/mac80211/chan.c          |  13 ++-
 net/mac80211/driver-ops.h    |  50 +++++++++++-
 net/mac80211/ieee80211_i.h   |  29 +++++--
 net/mac80211/iface.c         | 159 +++++++++++++++++++++++++++---------
 net/mac80211/main.c          |  72 ++++++++++++----
 net/mac80211/mesh.c          |  33 +++++--
 net/mac80211/rx.c            |  65 +++++++--------
 net/mac80211/scan.c          |  10 +-
 net/mac80211/trace.h         |  38 +++++++++-
 net/wireless/nl80211.c       |  46 +++++++++-
 net/wireless/scan.c          |  10 +-
 net/wireless/util.c          |  29 +++++++-
 16 files changed, 494 insertions(+), 119 deletions(-)

base-commit: 30335bbc777aa14ccf5ea329296f59bb30d0180f
-- 
git-series 0.9.1

