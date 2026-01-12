Return-Path: <linux-wireless+bounces-30708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44ED14CEE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFBA530060E3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18537E316;
	Mon, 12 Jan 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pC8at1Ww";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O922YI4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F782EC0A2
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243979; cv=none; b=VU3/P/wzUNAM45jSoDYRIc2cA74MlCAAqWpAMA/iK+W6Ay1dSw7A0DXAOmlhhw4jdicNUiNBJHPBI4+eQ7banvKzbYYJFw+ReVYX8rx37LxjD/89cpFKPlh8Vd+nnDrdHuD7SBXkiNRePeGB3aYDtJv4ksEWSmaZzD+yoraygRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243979; c=relaxed/simple;
	bh=jxZfTkmFXIwzjzA1qu7DyRfABsyTGFU6W7JdTK2vXMI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=c3yxdQEUULCGAsx2FEvtYfOxCa106sqs6uiBz9+U087/KxfHDsFK3EGJDEKNJYRSdrDYarFqCNhivh0F0twVIAXx8dc0PWCLDxungbWN+biaUAfDGNTvcBJ7VP5RTjWeNvwZ2nhcF2wuddN/XKNv4XLw6PynXaVqEVCeENv0Yk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pC8at1Ww; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O922YI4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CIaC4w1358202
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 18:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pPUrZq6lfm3OFSWGEBv20I
	zq1Vb31BpZwszeRnq7rCo=; b=pC8at1WwMeW9dOudabgIlw7ulzfINxtAmcwCAN
	D+69De/Nx8U8huI2sMnrs134bOC06Hr5N8P1icLqPIhnwM6cx+fTDXcxsHkIsYIt
	UrPCnOVnylfhe9t8o7vxMNlarNIlo7KdaXM0zlwG7474LoONeL9xGo2Ij4hM01Ge
	9/8GR7I+7rsOxvLhTkzaezRlWKRXaFxxI654NlwzuoMrx8U20vbqOn/dnXfiqF4I
	iYSnksS7jdo88HProksHfJAItP6uKnzEUpXeeGn7QpALAnkIKybf75ft8aJ/KkJq
	Sg4oHrY5GUE0uJgGffZ5XSXIlkcZBN03sm1g5isf2Xl/P2og==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6cng1mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 18:52:56 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-11f3d181ef2so37249147c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768243975; x=1768848775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPUrZq6lfm3OFSWGEBv20Izq1Vb31BpZwszeRnq7rCo=;
        b=O922YI4bHs7szGePJWFvAA7ZwvgbanzP66jz9qT2EE3UEO5auTdbn2eg22wYqoUZ9l
         NQIRjCfAsDLjR/mwvmev0HfwS9LLx83JnT744FpXaprSkNfgjzXBT9WWX5Cm8KpZVP7c
         rCT6h5cWu9+Su5yYVA+/mImrutlEj43p6p93Y+n92/70JPwT2dVKdIluMy7mjZ+htQuB
         4HXAsV1FtGVZS5JNptiTv+VdrVyZZbEOqCZLBclXf4QK1no8YHhXm6ftV2ZRy7zBznpf
         GrQ9KwU+jmFhlPYY4TPEi8ybS5iQwOIoul6HZJGyxWf87gU7+wZsNvT3s+oduzxjJVYD
         6a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768243975; x=1768848775;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPUrZq6lfm3OFSWGEBv20Izq1Vb31BpZwszeRnq7rCo=;
        b=A5RgwpmNdv0Y9kYgJMDjPB+52vK+hQ37ib/BI/kIVmG5yYJ3rhVVgvuktUEDiKPOFU
         bo/Y/Omlb2YFwsmHx/QxXK1ztjrQPL9Jv2jWKXjkZdf1S0eGBtl5LJ0YN+MMQOCtlaZ/
         LEbigMmXRvYQq6jrZ1ddYI3BygLoV5S0eGzrhtM5+srVsJIdYJRxJ10KOR4j3aEqYHRy
         3X6PTOx0RAvIwladXutZChhe3YydVVfBUMMLIocFxqfpXx2gEHNcAPUBkaI1pOfNXdqO
         owM0DTvePHLMbvgYwWI29cXKKtes7rNOusz/IH5IPe/J3kWnVe17hYNmVr4Jo67NOOk4
         xUuQ==
