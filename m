Return-Path: <linux-wireless+bounces-32238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OFOInoZoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C041B2842
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB3A304D906
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAC341AB1;
	Fri, 27 Feb 2026 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="XLCw7zsV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294F335BB4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165494; cv=none; b=NQKX+9R3DjY1dAJ1DJB1NWuAZRYVSRixWgPAfcm4Rbo5EIQKugejNlD0KL2+Yak6i0BdNvd2rIFgOFybWIix1sqWf/B24Y6Fs8nekw8iyAZaB/GEXhT6nR86ORVXGOnRt8Y8O3YrsEekGqTnfLe/8OUeLm56uizdMl5CUtrVe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165494; c=relaxed/simple;
	bh=VLQGar4Z4Lp5ZsRojt2odXp00tuFmiiOmEPooEY7+zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8NfwHInntvGjZoUwv31xatmfu+E53C/lyo+0hNAc2pbTu33KHsPPsld7XQy7TapQ4smMLhZQ7LOLRP/COjgIhAx/P9SulwpFRuszMMPnRFRRbGpjJOPHZbydc9+C67OgD2IfUtJuowORN91pTd2ke3fabUpaPvRiAj91eefE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=XLCw7zsV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad3f12a496so11354925ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165492; x=1772770292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RIKJr7tm+TgmFzPXkyaOVMYV0y1EBSwNlrYxdarANs=;
        b=XLCw7zsV0V0T4882i25anmkTNaUebgWvvbET7DFn7VEmXe6aP6cFlYTCPD3wQjcSuc
         92eHp4ai7jqYILeU4BSXfBKEisIwQl0aek1LulJWWmWteJI0tgJvtIr4skQ3zAETEZrR
         JUx6ERpGE8b+MBlPiUPpSxxm3Aa7cghY0GmFDnFK4vfFOIxf/6G0nimA03/wd2JCyAKu
         mX3lwVAANNzXnw+sgvmK1eUlfSJcgkryd1IkPa7XBEEFSE0OTp6a+3I2NeYD4+2XOLHY
         zSQ7PCHlohBATp312XoGUTKYSyfTLz0JyOwtp6kdbATWkbIo4+dpfZ+pe6D67KLhobOP
         U9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165492; x=1772770292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RIKJr7tm+TgmFzPXkyaOVMYV0y1EBSwNlrYxdarANs=;
        b=t3oe5pesgm+Rl3XDljj6zZ55zwtJIiOUszSwV/o4tCXW5bCkK5bjdU8pmkyWDfGAxK
         GHk+UkWlId7ZXS3LOUxOjY3pSILd8IsgrsLWaAT8clWGOSoQLGPeuTv2/Q9XEtJ3FNr6
         PYvEjZvgWi+gGKFc7XHOo2aUmGGBYoDZer81P8EWgdlxMrBKuMyPYjcOO1bFX6v95lED
         YJWQFHKz5zptXocmBl9tHEGXY85t+IZbEVdbqWQkZJPjEL4PxAZvFSSg+ZBbJAJWjZ88
         OuuJeDkH7IB6SxPYjR+ptGK9IKeUvMkqclQymWqH2C6/Yn50ffRiy7zibF9i/XO2pZbO
         uc+A==
X-Forwarded-Encrypted: i=1; AJvYcCUvJLznLzM3ubC0qfvfg5FfTZmKV4pdl52WsnP484EhJDl2xoNWpxQVK7/XICRbFOFIS57J7ns/den/59iwSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OcwHqdM9pjw0rW/QYrXz6Rl6AawkcRZIVQnYaiGTj4hghGzK
	47JLd5enPlaC5yfvMnx772ra4rfOPeOgYqCwPvXFsKJcuAtAPKhpO/wHDsBhh23fmBs=
