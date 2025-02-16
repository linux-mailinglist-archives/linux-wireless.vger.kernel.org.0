Return-Path: <linux-wireless+bounces-18970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A9A37372
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1336B1888CFB
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1818C93C;
	Sun, 16 Feb 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cb1zWBgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6A290F
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699017; cv=none; b=P1jBZ1UgTDDpW/JMujSWMN0k6NhvRtOeunaz/Dard3tAzF2ITdIxcH/SSgqVlTH87FEH2M9CbYbfNpfWXdsw5xNQe0avHOofxKlICwio2B3t6mxqJv0Gt3GMMnosR+31hd9PQggxh7mtXWyxmLBfbP/0KfCHsHzwYJjsvbLlgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699017; c=relaxed/simple;
	bh=rtiu69FaOWLrF8gvel3ls4SbyDprvTf3WJQlbt8zPAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJymBBBFu4zWg0aZxckxqmmRSso6pmnCF0Mgydih+gyQHk14JRq83Nfb0glJt0V1YDlvevlPCWEtv8eywgBRXjkDQJU3bw+7hnxvyTjjPVL8RkAXswvlys93zHU0ymvUswXO4amK0JMmonfL17NoV5w3Q4CuRScsum+YxNsXyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cb1zWBgg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699016; x=1771235016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rtiu69FaOWLrF8gvel3ls4SbyDprvTf3WJQlbt8zPAc=;
  b=Cb1zWBgg/j+y9SkheSu5LjC/fxywE13WENMl3PS9q7KGXUeydIBg5rTu
   X0F73rQFBKjXtC6EbqUdjmGFX+9h5s6L8fVq/Yp7GJRrdW5rVUoOw7ITc
   3iwiiXwx+5/0FTcbkiyhZTXk3bj7QqtGbaXwRauT73d9swl4TE5DzAMGJ
   2w+uwefECkabmtoXU4QgSUqZ6On3YvXTcldYwss00X2xaM8cIRRneUf4r
   MdpoFzGelhj35KtQfaPcS9fdD2DUVUa6Is+85K+atXxoBRViulnrAUavu
   1oooknYkKsl0LB65lQgBDX8X0mk8fFe5PlYYPfyhSftwZxj7lZmxX38bl
   w==;
X-CSE-ConnectionGUID: ezC9Vd4QRbmqqFHkZbLO/w==
X-CSE-MsgGUID: 6+PyhzWET6e9DUj6CvgYBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323341"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:35 -0800
X-CSE-ConnectionGUID: JOQOzsyJSk64USUAnbSoKw==
X-CSE-MsgGUID: xnZA8ybKQ8GBeby5WxHLiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785189"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 00/42] wifi: iwlwifi: mld: introduce iwlmld
Date: Sun, 16 Feb 2025 11:42:39 +0200
Message-Id: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlwifi is the driver of all Intel wifi devices since 2008.
Since then, the hardware has changed a lot, but the firmware
API has changed even more. The need to keep one driver that
supports all those different APIs led us to introduce a new
architecture circa 2012 which allowed us to keep the same
interface to the hardware (DMAs, Tx queues, etc...) with a
new layer to implement the mid-layer between mac80211 and
the firmware. The first component is called the 'transport'
and the latter is called 'operation_mode' a.k.a  op_mode.

In 2013 we took advantage of the new architecture to
introduce iwlmvm which allowed us to implement the, then,
new firmware API. This op_mode supports 7260 and up, those
devices supports support at least VHT.

Since then, wifi evolved and so did the firmware. It became
much bigger and took a lot of functionality from the driver.
It became increasingly hard to keep the same op_mode for the
newest devices and we experienced frequent regressions on
older devices. In order to avoid those regressions and keep
the code maintainable, we decided it was about time to start
a new op_mode.

iwlmld is a new op_mode that supports BE200 or newer if the
firmware being used is 97.ucode or newer. If the user has
an older devices or BE200 with .96.ucode, iwlmvm will be
loaded. Of course, this op_mode selection is seamless.

All the features supported in iwlmvm are supported in
iwlmld besides a few seldom used use cases: injection and
Hotspot 2.0. Those are under work.

A few points about the implementation:
 * iwlmld doesn't have any mutexes, it relies on the
   wiphy_lock
 * iwlmld is more "resource oriented": stations, links and
   interfaces are allocated and freed only after all the
   relevant flows are completed.
 * Firmware notifications' sizes are validated in a more
   structured way.

We would love to see this new op_mode merged in 6.15. The
firmware for this new driver (.97.ucode) is not yet publicly
available but it'll be sent very soon.
People eager to get an early version of this firmware can
contact Emmanuel at:
emmanuel.grumbach@intel.com

I've listed the people who directly contributed
code, but many others from various teams have
contributed in other ways.