X-Gm-Message-State: AOJu0YxJKFqOUDOLsIw9Uuyz7YW7ujQ7VdRHUz1r7ALdidUP1MXbRM3N
	RECDMI2xAvqbrFPeLvk9k9vlCqzi1P53GshATjFvPjUlUmjCGsuppHpOJAkhN4KjwV82aRwxC+s
	EXn8ZTWbPsdrR5jTmx7O8pvd6u158DlmHteIo8W5az0gJ9rbKSrVgGMHFVmwGWtMRP81NUGxj9L
	PTmw==
X-Gm-Gg: AY/fxX5hnGeogUSj3Ckic+8E42oFFjCVEV14+vAXI1oj//NpDQ579R0GtLiZKfuaswI
	1PnKcCPXzHgwO6YUw7BmMw949/NR49aOAeJYxnzB8wiH35Lkvp895l9w/NM0xIVb7/PZYc8m5Ne
	QH4ew8I1B85QUoFm6DhykoJ4nkauTxu54EKlTXr/SVUoQZxAkQ5sQQ7a/XVCgY84GmZ9HEIYZuw
	KhHoQivYYe44U/KiLM7sQecdmZ4/md2IbiF5Y+aigpELcS6UrRKGUDByt0sypwoDI7kAifh7fOB
	Lu9WYKug1HoXoouFW1dj3OnGvoW45/EA3OarT0uenFKMfN/Mq9lB+RpH5l4otipP+PrpjTqq8ok
	9DPOolajf0fbw6z0KYTp0XAy25eJaW9R1dQgDaOkOX8l+ZajYQSd6/+xgFYZMx7V80OxZLfR4r3
	8xKzU=
X-Received: by 2002:a05:7022:685:b0:119:e569:f25f with SMTP id a92af1059eb24-121f8abbae9mr17227531c88.8.1768243974984;
        Mon, 12 Jan 2026 10:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEN27cmS0iMC3SrMDtw9ExStAnjoPM6Fc850fpFVT7mKd7JFQQqQ70+TgElePVysC+Tt6HWA==
X-Received: by 2002:a05:7022:685:b0:119:e569:f25f with SMTP id a92af1059eb24-121f8abbae9mr17227500c88.8.1768243974217;
        Mon, 12 Jan 2026 10:52:54 -0800 (PST)
Received: from [10.227.107.72] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm26075720c88.5.2026.01.12.10.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:52:53 -0800 (PST)
Message-ID: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 10:52:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>
Subject: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP Coordination
 (MAPC)
To: ath12k@lists.infradead.org, hostap@lists.infradead.org,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9axnciN3qwPuoXUEamKItjVAfUcsqDcb
X-Authority-Analysis: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=69654308 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ux5jCyw-kAsZt0kIruIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 9axnciN3qwPuoXUEamKItjVAfUcsqDcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE1NiBTYWx0ZWRfX195eezX++LoP
 HYjKZ42P6DgVJ3d9FCRb8qhiDyUiadEVnYdAAeC6z/KP5/tdKpxDGZZ10CTNucfwB1uXhtcOuc3
 KTTgDj9I9MVOpjRyUzEhhVIUkGNwAgJT1h2MyV0pHXRZhEEJsMgKMsPpax8tDAA/JaCWuPPmqPE
 Wy4+p6mHZbIjI6TswGmQ4sFQxuUh1gwSip+KbMwJexgrdlmcIgNet7mDaB1ogWRGe6s5sZSEDYA
 8pj64XqBOnKyL2cf4rcQ08o/uy6D5T490jpm2pYndonEIFaiAnJ/OXyHCTLT+wNzpfU0Q/8DIFj
 hPxDXjqlTno/mz9ubqnVDMzT8ck7rpwDAy+OElNMPAiv/vThgzj0wVxKbcgttTh6kZHdMRCRtVm
 MmZix+0BVyPsbkj3y/s6EukKGaqxPbiPhAEZv+6NfwBwJnyVe0fxWQa35DU3znXx6q6mYuhiTvQ
 OviTrMsuYJPf8ZqCwrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120156

