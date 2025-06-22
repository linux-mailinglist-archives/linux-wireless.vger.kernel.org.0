Return-Path: <linux-wireless+bounces-24322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A16AE32C7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDAE16EA09
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47239219E8C;
	Sun, 22 Jun 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9/Ak8Sp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BFC6136
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631128; cv=none; b=lAg8Ca5tTmh84OiNpnX+bexk1oEUmjX3YV1Fmc9cnuvbOcGHaAP3D4ymCW0OjDVSnLc4QA+D5subqKSxfSGBNl+MiLOhsW2wdNGgfq91m7QanDYKY5RNoHvQyQsP34S4zZoL/bFna1J92dJ14tZzCJ3Zb0LvIbN5NBbrBLwdoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631128; c=relaxed/simple;
	bh=Y0dGfVGe4zpK96ClThSFQWl6PTsFOjwjLUcPC7kNeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCqA1hbr7x9oelX4NJmYabr8Y50S0cd68HUYdIfk30GGqAoLSPsc28UkvyeSpAjVLtpTL4sKK4JAPRxRYWD+hq6Do80VqRBCJIO1ZzJAKOTnqymQvsvxWVe9UdaRtViGo98/D9olQepzWyn0+Nxkx2HAa8Pi4dw/JoTDrF4VBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9/Ak8Sp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631127; x=1782167127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y0dGfVGe4zpK96ClThSFQWl6PTsFOjwjLUcPC7kNeuI=;
  b=l9/Ak8Sp7fh/yKIk1o/2iKlR3bXGhJg3BZ+xk0KOkY82tTBAWkLn9sdo
   iP3mdPLcZVlF/RGO8BYv4+EPaSXzRwmbJykopu0CM3y0X4kSIz0z1A4p1
   ppFZepYAUYfJrXz8NMHoBbyZgoQx5qM0AJd2IrKWyxWNO2IFGnIqu5tFN
   WfiQWFD2SR19Z3WereT4bQOPVoWw8zIt+Z3S/jyg+X/4yJMsbpsZUGUxS
   nFXdUPX1JK1DLwAmRfAhN+rOQda+aG8VSPI8eJtgSKUcEsXqsQAQ/Oteb
   uxfzBkM5kdshJgsV1tlOLhj+xFjR77moIrrNItBgW2a2CEyqKKXNFikPX
   g==;
X-CSE-ConnectionGUID: B0+nKA0kRV2lesxyFN8zXg==
X-CSE-MsgGUID: 62i+Io8jQn6sbX43c8c1gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916069"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916069"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:26 -0700
X-CSE-ConnectionGUID: FcPs3J3jS2STYnTAnmVdNA==
X-CSE-MsgGUID: Koo4O9JtTrG6wygjF+tWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295512"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:24 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 0/5] wifi: nl80211: Extend NAN APIs to allow more flexible implementations
Date: Mon, 23 Jun 2025 01:24:39 +0300
Message-ID: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends exiting NAN APIs to support more
configuration options for NAN synchronization and a user space oriented
NAN Service Discovery implementation.
Existing NAN APIs are very limited and not really used, resulting in
vendors using proprietary vendor commands and a need to offload NAN
protocol implementations to the device firmware or driver.
In this series, additional APIs are added which allow to extend the
configuration of the NAN Synchronization logic and support user space
oriented NAN Service Discovery implementation.
With this design, wireless devices/drivers are still required to
implement NAN synchronization and cluster merging. NAN Discovery Engine,
may be either offloaded (keep using the existing APIs) or alternatively
implemented in user space.
To support user space oriented NAN Discovery Engine, the device will
notify user space with %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION about the
upcoming Discovery Window (DW). This notification should be used as a
trigger for transmission of uncsolicited multicast SDF's (i.e.
unsolicited publish and active subscribe). Once SDF transmission is
requested with %NL80211_CMD_FRAME, the device shall take care of the
actual frame transmission during the upcoming DW.
Note, this notification may be sent before the actual DW start time.
On DW termination, the device/driver shall flush all untransmitted NAN
management frames. Untransmitted frames shall not be carried forward to
the next DW.
Note that such approach may not be appropriate for highly power
efficient devices or scenarios that require long discovery sessions, as
it may require the host to wake up for each DW.
User space can in turn turn off this notification using
%NL80211_NAN_CONF_NOTIFY_DW configuration flag if it doesn't intend to
send unsolicited multicast SDFs to prevent unneeded wake ups.

%NL80211_CMD_NAN_CLUSTER_JOINED notification shall be sent once after
new NAN cluster has been started or the device has joined an existing
cluster. In addition each time, cluster merge procedure results in
cluster merging, user space shall be notified. This is required, as
cluster ID is used as address 3 in SDF frames. Untransmitted frames
should be flushed, when this notification is generated in order to
prevent transmission of SDFs with invalid address 3.

This patch series goal is to provide APIs to support NAN synchronization
and user space oriented Service Discovery. It will be further extended
in a separate patch set to support user space implementation of NAN data
path (NDP) and NDL schedule establishment.

Andrei Otcheretianski (5):
  wifi: nl80211: Add more configuration options for NAN commands
  wifi: nl80211: Add more NAN capabilities
  wifi: nl80211: Add NAN Discovery Window (DW) notification
  wifi: cfg80211: Add cfg80211_next_nan_dw_notif() API
  wifi: cfg80211: Add cluster joined notification API's

 include/net/cfg80211.h       |  95 +++++++++
 include/uapi/linux/nl80211.h | 144 +++++++++++++-
 net/wireless/nl80211.c       | 373 +++++++++++++++++++++++++++++++----
 net/wireless/trace.h         |  34 ++++
 4 files changed, 607 insertions(+), 39 deletions(-)

-- 
2.49.0