Co-developed-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Avraham Stern <avraham.stern@intel.com>
Co-developed-by: Daniel Gabay <daniel.gabay@intel.com>
Co-developed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Co-developed-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Co-developed-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Co-developed-by: Benjamin Berg <benjamin.berg@intel.com>
Co-developed-by: Shaul Triebitz <shaul.triebitz@intel.com>

  wifi: iwlwifi: mld: add file agg.h/c
  wifi: iwlwifi: mld: add file ap.h/c
  wifi: iwlwifi: mld: add file coex.h/c
  wifi: iwlwifi: mld: add file constants.h
  wifi: iwlwifi: mld: add file d3.h/c
  wifi: iwlwifi: mld: add file debugfs.h/c
  wifi: iwlwifi: mld: add file ftm-initiator.h/c
  wifi: iwlwifi: mld: add file fw.c
  wifi: iwlwifi: mld: add file hcmd.h
  wifi: iwlwifi: mld: add file iface.h/c
  wifi: iwlwifi: mld: add file key.h/c
  wifi: iwlwifi: mld: add file led.h/c
  wifi: iwlwifi: mld: add file link.h/c
  wifi: iwlwifi: mld: add file low_latency.h/c
  wifi: iwlwifi: mld: add file mac80211.h/c
  wifi: iwlwifi: mld: add file mcc.h/c
  wifi: iwlwifi: mld: add file mld.h/c
  wifi: iwlwifi: mld: add file mlo.h/c
  wifi: iwlwifi: mld: add file notif.h/c
  wifi: iwlwifi: mld: add file phy.h/c
  wifi: iwlwifi: mld: add file power.h/c
  wifi: iwlwifi: mld: add file ptp.h/c
  wifi: iwlwifi: mld: add file regulatory.h/c
  wifi: iwlwifi: mld: add file roc.h/c
  wifi: iwlwifi: mld: add file rx.h/c
  wifi: iwlwifi: mld: add file scan.h/c
  wifi: iwlwifi: mld: add file session-protect.h/c
  wifi: iwlwifi: mld: add file sta.h/c
  wifi: iwlwifi: mld: add file stats.h/c
  wifi: iwlwifi: mld: add file thermal.h/c
  wifi: iwlwifi: mld: add file time_sync.h/c
  wifi: iwlwifi: mld: add file tlc.h/c
  wifi: iwlwifi: mld: add file tx.h/c
  wifi: iwlwifi: mld: add KUnit test file agg.c
  wifi: iwlwifi: mld: add KUnit test file hcmd.c
  wifi: iwlwifi: mld: add KUnit test file link.c
  wifi: iwlwifi: mld: add KUnit test file link-selection.c
  wifi: iwlwifi: mld: add KUnit tests module file
  wifi: iwlwifi: mld: add KUnit test file rx.c
  wifi: iwlwifi: mld: add KUnit utils.h/c
  wifi: iwlwifi: mld: add KUnit tests Makefile
  wifi: iwlwifi: mld: add the new operation mode

 drivers/net/wireless/intel/iwlwifi/Kconfig    |   16 +-
 drivers/net/wireless/intel/iwlwifi/Makefile   |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    5 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   28 +-
 .../net/wireless/intel/iwlwifi/mld/Makefile   |   16 +
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |  671 +++++
 drivers/net/wireless/intel/iwlwifi/mld/agg.h  |  128 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |  344 +++
 drivers/net/wireless/intel/iwlwifi/mld/ap.h   |   46 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |   40 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.h |   15 +
 .../wireless/intel/iwlwifi/mld/constants.h    |   88 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 1998 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/d3.h   |   51 +
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  826 +++++
 .../net/wireless/intel/iwlwifi/mld/debugfs.h  |  200 ++
 .../intel/iwlwifi/mld/ftm-initiator.c         |  451 +++
 .../intel/iwlwifi/mld/ftm-initiator.h         |   15 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  536 ++++
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h |   54 +
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  671 +++++
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  234 ++
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  358 +++
 drivers/net/wireless/intel/iwlwifi/mld/key.h  |   39 +
 drivers/net/wireless/intel/iwlwifi/mld/led.c  |  100 +
 drivers/net/wireless/intel/iwlwifi/mld/led.h  |   29 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 1216 ++++++++
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  153 +
 .../wireless/intel/iwlwifi/mld/low_latency.c  |  335 +++
 .../wireless/intel/iwlwifi/mld/low_latency.h  |   68 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 2672 +++++++++++++++++
 .../net/wireless/intel/iwlwifi/mld/mac80211.h |   13 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  329 ++
 drivers/net/wireless/intel/iwlwifi/mld/mcc.h  |   17 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  707 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  586 ++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  993 ++++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  157 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  755 +++++
 .../net/wireless/intel/iwlwifi/mld/notif.h    |   35 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  |  116 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |   49 +
 .../net/wireless/intel/iwlwifi/mld/power.c    |  395 +++
 .../net/wireless/intel/iwlwifi/mld/power.h    |   33 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |  321 ++
 drivers/net/wireless/intel/iwlwifi/mld/ptp.h  |   45 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  393 +++
 .../wireless/intel/iwlwifi/mld/regulatory.h   |   23 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.h  |   20 +
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 2060 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   72 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 2006 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  135 +
 .../intel/iwlwifi/mld/session-protect.c       |  222 ++
 .../intel/iwlwifi/mld/session-protect.h       |  102 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 1265 ++++++++
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  266 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  510 ++++
 .../net/wireless/intel/iwlwifi/mld/stats.h    |   22 +
 .../wireless/intel/iwlwifi/mld/tests/Makefile |    5 +
 .../wireless/intel/iwlwifi/mld/tests/agg.c    |  663 ++++
 .../wireless/intel/iwlwifi/mld/tests/hcmd.c   |   62 +
 .../intel/iwlwifi/mld/tests/link-selection.c  |  171 ++
 .../wireless/intel/iwlwifi/mld/tests/link.c   |  103 +
 .../wireless/intel/iwlwifi/mld/tests/module.c |   11 +
 .../net/wireless/intel/iwlwifi/mld/tests/rx.c |  353 +++
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  475 +++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |  124 +
 .../net/wireless/intel/iwlwifi/mld/thermal.c  |  438 +++
 .../net/wireless/intel/iwlwifi/mld/thermal.h  |   36 +
 .../wireless/intel/iwlwifi/mld/time_sync.c    |  240 ++
 .../wireless/intel/iwlwifi/mld/time_sync.h    |   26 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  717 +++++
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h  |   23 +
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 1374 +++++++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.h   |   77 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    9 +-
 78 files changed, 27958 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/constants.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/fw.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/module.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.h

-- 
2.34.1