Hello Everyone,

This RFC presents a high-level design proposal for Multi-AP Coordination
framework in IEEE 802.11bn (Wi-Fi 8).

The design is based on IEEE 802.11bn-D1.1 (as of Dec 2025) and may be
updated based on future draft updates.

We hope to gather feedback on the proposed architecture and subsystem
integration strategy. This document does not include implementation
patches or code and is intended solely for design-level discussion.

==============================
Table of Contents
==============================
(1) Introduction & Scope
(2) Background
(3) Proposal
    (3.1) Control Path

==============================
(1) Introduction & Scope
==============================
The IEEE 802.11bn specification has introduced the concept of
Multi-AP Coordination (MAPC) framework which includes set of
schemes (such as Co-BF, Co-SR, Co-TDMA, Co-RTWT and Co-CR) and
procedure in which APs operating their BSSs on the same primary
20 MHz channel coordinate to reduce interference and to improve
network performance, such as medium utilization efficiency,
communication reliability, and latency.

The scope of this RFC is as follows:
1. Enable MAPC framework support across hostapd, mac80211,
   cfg80211 and WLAN-drivers up to 802.11bn-D1.1
2. Focus on AP-side support
   - Capability exchange
   - Feature-specific negotiation
   - MAPC context management
3. Focus on WiFi based inter-AP coordination
   Multi-AP coordination over wired connections will be
   added later, based on specification updates

The following sub-features of the MAPC framework will be deferred
to subsequent versions of this RFC, as the specification is still
evaluating options for MAPC frame handling in multi-cohosted VAP
and MBSSID scenarios:
   - MAPC security

Patches will be proposed in the subsequent version of the RFC once
we have achieved general consensus on the architecture.

==============================
(2) Background
==============================
The MAPC framework operates in three phases:
    - Phase 1 Discovery
      AP advertise MAPC capabilities and common parameters using
      Public Action MAPC Discovery Request/Response frames
      (Ref.IEEE 802.11bn-D1.1, 9.6.7.65 to 9.6.7.66).

    - Phase 2 Negotiation
      AP establish, update, or teardown scheme-specific agreements
      (e.g., Co-BF, Co-SR, Co-TDMA, Co-RTWT, Co-CR) using individually
      addressed MAPC Negotiation Request/Response frames
      (Ref. IEEE 802.11bn-D1.1, 9.6.7.68 to 9.6.7.69).

      - APID Assignment
        When establishing the first MAPC agreement the AP assigns
        an APID to the peer AP (Ref. IEEE 802.11bn-D1.1, 9.4.1.8).
        APIDs share the AID pool(1 to 2006) with non-AP STAs.
        APIDs remain valid while any agreement exists.

    - Phase 3 Operations
      Feature specific frame exchange with peer AP for the established
      agreement.

=============================
(3) Proposal
=============================
(3.1) Control Path (MAPC)
      The MAPC control path is handled in user space by hostapd. The kernel
      layers (cfg80211 and mac80211) pass the required information to the
      WLAN driver.

