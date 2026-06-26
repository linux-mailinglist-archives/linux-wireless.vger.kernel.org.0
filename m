Return-Path: <linux-wireless+bounces-38111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 05WCM44cPmrL/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:30:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14B6CAA39
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:30:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b="kfz4dF/m";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38111-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38111-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A43483004D1C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB3239567;
	Fri, 26 Jun 2026 06:30:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F670233951
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455432; cv=none; b=UpGX6V3XXi0jsf5xyKm2bctC+/NcW5DDE9z4ayVPmuXtb742ZUIQ3EkNVAgKJqYg2JDHxJJzNYr6AOaTVaWB8rbNin4/mZJlDHm6y1PH28vPGdNixjxiD1JN8hw0WN8UhVObyx+e8Ceuo6eLkonlAeNb7xZAJrGSDn+5zl8xvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455432; c=relaxed/simple;
	bh=sX1p+FN18r2OvDAPIYwwJyXZSi1w59w0vDoqaVO1Syo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbJrtHEGXvktnFgpzHzKqpfEbkrjsiwxEw+J0YK/ZJS8Q8FYqq9ZJCBNQQYoctAjAq00qvnsnAtXJp71PtgYlTH5ZDuJdCpOvKbFz4E3e5xBkZ74XJMBijImp3UVFt6Y5+1lwj6BVvS9183UEwjudo3ytqJRPpBm8hNNrQffbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=kfz4dF/m; arc=none smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13810b63a1aso1700553c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455429; x=1783060229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiaP3ZlhaYlATqNqYrqTrqjLBsLQrAGRt1+FvyixGCg=;
        b=kfz4dF/mfh6z0ZfRtwuOyTM97EJ0NttYpvkNcrosaf/Cnfwx9QCRcteScSNiH7EswR
         DHzUJfAVN3xYVX3x1EQcphGYWrkBxvq5+Alz7OeTPQkQuHp6NoBsIURLl0GLrAOkPpFI
         pJFvX2DgVnVcuwB1KWt2OqjUuADVlN53nb677K1w6IsXgzTzF9/2gQSA9ls7j4nqASSE
         0oZ49w09iW/117yP7wxrHqVYexOSJjHRXhJr7VJO3WfCKANgm4qbp2aSX1ECulZoRjzz
         IWJ/CE2UfY513xU/yWEMAFapF8C94ks4lGiL8t7B+cBX1iVbzvsavPSLN4+PLxMj3qWz
         wKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455429; x=1783060229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiaP3ZlhaYlATqNqYrqTrqjLBsLQrAGRt1+FvyixGCg=;
        b=D5QiX9m0hpPi0cpSIUmHEwM2By7p3BtTNaxIJN5kxta6nmAS4o1ktmmsvQi+mvDYdO
         wfarPAKvLIcFRqjDWi4GFluVmBj6IcZJqqiIogRxVNebp9dMjDr7cXe2uAUkV32HpMie
         3UJdH3VZREF73FJjVpFcT80/DtG+rIFkYRugqH5xJJNqCu8URRWU5SgENpNSSddkP6zF
         NEK/NNK/2g2uo9cHK4zeEI9A+5THsrJI5ftikMt/Agbc3KHa+AXvZ8TJrA4jHLbmM2bf
         zNmHW2SN+JrQT0pIIwJRUm17tuxpKPpArp3+58qBinRH/9pRllvEC+iKsL4mw9w0n+C9
         hXJA==
X-Forwarded-Encrypted: i=1; AFNElJ9ikAqheAo3UzsQp8u16YXakRBP5CCxFwq0CZojr5EkNZeBnbsShUZOYgglEpQUNWUaxle7WjSc1NVpMnlsIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5NOLCDr6a6z8Ixz4Xr8IoClv8qMmZZFAfZjQznyBYeeLci0t
	5jxeTUzG99nOK8WCkWvnqH9WqhNcNH4oIDOnsbuCov6KjydLoyQzoU3ousJbQ8pe8uk=
