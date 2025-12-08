Return-Path: <linux-wireless+bounces-29579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F5CABF93
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EF03004F7F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7B23D7FB;
	Mon,  8 Dec 2025 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="neMZQP8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA9233704
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165209; cv=none; b=ZPJ98y9N6pSL0HtTC42yD4Ka7B24bdRYXx7mVfE7IAS72PT40lK6yTBFBrMaXcnSv2uxBlqLDUEwt6a04mf94mkQCAFh/kEMiYk484i8qlK/v22Sv1v9sWJ64KS2jae/DrFBbTOl2X62NjLgtMDceJmeAgXlvzNaj1OxbVFEpxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165209; c=relaxed/simple;
	bh=MdzpobkfwNX50HpHb61DHI/lrhQ5aIRi4gZEf8QVqc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoELrHpIfz5ZGxs5rP9K9mbY7/bXoBKc104506NjmAjGNrf8xIXxUgJGK5FSpMqpihU/BuesMmJhXSTNYVRoK0QCNEY51vZ37Cbveiw2urkl89xcCZo3Gk1IcjJw43WwYF1wqK+AdJNEACYXLLvtcadv7o2vX+fjNshJlhmL/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=neMZQP8D; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343ea89896eso3626044a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 19:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1765165207; x=1765770007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4lHY+nRzrTmxWclCC8siYd2+AI57YQwsqJAJhziLYE=;
        b=neMZQP8Dtl3zEu5Gq7BYhJXiNK4o8i5uKLB0ow8NcIAT/Ms2MebZGnfd4KGdh/kq8z
         mqAmOVNqSUj/wIy7Ln7MhBcbgnK540hL6ppxYzXFjblK8Nf4LGHOBOySQmq8DGsq3Y0R
         ysn+mjLtzGrbdkHaodVsGXjtlMzrgO9RuR1MWMQWmRBqNRjFcqiRpPqgSmrmRvuEVPO1
         ad61R/3Dk0iLZSEBFAFeWIYhq/ZOUmlIZDRtcMNtAO40IdyRGq+fa8DRchO5UDILVlgB
         9rrIncU/AlThCTc0Km4APR8OSR9kliXbuKH2R0ZZTyMDiw/yAd7HBXlaWmOANhDTD8mz
         ds0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165207; x=1765770007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4lHY+nRzrTmxWclCC8siYd2+AI57YQwsqJAJhziLYE=;
        b=J4NX0NNMKM889Y3VN2qJbcn7u079FDL/134mlEy8e1ihcGlx47dCf2vaN/MHZVzCX7
         Qfc9CRXGUcLpItA3tk3xxSHxsNIBp0Qcfyewv1XNiY7zvYDgjCCd4cj+Qhb+hPnk3IfF
         Y/v1VEgrvfL3qk61Li360FY5Pz9jjjE0pDe/qTvmyHZPZsVycVYLWMUAPA3/yKdRuo5s
         WDF2erW1RpF4iRhqfPxyt/Rxdnhs0CIlho13alTxuRrwsYm+50VDIzSIDkDsp93+7SQx
         KvMEOwP396WFvDF4X2L/MnrEpsaExnnK/O2CEt29jcVSQPOJr1jEA3BJup7W5pwQ36V/
         +Hfg==
X-Gm-Message-State: AOJu0YxqTUIQnDH941rMi1pZLtKXnEtK9Kec+VcMwv/uUrgOANlb07jW
	rRikqru3CMIuZazMhw8/mzHKw/8vDUXF9/qqEwkIk1ULDAPn9ZxkGPwJKxB3OY2GkZb/nHvpws6
	8GxhNvw==
X-Gm-Gg: ASbGncvCVGcY9Puj65V4hWEWwwG8pdHvm+I8dSokAn4+JsKmiuIqudzOGljduATfNP9
	ToW09lC050UMIymlhFMZ45vm43K4Uq3a+C4qakMQXq5tkXR23Hq/PE62LQoMyb7pUDNe4KwwpFS
	9bQ4mI1YqxrmOkbOyk1XT0P7bf938y62l1n5a6vNh6Fhxytq2nIxRmqU0mhzOSpvAGO/VfCrO6+
	iQfIzcfYm9TyEYMtXnX0fDOXEmS0wSBftwxT/y58Aefe+10bPYx6S15DKZYDfPVhwv4p14C0S0D
	ShVRbC95RjZ3t7hZhZ5//CBieGQ6CFSXRHgts1HgaqGAwVd4cTVqiqXFmGQE/lNc8I0HwFbbtUP
	p7WYA6G4SttyxgXzaW+gUDXJ221AQMfSmxRLxFaq8PON0+ZF980cSpzvcOTSIlZ9IFxddajiVVo
	kOtF/fYvj+uwnWHmKdzc7d+q/q
X-Google-Smtp-Source: AGHT+IGyJSQ26tVWqwFX87md84D/inNK+bYs/Gx0w4Tp6C3bxoXZKFlusHMfQwBt6X1IDAgiAMZYMw==
X-Received: by 2002:a17:90b:2691:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-349a260b134mr4618290a91.34.1765165206844;
        Sun, 07 Dec 2025 19:40:06 -0800 (PST)
Received: from 1207.mumbai.mm.lcl ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea899desm10383209a91.17.2025.12.07.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:40:06 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	arien.judge@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH wireless-next 0/3] wifi: add S1G response indication configuration with NDP BA support
Date: Mon,  8 Dec 2025 09:09:36 +0530
Message-Id: <20251208033939.3005700-1-ria.thomas@morsemicro.com>
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

Ria Thomas (3):
  wifi: cfg80211: Add support for S1G Response Indication Configuration
  wifi: mac80211: track S1G Response Indication (RI) and notify drivers
  wifi: mac80211: add support for NDP ADDBA/DELBA for S1G

 include/linux/ieee80211-ht.h  |  3 +++
 include/linux/ieee80211-s1g.h | 14 +++++++++++++
 include/linux/ieee80211.h     |  2 ++
 include/net/cfg80211.h        |  2 ++
 include/net/mac80211.h        |  6 ++++++
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
 21 files changed, 222 insertions(+), 13 deletions(-)

-- 
2.25.1