Figure 1: Proposed Subsystem Integration for MAPC
-----------------------------------------------------
+---------------------------------------------------------------+
|                           hostapd                             |
|                                                               |
|   +----------------------+    +----------------------+        |
|   |   MAPC Discovery     |    |   MAPC Negotiation   |        |
|   +----------------------+    +----------------------+        |
|                                                               |
|   +----------------------+    +----------------------+        |
|   |   MAPC Peer Mgmt     |    |    MAPC Security     |        |
|   +----------------------+    +----------------------+        |
|                                                               |
|                 +----------------------+                      |
|                 |       NL80211        |                      |
|                 +----------------------+                      |
+---------------------------------------------------------------+
+---------------------------------------------------------------+
|                          cfg80211                             |
|                                                               |
|                 +----------------------+                      |
|                 |       NL80211        |                      |
|                 +----------------------+                      |
+---------------------------------------------------------------+
+---------------------------------------------------------------+
|                          mac80211                             |
|                                                               |
|                 +----------------------+                      |
|                 |    MAPC Peer Mgmt    |                      |
|                 +----------------------+                      |
+---------------------------------------------------------------+
+---------------------------------------------------------------+
|                WLAN Driver (e.g., ath12k)                     |
|                                                               |
|   +----------------------+    +---------------------------+   |
|   |   MAPC Peer Mgmt     |    | MAPC Policy Config Mgmt   |   |
|   +----------------------+    +---------------------------+   |
|                                                               |
|                 +---------------------------+                 |
|                 | MAPC Event Gen/Notify     |                 |
|                 +---------------------------+                 |
+---------------------------------------------------------------+

      (A) Hostapd
          - Protocol Parsing & MAPC context management:
            hostapd handles the transmission and reception of MAPC
            Discovery and MAPC Negotiation public action frames with
            neighboring APs.

            - MAPC discovery:
              - After BSS setup, hostapd may initiate MAPC Discovery
                exchanges with neighboring APs.
              - On receiving a MAPC Discovery frame from a peer AP,
                hostapd:
                - Extracts MAPC capabilities, common parameters and
                  (if present) Per Scheme Profiles.
                - Creates a MAPC peer in hostapd and triggers peer
                  creation in the kernel using NL80211_CMD_NEW_STATION
                  with NL80211_ATTR_MAPC_PEER, marking the station as a
                  MAPC peer.

Figure 2: MAPC Discovery Sequence
-----------------------------------------------------
+--------------------------------------------------------------------+
|                        UHR AP-1                                    |
|  +---------+       +---------+       +---------+       +---------+ | +---------+
|  |         |       |         |       |         |       |         | | |         |
|  | hostapd |       | cfg80211|       | mac80211|       |  wlan   | | |  UHR    |
|  |         |       |         |       |         |       | driver  | | |  AP-2   |
|  +----+----+       +----+----+       +----+----+       +----+----+ | +----+----+
|       |                 |                 |                 |      |      |
|  +----+---------------+ |                 |                 |      |      |
|  | init hostapd & HW  | |                 |                 |      |      |
|  | MAPC support update| |                 |                 |      |      |
|  +----+---------------+ |  MAPC Discovery |                 |      |      |
|       |                 |    Request      |                 |      |      |
|       |                 |(MAPC capability)|                 |      |      |
|       +-----------------+-----------------+-----------------+------|------>
|       |                 |  MAPC Discovery |                 |      |      |
|       |                 |    Response     |                 |      |      |
|       |                 |(MAPC capability)|                 |      |      |
|       <-----------------+-----------------+-----------------+------|------+
|       |                 |                 |                 |      |      |
|  +----+---------------+ |                 |                 |      |      |
|  |alloc sta_info store| |                 |                 |      |      |
|  |MAPC capa & params  | |                 |                 |      |      |
|  +----+---------------+ |                 |                 |      |      |
|       |                 |                 |                 |      |      |
|       nl80211_new_station()               |                 |      |      |
|       +----------------->                 |                 |      |      |
|       |(attr MAPC_PEER) |                 |                 |      |      |
|       |                 |                 |                 |      |      |
|       |                 |rdev_add_station()                 |      |      |
|       |                 +----------------->                 |      |      |
|       |                 |                 |                 |      |      |
|       |                 |            +-----------------+    |      |      |
|       |                 |            | alloc mapc sta  |    |      |      |
|       |                 |            |     object      |    |      |      |
|       |                 |            +-----------------+    |      |      |
|       |                 |                 |                 |      |      |
|       |                 |                 +----------------->      |      |
|       |                 |                 |                 |      |      |
|       |                 |                 |     +-----------------+|      |
|       |                 |                 |     | alloc mapc sta  ||      |
|       |                 |                 |     |     object      ||      |
|       |                 |                 |     +-----------------+|      |
|       |                 |                 |                 |      |      |
|       v                 v                 v                 v      |      v
+--------------------------------------------------------------------+

            - MAPC Negotiation:
              - hostapd initiates and responds to MAPC Negotiation
                exchanges for one or more schemes. When a negotiation
                completes successfully:
                - hostapd programs the APID and per-scheme parameters
                  into the kernel via NL80211_CMD_SET_STATION.
                - When all MAPC agreements with a peer AP are removed,
                  hostapd deletes the MAPC peer from the kernel using
                  NL80211_CMD_DEL_STATION

