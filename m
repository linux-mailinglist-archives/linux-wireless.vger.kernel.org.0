Return-Path: <linux-wireless+bounces-29616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81738CAF047
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAB4430049AE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18D1A76BB;
	Tue,  9 Dec 2025 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="DJiHglQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508679DA
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261514; cv=none; b=RK+MOJ15G70OEtbJNh/g6Klgk9k+IVRGrqUnrsQUeZckvfp4ke38Y27ThYuUuPf1sEnSZ4OP89OU6TEwVB2J+TfZ6NS4tE3ENVVwLC8kK6kDUk4ojlx5vr5QvtTaAph8QbwalSeRhXFRUR6DMKoX9yBNmVq4Xyt0rQ75fVaKkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261514; c=relaxed/simple;
	bh=HnIZMGWsR3V5l/iGP6JZjSXfXMWRSqcPPLE4NLPoYcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPHT028PHN761uZzpHa6xlgScC4hZ0dY8xDSRYgRD/RVhsON0ldPvB8LD9N0t0+JyryW8vm6ittd9auuoSKUcbIhb8lhVfveay+/jkmV/Mfam5Xs0clzOMh+wifHw/inkNsFWhTwb8so7SXE6NHSlJyu6IOb5urrHL3t2O3Xz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=DJiHglQl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6517874b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 22:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765261511; x=1765866311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+r48Nssg5FB5qbabnls4AgUbZIj1IlCm4l9Na4PYBZw=;
        b=DJiHglQlT4EnhvxCbuHh0/KJxzPEG/NRJKZCWZlbpXeypwBbax7RNLlL9SOf6wdpHi
         Zs/IDiFSWmGEuti9hyhOYa0usJKuFUw0YZ5t1rkYL3pe+Wm5Cw90bsuconNMp7B7TS36
         9BAqr6rS/cqDHQfmF9qQAXdowMnzvuXiv7q3xMbafFFfCqDzV/8iuLsYFnofrtboLRht
         HiuVAG7BDzxyjdqlW1C8XwZu0VlKPh4K5zIUG3VK3ym26CzuBAMJwDsiIqrrjbXnZuos
         nsBr0uD1Lk7yGCET3T/FMs715aFAwpqx13N8U/15HJEmS6rwuP10cSo1WmHcMvnUN/45
         LQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261511; x=1765866311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r48Nssg5FB5qbabnls4AgUbZIj1IlCm4l9Na4PYBZw=;
        b=d1AmCckmoqWcD0u1CF5ZM1kPCE+HKr+UZ1JAyTrTKE4OJw8s6AHAf9T7z5u/LB7n+N
         kOPdg4yJQiaZLqW6FO3OVs3/3ujTt/esDpgtWs4X1S3IbHYAAqFZ/M8irPIE3SVh9LnN
         q28f6hzaA+awfh3ske4quiJJbZy84iHAnr4PF71Zai6P4kkhcpnP5IRPzOSWKsuvqj1I
         ivHYfDiPQ1G/3GTHZ6JxVzE5614LETMwaHmnjUadAa2rttIKjtsnZjyjiaLCnT9iKKdA
         HHAGP7Cbu1SXN3hsS3xRsala8Hdxu0+bH1C63eJN8eJjly1+YtVKPf9l2sz5Gli6Yr+Q
         0nWg==
X-Gm-Message-State: AOJu0YxglbIt5iC78lPH6e95736NDcnln87/KUOhVRtLnUYPQnR8rtzQ
	TjyOqvAS6nk4GKeXxcE5eA3Dg7uO2nAbbOFZ0L7aK4qZCwP40zOs5b2kHi4POhqi4Q==
X-Gm-Gg: ASbGncuaFCOCGtbmtMjgdo1bXlxqfarYoV1Pm9dukaq3+WK/c+PRbAKzv18Ohh3qMlK
	+j/bMvXTk1EbzITNb184hGXIGhbp0t+d6EyX+65prQZ6ob2uggZ8bJDFWbAg9sG/AJy+4cT9Z+T
	bJDcrOlHVXCFaq45GxV9Y/1mIBXBi+mFAo1gNvwIN4otFevzhOjkZ3hMSgseve57dy9pjZ90Q23
	U6l2s03lnyGzum1jYGS5UDhJf+/Y+eyNkXLHBKCtdya8gEVuuN0Vn7HtMqtZD+oAOb881veogck
	jxjL4xla0lkdQDs5i0eIPkEMFt4K/CHusQZQWf1iQJLKKupEkiAmd0hCB/FlEjclgBIpUQ2Sepq
	+oFEnp75BgWCRXRYYdk8r0lIC1tDQMqE/qAwiegCWkqDEfl31YFlaelbi8ySxtCw3o85wd53ACT
	hiOpn55EHJMUwZBGRqJg5AmQpq