X-Gm-Gg: AfdE7cn+Yg39BMqBgQiBjtjFmGNxosPcDA1b+wSV/8PXVZxJkKKB8nKWvkYg35Ov5qJ
	votAKajXTdES3QXAo5LpXUZoT//kqhkTrZX6NeWT3QUTQ3Fnhp72jCQAosMK+8bK4VZzsWr8VP7
	5nP8UZ3uA7yG+KaFYEhJ6451RboHPdc6wXZCVKew50TpQ1LNYAJiEzTcHOqgQfrbjitx387daS2
	A6bbVLwEngMfypzocG90ScubjHM/76WHpUWdOc7Muvm1kqb+Acy5vxYPQJ3C4IaDA4cubdBvNRl
	6XYh3AR39DMxeGpXCP13OPHPD3gMt2m8FvAAEG3O9MWf6+DaKOZQ5kYa21uZ9bVkU5GSLcV7yVj
	QlKatF7mmwdnkN+j+FRAhOTSvDeZpjGIgluAaW/yZAlcEZZ2DWFr03jdo97PvL26FJiTT2qtbF1
	aoX5aLE3R+7YDMRk3dAFCiGI+IwmnumFcFLUirs+m62N8P0CbyP1rWycXaaM6xI7KAmMsRvL4BS
	BkwVe8jqwgJZI+yRj0O
X-Received: by 2002:a05:7022:6b91:b0:138:4f8f:e2f3 with SMTP id a92af1059eb24-139dbb61d1amr5369064c88.32.1782455428988;
        Thu, 25 Jun 2026 23:30:28 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:30:28 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Andrew Pope <andrew.pope@morsemicro.com>,
	Bassem Dawood <bassem@morsemicro.com>,
	Chetan Mistry <chetan.mistry@morsemicro.com>,
	James Herbert <james.herbert@morsemicro.com>,
	Sahand Maleki <sahand.maleki@morsemicro.com>,
	Simon Wadsworth <simon@morsemicro.com>
Subject: [PATCH wireless-next v3 00/33] wifi: mm81x: add mm81x driver
Date: Fri, 26 Jun 2026 16:28:56 +1000
Message-ID: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-38111-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:lachlan.hodges@morsemicro.com,m:andrew.pope@morsemicro.com,m:bassem@morsemicro.com,m:chetan.mistry@morsemicro.com,m:james.herbert@morsemicro.com,m:sahand.maleki@morsemicro.com,m:simon@morsemicro.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D14B6CAA39

This series adds the first Wi-Fi HaLow driver to support the Morse
Micro mm81x chip family via USB and SDIO.

S1G support in the kernel is only new, and as a result this driver has
been scoped to be simple and only support station and AP interface.
The Wi-Fi specific features only cover the minimum required for basic
use such as powersave, aggregation, rate control and so on. The driver
will be extended into the future as S1G support for operations such as
ACS, channel switching and so on are added into the wireless stack.

The driver contains two checkpatch CHECKs for a static rate array
and a line length of 81 using the same ignore list as the wireless
checkpatch NIPA bot with the exception of OPEN_ENDED_LINE which has
been excluded.

The driver has been build tested on a long list of architectures and
compilers via Intels LKP.

The driver currently supports IEEE80211-2024 US channels only, with
AU 2020 also available. In order for this to be expanded additional
non-trivial kernel work is required which will begin once the
driver is upstream.

Changes since v2:

- In INIT_CMD_HDR don't init members to 0
- Remove the if (!cmd_q) and subsequent comment as this will never be
  false with YAPS
- Clamp firmware retcode if outside errno range to prevent erroneous
  ERR_PTR usage when passing ret code up the stack
- Remove some LE force wrappers
- convert beacon work from tasklet (deprecated) to work item running
  on system_bh_wq
- mm81x_yaps_hw_status_registers -> mm81x_yaps_status_regs
- Introduce mm81x_yaps_hw_status_regs which is the fw representation
  of the status registers for DMA target (i.e in little endian)
- Remove macro typedefs over default Elf types
- Introduce mm81x_elf32_ehdr and friends as implementation-specific
  types to parse fw and bcf
- Use read_poll_timeout for waiting for host table pointer rather then
  open coding
- Use put_unaligned_le16 for reading the mac address from OTP
- Use tabs for the CHANS1G macro, also enclose chan_flags in braces to
  prevent checkpatch error
- remove some basic sta member variable wrappers and just call directly
- Remove sta_rc_update entirely, this cannot be reached in S1G
- Free mcast_filter to fix memory leak
- Rename mac2leuint32 to mac2le32 also add a comment
- use block_len and byte_len respectively for unaligned reads in sdio
- Propagate error in sdio_reg32_read
- Fix leaks and cleanups in usb probe
- Fix off by one in pkt->tc_queue check
- Remove some rc.{c/h} code that is unused
- Removed use_1mhz_probes scan param since we unconditionally set it
  to true, as a result unconditionally set HOST_CMD_HW_SCAN_FLAGS_1MHZ_PROBES