Figure 3: MAPC Negotiation Sequence (ESTABLISHMENT/UPDATE)
---------------------------------------------------------
+--------------------------------------------------------------------+            
|                           UHR AP-1                                 |            
|  +---------+       +---------+       +---------+       +---------+ | +---------+
|  |         |       |         |       |         |       |         | | |         |
|  | hostapd |       | cfg80211|       | mac80211|       |  wlan   | | |  UHR    |
|  |         |       |         |       |         |       | driver  | | |  AP-2   |
|  +----+----+       +----+----+       +----+----+       +----+----+ | +----+----+
|       |                 |                 |                 |      |      |     
|       |                 |                 |  +--------------+-----+|      |     
|       |                 |                 |  | Notify hostapd to  ||      |     
|       |                 |                 |  |    Trigger MAPC    ||      |     
|       |                 |                 |  |    Negotiation     ||      |     
|       |                 |                 |  +--------------+-----+|      |     
|       |  NL80211_CMD_MAPC_NEGOTIATION_TRIGGER(scheme-id,action)    |      |     
|       <-----------------+-----------------+-----------------+      |      |     
|  +----+---------------+ |                 |                 |      |      |     
|  |parse scheme-id &   | |                 |                 |      |      |     
|  |action. Init MAPC   | |MAPC Negotiation |                 |      |      |     
|  |    Negotiation     | |     Request     |                 |      |      |     
|  +----+---------------+(scheme params & APID1               |      |      |     
|       |              Optype:ESTABLISHMENT/UPDATE)           |      |      |     
|       +-----------------+-----------------+-----------------+------+------>     
|       |                 |MAPC Negotiation |                 |      |      |     
|       |                 |    Response     |                 |      |      |     
|       |                (scheme params & APID2               |      |      |     
|       |              Optype:ACCEPT/REJECT/ALTERNATE)        |      |      |     
|       <-----------------+-----------------+-----------------+------+------+     
|  +----+---------------+ |                 |                 |      |      |     
|  |store APID & scheme | |                 |                 |      |      |     
|  |params.             | |                 |                 |      |      |     
|  +----+---------------+ |                 |                 |      |      |     
|       |                 |                 |                 |      |      |     
|      nl80211_set_station()                |                 |      |      |     
|       +----------------->                 |                 |      |      |     
|       |  (MAPC scheme   |                 |                 |      |      |     
|       |   info & APID)  |rdev_set_station()                 |      |      |     
|       |                 +----------------->                 |      |      |     
|       |                 |                 +----------------->      |      |     
|       |                 |                 |                 |      |      |     
|       |                 |                 |        +--------------+|      |     
|       |                 |                 |        | MAPC Policy  ||      |     
|       |                 |                 |        | config set   ||      |     
|       |                 |                 |        +--------------+|      |     
|       |                 |                 |                 |      |      |     
|       v                 v                 v                 v      |      v     
+--------------------------------------------------------------------+            

            [NOTE] MAPC Negotiation AGREEMENT_UPDATE does not modify
                   the APID assigned during AGRREMENT_ESTABLISHMENT

