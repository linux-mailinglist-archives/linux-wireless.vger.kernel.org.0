Return-Path: <linux-wireless+bounces-27935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF9BCEB90
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Oct 2025 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 963CD34FCBD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4512741DA;
	Fri, 10 Oct 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dCtGzP+r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A81A9FAE
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136639; cv=none; b=ILwXg1xJGuqrVOX98w6Bz5prz2s0n+NuWZ1YbNc/zro4Z/SOhPetSoaYg8nrTiPTbzJpQR3XVFtztZH3Vkx3Wf7bncVpcllk6QHft0YkSrjPyTzglsMXMLaGe/GyePAgJk/4ms+ecY73n7JZSg6DWhua+qPjQqa9mlVtrmodrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136639; c=relaxed/simple;
	bh=snAcxIZxtk+uwxwuokS21HaVlE+Eeb67yy7Gdi/yo4Q=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=BU0+yZgyKiWQcTN1iLf0Gz00wHQit2kD8rsrxrWweH8sTZpbCOs3ha8nbztwmMUDY+THCiJeNOC8y0jYmpus1AgdtFn3FPkdx+Q0PaJz0LRjZj08UwMI8HK6L6DlxP2chHUTyEJ07fwcJkQ6PWcGW8ZYwJ9ysVQCbn7IooDc02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dCtGzP+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AEwnL2002164;
	Fri, 10 Oct 2025 22:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H8nble5sGIthXJViy4n2e5
	eYfLCZ4bB0E6w4ZlSC2Mw=; b=dCtGzP+ryV7ficWKnpvvKePXBPOkTTEgMp06oQ
	M8jUk3gLPNJsmuV2PCjBD/OwIRmOyN2dJE9itgzRYlDW8YX8FNwxrHBhjWHQJK/+
	nYDUwkldQbsBwRGIubUELkEF7BGZ19QeVibckmOZIAvIO7J4R5XlTN+inlk3lRsU
	Fr4bnmWDWIpT40kTGtX6qZqQTUudb3z+ilqKFlbq63bSzECdoLhu5gLy8WboVd+a
	VLvREBRTIw3+Pk+MGgvOwbTvqIzX7sNu5h8pVnCNDTbgkwoUuC8eojZgM2WjExWb
	oYhkQ9rpDHI1UOf5YGq8dwvvIVz9NGEAXeqnITZAkIT3trIA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u7va8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 22:50:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59AMoPWr019274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 22:50:25 GMT
