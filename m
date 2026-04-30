Return-Path: <linux-wireless+bounces-35647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ6QGArh8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:56:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B31049D63A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B2E930072B0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766C2C2346;
	Thu, 30 Apr 2026 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="xM7CSgHu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF42282F2B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524997; cv=none; b=EMJ/D/wkTnibERuASclWF3Jh2QJDAng6VDxv62gT4kcmxej1OkRAuZVreHV9g31GgLIjzfE9KUT5ewJeyS7fK7Q7ntlajQ8yVnQfIWrdnPc/Cj6lBqIeqo0eTW8W8ZWqu2+Rji2LDqlyCZ7XV5BBIT2WMxHglifJNYMyZWg7GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524997; c=relaxed/simple;
	bh=6cKZnFur2TpsiZ0oCLiBBb6IopnJiCX6SmWKF2QNtx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf0diqrmmkxGTMdKCloYWvdqkMKI+cPy20RtZyGMdvgd8Jz7tmGwwXhPwuqe+F+lf8n3B/Y/Gn1XeMNUsk47fOURo1v3nGtvZXIKhOgGvo/HWCstBSN5RazXS5KKdxaBv0PyDz2sDyJ4R6u6dh1FkS9ORW85rwwl60+kJDfzT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=xM7CSgHu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82735a41920so197078b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777524995; x=1778129795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrKRXCSO9IyYLxChGV5HUKMlWftoRMZLwdIAAdRcRJ8=;
        b=xM7CSgHuiZcc82uNIl1ZR8jbLjit3TWXxjWXplQatTNraJc34uk17aeWBnso2Srszf
         jW3ifxQSLh0u59a90l5i10uuQwrekwCNTIMQPV1J/tjVUoKo0cokSDsT6UCC0i1qnkdZ
         UIU0qb/Wc+q4d+cIDzduRyjZSt5/la0Ns+TVWbQWNTjMgs5nGt/PToM79oFskXeGOgAX
         MyZGSc1SBHjF4OnBg0KuWVOesD1xvVTE+FvclonVSiPEJOHns9GlH6je89g+rfYXbxw5
         FijggJY6F6DcFPPygaTI98O9XappDw+EKQIqUo3iYbEo7SXW7NNS/qELEgMNqAZ7j/IY
         K6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524995; x=1778129795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrKRXCSO9IyYLxChGV5HUKMlWftoRMZLwdIAAdRcRJ8=;
        b=saNSW3e+JRNaBEuxGUicnSElYD1NQp40lQGQgP5YWGlgm0bJ6ya1AzCYnsH8fo5VsC
         rpkEwd4VLw4DSdvBgZKG/u900xH/5u2sumHvD/rqEiFaNSgaYtkdq+epZnGO+ioQP0n+
         F7mUYijLb4/kwBoobhwBCWHLhvHA2QYOKOm+4pnQ1zstr9SIVKbzwcvFvWQyIqitVyo2
         z2EqvgtbOP+8B9dmWiVavkg7MHuXLsqmvGk1z/F4x2VhzlpKZuEdiai5XHVHrA+PdgYG
         lhWjvnPEfD/NF4NBWqBPPh1hNHz8KtIUk6Xw29zk8sbzDy7VuhJOyW8D8SRBS6+d7lYS
         awtA==
X-Forwarded-Encrypted: i=1; AFNElJ+MTzkFiI/nPPdwQhrKqQByls6WN7rADak3vepBlIFg3DDIzLPrr8YKEf1DTmu/A6wJhgFsxY7YsDesfnfQug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6CAJsaOdM6AWAE+yWKF9BY+ahPxaSC5TLjiDGULFNdZDUElj
	S8Q+xTIZNDAQJbPAwmMEvkBcjFAqkoI05ny36Xw4Gqg9vHXhvF8800hTSX2knC2xOBI=
X-Gm-Gg: AeBDietWBvpD2o1XZCY0GCbN4hDrsQHe+Dtp+4ECYLIx5ooa2CvKN6vYMF4b7P1I2m8
	KJCmNEn1V45ZOWCQoI3esy6WDkNsGmlyuj6oGfBnOEGMVEMUybF1Kf4DIS11Gx5bIFNVCZ4n07z
	Mh0KcQUr8SNB1YlvfByuxhtqwTQ8zefnBHeEjoLLI4oWZrTvbjwLcNRfT3N1q4eJfeimZ91qy8I
	Nj7L8LakCnIguOhFwYG/i71INCesogTCciVtG2XzWftCr8J+n+CFfGnxyPtU5Gt/WCrkccwk7Pt
	Nof8p1ncWINOxMSn3KDyEkCbzEVcCMAy0yscIJ9yqVBsTayiv5X7zxtYrkJ1fmNGa0fXP/YfEy/
	WwwcBciJBfep2yfcvgpxjAL2PgcihGco1EPPH3K0Nx5TZFD4FYpCZaVpgo+4aarF2l7iMg1G2Ke
	Kv5+FM6XvIPT4iFWRVmhBTHwHwPshITXxF/BdgplJah7lXbIFh24+eB9z8bH6cUsrW+oQ9dAkMz
	j6IBYdks6U31eEfF+ya/Fgxhh+li3ebcSjYCe+erA==
