Return-Path: <linux-wireless+bounces-38773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9zwIEpq2TWqQ9QEAu9opvQ
	(envelope-from <linux-wireless+bounces-38773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 04:31:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B287212F4
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 04:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=rVKJSuDH;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38773-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38773-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3673011113
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7673955E3;
	Wed,  8 Jul 2026 02:30:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F514379ECF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 02:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477853; cv=none; b=qxhK68yj0q1a/yBxSw6LsyPMpKB2khCm4ab2P01jJSCKoTXnvT2ovIrSztKuZNgkroyluqcXUdBC/nxYig7QeHO5b1QfKIZzJTC2nIgaJDRjS1nA9RSAu2a1dy7Hv4v0ck1Axh4j58eVGDmkONdyh/Z0ZQiATu8F2ayatZpB+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477853; c=relaxed/simple;
	bh=i1Mgo6TgyRD8i2fVrC0r8VExcL/g7/2QWuNArqObyyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sz55tbMQfUTYeA2wjsexF3lYrGvZbOGVgw6gaX/v4Kl74S4Xc+VwGh4ttEPqLYbMR8FUeoXe/y1qhlzA7Htc1UKFOthcZzyJ/mIgxrQUjqz5C9OR1W5h2/8L42a/rBKDTxo7zrnDXm8bEJ3cfoFRIjJHgJ6A6fgULOv6eRxDgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=rVKJSuDH; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso87842a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1783477851; x=1784082651; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1pfKei1esO+zFwIXH53UVxMYrpFP1S5MrPPXv4xctw=;
        b=rVKJSuDHYW+JRkJiFmnAC8RQPRpN+8WP/5PIa2QQOprxqh/wK+8I3fVRaG5Dei1Q0u
         ERS/Cny7+qJoKXEVGN3VgUrLy0uaG2y8Behdmed3c0R3garfix8GZtjXU3HSk3wFptFz
         tv+zBeK85rp7IWxIFlOMqe1PuIIRfMpHLUoqURMWi0vo/d1EACA5NyLQ2+NFAFCNPPvZ
         wy3mgfQq+l58mO4AAylrUGeYP3wVCbj/8rRLWlivvzo0S8437dpmQZ+n3y8yAx2W6xi5
         tS6VozY9tuSWP+mq9ggMSo8eB0gg2Ptd3uUMxx3ugQsyZpQUyAFkH8R6fkwOwzCqqcTz
         UxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477851; x=1784082651;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1pfKei1esO+zFwIXH53UVxMYrpFP1S5MrPPXv4xctw=;
        b=CHJNMlA0S8sdyePBBEz3Cy3RuErDgxEWlHeiqWdP947Haradk0HvvEcgdtKDGv3nVQ
         WawvuKSGM27kUJ5d0VHe6UmRtaYtyBABQoxHXQXxcs1c9YN9eT+i3/F5G5WU4lGiB2lS
         XrV+hygEuGmmrC6E/N+kobgiIviitdgEz5GnGLUV+x1yFkXvqj6/mSEMLx0NvEK5SmbM
         FXQ0VHCd32krMF1OUU84Zu+fhtukkm1JZiwRctNZaLrtoIA1oa7GIh+lu+HRAZwlhepe
         qvD4OXLXShi56TfF2+5r3yc/kpYmnkwmqVgJqe8CTEt3A0EbwutcrTzs2Un2V+dTSUGx
         /dAQ==
X-Gm-Message-State: AOJu0Yx/dAExhF+0os5ykNmXU7vsYfaazPXURjATK9APVy8nFqlzfGb3
	nvPNV/cGpbjqU1DDVbeAjdp/kH1N4rUTVut/rVgSw20QZ25ux9kUAeGcaejZEozryyY=
X-Gm-Gg: AfdE7cn1X5gXgg/RpeRUkCNy8hOc/l12MxdVzOf0NIUsLmBBCBjQE2LXRQvmQVb6Ug2
	LB3KssrlrmY59F1jZ5JfmvmUPtcdUNLpHbA6B5x2RGIj5Rv67Lcw8YxBSHGlfdrMqXZ+J3H+tGD
	caj95R3bNnDD5CJxrkmvo2aM/PSN37C9uSbWO1kVdwA+OXrWssEM7mhFd9aiJlMBFqBNr/NZ7O9
	jE+xlv+2o9p4j4CdRx6t1lxIHyuiHCzQrwIPEQDFdLslEmW6xP81nIc5jl+iJhUWj0sx6c3QLUQ
	JrktWHW4iqhQGXBAA9Xk3TvEEGoNI+wWf4Q/a/iI+6FkMFkZ/AR4g9zseX/WCZxXilw/AtDr+85
	4n9oEVNd0dV65YVAD9IGJAdW5YPqppQLwfoBcJZPrkwNjtvkC52JLA+b/eOKGIcoxOxlMdl1axI
	ismpSLy+JnFfkCLSkOkuDjUew7BuXNzx5kAOrSMz3diYCG7LWAdGpsXqAcie6O3bm42PRQRleqB
	a6Ko4eupOJY
X-Received: by 2002:a05:6a20:12d2:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c0bcf48fa9mr379437637.2.1783477851422;
        Tue, 07 Jul 2026 19:30:51 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm14337917c88.0.2026.07.07.19.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:30:51 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:30:47 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com, 
	ayman.grais@morsemicro.com, dan.callaghan@morsemicro.com
Subject: pull request: mm81x-driver-08-07-2026
Message-ID: <svi6q7fgwkgzr6ta3ailxwubgoiokykfybz45igpqiry342tbv@vvqslr3ss7r4>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:dan.callaghan@morsemicro.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38773-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vvqslr3ss7r4:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B287212F4

The following changes since commit ac798f757d6475dc6fee2ec899980d6740714596:

  wifi: mac80211: Route (Re)association req/response to per-STA queue (2026-07-07 10:16:31 +0200)

are available in the Git repository at:

  https://github.com/MorseMicro/linux.git tags/mm81x-driver-08-07-2026

for you to fetch changes up to b1906cea00b021acea22460225401d5b27bc7c36:

  wifi: mm81x: add mm81x Wi-Fi HaLow driver (2026-07-08 12:03:50 +1000)

----------------------------------------------------------------

Introduce mm81x driver for mm81x based chipsets plus associated
SDIO ids.

----------------------------------------------------------------
Lachlan Hodges (2):
      mmc: sdio: add Morse Micro vendor ids
      wifi: mm81x: add mm81x Wi-Fi HaLow driver

 MAINTAINERS                                        |    8 +
 drivers/net/wireless/Kconfig                       |    1 +
 drivers/net/wireless/Makefile                      |    1 +
 drivers/net/wireless/morsemicro/Kconfig            |   15 +
 drivers/net/wireless/morsemicro/Makefile           |    2 +
 drivers/net/wireless/morsemicro/mm81x/Kconfig      |   24 +
 drivers/net/wireless/morsemicro/mm81x/Makefile     |   21 +
 drivers/net/wireless/morsemicro/mm81x/bus.h        |   99 +
 drivers/net/wireless/morsemicro/mm81x/command.c    |  563 +++++
 drivers/net/wireless/morsemicro/mm81x/command.h    |   85 +
 .../net/wireless/morsemicro/mm81x/command_defs.h   | 1658 +++++++++++++
 drivers/net/wireless/morsemicro/mm81x/core.c       |  138 ++
 drivers/net/wireless/morsemicro/mm81x/core.h       |  456 ++++
 drivers/net/wireless/morsemicro/mm81x/fw.c         |  752 ++++++
 drivers/net/wireless/morsemicro/mm81x/fw.h         |  143 ++
 drivers/net/wireless/morsemicro/mm81x/hif.h        |  117 +
 drivers/net/wireless/morsemicro/mm81x/hw.c         |  367 +++
 drivers/net/wireless/morsemicro/mm81x/hw.h         |  159 ++
 drivers/net/wireless/morsemicro/mm81x/mac.c        | 2443 ++++++++++++++++++++
 drivers/net/wireless/morsemicro/mm81x/mac.h        |   63 +
 drivers/net/wireless/morsemicro/mm81x/mmrc.c       | 1354 +++++++++++
 drivers/net/wireless/morsemicro/mm81x/mmrc.h       |  193 ++
 drivers/net/wireless/morsemicro/mm81x/ps.c         |  120 +
 drivers/net/wireless/morsemicro/mm81x/ps.h         |   22 +
 drivers/net/wireless/morsemicro/mm81x/rate_code.h  |  177 ++
 drivers/net/wireless/morsemicro/mm81x/rc.c         |  494 ++++
 drivers/net/wireless/morsemicro/mm81x/rc.h         |   51 +
 drivers/net/wireless/morsemicro/mm81x/sdio.c       |  613 +++++
 drivers/net/wireless/morsemicro/mm81x/skbq.c       | 1064 +++++++++
 drivers/net/wireless/morsemicro/mm81x/skbq.h       |  218 ++
 drivers/net/wireless/morsemicro/mm81x/usb.c        |  943 ++++++++
 drivers/net/wireless/morsemicro/mm81x/yaps.c       |  704 ++++++
 drivers/net/wireless/morsemicro/mm81x/yaps.h       |   77 +
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c    |  702 ++++++
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.h    |   52 +
 include/linux/mmc/sdio_ids.h                       |    3 +
 36 files changed, 13902 insertions(+)
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