X-Gm-Gg: ATEYQzwo3z1sE2FWp3JfzKNtSQesR4Xf/FpBVeDeLQMYg8QaRDkZ1Avh5Ij/w2LAFoc
	VfeeA3SPtCiVjONrHvXejZGdfjxDXsX6xjcr2XDdNZin2gPNL0TrpGaP8ab8fiCJKTZZeMbTpxG
	ke5evnRRoFSIFslqwRo3FA38bEFiuvjg8aH+MmJm2tQ8KbPHYQji9WbePL422oIN7TLatZieKxB
	whTjIoyc+7iKd8Rgx28AdMcrj05/VcIzp1U72x3ebGsmV3FzJuLFHIa4gHtxoGSexXG0PAuUnNL
	WyH719/dj9VGotY3IEpurlI6k/kbHKogboDJfBCd0dMiSgSUrq+qaEUbla4rtspAcuV4mJk4gcS
	IC7NW7eLDEF0OxbMSrpfSmvCLWtn+sQ1VxQpyhahmHuJcAzz/x6z1RQZSp3oBv/NT86v0mH1O2n
	YZeDK1AGs8kYPGJDjIiRAWN5SDHIxa6/1Qkp5/ILTS4+GdEpFLHdAIYWeXfJDJf97VqKv4mu2bE
	0DV+1cM/aWvHwITFTv9jJ7LgmfT1jw=
X-Received: by 2002:a17:903:2342:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2ae2b6500b8mr13578585ad.7.1772165492316;
        Thu, 26 Feb 2026 20:11:32 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:11:32 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 00/35] wifi: mm81x: add mm81x driver
Date: Fri, 27 Feb 2026 15:10:10 +1100
Message-ID: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32238-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]
X-Rspamd-Queue-Id: 75C041B2842
X-Rspamd-Action: no action

This series adds the first Wi-Fi HaLow driver to support the Morse 
Micro mm81x chip family via USB and SDIO.

S1G support in the kernel is only new, and as a result this driver has
been scoped to be simple and only support station and AP interface.
The Wi-Fi specific features only cover the minimum required for basic
use such as powersave, aggregation, rate control and so on. The driver
will be extended into the future as S1G support for operations such as
ACS, channel switching and so on are added into the wireless stack.

The driver contains a single checkpatch CHECK for a static rate array
using the same ignore list as the wireless checkpatch NIPA bot with
the exception of OPEN_ENDED_LINE which has been added.

The driver has been build tested on a long list of architectures and
compilers via Intels LKP.

The driver currently supports IEEE80211-2024 US channels only, with
AU 2020 also available. In order for this to be expanded additional
non-trivial kernel work is required which will begin once the
driver is upstream.

Some items of importance:

* Our firmware cannot be loaded with the 00 regdom. Due to the
  disparate nature of S1G channels, it's not feasible to store the
  entire regdom on the chip in EEPROM or similar. This means the chip
  will fail to boot when the world regdom is selected. The nature of
  the reg notifier means there is no clean way to propagate this error
  to usermode besides through kernel logs (obviously interface 
  addition will also fail).

* When reacting to dynamic regulatory changes from usermode, we must
  perform a full chip restart. Unfortunately this requires a blocking
  reset in the regulatory notifier to prevent subsequent command 
  failures. Feedback on this would be appreciated, but we note that 
  this is due to the limitation of our current chip/firmware as above.

* There is currently no upstream support for S1G within
  hostpad / wpa_supplicant / iwd. This makes testing of the driver
  challenging. We intend to post upstream patches for these utilities
  shortly following the submission of this driver. 

* We were going to push the driver to staging, but we believe the driver
  is in a good enough state for the regular tree (pending review of
  course :-)). However, while it is not the normal process, staging may
  be something to consider so that the upstream ecosystem can mature over
  ~6 months.

The firmware will be posted in the next version.

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