X-Received: by 2002:a05:6a00:3499:b0:81f:852b:a925 with SMTP id d2e1a72fcca58-834fdb58a31mr1819928b3a.1.1777524994848;
        Wed, 29 Apr 2026 21:56:34 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:56:34 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 00/31] wifi: mm81x: add mm81x driver
Date: Thu, 30 Apr 2026 14:55:26 +1000
Message-ID: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B31049D63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35647-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This series adds the first Wi-Fi HaLow driver to support the Morse
Micro mm81x chip family via USB and SDIO.

S1G support in the kernel is only new, and as a result this driver has
been scoped to be simple and only support station and AP interface.
The Wi-Fi specific features only cover the minimum required for basic
use such as powersave, aggregation, rate control and so on. The driver
will be extended into the future as S1G support for operations such as
ACS, channel switching and so on are added into the wireless stack.

The driver contains two checkpatch CHECK;s for a static rate array
and a line length of 81 using the same ignore list as the wireless
checkpatch NIPA bot with the exception of OPEN_ENDED_LINE which has
been added.

The driver has been build tested on a long list of architectures and
compilers via Intels LKP.

The driver currently supports IEEE80211-2024 US channels only, with
AU 2020 also available. In order for this to be expanded additional
non-trivial kernel work is required which will begin once the
driver is upstream.

BCFs (Board Files):

https://github.com/MorseMicro/morse-firmware/tree/65ca270dac4ad70d009db6c50b26502177aae9e4/bcf/morsemicro

Every module SHOULD have OTP programmed and the driver will
automatically select the appropriate BCF for the module via the
boardtype symlink. For debugging purposes, or in rare cases where
a module does NOT have the board type programmed, a module parameter
exists to set the bcf accordingly.

Firmware:

https://github.com/MorseMicro/morse-firmware/blob/65ca270dac4ad70d009db6c50b26502177aae9e4/firmware/mm8108b2-rl.bin

Changes since v1:

- move the SDIO ID patch to before the sdio.c
- remove B1 SDIO ID
- significant cleanup and refactor of sdio.c
- make use of module_sdio_driver and module_usb_driver
- refactor core as a separate module such that we now have mm81x_core,
  mm81x_sdio and mm81x_usb
- remove the debug print abstraction, use the existing dev_dbg and
  friends
- remove the global mors->lock since everything was already under
  wiphy lock anyway
- removed UNUSED macro
- remove ret=0 assignment in a few places
- use ieee80211_rx_ni instead of the irq safe version to reduce a level
  of worker indirection
- remove the broadcast management frame lookup, let mac80211 handle it
- emulate chanctx
- remove wrappers around BIT and friends from mmrc
- removed outdated (and unneeded) USB comment
- rename the private struct from 'mm' to 'mors' and friends (mm_vif ->
  mors_vif, mm_sta -> mors_sta etc.)
- move the creation / retrieval of mac address into core.c
- remove noisy logs from both usb and sdio probe
- remove some WARNs from sdio.c and usb.c
- remove device tree bindings and any of associated code from sdio.c
- remove SDIO powersave functionality
- use designated initialisers for initialising commands
- remove some unused response arguments when tx'ing commands

v1: https://lore.kernel.org/linux-wireless/20260227041108.66508-1-lachlan.hodges@morsemicro.com/

The driver has had many authors who are listed below in
alphabetical order:

Signed-off-by: Andrew Pope andrew.pope@morsemicro.com
Signed-off-by: Arien Judge arien.judge@morsemicro.com
Signed-off-by: Ayman Grais ayman.grais@morsemicro.com
Signed-off-by: Bassem Dawood bassem@morsemicro.com
Signed-off-by: Chetan Mistry chetan.mistry@morsemicro.com
Signed-off-by: Dan Callaghan dan.callaghan@morsemicro.com
Signed-off-by: James Herbert james.herbert@morsemicro.com
Signed-off-by: Sahand Maleki sahand.maleki@morsemicro.com
Signed-off-by: Simon Wadsworth simon@morsemicro.com
Signed-off-by: Lachlan Hodges lachlan.hodges@morsemicro.com