Figure 4: MAPC Negotiation Sequence (TEARDOWN)
-----------------------------------------------------
+--------------------------------------------------------------------+
|                        UHR AP-1                                    |
|  +---------+       +---------+       +---------+       +---------+ | +---------+
|  |         |       |         |       |         |       |         | | |         |
|  | hostapd |       | cfg80211|       | mac80211|       |  wlan   | | |   UHR   |
|  |         |       |         |       |         |       | driver  | | |   AP-2  |
|  +----+----+       +----+----+       +----+----+       +----+----+ | +----+----+
|       |                 |                 |                 |      |      |
|       |                 |                 | +---------------+-----+|      |
|       |                 |                 | |Notify hostapd to    ||      |
|       |                 |                 | |Trigger MAPC         ||      |
|       |                 |                 | |Negotiation(Teardown)||      |
|       |                 |                 | +---------------+-----+|      |
|       |  NL80211_CMD_MAPC_NEGOTIATION_TRIGGER(scheme-id,action)    |      |
|       <-----------------+-----------------+-----------------+      |      |
|  +----+----------------+|                 |                 |      |      |
|  |parse scheme-id &    ||                 |                 |      |      |
|  |action. Init MAPC    ||                 |                 |      |      |
|  |Negotiation(Teardown)||                 |                 |      |      |
|  +----+----------------+|MAPC Negotiation |                 |      |      |
|       |                 |     Request     |                 |      |      |
|       |                 |(Optype:TEARDOWN)|                 |      |      |
|       +-----------------+-----------------+-----------------+------+------>
|       |                 |MAPC Negotiation |                 |      |      |
|       |                 |    Response     |                 |      |      |
|       |                 | (Optype:ACCEPT) |                 |      |      |
|       <-----------------+-----------------+-----------------+------+------+
|  +----+----------------+|                 |                 |      |      |
|  |If agreement count   ||                 |                 |      |      |
|  |is zero for MAPC peer||                 |                 |      |      |
|  |then initiate MAPC   ||                 |                 |      |      |
|  |peer delete          ||                 |                 |      |      |
|  +----+----------------+|                 |                 |      |      |
|       |                 |                 |                 |      |      |
|      nl80211_del_station()                |                 |      |      |
|       +----------------->                 |                 |      |      |
|       |                 |                 |                 |      |      |
|       |                 |rdev_del_station()                 |      |      |
|       |                 +----------------->                 |      |      |
|       |                 |                 +----------------->      |      |
|       |                 |                 |                 |      |      |
|       |                 |                 |        +--------------+|      |
|       |                 |                 |        |  MAPC peer   ||      |
|       |                 |                 |        |  clean-up    ||      |
|       |                 |                 |        +--------+-----+|      |
|       |                 |                 |                 |      |      |
|       |                 |                 |                 |      |      |
|       |                 |                 |                 |      |      |
+-------v-----------------v-----------------v-----------------v------+      v

            [NOTE] The MAPC peer concept is necessary because the
                   specification defines protected-dual variants of
                   the MAPC Negotiation Request and Response frames.
                   When secured MAPC negotiation is required, each
                   coordinating AP must maintain a separate MPASN derived
                   security context for every neighboring AP.

      (B) cfg80211
          cfg80211 handles the following commands and notifications for MAPC
          - NL80211_CMD_NEW_STATION: to create a MAPC station for an MAPC
            peer, marked by NL80211_ATTR_MAPC_PEER.
          - NL80211_CMD_SET_STATION: to set APID and per scheme parameters.
          - NL80211_CMD_DEL_STATION: to delete MAPC stations
          - NL80211_CMD_GET_STATION: to retrieve MAPC station information

          New notifications from cfg80211 to user space:
          - NL80211_CMD_MAPC_NEGOTIATION_TRIGGER
            Direction: kernel to user space.
            Source: cfg80211 on behalf of the WLAN driver/firmware.
            Purpose: Provide a hint to hostapd that MAPC Negotiation
            Request should be triggered on this interface. For each 
            MAPC scheme, the driver/firmware may request establishment,
            update, or teardown of an agreement. hostapd is expected
            to apply policy and iterate over the locally known MAPC
            peers for this interface.

            Attributes:
            - NL80211_ATTR_MAPC_SCHEMES (nested)
              Contains one or more per-scheme MAPC negotiation hints. Each
              nested entry includes:
              - NL80211_ATTR_MAPC_SCHEME_TYPE
                Identifies the MAPC scheme (e.g., Co-BF, Co-SR, Co-TDMA,
				Co-RTWT, Co-CR).
              - NL80211_ATTR_MAPC_ACTION
                Requested negotiation action for this scheme:
                - NL80211_MAPC_ACTION_ESTABLISH: establish new agreement(s).
                - NL80211_MAPC_ACTION_UPDATE: update existing agreement(s).
                - NL80211_MAPC_ACTION_TEARDOWN: teardown existing agreement(s).

      (C) mac80211
          Two design options are considered for representing MAPC peers in
          mac80211:

          Option-A(Preferred): Reuse existing station management infra
          - Allocate standard station objects (struct sta_info / struct
            ieee80211_sta) to represent MAPC peers, and call the WLAN driver.
          - Use a subset of the existing mac80211 station states (NOTEXIST,
            NONE, AUTH) to represent a MAPC stations.
          - Receive MAPC parameters from cfg80211 and forward them to the
            WLAN driver (for example, via existing station update paths).
          - Use NL80211_ATTR_MAPC_PEER to mark a station as a MAPC station,
            so that data path features (e.g., rate control, aggregation,
            buffering) can be bypassed.
          Pros:
          - Minimal changes to existing mac80211 data structures and state
            machine.
          - Reuses existing add_station / sta_state transitions and driver
            callbacks.
          Cons:
          - Overloads the full station infra for control only usage.

          Option-B: Define lightweight MAPC peer/station management
          infra
          In this option, mac80211 defines a lightweight MAPC station
          management infra, decoupled from normal data-path stations:
          - MAPC requesting and responding APs exchange only management/control
            frames. Most datapath related fields in the existing sta_info/
            ieee80211_sta structures are not applicable.
          - Defines a lightweight MAPC station object
            (e.g., struct ieee80211_mapc_sta)to hold MAPC peer context,
            including:
            - Peer MAC address (BSSID), APID, MAPC security context. MAPC
              capabilities and common parameters.
            - A separate MAPC station list is maintained in mac80211 to track
              all MAPC stations.

          New mac80211 to driver callbacks to be introduced, for example:
          - add_mapc_station() create a MAPC peer/station in the
            driver.
          - change_mapc_station() update APID and scheme parameters for an
            existing MAPC peer/station.
          - del_mapc_station() delete a MAPC peer/station in the driver
          Pros:
          - Clean separation between datapath stations and MAPC control only
            stations.
          Cons:
          - Requires new data structures and callbacks in mac80211 and WLAN
            driver.
          - Slightly larger implementation versus Option A.

      (D) WLAN Driver
          - The WLAN driver maps MAPC stations from mac80211 into driver
            peers and programs scheme specific parameters for Phase 3
            operations.
          - MAPC station/peer creation and deletion:
            For Option A:
            - Reuse standard station callbacks (add_station, change_station,
              remove_station) and treat the MAPC peers as control-only
              (no data-path handling).

            For Option B:
            - Implement the new MAPC-specific callbacks (add_mapc_station,
              change_mapc_station, del_mapc_station) to manage MAPC peers.
            - Event reporting:
              - Inform mac80211/cfg80211 that MAPC negotiation should be
                establish, update or torn down with
                NL80211_CMD_MAPC_NEGOTIATION_TRIGGER.

Regards,
Abhishek