Lachlan Hodges (35):
  wifi: mm81x: add bus.h
  wifi: mm81x: add command.c
  wifi: mm81x: add command_defs.h
  wifi: mm81x: add command.h
  wifi: mm81x: add core.c
  wifi: mm81x: add core.h
  wifi: mm81x: add debug.c
  wifi: mm81x: add debug.h
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
  wifi: mm81x: add sdio.c
  wifi: mm81x: add skbq.c
  wifi: mm81x: add skbq.h
  wifi: mm81x: add usb.c
  wifi: mm81x: add yaps.c
  wifi: mm81x: add yaps.h
  wifi: mm81x: add yaps_hw.c
  wifi: mm81x: add yaps_hw.h
  dt-bindings: vendor-prefixes: add Morse Micro
  dt-bindings: net: wireless: morsemicro: add mm81x family
  mmc: sdio: add Morse Micro vendor ids
  wifi: mm81x: add Kconfig and Makefile
  wifi: mm81x: add MAINTAINERS entry

 .../net/wireless/morsemicro,mm81x.yaml        |   74 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/morsemicro/Kconfig       |   15 +
 drivers/net/wireless/morsemicro/Makefile      |    2 +
 drivers/net/wireless/morsemicro/mm81x/Kconfig |   34 +
 .../net/wireless/morsemicro/mm81x/Makefile    |   19 +
 drivers/net/wireless/morsemicro/mm81x/bus.h   |   90 +
 .../net/wireless/morsemicro/mm81x/command.c   |  619 ++++
 .../net/wireless/morsemicro/mm81x/command.h   |   84 +
 .../wireless/morsemicro/mm81x/command_defs.h  | 1668 +++++++++++
 drivers/net/wireless/morsemicro/mm81x/core.c  |  157 +
 drivers/net/wireless/morsemicro/mm81x/core.h  |  499 ++++
 drivers/net/wireless/morsemicro/mm81x/debug.c |   87 +
 drivers/net/wireless/morsemicro/mm81x/debug.h |   58 +
 drivers/net/wireless/morsemicro/mm81x/fw.c    |  743 +++++
 drivers/net/wireless/morsemicro/mm81x/fw.h    |  107 +
 drivers/net/wireless/morsemicro/mm81x/hif.h   |  116 +
 drivers/net/wireless/morsemicro/mm81x/hw.c    |  372 +++
 drivers/net/wireless/morsemicro/mm81x/hw.h    |  175 ++
 drivers/net/wireless/morsemicro/mm81x/mac.c   | 2642 +++++++++++++++++
 drivers/net/wireless/morsemicro/mm81x/mac.h   |   69 +
 drivers/net/wireless/morsemicro/mm81x/mmrc.c  | 1353 +++++++++
 drivers/net/wireless/morsemicro/mm81x/mmrc.h  |  198 ++
 drivers/net/wireless/morsemicro/mm81x/ps.c    |  239 ++
 drivers/net/wireless/morsemicro/mm81x/ps.h    |   22 +
 .../net/wireless/morsemicro/mm81x/rate_code.h |  177 ++
 drivers/net/wireless/morsemicro/mm81x/rc.c    |  559 ++++
 drivers/net/wireless/morsemicro/mm81x/rc.h    |   62 +
 drivers/net/wireless/morsemicro/mm81x/sdio.c  |  803 +++++
 drivers/net/wireless/morsemicro/mm81x/skbq.c  | 1056 +++++++
 drivers/net/wireless/morsemicro/mm81x/skbq.h  |  218 ++
 drivers/net/wireless/morsemicro/mm81x/usb.c   |  971 ++++++
 drivers/net/wireless/morsemicro/mm81x/yaps.c  |  704 +++++
 drivers/net/wireless/morsemicro/mm81x/yaps.h  |   77 +
 .../net/wireless/morsemicro/mm81x/yaps_hw.c   |  683 +++++
 .../net/wireless/morsemicro/mm81x/yaps_hw.h   |   52 +
 include/linux/mmc/sdio_ids.h                  |    4 +
 40 files changed, 14821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
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
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/debug.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/debug.h
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