Received: from [10.110.37.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Fri, 10 Oct
 2025 15:50:24 -0700
Message-ID: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
Date: Fri, 10 Oct 2025 15:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <ath12k@lists.infradead.org>, <hostap@lists.infradead.org>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
From: Aditya Sathish <quic_asathish@quicinc.com>
Subject: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8 Seamless
 Mobility Domain (SMD)
Organization: Qualcomm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e98db2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=zMuR0zD9l8Ul11tQCSsA:9 a=khwfyjgA5lqb-EQM:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oIdWIz23qkI5BYksVNtinR_A8tQZ8KR8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwavhRqQ8vg1p
 vTeE8JSfAxKpnVbTOj4eNmYDwXWLAF4V4cXePeeUtHC6sHeqVgKzulR3M/rYG91rAavf6p+UnYH
 xABkY/Y76S8uqRLMSm4AAVeP3/wq1EMKJXVd7JDANh/oeVhmDq2riDeWK2gh1Ehm/xtHmb0opih
 dG6SjZlS1GiDPE61Q1tRRGUCp7ERNHG0MYByt3qIVsi8dOlZy07WIOvDqCbyAq7uICXIwRVOCAu
 i3I6OnKsBNaq9JpDPXDZdnD9hfttjgPwC+RRpcOvmVjKd9fNIkppvuMq8gtxdWvMw2T3nzokPkM
 PUzGJCoH1Z6BaG1hCpjjcFrgcNTq9KR9lkqITY2B39SWtDrSnleMhxnff8cAkelKl6HMJJ/5/g3
 NP1umb07pnGyc13DuSjfRJsdRJaung==
X-Proofpoint-ORIG-GUID: oIdWIz23qkI5BYksVNtinR_A8tQZ8KR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Hello Everyone,

This RFC presents a high-level design proposal for Seamless Mobility Domain (SMD)
Basic Service Set (BSS) Transition (ST) in IEEE 802.11bn (Wi-Fi 8).

The design is based on IEEE 802.11bn-D1.0 (as of October 2025), and may be updated
based on future draft updates.

We hope to gather upstream community feedback on the proposed architecture and
subsystem integration strategy. This document does not include implementation patches
or code and is intended solely for design-level discussion.

=====================
Table of Contents
=====================
(1) Introduction & Scope
(2) Background
	(2.1) SMD-ME
	(2.2) MAC-SAP
	(2.3) SMD Sequences
(3) Proposal
	(3.1) Subsystem Impact
	(3.2) SMD Sequences
		(3.2.1) SMD Bring-Up
		(3.2.2) SMD AP MLD Bring-Up
		(3.2.3) SMD IAP Neighborhood Update
			(3.2.3.1) SMD IAP Neighbor Fetch and Response
			(3.2.3.2) SMD IAP Neighbor Update
		(3.2.4) SMD Association
		(3.2.5) ST Discovery
			(3.2.5.1) Active Scanning
			(3.2.5.2) BTM or Neighbor Report
		(3.2.6) ST Selection Recommendation
		(3.2.7) ST Preparation
		(3.2.8) ST Execution
			(3.2.8.1) ST Execution to Serving AP MLD
			(3.2.8.2) ST Execution to Target AP MLD
		(3.2.9) ST Transitory Termination
			(3.2.9.1) Nominal Max DL Drain Period Expiry
			(3.2.9.2) AP-Side Forced Termination
			(3.2.9.3) Non-AP-MLD-Side Forced Termination
	(3.3) Inter-AP (IAP) Communication for SMD
		(3.3.1) Protocol
			(3.3.1.1) Fragmentation
			(3.3.1.2) Encryption
		(3.3.2) Endpoints

========================
[1] Introduction & Scope
========================
The IEEE 802.11bn specification has introduced the concept of a Seamless Mobility
Domain (SMD) consisting of multiple collocated and non-collocated AP MLDs. An
SMD Management Entity (SMD-ME) coordinates context sharing and roaming decisions
across AP MLDs, acting as a logical anchor for roaming and mobility. Within an SMD, a
non-AP MLD can perform ST roaming between the AP MLDs while maintaining association
with an SMD-ME and connectivity at the Medium Access Control Service Access Point
(MAC-SAP).

The scope of this RFC is as follows:
1. Enable SMD roaming feature support across mac80211, cfg80211, hostapd, and WLAN
   drivers up to 802.11bn-D1.0
2. Focusing on AP MLD-side support for roaming, including:
   - Context transfer
   - SMD neighborhood update
   - ST roaming sequences
   - Inter-AP communication and ST Execution framework for kernel-offload mode

The following sub-features in SMD will be deferred to the version 2 (v2) of the RFC:
   - Non-AP MLD support
   - PTK Mode 1 support
   - SMD MBSSID support

Patches will be proposed in the subsequent version of the RFC once we have achieved
general consensus on the architecture.

==============
[2] Background
==============
The key aspects involved in ST roaming are:
- SMD-ME: Entity managing the mobility coordination
- MAC-SAP: Interface between MAC and higher layers
- ST Sequences: Signaling for discovering, preparing and executing ST roaming

	[2.1] SMD-ME
	------------
	The SMD-ME is a logical entity for managing the authentication, association,
	and security context of a non-AP MLD within an SMD. It is shared across all
	the AP MLDs that are part of the SMD group. When a client associates to an
	SMD-capable AP MLD, the PMK and PTK keys are generated with both the AP MLD
	and the SMD MAC Address. IEEE 802.11bn-d0.1 Section 9.4.2.aa2 defines two
	modes of operation:
	- PTK Mode 0: A single PTK shared across all the AP MLDs in an SMD
	- PTK Mode 1: A unique PTK generated at each AP MLD

	There are two implementations for the SMD-ME:
	- Centralized SMD-ME: AP MLDs report their state and the state of their
	  associated non-AP MLDs to this centralized entity. The SMD-ME in turn
	  facilitates the roaming of clients with the AP MLDs in its domain.
        - Decentralized SMD-ME: Hosted on each AP MLD, with state synchronization
	  performed using inter-AP signaling between individual AP MLDs.

	[NOTE] IEEE 802.11bn-D1.0 does not define centralized or distributed SMD but
	the implementation of SMD-ME can intuitively be one or the other with the
	latter involving inter-AP signalling over the backhaul to synchronize AP MLD
	and non-AP MLD context between the distributed AP MLDs.

Figure 1: Distributed and Centralized SMD-ME Diagram
----------------------------------------------------
(a) Distributed SMD-ME                  (b) Centralized SMD-ME
┌────────────────────────────────┐      ┌────────────────────────────────┐
│               DS               │      │               DS               │
└────────────────────────────────┘      └────────────────────────────────┘
┌────────┐  ┌────────┐  ┌────────┐      ┌────────────────────────────────┐
│ SMDME0 │  │ SMDME0 │  │ SMDME0 │      │             SMDME0             │
├────────┤  ├────────┤  ├────────┤      └────────────────────────────────┘
│  MLD0  │  │  MLD1  │  │  MLD2  │      ┌────────┐  ┌────────┐  ┌────────┐
├──┬──┬──┤  ├──┬──┬──┤  ├──┬──┬──┤      │  MLD0  │  │  MLD1  │  │  MLD2  │
│L0│L1│L2│  │L0│L1│L2│  │L0│L1│L2│      ├──┬──┬──┤  ├──┬──┬──┤  ├──┬──┬──┤
└──┴──┴──┘  └──┴──┴──┘  └──┴──┴──┘      │L0│L1│L2│  │L0│L1│L2│  │L0│L1│L2│
                                        └──┴──┴──┘  └──┴──┴──┘  └──┴──┴──┘

	[2.2] MAC-SAP
	-------------
	The MAC Service Access Point (MAC-SAP) is an interface between the AP MLD and
	the Distribution System (DS) interfacing with the Logical Link Control (LLC)
	layer.

	IEEE 802.11bn-D1.0 Section 37.16.1 defines two modes:
	- Multiple MAC-SAP (SMD Mode 0): Each AP MLD has its own MAC-SAP. Roaming
	  will require DS mapping updates.
	- Single MAC-SAP (SMD Mode 1): Shared across AP MLDs or hosted on a
	  controller. No DS mapping update needed during roaming.
  
Figure 2: Distributed and Centralized MAC-SAP Diagram
-----------------------------------------------------
(a) Distributed MAC-SAP                 (b) Centralized MAC-SAP
┌────────────────────────────────┐      ┌────────────────────────────────┐
│               DS               │      │               DS               │
├────────┬──┬────────┬──┬────────┤      ├────────────────────────────────┤
│MAC-SAP0│  │MAC-SAP1│  │MAC-SAP2│      │            MAC-SAP0            │
├────────┤  ├────────┤  ├────────┤      ├────────────────────────────────┤
│ SMDME0 │  │ SMDME0 │  │ SMDME0 │      │             SMDME0             │
├────────┤  ├────────┤  ├────────┤      └────────────────────────────────┘
│  MLD0  │  │  MLD1  │  │  MLD2  │      ┌────────┐  ┌────────┐  ┌────────┐
├──┬──┬──┤  ├──┬──┬──┤  ├──┬──┬──┤      │  MLD0  │  │  MLD1  │  │  MLD2  │
│L0│L1│L2│  │L0│L1│L2│  │L0│L1│L2│      ├──┬──┬──┤  ├──┬──┬──┤  ├──┬──┬──┤
└──┴──┴──┘  └──┴──┴──┘  └──┴──┴──┘      │L0│L1│L2│  │L0│L1│L2│  │L0│L1│L2│
                                        └──┴──┴──┘  └──┴──┴──┘  └──┴──┴──┘

	[NOTE] The selection of MAC-SAP and SMD-ME is implementation-defined and
	depends on factors such as the HW design and architecture. This RFC proposes
	a distributed MAC-SAP and SMD-ME model, which Qualcomm is adopting. However,
	the architecture is intended to be extensible for centralized MAC-SAP
	and/or SMD-ME also.

	[2.3] SMD Sequences
	-------------------
	IEEE802.11bn-D1.0 Section 37.16.1 describes 5 key SMD sequences for roaming
	as described in Figure 3:
	- SMD Discovery: Identification of SMD group members
	- SMD Selection Recommendation: Identification of roaming candidate AP MLDs
	- ST Preparation: Initiating transition of a client to a new AP MLD in same SMD
	- ST Execution: Completing transition of a client to the new prepared AP MLD
	- ST Transitory Indication: Terminating the DL draining at the serving AP MLD

	For both ST Preparation and ST Execution, the specification allows the
	transfer of client association, datapath and control path context between AP
	MLDs in the same SMD by use of inter-AP backhaul communication over wired or
	wireless links (see IEEE802.11bn-D1.0 Section 3.16.8).

Figure 3: SMD Roaming Sequence Flow
-----------------------------------
┌──────┐   ┌──────────────┐                  ┌───────────────┐
│Client│   │Serving AP MLD│                  │ Target AP MLD │
└──┬───┘   └───────┬──────┘                  └────────┬──────┘
   │ Discovery     │                                  │       
   ├───────────────►                                  │       
   │ Request       │                                  │       
   │             ┌─┴──────────────────────────────────┴─┐     
   │             │      Determine the neighborhood      │     
   │             │     AP MLDs part of the same SMD     │     
   │             └─┬──────────────────────────────────┬─┘     
   │  Discovery    │                                  │       
   │◄──────────────┤                                  │       
   │  Response     │                                  │       
   │               │                                  │       
   │               │                                  │       
   │               │                                  │       
   │ Recommendation│                                  │       
   ├───────────────►                                  │       
   │ Request       │                                  │       
   │             ┌─┴──────────────────────────────────┴─┐     
   │             │       Determine the recommended      │     
   │             │            target AP MLD             │     
   │             └─┬──────────────────────────────────┬─┘     
   │ Recommendation│                                  │       
   │◄──────────────┤                                  │       
   │  Response     │                                  │  
┌──┴───────────────┴──────────────────────────────────┴────┐
| Started SMD BSS transition                               |
└──────────────────────────────────────────────────────────┘     
   │               │                                  │       
   │   Roam Prep   │                                  │       
   ├──────────────►│   IAP SMD BSS Transition Request │       
   |               |       (ST Preparation)           |       
   │               ├─────────────────────────────────►│       
   │               │                                  │       
   │               │   IAP SMD BSS Transition Resp    │       
   │               │       (ST Preparation)           │       
   │               │◄─────────────────────────────────┤       
   │   Roam Prep   │                                  │       
   │     Resp      │                                  │       
   │◄──────────────┤                                  │       
   │               │                                  │       
   │               │                                  │       
   │   Roam Exec   │                                  │       
   ├──────────────►│   IAP SMD BSS Transition Request │       
   |               |       (ST Execution)             |       
   │               ├─────────────────────────────────►│       
   │               │                                  │       
   │               │   IAP SMD BSS Transition Resp    │       
   │               │       (ST Execution)             │       
   │               │◄─────────────────────────────────┤       
   │   Roam Exec   │                                  │       
   │     Resp      │                                  │       
   │◄──────────────┤                                  │       
   │               │                                  │     
   │               │                                  │     
   │  Notify (opt) │                                  │ 
   ├──────────────►│                                  │
   │       ┌────────────────┐                         │
   │       | Clean up peers |                         │
   │       └───────┬────────┘                         │
┌──┴───────────────┴──────────────────────────────────┴────┐
| Completed SMD BSS transition                             |
└──────────────────────────────────────────────────────────┘

============
[3] Proposal
============
Qualcomm's initial proposal, as described in this RFC, will follow a distributed
SMD-ME along with a distributed MAC-SAP architecture. However, the design is intended
to be extensible for centralized SMD-ME as well as centralized MAC-SAP options which
other vendors using mac80211-based drivers may propose.

The proposal is organized into the following components:
- Subsystem Impact: Key subsystems and their roles in supporting ST roaming
- SMD Sequences: All the new (and existing) sequences involved in ST roaming
- Inter-AP Communication Framework: Proposed backhaul communication protocol for
  context transfer

	[3.1] Subsystem Impact
	----------------------
	The following diagram illustrates the new functional blocks proposed for
	integration into the upstream wireless driver architecture—specifically
	across the WLAN driver, mac80211, cfg80211, and hostapd subsystems. For
	consistency, we refer to the mac80211-based driver (for example, ath12k) as
	the WLAN driver throughout this RFC.

Figure 4: Proposed Subsystem Integration for SMD Roaming Support
----------------------------------------------------------------
┌────────────────────────────┐
│┌────────────┐┌────────────┐│
││SMD         ││SMD Select  ││
││Preparation ││Candidate   ││
│└────────────┘└────────────┘│
│┌────────────┐┌────────────┐│
││Auth &      ││SMD         ││
││Association ││Discovery   ││
│└────────────┘└────────────┘│
│┌────────────┐┌────────────┐│
││Peer        ││SMD Neighbor││
││Management  ││DB Update   ││
│└────────────┘└────────────┘│
│┌────────────┐┌────────────┐│
││802.1X      ││NL80211     ││
││            ││            ││
│└────────────┘└────────────┘│
│           Hostapd          │
└────────────────────────────┘
┌────────────────────────────┐
│┌──────────────────────────┐│
││         nl80211          ││
││                          ││
│└──────────────────────────┘│
│┌──────────────────────────┐│
││         DS Update        ││
││          (L2UF)          ││
│└──────────────────────────┘│
│          cfg80211          │
└────────────────────────────┘
┌────────────────────────────┐
│┌────────────┐┌────────────┐│
││SMD         ││SMD Peer    ││
││Execution   ││Context     ││
│└────────────┘└────────────┘│
│┌──────────────────────────┐│
││Inter-AP                  ││
││Communication Framework   ││
│└──────────────────────────┘│
│          mac80211          │
└────────────────────────────┘
┌────────────────────────────┐
│┌────────────┐┌────────────┐│
││Context     ││SMD Frame   ││
││Collection  ││Priority    ││
│└────────────┘└────────────┘│
│ WLAN driver (e.g. ath12k)  │
└────────────────────────────┘

	[3.2] SMD Sequences
	-------------------
	There are 9 sequences which are relevant towards SMD setup and ST roaming:
	(1) SMD Bring-Up: Bringing up the SMD Management Entity (SMD-ME)
	(2) AP MLD Bring-Up: Updates to the existing AP MLD bring-up sequence
	(3) SMD Neighborhood Update: Tracking the SMD neighborhood
	(4) SMD Association: AP MLD handling for SMD association to a non-AP MLD
	(5) SMD Discovery: Enable a non-AP MLD to track AP MLDs in its SMD
	(6) SMD Selection Recommendation: Recommend target AP MLDs to a non-AP MLD
	(7) ST Preparation: Handling client-initiated preparation of a target AP MLD
	(8) ST Execution: Handling client-initiated execution to a target AP MLD
	(9) ST Transitory Indication: Handling DL drain termination

		[3.2.1] SMD Bring-Up
		--------------------
		Figure 5 describes the SMD bring-up sequence in the kernel stack and
		involves the following:
		- Reading HW/FW capabilities for SMD
		- Registering SMD-specific ieee80211_ops and cfg80211_ops
		- Updating wiphy and ieee80211_hw flags for ST roaming support
		- Updating wiphy and ieee80211_hw flags for kernel-offloaded
		  ST execution support

Figure 5: SMD Bring-Up Sequence in Kernel Stack
-----------------------------------------------
┌──────┐                    ┌────────┐             ┌──────────┐
│WLAN  │                    │mac80211│             │ cfg80211 │
│Driver│                    │        │             │          │
└──────┘                    └────────┘             └──────────┘
    │                            │                      │
    │                            │                      │
┌───┴─────────┐                  │                      │
│Register SMD │                  │                      │
│ieee80211 ops│                  │                      │
└───┬─────────┘                  │                      │
    │  ieee80211_alloc_hw()      │                      │
    │───────────────────────────►│                      │
    │                       ┌────┴────────┐             │
    │                       │Register SMD │             │
    │                       │cfg80211 ops │             │
┌───┴────────┐              └────┬────────┘             │
│Update SMD  │                   │wiphy_alloc()         │
│capabilities│                   │─────────────────────►│
│in wiphy and│                   │                      │
│ieee80211_hw│                   │                      │
└───┬────────┘                   │                      │
    │   ieee80211_register_hw()  │                      │
    ├───────────────────────────►│wiphy_register()      │
    │                            ├─────────────────────►│
    ▼                            ▼                      ▼

		Figure 6 describes the SMD bring-up sequence in hostapd and involves
		the following:
		- Reading the wiphy flags for SMD support in the HW/FW
		- Reading the following configurations from hostapd configurations
			- SMD ID: 48-bit MAC address
			- Neighboring AP MLD member MAC addresses part of same SMD
			- SMD inter-AP communication wildcard key (similar to FT)
			  [NOTE] Optionally, similar to FT, each AP MLD can operate
			  with a separate key.
			- SMD mode (MAC-SAP mode)
			- PTK mode
			- SMD execution timeout
			- MTU size of inter-AP transport channel
			- Nominal max DL drain time period
			- Retry limit for SMD neighborhood signals
		[NOTE] These configurations will evolve along with the specification
		and code development

Figure 6: SMD Bring-Up Sequence in Hostapd
------------------------------------------------
 ┌───────┐                 ┌────────┐
 │Hostapd│                 │cfg80211│
 └───┬───┘                 └────────┘
     │                         │
     │                         │
┌────┴───────┐                 │
│Initialize  │                 │
│hostapd and │                 │
│probe driver│                 │
│capabilities│                 │
└────┬───────┘                 │
     │   NL80211_CMD_GET_WIPHY │
     ├────────────────────────►│
     │                     ┌───────────────────────┐
     │                     │Populate               │
     │                     │nl80211 command        │
     │                     │based on wiphy data    │
     │                     │(including SMD support)│
     │                     └───────────────────────┘
     │   NL80211_CMD_WIPHY_INFO│
     │◄────────────────────────┤
┌────┴───────┐                 │
│Intersect   │                 │
│driver caps │                 │
│with hostapd│                 │
│support     │                 │
└─────┬──────┘                 │
      │                        │
┌─────┴────────────┐           │
│Read and store    │           │
│configurations    │           │
└─────┬────────────┘           │
      ▼                        ▼

		[3.2.2] SMD AP MLD Bring-Up
		---------------------------
		Figure 7 describes the SMD AP MLD bring-up sequence involving:
		- Creating the MLD interface with the SMD configurations including:
		  [NOTE] These will evolve along with standard and code development
			- SMD ID
			- Neighborhood AP MLD MAC addresses part of the SMD group
			- SMD inter-AP communication key(s)
			- SMD mode
			- PTK mode
		- Setting up of a neighbor database for kernel-offloaded inter-AP
		  communication during ST execution containing the following for
		  each neighbor within the SMD:
			- AP MLD MAC address
			- Inter-AP communication key(s)
		- Registration of the inter-AP Rx handler in mac80211 (if kernel
		  offload ST Execution is enabled) using dev_add_pack()
		[NOTE] This is applicable only if kernel-offload is enabled

Figure 7: SMD AP MLD Bring-Up Sequence
--------------------------------------
  ┌───────┐                  ┌────────┐       ┌────────┐                  
  │Hostapd│                  │cfg80211│       │mac80211│                  
  └───┬───┘                  └───┬────┘       └────┬───┘                  
┌─────┴──────────────┐           │          ┌──────┴───────────────────┐  
│Create MLD interface│           │          │Pass MLD interface        │  
│along with SMD ID   ├───────────┼─────────►|creation params to        │  
│to cfg80211         │           │          │FW via mac80211 and ath12k│  
└─────┬──────────────┘           │          └──────────────────────────┘  
┌─────┴────────────────┐         │          ┌──────────────────────────┐  
│Set channel and wiphy │         │          │Update channel params     │  
│params                ├─────────┼─────────►|in the driver             │  
└─────┬────────────────┘         │          └──────┬───────────────────┘  
┌─────┴─────────────────┐        │          ┌──────┴─────────────────────┐
│Set beacon and start AP├────────┼─────────►│Send VIF start to the WLAN  │
└─────┬─────────────────┘        │          │driver and start beaconing  │
      │                          │          └──────┬─────────────────────┘
      │                          │                 │                      
┌─────┴─────────────────┐        │          ┌──────┴───────┐              
│Install group keys     ├────────┼─────────►│Set group keys│              
└─────┬─────────────────┘        │          │in FW         │              
      │                          │          └──────┬───────┘              
      ▼                          ▼                 ▼                      

		[3.2.3] SMD IAP Neighborhood Update
		----------------------------------------
		To enable client-initiated ST Discovery and Selection Recommendation,
		the neighborhood database in each AP MLD needs to track the SMD
		group members

		The SMD inter-AP neighborhood update procedures define a set of
		inter-AP signals to be sent in the backhaul links to notify the
		addition, removal, or modification of links within the SMD topology.

		Hostapd already maintains a per-link neighborhood database which is
		used for neighbor reports. This database will need to be advertised
		and updated by the SMD neighborhood members under changes to their
		internal states. Content includes:
		- MAC address of neighboring link
		- Neighbor report element (see IEEE 802.11bn-D1.0 Section 9.4.2.35)
		- Operating class
		- Channel number
		- PHY type
		- Optional subelements (see IEEE 802.11 Table 9-212)

		There are two types of SMD IAP neighbor update signals proposed:
		(1) IAP SMD Neighbor Fetch and Response: Request for capabilities
		(2) IAP SMD Neighbor Update: Broadcast capabilities of self.

			[3.2.3.1] SMD IAP Neighbor Fetch and Response
			---------------------------------------------
			Figure 8 shows the fetch commands as request/response
			mechanisms (broadcast or unicast) initiated in one of the
			following conditions:
			(1) On receiving a IAP SMD Neighborhood Update Request or
			    Notification
			(2) If the neighborhood table entry for one or more AP
			    MLD(s) is stale. A periodic update will be sent till
			    a response is received from a neighboring AP MLD. If
			    there is no response, the fetch request will be
			    stopped beyond a configured number of retries (set in
			    hostapd)

			[NOTE] A neighbor table entry is considered stale if the
			its content has not been updated for longer than a
			configured threshold.


Figure 8: SMD IAP Neighbor Fetch and Response Diagram
-----------------------------------------------------
                                                                               
┌──────────┐                     ┌───────────┐            
│Serving AP│                     │ Target AP │            
└─────┬────┘                     └───────┬───┘            
┌─────┴─────────┐                        │                
│Requests       │ IAP SMD Neighbor┌──────┴───────────────┐
│info from all  ├────────────────►│Populates its         │
│neighbor AP    │   Fetch         │neighbor report       │
│MLDs within a  │                 │IE in SMD IAP         │
│timeout (OR)   │◄────────────────┤message and sends     │
│requests info  │ IAP SMD Neighbor│back to serving AP MLD│
│from select    │   Response      └──────┬───────────────┘
│neighbor AP    │                        │                
│MLDs with stale│                        │                
│entries        │                        │                
└─────┬─────────┘                        │                           
      ▼                                  ▼

			[3.2.3.2] SMD IAP Neighbor Update
			---------------------------------
			Update notifications are broadcast or unicast notifications
			that are initiated by an AP MLD in the following events as
			shown in Figure 9:
			(1) Changes to the MLD:
				(1) When an AP MLD is created
				(2) When an AP MLD is destroyed
				(3) When an AP MLD capability is modified.
			(2) Changes to individual links:
				(1) When a link is reconfigured
				(2) When a link is brought down
				(3) When a link is brought up
				(4) When a link capability is modified.

Figure 9: SMD IAP Neighbor Update Diagram            
-----------------------------------------
┌──────────┐                     ┌───────────┐            
│Serving AP│                     │ Target AP │            
└─────┬────┘                     └───────┬───┘            
      │                                  │                
┌─────┴─────────┐                        │                
│AP MLD changes │                        │                
│state (or) link│                        │                
│changes state  │                        │                
└─────┬─────────┘                        │                
      │                                  │                
┌─────┴─────────┐                 ┌──────┴───────────────┐
│AP MLD creates │                 │Populates its         │
│new neighbor   │ IAP SMD Neighbor│neighborhood table    │
│report IE and  │────────────────►│                      │
│sends it to    │      Update     └──────┬───────────────┘
│neighbor AP    │                        │
└─────┬─────────┘                        │      
      │                                  │                
      ▼                                  ▼                

		[3.2.4] SMD Association
		-----------------------
		As in Figure 10, SMD association follows the existing association
		sequence with the addition of the following (see IEEE 802.11bn-D1.0
		Section 12.2.4):
		- Authentication request/response will advertise the SMD IE
		- Association request/response will also advertise the SMD IE
		[NOTE] There is currently some open items in the standard regarding
		this which will be updated in RFC v2.

		The PMK and PTK generated as part of the authentication and EAPOL
		exchange, respectively, for the associated non-AP MLD remains the
		same for the lifetime of the association.

		The PMK is derived with the SMD-ME against the SMD ID. The PTK
		is derived with the AA/BSSID as the AP MLD to which the non-AP MLD
		has initially associated while the SMD ID is added to the end
		of the context of the PTK formula (see IEEE 802.11bn-D1.0 Section
		37.16.5.3)

		[NOTE] This RFC proposal only considers PTK Mode 0 (i.e., the use of
		a per-SMD PTK). Support for PTK Mode 1 (i.e., the use of a per-AP-MLD
		PTK) will be introduced in RFC v2.

Figure 10: SMD Association Diagram
----------------------------------
   ┌────────┐           ┌────────┐   ┌────────┐       ┌─────────────┐    
   │hostapd │           │cfg80211│   │mac80211│       │ wlan-driver │            
   └───┬────┘           └────┬───┘   └────┬───┘       └────┬────────┘            
       │                     │            │         ┌──────┴──────┐         
       │                     │            │         │Receive auth │         
┌──────┴───────────┐         │            │         │req and pass │         
│Receive auth      │   [NOTE] Can also be 4 way     │to hostapd   │         
│req, read SMD IE, │◄───────────────────────────────┼via cfg80211 │         
│generate PMK,     │         SAE authentication     └──────┬──────┘         
│create peer and   │         │            │         ┌──────┴───────┐        
│prepare auth resp ┼─────────┼────────────┼────────►►Send auth resp│        
└──────┬───────────┘         │            │         │to FW via HW  │        
       │                     │            │         │ring          │        
       │                     │            │         └──────┬───────┘        
       │                     │            │                │                
       │                     │            │         ┌──────┴──────┐         
┌──────┴─────────────┐       │            │         │Receive assoc│         
│Receive assoc req,  │◄──────┼────────────┼─────────┼req and pass │         
│read SMD ID, verify │       │            │         │to hostapd   │         
│SMD group, associate│       │            │         │via cfg80211 │         
│peer and prepare    │       │            │         └──────┬──────┘         
│assoc resp          │       │            │         ┌──────┴────────┐       
│                    ├───────┼────────────┼─────────►Send assoc resp│       
└───────┬────────────┘       │            │         │to FW via HW   │       
        │                    │            │         │ring           │       
        │                    │            │         └──────┬────────┘       
┌───────┴────────────┐       │            │         ┌──────┴─────────────┐  
│Prepare M1 of EAPoL ├───────┼────────────┼────────►│Receive M1, generate│  
│with ANonce         │       │            │         │PTK with SMD ID,    │  
└───────┬────────────┘       │            │         │send M2             │  
┌────────────────────┐       │            │         │                    │  
│Receive M2, derives ◄───────┼────────────┼─────────┤                    │  
│PTK with SMD ID,    │       │            │         └──────┬─────────────┘  
│generates GTK and   │       │            │         ┌──────┴───────────────┐
│IGTK keys, prepare  ├───────┼────────────┼─────────►Receive M3, install   │
│M3                  │       │            │         │GTK and IGTK keys,    │
└───────┬────────────┘       │            │         │prepare M4 and send it│
┌───────┴─────────────┐      │            │         │                      │
│Receive M4, and      ◄──────┼────────────┼─────────┤                      │
│authorize peer       │      │            │         └──────┬───────────────┘
└───────┬─────────────┘      │            │                │                
        ▼                    ▼            ▼                ▼                

                [3.2.5] ST Discovery
                --------------------
		There are three methods for ST Discovery as described in the
		specifications (see IEEE 802.11bn-D1.0 Section 37.16.2):
		(1) Active (or passive) scanning from the non-AP MLD
		(2) BSS Transition Management (BTM) exchanges
		(3) Neighborhood Report Request/Response exchanges

                        [3.2.5.1] Active/Passive Scanning
                        ---------------------------------
			This method utilizes the existing multi-link probe request
			and response mechanism that a non-AP MLD uses during active
			or passive scanning as shown in Figure 11.
			SMD information is advertised in the RNR IE and SMD IE in
			beacons or probe responses (see IEEE 802.11bn-D1.0 Section
			37.16.2.1)

Figure 11: ST Discovery using Active Scanning
---------------------------------------------                                       
┌──────┐   ┌──────────┐  ┌───────────┐       
│Client│   │Serving AP│  │ Target AP │       
└──┬───┘   └─────┬────┘  └───────┬───┘       
   │             │               │            
   │ Probe Req   │               │            
   ├─────────────►               │            
   │             │               │            
   │ Probe Req   │               │            
   ├─────────────┼──────────────►│            
   │       ┌──────────────┐   ┌──────────────┐
   │       │Prepare RNR   │   │Prepare RNR   │
   │       │IE and add SMD│   │IE and add SMD│
   │       │IE to prb resp│   │IE to prb resp│
   │       └─────┬────────┘   └──┬───────────┘
   │             │               │            
   │◄────────────┤               │            
   │◄────────────┼───────────────┤            
   │ Probe Resp  │               │

			[3.2.5.2] BTM or Neighbor Report
			--------------------------------
			This method utilizes the BSS Transition Management (BTM)
			or Neighbor Report sequence initiated by the non-AP MLD to
			report neighboring AP MLDs which are both part of the same
			SMD as well part of other SMDs as shown in Figure 12.
			For ST Discovery, the client can use a BTM Query with
			Reason=Discovery.
			Each AP MLD reported will contain the information described
			in IEEE 802.11bn-D1.0 Section 37.16.2.1 and includes a
			Neighbor Report element containing:
			- BSS Load (if included in beacon)
			- UHR Operations
			- UHR Capabilities
			- Supported Rates and BSS Membership Selectors
			- Extended Supported Rates and BSS Membership Selectors
			- SMD IE (if part of different SMD from reporting AP)

Figure 12: ST Discovery with BTM Exchange or Neighbor Report Diagram
--------------------------------------------------------------------
┌──────────────────────────────────────┐
│        ┌────────────────────────────┐│
│        │(2) Probe neighbor table    ││
│        ├────────────────────────────┤│
│        │(3) Prepare neighbor IE     ││
│        │    in BTM Request or       ││
│        │    Neighbor Report Resp    ││
│hostapd │    for all AP MLDs in SMD  ││
│        └────────────────────────────┘│
└───┬──────────────────────▲───────────┘
    │                      │
┌───┴────────────────┐     │
│(4) Send BTM Request│     │
│    Neighbor Report │     │
│    Response        │     │
└───┬────────────────┘     │
    │                      │
┌───┴──────────────────────┴───────┐
│cfg80211                          │
└───┬──────────────────────┬───────┘
    │                      │
┌───┴──────────────────────┴───────┐
│mac80211                          │
└───┬──────────────────────┬───────┘
    │                      │
┌───┴──────────────────────┴───────┐
│WLAN driver                       │
└───┬──────────────────────┬───────┘
    │                      │
    │                      │
    │        ┌─────────────┴─────────────┐
    │        │(1) Receive BTM Query or   │
    │        │    Neighbor Report Request│
    │        └─────────────┬─────────────┘
    │                      │
┌───▼──────────────────────┴───────┐
│WLAN HW                           │
└──────────────────────────────────┘

		[3.2.6] ST Selection Recommendation
		-----------------------------------
		ST Selection Recommendation is initiated by the client with the
		intention of gaining insight from the serving AP MLD of potential
		candidates for roaming.

		ST Selection Recommendation uses BTM but with a Reason=Recommendation
		This gives the AP an indication that the list of APs to respond with
		needs to be a recommendation for roaming. The sequence will follow
		ST Discovery BTM as shown in Figure 13. Just like in Section 3.2.5,
		the reporting AP MLD should include content described in
		IEEE802.11bn-D1.0 Section 37.16.2.1.

		[3.2.7] ST Preparation
		----------------------
		Figure 14 describes the ST Preparation sequence as 12 steps,
		beginning when the UHR Reconfiguration Request (ST Preparation)
		frame is received by the WLAN HW and ending when the UHR
		Reconfiguration Response (ST Preparation) frame is sent back to
		the non-AP MLD. For details on the specification, refer to
		IEEE802.11bn-D1.0 Section 37.16.5.

		There are two inter-AP signals which are to be used for this
		sequence for the transfer of context and confirmation of
		preparation at the target AP MLD:
		- IAP SMD BSS Transition Request (ST Preparation)
		- IAP SMD BSS Transition Response (ST Preparation)

		The sequence is described as below:
		- Serving AP MLD:
			(00) WLAN HW:
				- UHR Reconfiguration Request (ST Preparation)
				  is sent to the WLAN driver
			(01) WLAN Driver:
				- Verifies the frame and sender
				- Requests the HW for the following HW context
				  as per IEEE802.11bn-D1.0 Section 37.16.8:
					- Tx BA information
					- Rx BA information
				- Receives the HW context and attaches to
				  the management frame SKB using
				  SKB_EXTENSIONS
				- Sends the UHR Reconfiguration Request (ST
				  Preparation) frame along with context to
				  mac80211
			(02) Mac80211:
				- Passes the UHR Reconfiguration Request (ST
				  Preparation) frame along with context to
				  Hostapd using existing NL80211_CMD_FRAME with
				  new attributes for context
			(03) Hostapd:
				- Verifies the frame and ST Preparation sanity
				- Prepares the payload for the IAP SMD BSS
				  Transition Request (ST Preparation) containing
				  the following:
					- Tx BA information
					- Rx BA information
					- Non-AP MLD association context
					- Non-AP MLD PMK
					- Non-AP MLD PTK
					- Established QoS context
					- Requested QoS context
					- Flag to reset DL SN
					- Flag to reset UL SN
				- Sends the IAP SMD BSS Transition Request (ST
				  Preparation) payload to mac80211 using
				  NL80211_CMD_IAP_TX
				  [NOTE] This NL command is generic and can be
				  reused for other inter-AP communication uses
				  other than SMD. Please see Section 3.3 for
				  more information on kernel-offload inter-AP
				  communication.
			(04) Mac80211:
				- Encrypts the packet using the inter-AP key.
				- Fragments the packet against the configured
				  MTU size.
				- Sends the packet to the bridge using
				  netif_receive_skb().
		- Target AP MLD:
			(05) Mac80211:
				- Receives all fragmented packets via
				  registered Rx handler from network stack.
				- Reassembles fragmented packets.
				- Decrypts the packet using inter-AP key.
			(06) Mac80211:
				- Passes the payload to hostapd using
				  NL80211_CMD_IAP_RX.
			(07) Hostapd:
				- Verifies the non-AP capabilities
				  and requested capabilities from target AP.
				- Sends the following commands to the
				  kernel stack for the WLAN driver and FW:
					- Create station
					- Associate station
					- Set keys
					- Set context
					- Set station state
			(08) Hostapd:
				- Prepares the IAP SMD BSS Transition Response
				  (ST Preparation) with the following fields:
					- Accepted links
					- Accepted QoS rules
					- Status (success/failure)
				  [NOTE] UL/DA BA Information of the target AP
				  intended to be sent as part of IAP SMD BSS
				  Transition Response (ST Preparation) is
				  still open in standards and will be updated
				  in RFC v2. PTK Mode 1 support will described
				  in RFC v2.
				- Sends the payload to mac80211 using
				  NL80211_CMD_IAP_TX
			(09) Mac80211:
				- Encrypts the packet using the inter-AP key.
				- Fragments the packet against the configured
				  MTU size.
				- Sends the packet to the bridge using
				  netif_receive_skb().
		- Serving AP MLD:
			(10) Mac80211:
				- Receives all fragmented packets via
				  registered Rx handler from network stack.
				- Reassembles fragmented packets.
				- Decrypts the packet using inter-AP key.
			(11) Mac80211:
				- Passes the payload to hostapd using
				  NL80211_CMD_IAP_RX.
			(12) Hostapd:
				- Parses the IAP SMD BSS Transition Response
				  (ST Preparation) payload.
				- Prepares the UHR Reconfiguration Request
				  (ST Preparation) frame for the non-AP MLD
				  containing the following information:
					- Status
					- Accepted links
					- Established QoS rules
					- AID
					- Basic ML IE (if at least one link
					  was accepted and status=success)
				  [NOTE] UL/DA BA Information of the target AP
				  intended to be sent as part of IAP SMD BSS
				  Transition Response (ST Preparation) is
				  still open in standards and will be updated
				  in RFC v2. PTK Mode 1 support will described
				  in RFC v2.
				- Sends the management frame to the WLAN
				  driver and FW using NL80211_MGMT_TX.
				- Starts the timer for SMD Execution Timeout
				  as per configuration.

		[NOTE] Details on the inter-AP communication design proposed
		which impacts this sequence is described in Section 3.3 of
		this RFC.

Figure 14: ST Preparation Diagram
---------------------------------
┌──────────────────┐                                  ┌───────────────────────┐
│hostapd           │                                  │                hostapd│
└──▲────┬────▲───┬─┘                                  └───────▲────┬────┬─────┘
   │    │    │   │                                            │    │    │      
   │  (03)   │  (12)                                          │  (07) (08)     
   │    │    │   │                                            │    │    │      
┌──┴────┴────┴───┴─┐                                  ┌───────┴────┴────┴─────┐
│cfg80211          │                                  │               cfg80211│
└──┬────┬────┬───┬─┘                                  └───────┬────┬────┬─────┘
   │    │    │   │                                            │    │    │      
 (02)   │  (11)  │                                          (06)   │    │      
   │    │    │   │                                            │    │    │      
┌──┴────▼────┴───┴─┬──(04)─►──────┐   ┌──────┬─(05)───►───────┴────┴────▼─────┐
│mac80211          │       │bridge◄───►bridge│        │               mac80211│
└──▲─────────────┬─◄──(10)─┴──────┘   └──────◄─(09)───┴────────────┬──────────┘
   │             │                                                 │           
 (01)            │                                                 │           
   │             │                                                 │           
┌──┴─────────────┴─┐                                  ┌────────────┴──────────┐
│wlan-drv          │                                  │               wlan-drv│
└──▲─────────────┬─┘                                  └────────────┬──────────┘
   │             │                                                 │           
 (00)            │                                                 │           
   │             │                                                 │           
┌──┴─────────────▼─┐                                  ┌────────────▼──────────┐
│wlan-hw           │                                  │                wlan-hw│
└──────────────────┘                                  └───────────────────────┘
  Serving AP MLD                                           Target AP MLD

		[3.2.8] ST Execution
		--------------------
		Once the target AP has been prepared and the client has
		successfully received a UHR Reconfiguration Response (ST
		Preparation), the non-AP MLD has to send an UHR
		Reconfiguration Request (ST Execution) within the Execution
		Timeout Value that is described in the SMD IE.
		Failure to do so will trigger a clean up sequence for the
		client in the target AP and all roaming states will be
		cleared in the serving AP MLD.

		The non-AP MLD has the choice to send the UHR
		Reconfiguration Request (ST Execution) to both the target
		AP MLD as well as the serving AP MLD, although the latter
		may be considered more organic.

			[3.2.8.1] ST Execution to Serving AP MLD
			----------------------------------------
			Figure 15 describes the sequence for a non-AP MLD
			initiating ST Execution to the serving AP MLD. For
			additional details on specification, refer to
			IEEE802.11bn-D1.0 Section 37.16.6. It begins when
			when the UHR Reconfiguration Request (ST Execution)
			frame is received by the WLAN HW and ending when
			the UHR Reconfiguration Response (ST Execution)
			frame is sent back to the client.

			The sequence is elaborated as below:
			- Serving AP MLD
				(00) WLAN HW:
					- Send the UHR Reconfiguration Request (ST
					  Execution) to the WLAN driver
				(01) WLAN Driver:
					- Receive the management frame.
					- Verify the frame and sender
					- Request for latest context from HW
					  including:
						- Tx BA information
						- Rx BA information
					- Receive the latest context from HW
					  and attach it to the management frame
					  SKB using SKB_EXTENSIONS
					- Send the SKB with context to mac80211
					  using ieee80211_rx() 
				(02) Mac80211:
					- Notify hostapd for EXECUTION_START
					  using NL80211_CMD_SMD_NOTIFY
				(03) Mac80211:
					- Parse the UHR Reconfiguration Request
					  (ST Execution)
					- Verify that desired target AP has been
					  prepared and client is eligible for
					  ST Execution
					- Prepare the IAP SMD BSS Transition
					  Request (ST Execution) payload containing
					  the following:
						- Tx BA information
						- Rx BA information
					- Encrypt the IAP SMD BSS Transition Request
					  (ST Execution) using the inter-AP key
					- Fragment the packet (if applicable)
					- Send the fragments to the target AP MLD
					  by pushing the packets to the bridge
					  using netif_receive_skb()
			- Target AP MLD:
				(04) Mac80211:
					- Receives all fragmented packets via
					  registered Rx handler from network stack.
					- Reassembles fragmented packets.
					- Decrypts the packet using inter-AP key.
				(05) Mac80211:
					- Notify hostapd for EXECUTION_START.
				(06) Mac80211:
					- Parse the IAP SMD BSS Transition Request
					  (ST Execution)
					- Verify execution eligibility for non-AP MLD
					- Send a command to the WLAN driver, HW and
					  FW to indicate the following:
						- DL SN not transferred to FW
						- UL SN not transferred to FW
						- Context to HW
				(07) Mac80211:
					- Send an L2 update frame to the bridge to
					  start forwarding DL packets to the target AP MLD.
					- Notify hostapd for EXECUTION_IN_PROG
				(08) Mac80211:
					- Prepare the IAP SMD BSS Transition Response
					  (ST Execution) containing the following:
						- Status
						- Group Keys
					- Encrypts the packet using the inter-AP key.
					- Fragments the packet against the configured
					  MTU size.
					- Sends the packet to the bridge using
					  netif_receive_skb().
			- Serving AP MLD:
				(09) Mac80211:
					- Receives all fragmented packets via
					  registered Rx handler from network stack.
					- Reassembles fragmented packets.
					- Decrypts the packet using inter-AP key.
				(10) Mac80211:
					- Parse the payload of the IAP SMD BSS
					  Transition Response (ST Execution).
				(11) Mac80211:
					- Prepare the UHR Reconfiguration Response
					  (ST Execution) containing the following:
						- Status Code
						- Nominal Max DL Drain Period as
						  configured
						- Group Keys from target AP MLD
						- UL BA information
					- Send the management frame to the WLAN
					  driver and FW for transmission to non-AP
					  MLD.
					- Notify hostapd for EXECUTION_IN_PROG and
					  start timer for Nominal Maximum DL
					  Draining Period

Figure 15: ST Execution to Serving AP MLD Diagram
-------------------------------------------------                   
┌──────────────────┐                                  ┌───────────────────────┐
│hostapd           │                                  │                hostapd│
└──▲─────────▲─────┘                                  └───────▲────▲──────────┘
   │         │                                                │    │           
   │         │                                                │  (07)          
   │         │                                                │    │           
┌──┴─────────┴─────┐                                  ┌───────┴────┴──────────┐
│cfg80211          │                                  │               cfg80211│
└──┬─────────┬─────┘                                  └───────┬────┬──────────┘
   │         │                                                │    │           
 (02)      (10)                                             (05)   │           
   │         │                                                │    │           
┌──┴─────────┴─────┬──(03)─►──────┐   ┌──────┬─(04)───►───────┴────┴──────────┐
│mac80211          │       │bridge◄───►bridge│        │               mac80211│
└──▲─────────────┬─◄──(09)─┴──────┘   └──────◄─(08)───┴────────────┬──────────┘
   │             │                                                 │           
 (01)          (11)                                              (06)          
   │             │                                                 │           
┌──┴─────────────┴─┐                                  ┌────────────┴──────────┐
│wlan-drv          │                                  │               wlan-drv│
└──▲─────────────┬─┘                                  └────────────┬──────────┘
   │             │                                                 │           
 (00)            │                                                 │           
   │             │                                                 │           
┌──┴─────────────▼─┐                                  ┌────────────▼──────────┐
│wlan-hw           │                                  │                wlan-hw│
└──────────────────┘                                  └───────────────────────┘
  Serving AP MLD                                           Target AP MLD

			[3.2.8.2] ST Execution to Target AP MLD
			---------------------------------------
			Figure 16 describes the ST Execution sequence to the target
			AP MLD.

			The sequence can be described as follow:
			- Target AP MLD:
				(00) WLAN HW:
					- Sends the frame to the WLAN driver
                                (01) WLAN Driver:
					- Sends the frame to the mac80211
				(02) mac80211:
					- Notify hostapd for EXECUTION_START
				(03) mac80211:
					- Prepares the IAP SMD BSS Transition Request
					  payload
					- Encrypt the payload
					- Fragment the payload up to the MTU size
					- Attach IAP SMD header
					- Send IAP message with netif_receive_skb()
			- Serving AP MLD:
				(04) mac80211:
					- Receives the IAP messages using registered
					  handler
					- Reassemble the IAP SMD message
					- Decrypt the payload
				(05) mac80211:
					- Notify hostapd for EXECUTION_START
				(06) mac80211:
					- Send context collection request to WLAN
					  driver and WLAN HW/HW
				(07) WLAN HW/FW:
					- Send context to mac80211 via WLAN driver
				(08) mac80211:
					- Notify hostapd for EXECUTION_COMPLETE
				(09) mac80211:
					- Prepare IAP SMD BSS Transition Response (ST
					  Execution) containing:
						- DL BA context
						- UL BA context
					- Encrypt the payload
					- Fragment the packets upto configured MTU
					- Send the packets to the bridge using
					  netif_receive_skb()
			- Target AP MLD:
				(10) mac80211:
					- Receive the IAP SMD BSS Transition Response
					  (ST Execution) containing latest context.
					- Reassemble the packets
					- Decrypt the payload
					- Parse the payload and verify content
				(11) mac80211:
					- Notify hostapd for EXECUTION_COMPLETE
				(12) mac80211:
					- Send latest context to WLAN driver
					  and HW containing:
						- Tx BA context
						- Rx BA context
					- Perform DS mapping update by sending
					  an L2 update frame to the bridge
					- Prepare the UHR Reconfiguration Response
					  (ST Execution) containing the following:
						- Status Code
						- Group Keys from target AP MLD
						- UL BA information
					  [NOTE] As per IEEE802.11bn-D1.0 Section
					  37.16.7, there is no DL draining if
					  ST Execution is sent to target AP MLD,
					  hence there is no DL Drain period indicated.
					- Send the management frame to the WLAN
					  driver and FW for transmission to non-AP
					  MLD.

Figure 16: ST Execution to Target AP MLD Diagram
------------------------------------------------  
┌───────────────────┐                                 ┌──────────────────┐
│            hostapd│                                 │hostapd           │
└───▲────────▲──────┘                                 └──▲─────────▲─────┘
    │        │                                           │         │    
    │       (08)                                         │         │    
    │        │                                           │         │    
┌───┴────────┴──────┐                                 ┌──┴─────────┴─────┐
│           cfg80211│                                 │cfg80211          │
└───┬────────┬──────┘                                 └──┬─────────┬─────┘
    │        │                                           │         │    
  (05)       │                                         (02)      (11)     
    │        │                                           │         │      
┌───┴────────┴──────┬──(09)─►──────┐   ┌──────┬─(10)──┌──┴─────────┴─────┐
│           mac80211│       │bridge◄───►bridge│       │mac80211          │
└────────┬───▲──────◄──(04)─┴──────┘   └──────◄─(03)──└──▲─────────────┬─┘
         │   │                                           │             │  
       (06)  │                                         (01)          (12) 
         │   │                                           │             │  
┌────────┴───┼──────┐                                 ┌──┴─────────────┴─┐
│           wlan-drv│                                 │wlan-drv          │
└────────┬───┬──────┘                                 └──▲─────────────┬─┘
         │   │                                           │             │  
         │  (07)                                       (00)            │  
         │   │                                           │             │  
┌────────▼───┴──────┐                                 ┌──┴─────────────▼─┐
│            wlan-hw│                                 │wlan-hw           │
└───────────────────┘                                 └──────────────────┘
    Serving AP MLD                                       Target  AP MLD

		[3.2.9] ST Transitory Indication
		--------------------------------
		If ST Execution was carried out with the serving AP MLD
		and a non-zero Nominal Maximum DL Drain Period Duration
		was advertised by the serving AP MLD, the serving AP MLD
		will continue to send DL packets to the non-AP MLD until
		one of the three conditions are met:
		(1) Nominal Max DL Drain Period has expired
		(2) AP-side forced termination
		(3) Non-AP MLD has notified to terminate DL draining

			[3.2.9.1] Nominal Max DL Drain Period Expiry
			--------------------------------------------
			If the Nominal Max DL Drain Period has expired,
			as in Figure 17, then timer expiry in hostapd
			will cleanup the peer along with sending
			an IAP SMD BSS Transition Complete notification
			to the target AP MLD to move its own state machine
			to EXECUTION_COMPLETE.
			If the non-AP MLD had requested the serving
			AP MLD to indicate DL drain completion, then the
			current AP can send a UHR Reconfiguration Notify
			frame with a per-TID flag set.
			See IEEE 802.11bn-D1.0 Section 37.16.6.

Figure 17: Nominal Max DL Drain Period Expiry Diagram:
------------------------------------------------------
                                                                            
             ┌───────────────────┐                                          
             │            hostapd│                                          
             └─┬─────┬───────────┘                                          
(01) STA Cleanup     │(03) UHR Reconfig Notify                              
               │     │     (if requested by non-AP MLD)                     
               │     │                                                      
             ┌─┴─────┴───────────┐                                          
             │           cfg80211│                                          
             └─┬─────┬───────────┘                                          
               │     │                                                      
               │     │                                                      
               │     │                                                      
             ┌─┴─────┴───────────┐                                          
             │           mac80211├────────►                                 
             └─┬─────┬───────────┘      (02) IAP SMD BSS Transition Complete
               │     │                                                      
               │     │                                                      
               │     │                                                      
             ┌─┴─────┴───────────┐                                          
             │           wlan-drv│                                          
             └─┬─────┬───────────┘                                          
               │     │                                                      
               │     │                                                      
               │     │                                                      
             ┌─▼─────▼───────────┐                                          
             │            wlan-hw│                                          
             └───────────────────┘                                          
                 Serving AP MLD                                             

			[3.2.9.1] AP-Side Forced Termination
			------------------------------------
			If the pending DL packets are emptied or if
			the DL buffer control has exceeded, as in Figure 18,
			then the FW will notify the WLAN driver about
			this event via a control path signal.
			This will trigger an event to hostapd to move
			the serving AP MLD to EXECUTION_COMPLETE and
			carry out the peer cleanup activities.
			Mac80211 will send an IAP SMD BSS Transition
			Complete notification to the target AP MLD to
			move its respective state machine to
			EXECUTION_COMPLETE.
			See IEEE 802.11bn-D1.0 Section 37.16.6.

Figure 18: AP-Side Forced Termination
-------------------------------------
         ┌───────────────────┐                                        
         │            hostapd│                                        
         └─▲────┬────────────┘                                        
           │    │(03) STA  Cleanup                                    
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           cfg80211│                                        
         └─┬────┬────────────┘                                        
           │    │                                                     
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           mac80211├────────►                               
         └─┬────┬────────────┘    (02) IAP SMD BSS Transition Complete
           │    │                                                     
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           wlan-drv│                                        
         └─┬────┬────────────┘                                        
(01) Terminate  │
     DL Drain   │                                                     
           │    │                                                     
         ┌─┴────▼────────────┐                                        
         │            wlan-hw│                                        
         └───────────────────┘                                        
             Serving AP MLD                                           

			[3.2.9.3] Non-AP-MLD-Side Forced Termination
			--------------------------------------------
			As per IEEE 802.11bn-D1.0 Section 37.16.9, the non-AP
			MLD can send a UHR Reconfiguration Notify frame with
			the DL Draining Completed field set to 0 to indicate
			the termination of the DL draining period at any point
			before the expiry of the Nominal Max DL Drain Period.
			On receiving this notification from the non-AP MLD,
			the FW will cease transmissions and notify the non-AP
			MLD via the WLAN driver with the UHR Reconfiguration
			Notify management frame. This can be sent to the
			serving AP MLD (as shown in Figure 19) or to the
			target AP MLD.
			In case of receiving the termination on the serving
			AP MLD, the frame is passed to Mac80211 which will send
			a IAP SMD BSS Transition Complete notification to the
			target AP MLD to move its state to EXECUTION_COMPLETE.
			If case of receiving the termination on the target
			AP MLD, the IAP SMD BSS Transition Complete is
			sent to the serving AP MLD  to move its state to
			EXECUTION_COMPLETE.
			
			See IEEE 802.11bn-D1.0 Section 37.16.6.

Figure 19: Non-AP-MLD-Side Forced Termination to Serving AP MLD
---------------------------------------------------------------
         ┌───────────────────┐                                        
         │            hostapd│                                        
         └─▲────┬────────────┘                                        
           │    │(03) STA  Cleanup                                    
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           cfg80211│                                        
         └─┬────┬────────────┘                                        
           │    │                                                     
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           mac80211├────────►                               
         └─┬────┬────────────┘    (02) IAP SMD BSS Transition Complete
           │    │                                                     
           │    │                                                     
           │    │                                                     
         ┌─┴────┴────────────┐                                        
         │           wlan-drv│                                        
         └─┬────┬────────────┘                                        
(01) UHR   │    │                                                     
     Reconfig   │                                                     
     Notify│    │                                                     
         ┌─┴────▼────────────┐                                        
         │            wlan-hw│                                        
         └───────────────────┘                                        
             Serving AP MLD        

		[NOTE] If SN transfer was not requested by the client for DL,
		then the target AP MLD cannot transmit packets until it
		receives the IAP SMD BSS Transition Complete indication from
		the serving AP MLD. If SN transfer was requested, then the
		target AP MLD cannot transmit packets beyond the current DL
		buffer control until the IAP SMD BSS Transition Complete
		indication is received from the serving AP MLD.
		Refer to IEEE 802.11bn-D1.0 Section 37.16.6
		for more details.

	[3.3] Inter-AP Communication
	----------------------------
	Since the IEEE 802.11bn-D1.0 does not define an inter-AP communication
	framework. This section proposes an upstream design inter-AP
	communication based on the L2 protocol that is used with FT roaming in
	hostapd today.

		[3.3.1] Protocol
		----------------
		Currently, IEEE802.11r FT uses two types of transport channels:
		(1) ETH_P_OUI 802.3: frames for R1KH push/pull sequences for
		    generating the PMK,
		(2) ETH_P_RRB 802.3: frames for FT authentication and association
		    backhaul exchanges between the serving and target AP.

		The former holds an encrypted payload while the latter is an
		plain-text payload which assumes trusted endpoints.

		This proposal introduces an inter-AP framework that is based on the
		Extended OUI (88-B7) EtherType with encrypted payloads for context
		transfer and other inter-AP communication messages relating to SMD
		as shown in Figure 20.

Figure 20: L2 Vendor EtherType Protocol for SMD Inter-AP Communication
----------------------------------------------------------------------
    ┌─────┬─────┬───────────────┬─────────┬───────┬───────┬───────┬───────┬───────┬────────────────┐
    │Src  │Dst  │Extended OUI   │OUI      │OUI    │OUI    │Frag   │Frag   │Frag   │Encrypted       │
    │Addr │Addr │EtherType      │         │Subtype│Suffix │ID     │Num    │Flags  │Payload         │
    │     │     │     88B7      │00:13:74 │ 0x002 │       │       │       │       │                │
    └─────┴─────┴───────────────┴─────────┴───────┴───────┴───────┴───────┴───────┴────────────────┘
Byte  0     5    11              13        16      17      18      20      21      25               XX

		The Src Addr, Dst Addr, EtherType, Subtype and Suffix fields are
		carried forward from the existing 88:B7 definition used in FT roaming
		in hostapd.

		Currently, there exists only a single subtype 0x01 which is used for
		FT roaming. We propose to use a new subtype 0x02 which will be
		dedicated to SMD messaging. The OUI suffix will indicate the different
		frame types for IAP SMD messaging.
		[NOTE] This will be elaborated on in subsequent patch submissions.

		The encrypted payload is designed as a series of TLVs that will be
		specific to the OUI Suffix. Detailed frame structures will be defined
		in RFC v2.

			[3.3.1.1] Fragmentation
			-----------------------
			Assuming that we support MTU size of at least 1500 bytes,
			there is a probability that the IAP SMD message payload
			may exceed the MTU size. For this reason, we propose to
			add a fragmentation scheme that is
			typically used for IP fragmentation or IEEE1905.1
			fragmentation. The encrypted payload is fragmented and
			the resulting data for each packet shall be prepended with
			a fragment ID generated by the sender, fragment number of
			each fragment and fragment flags.
			Currently, the following flags are expected to be used:
			(1) More Fragments
			(2) Is Fragmented

			[3.3.1.2] Encryption
			--------------------
			The encryption of the payload will follow the existing
			AES-SIV method that is used to encrypt the R1-KH push/pull
			sequences that is implemented in hostapd for IEEE802.11r
			FT roaming. Mac80211 already has an implementation of
			SW-based AES-SIV that is used for FILS encryption.

        [2.3.2] Endpoints
        -----------------
	To enable faster and more scalable SMD roaming, we propose placing the
	endpoint for Inter-AP (IAP) SMD messaging in kernel space, rather than
	relying on hostapd-managed messaging as used in FT roaming.
	
	The motivation for this design is to reduce latency during ST Execution,
	especially under max client concurrency and high system load and avoiding a
	direct impact on the data path transition.

	DL/UL traffic transition latency to the target AP MLD depends on the IAP
	messages and the ST Execution Response arriving on time. Therefore, these
	actions should not have to wait for pending management frames to be handled.

        To address this, we divide the inter-AP communication framework into three
	functional components:
        1. Preparing/Parsing the unfragmented and unencrypted IAP SMD frame
        2. Encrypting/Decrypting the unfragmented IAP SMD frame.
        3. Fragmenting/Reassembling the IAP SMD frame with the encrypted payload and
        sending/receiving the packet to the neighboring AP MLDs in the SMD.

	The encryption scheme, inherited from FT roaming, uses packet numbering that
	requires a unified endpoint for both transmission and reception of inter-AP
	frames. Therefore, when kernel-offload ST Execution is enabled, all inter-AP
	communication is routed through mac80211.
	
	For all non-critical inter-AP communication (e.g., IAP SMD Neighbor Update
	and IAP ST Preparation), hostapd will generate the payload and send it to
	mac80211 over nl80211 with a new netlink command, NL80211_CMD_IAP_TX.
	Mac80211 will take over the responsibility for both encryption and
	fragmentation before sending out packets to the bridge. See Section
	3.2.7 for sequences for ST Preparation utilizing this path.

	For critical inter-AP communication (e.g., IAP ST Execution and IAP ST
	Execution Complete), mac80211 will generate the payload autonomously and
	notify hostapd on changes to the ST Execution state machine in hostapd. This
	latency-critical signaling does not contain any non-AP MLD or AP MLD
	information which is residing in hostapd and hence can be offloaded to the
	mac80211. See Section 3.2.8 for ST Execution sequence utilizing this path.

        To avoid passing interface information from hostapd to mac80211, we propose
	to use netif_receive_skb() to send inter-AP messages to the bridge and
	towards the intended SMD neighbor and dev_add_pack() to register an Rx
	handler directly to mac80211.
	[NOTE] This RFC assumes the presence of a bridge similar to the FT
	implementation.

We would appreciate your prompt feedback to initiate the patch submission process for
the upstream code changes. Pending design proposals for the topics mentioned in
Section 1 will be introduced in RFC v2.

[NOTE] The following are key contributors to this RFC:
Aditya Sathish, Rohan Dutta, Krishna Rao, Santosh Anbu, Pooventhiran G,
Jhalak Naik, Kris Muthusamy

Regards,
Adtitya

