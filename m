Return-Path: <linux-wireless+bounces-29400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B1C924B6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9009D3AA8D5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F232FA37;
	Fri, 28 Nov 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bk56CRpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A832F748
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339665; cv=none; b=W+aPhhy/6A3smTgCCm1V6GxiiLREAgADtrt1Jjc9ULXh6JN1sVsgTAAf4L/V1TJqXIX08Us427fbBOkUHRjrk0dmQYd8wEhrRu1tVDyaXPI5PhFCxeUItm9HVCJ5aULe3Bs9UmfNnHFE9lM3nitqgq3Tg+NT/P38+OLJ/kPq0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339665; c=relaxed/simple;
	bh=vJwdHIyNeMiJKTJPKQYclQNelf0JAiGEK6OfWr30mA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBkH48cMSVGycU/7nsWNzLBOPeOsvO046tKJMqq6Ahru6JJG93+Zal7h/doThOtg2xyOBM50oJV4qlOmFi74Exg/T2r1Sbmf7TG2hxHrowxBp8Do4JqsDJBUpnid87f/Lnv1FxVi8moX5gnGr3Qp3ZiPMBdldDyU6Sj/Szcw7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bk56CRpZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=uFqNAEEemt8sX0mej90ZlzQ3BjUXZfpenqV+hoemxpU=; t=1764339663; x=1765549263; 
	b=bk56CRpZoyFWLsdYVnlWyK04FaYCUpUyXczsiVNrA93xNfvC+bp4vpRdeleoui9g9mUWq0ogAwq
	7OgeWiyWp/qoVwM44T/wAJR4Bd41B3ExGQzioTW3xv+ExJgRWWCC6Eguj7mGHdB7zSyS+tCOdH1sW
	j9ej/L7IhwnLQw7EmgtOfur+axKW9nzA2Vv1JOZZpIFlMqZdAEcUAJGX5kYj3/hzMYhZ1oBb7t8F6
	eRWDHkTdOp34thAbDzuxE83xZTEAuaGNbqidyGoU+s99T/IiTeu+x2BwNpOv6+I5bmlEeTja7J8/E
	dg8ZW3ZNFVlWn0MYCIaaDQRnX/AdGxcDQH+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLC-00000003926-3NiP;
	Fri, 28 Nov 2025 15:20:55 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 00/18] NAN synchronization for mac80211_hwsim
Date: Fri, 28 Nov 2025 15:15:38 +0100
Message-ID: <20251128141537.287627-20-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Hi,

These patches add support for NAN synchronization to mac80211_hwsim.
This is useful to better model the NAN synchronization behaviour and
also permits testing more complicated setups where a wmediumd instance
is used (possibly between multiple VMs).

Note that the current implementation is somewhat simplified and only
synchronizes on 2.4 GHz (it does send beacons on 5 GHz). It'll also
ignore beacons outside of the 2.4 GHz DW, which may lead to slow
discovery of newly visible NAN clusters.

Apart from this, synchronization should work well. There is no data path
at this point as the corresponding mac80211 API is not yet ready.

Benjamin

Benjamin Berg (18):
  wifi: mac80211_hwsim: fix typo in frequency notification
  wifi: mac80211_hwsim: disable BHs for hwsim_radio_lock
  wifi: mac80211_hwsim: remove unused nan_vif struct member
  wifi: mac80211_hwsim: move NAN related variables into a struct
  wifi: mac80211_hwsim: split NAN handling into separate file
  wifi: mac80211_hwsim: rename and switch simulation time to boottime
  wifi: mac80211_hwsim: move timestamp writing later in the datapath
  wifi: mac80211_hwsim: register beacon timer by calculating TBTT
  wifi: mac80211_hwsim: refactor NAN timer handling
  wifi: mac80211_hwsim: switch to use TXQs
  wifi: mac80211: add a TXQ for management frames on NAN devices
  wifi: mac80211_hwsim: limit TX of frames to the NAN DW
  wifi: mac80211_hwsim: select NAN TX channel based on current TSF
  wifi: mac80211_hwsim: only RX on NAN when active on a slot
  wifi: mac80211_hwsim: protect tsf_offset using a spinlock
  wifi: ieee80211: add more NAN definitions
  wifi: mac80211: export ieee80211_calculate_rx_timestamp
  wifi: mac80211_hwsim: implement NAN synchronization

 drivers/net/wireless/virtual/Makefile         |    2 +
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  146 +++
 ...mac80211_hwsim.c => mac80211_hwsim_main.c} |  573 +++-------
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 1012 +++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   89 ++
 include/linux/ieee80211-nan.h                 |   37 +
 include/linux/ieee80211.h                     |    1 +
 include/net/mac80211.h                        |   20 +
 net/mac80211/ibss.c                           |    2 +-
 net/mac80211/ieee80211_i.h                    |    4 -
 net/mac80211/iface.c                          |   28 +-
 net/mac80211/mesh_sync.c                      |    2 +-
 net/mac80211/rx.c                             |    2 +-
 net/mac80211/scan.c                           |    2 +-
 net/mac80211/tx.c                             |   16 +-
 net/mac80211/util.c                           |   51 +-
 16 files changed, 1551 insertions(+), 436 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (94%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h

-- 
2.51.1