- Implement flush with drop == false
- Move some macros / helper functions into stack that are generic

v1: https://lore.kernel.org/linux-wireless/20260227041108.66508-1-lachlan.hodges@morsemicro.com/
v2: https://lore.kernel.org/linux-wireless/20260430045615.334669-1-lachlan.hodges@morsemicro.com/

The driver has had many authors who are listed below in
alphabetical order:

Co-developed-by: Andrew Pope <andrew.pope@morsemicro.com>
Signed-off-by: Andrew Pope <andrew.pope@morsemicro.com>
Co-developed-by: Arien Judge <arien.judge@morsemicro.com>
Signed-off-by: Arien Judge <arien.judge@morsemicro.com>
Co-developed-by: Ayman Grais <ayman.grais@morsemicro.com>
Signed-off-by: Ayman Grais <ayman.grais@morsemicro.com>
Co-developed-by: Bassem Dawood <bassem@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
Co-developed-by: Chetan Mistry <chetan.mistry@morsemicro.com>
Signed-off-by: Chetan Mistry <chetan.mistry@morsemicro.com>
Co-developed-by: Dan Callaghan <dan.callaghan@morsemicro.com>
Signed-off-by: Dan Callaghan <dan.callaghan@morsemicro.com>
Co-developed-by: James Herbert <james.herbert@morsemicro.com>
Signed-off-by: James Herbert <james.herbert@morsemicro.com>
Co-developed-by: Sahand Maleki <sahand.maleki@morsemicro.com>
Signed-off-by: Sahand Maleki <sahand.maleki@morsemicro.com>
Co-developed-by: Simon Wadsworth <simon@morsemicro.com>
Signed-off-by: Simon Wadsworth <simon@morsemicro.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

Lachlan Hodges (33):
  wifi: cfg80211: introduce helper to get S1G primary width
  wifi: ieee80211: introduce generic KHZ_TO_HZ helper
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
 .../net/wireless/morsemicro/mm81x/command.c   |  563 ++++
 .../net/wireless/morsemicro/mm81x/command.h   |   85 +
 .../wireless/morsemicro/mm81x/command_defs.h  | 1658 +++++++++++
 drivers/net/wireless/morsemicro/mm81x/core.c  |  142 +
 drivers/net/wireless/morsemicro/mm81x/core.h  |  464 ++++
 drivers/net/wireless/morsemicro/mm81x/fw.c    |  732 +++++
 drivers/net/wireless/morsemicro/mm81x/fw.h    |  141 +
 drivers/net/wireless/morsemicro/mm81x/hif.h   |  117 +
 drivers/net/wireless/morsemicro/mm81x/hw.c    |  367 +++
 drivers/net/wireless/morsemicro/mm81x/hw.h    |  176 ++
 drivers/net/wireless/morsemicro/mm81x/mac.c   | 2443 +++++++++++++++++
 drivers/net/wireless/morsemicro/mm81x/mac.h   |   63 +
 drivers/net/wireless/morsemicro/mm81x/mmrc.c  | 1354 +++++++++
 drivers/net/wireless/morsemicro/mm81x/mmrc.h  |  193 ++
 drivers/net/wireless/morsemicro/mm81x/ps.c    |  120 +
 drivers/net/wireless/morsemicro/mm81x/ps.h    |   22 +
 .../net/wireless/morsemicro/mm81x/rate_code.h |  177 ++
 drivers/net/wireless/morsemicro/mm81x/rc.c    |  494 ++++
 drivers/net/wireless/morsemicro/mm81x/rc.h    |   51 +
 drivers/net/wireless/morsemicro/mm81x/sdio.c  |  613 +++++
 drivers/net/wireless/morsemicro/mm81x/skbq.c  | 1065 +++++++
 drivers/net/wireless/morsemicro/mm81x/skbq.h  |  218 ++
 drivers/net/wireless/morsemicro/mm81x/usb.c   |  943 +++++++
 drivers/net/wireless/morsemicro/mm81x/yaps.c  |  704 +++++
 drivers/net/wireless/morsemicro/mm81x/yaps.h  |   77 +
 .../net/wireless/morsemicro/mm81x/yaps_hw.c   |  702 +++++
 .../net/wireless/morsemicro/mm81x/yaps_hw.h   |   52 +
 include/linux/ieee80211.h                     |    1 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 include/net/cfg80211.h                        |   20 +
 38 files changed, 13931 insertions(+)
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