X-Google-Smtp-Source: AGHT+IEePM317Z1JZyJmSkzAOGINQUOwk5miMmeljJyAoP1gXngf4Y1Tb0AFMXZdwm1Zf4IrYeyBAg==
X-Received: by 2002:a05:6a00:2286:b0:7e8:43f5:bd2d with SMTP id d2e1a72fcca58-7e8c581631cmr10167561b3a.66.1765261511338;
        Mon, 08 Dec 2025 22:25:11 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c400sm14916187b3a.37.2025.12.08.22.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:25:10 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next v2 0/3] wifi: add S1G response indication configuration with NDP BA support
Date: Tue,  9 Dec 2025 11:54:21 +0530
Message-Id: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for S1G Response Indication configuration; 
section 10.3.2.17 and NDP ADDBA/DELBA negotiations; section 11.5.2.2 (b),
in accordance with IEEE 802.11-2024.

The Response Indication (RI) mechanism is unique to S1G and is used to
explicitly signal which type of response frame is expected at SIFS following
an eliciting frame. The RI is signaled in management and action frames and
must be tracked across session setup, which is very much required in
context of Block Ack negotiation.
The NDP-based Block Ack mechanism allows aggregation setup using null data
frames, avoiding legacy ADDBA/DELBA exchanges. When negotiation fails due to
mismatched support, the responder returns a status code indicating NDP
Block Ack is suggested (REJECTED_NDP_BLOCK_ACK_SUGGESTED), as
specified in IEEE 802.11-2024.

Trace sample:

IEEE 802.11 Wireless Management
    Fixed parameters
        Category code: Block Ack (3)
        Action code: NDP ADDBA Request (0x80)
        Dialog token: 0x01
        Block Ack Parameters: 0x1003, A-MSDUs, Block Ack Policy
            .... .... .... ...1 = A-MSDUs: Permitted in QoS Data MPDUs
            .... .... .... ..1. = Block Ack Policy: Immediate Block Ack
            .... .... ..00 00.. = Traffic Identifier: 0x0
            0001 0000 00.. .... = Number of Buffers (1 Buffer = 2304 Bytes): 64
        Block Ack Timeout: 0x0000
        Block Ack Starting Sequence Control (SSC): 0x0010
            .... .... .... 0000 = Fragment: 0
            0000 0000 0001 .... = Starting Sequence Number: 1

IEEE 802.11 Wireless Management
    Fixed parameters
        Category code: Block Ack (3)
        Action code: NDP ADDBA Response (0x81)
        Dialog token: 0x02
        Status code: BlockAck negotiation refused because, due to buffer constraints and other unspecified reasons, the recipient prefers to generate only NDP BlockAck frames (0x006d)
        Block Ack Parameters: 0x1002, Block Ack Policy
            .... .... .... ...0 = A-MSDUs: Not Permitted
            .... .... .... ..1. = Block Ack Policy: Immediate Block Ack
            .... .... ..00 00.. = Traffic Identifier: 0x0
            0001 0000 00.. .... = Number of Buffers (1 Buffer = 2304 Bytes): 64
        Block Ack Timeout: 0x0000

This patchset has been tested on S1G capable Morse Micro hardware and
verifies correct RI signaling and NDP Block Ack negotiation during
association and data exchange.

Changes since v1:
- Fixed kernel docs

Ria Thomas (3):
  wifi: cfg80211: Add support for S1G Response Indication Configuration
  wifi: mac80211: track S1G Response Indication (RI) and notify drivers
  wifi: mac80211: add support for NDP ADDBA/DELBA for S1G

 include/linux/ieee80211-ht.h  |  3 +++
 include/linux/ieee80211-s1g.h | 14 +++++++++++++
 include/linux/ieee80211.h     |  2 ++
 include/net/cfg80211.h        |  3 +++
 include/net/mac80211.h        |  9 +++++++++
 include/uapi/linux/nl80211.h  | 14 +++++++++++++
 net/mac80211/agg-rx.c         | 37 ++++++++++++++++++++++++++++++++---
 net/mac80211/agg-tx.c         | 22 +++++++++++++++++----
 net/mac80211/cfg.c            | 18 +++++++++++++++++
 net/mac80211/debugfs.c        |  1 +
 net/mac80211/ht.c             |  8 +++++---
 net/mac80211/ieee80211_i.h    |  9 ++++++++-
 net/mac80211/iface.c          |  3 +++
 net/mac80211/link.c           |  1 +
 net/mac80211/rx.c             | 11 +++++++++--
 net/mac80211/s1g.c            | 23 ++++++++++++++++++++++
 net/mac80211/sta_info.h       |  2 ++
 net/mac80211/util.c           |  3 +++
 net/wireless/nl80211.c        | 24 +++++++++++++++++++++++
 net/wireless/rdev-ops.h       | 14 +++++++++++++
 net/wireless/trace.h          | 18 +++++++++++++++++
 21 files changed, 226 insertions(+), 13 deletions(-)

-- 
2.25.1