Lachlan Hodges (31):
  wifi: mm81x: add bus.h
  wifi: mm81x: add command.c
  wifi: mm81x: add command_defs.h
  wifi: mm81x: add command.h
  wifi: mm81x: add core.c
  wifi: mm81x: add core.h
  wifi: mm81x: add fw.c
  wifi: mm81x: add fw.h
  wifi: mm81x: add hif.h
  wifi: mm81x: add hw.c
  wifi: mm81x: add hw.h
  wifi: mm81x: add mac.c
  wifi: mm81x: add mac.h
  wifi: mm81x: add mmrc.c
  wifi: mm81x: add mmrc.h
  wifi: mm81x: add ps.c
  wifi: mm81x: add ps.h
  wifi: mm81x: add rate_code.h
  wifi: mm81x: add rc.c
  wifi: mm81x: add rc.h
  mmc: sdio: add Morse Micro vendor ids
  wifi: mm81x: add sdio.c
  wifi: mm81x: add skbq.c
  wifi: mm81x: add skbq.h
  wifi: mm81x: add usb.c
  wifi: mm81x: add yaps.c
  wifi: mm81x: add yaps.h
  wifi: mm81x: add yaps_hw.c
  wifi: mm81x: add yaps_hw.h
  wifi: mm81x: add Kconfig and Makefile
  wifi: mm81x: add MAINTAINERS entry

 MAINTAINERS                                   |    8 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/morsemicro/Kconfig       |   15 +
 drivers/net/wireless/morsemicro/Makefile      |    2 +
 drivers/net/wireless/morsemicro/mm81x/Kconfig |   24 +
 .../net/wireless/morsemicro/mm81x/Makefile    |   21 +
 drivers/net/wireless/morsemicro/mm81x/bus.h   |   99 +
 .../net/wireless/morsemicro/mm81x/command.c   |  569 ++++
 .../net/wireless/morsemicro/mm81x/command.h   |   85 +
 .../wireless/morsemicro/mm81x/command_defs.h  | 1658 +++++++++++
 drivers/net/wireless/morsemicro/mm81x/core.c  |  146 +
 drivers/net/wireless/morsemicro/mm81x/core.h  |  478 ++++
 drivers/net/wireless/morsemicro/mm81x/fw.c    |  744 +++++
 drivers/net/wireless/morsemicro/mm81x/fw.h    |  107 +
 drivers/net/wireless/morsemicro/mm81x/hif.h   |  117 +
 drivers/net/wireless/morsemicro/mm81x/hw.c    |  365 +++
 drivers/net/wireless/morsemicro/mm81x/hw.h    |  176 ++
 drivers/net/wireless/morsemicro/mm81x/mac.c   | 2444 +++++++++++++++++
 drivers/net/wireless/morsemicro/mm81x/mac.h   |   69 +
 drivers/net/wireless/morsemicro/mm81x/mmrc.c  | 1354 +++++++++
 drivers/net/wireless/morsemicro/mm81x/mmrc.h  |  193 ++
 drivers/net/wireless/morsemicro/mm81x/ps.c    |  120 +
 drivers/net/wireless/morsemicro/mm81x/ps.h    |   22 +
 .../net/wireless/morsemicro/mm81x/rate_code.h |  177 ++
 drivers/net/wireless/morsemicro/mm81x/rc.c    |  556 ++++
 drivers/net/wireless/morsemicro/mm81x/rc.h    |   57 +
 drivers/net/wireless/morsemicro/mm81x/sdio.c  |  614 +++++
 drivers/net/wireless/morsemicro/mm81x/skbq.c  | 1053 +++++++
 drivers/net/wireless/morsemicro/mm81x/skbq.h  |  218 ++
 drivers/net/wireless/morsemicro/mm81x/usb.c   |  938 +++++++
 drivers/net/wireless/morsemicro/mm81x/yaps.c  |  704 +++++
 drivers/net/wireless/morsemicro/mm81x/yaps.h  |   77 +
 .../net/wireless/morsemicro/mm81x/yaps_hw.c   |  684 +++++
 .../net/wireless/morsemicro/mm81x/yaps_hw.h   |   52 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 36 files changed, 13951 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/Makefile
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Makefile
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/bus.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command_defs.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hif.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mmrc.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mmrc.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rate_code.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/sdio.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/usb.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.h

-- 
2.43.0


