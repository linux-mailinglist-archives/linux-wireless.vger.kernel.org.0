Return-Path: <linux-wireless+bounces-24446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DEAE7123
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47816163E94
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264212E7F15;
	Tue, 24 Jun 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KMJGfJBE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82B3074B5;
	Tue, 24 Jun 2025 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798675; cv=none; b=SM7RHEM6i+EkU1A0aGc3QQmfxhWB6203WCWUKPhk+YVrgv4R6p8V2mU+V0wRL8A6UpNkBK/7xx37ZOwyWM+bSPClDUY1euEky6kcJGwNlv5zhlJA2fGPvOvmV2QCVBJ4XL2v/Mixc6liKfYhRANtMlLCFS9HAqL8n3Ey8S7uVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798675; c=relaxed/simple;
	bh=plWal2UCmFCsGFsZYFeDyIvz3aunxQTdJLCNlC6A03I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lP7lfp/p9Jrm6+pKJyZiqS6PFxmJVRs0YEZCpAEWE1StE17zChtLBoUs2e/j4Hic+no8aVFDA6tBXkFKD1i9i7+6iV9zYzBumn3n5PrxqCOpK1PjUE9m0kgU8bfmPpDRdGwyGchj5JLSQy0CpdgVg9OG9iojLiARjXcNDGKEhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KMJGfJBE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGA8mo028706;
	Tue, 24 Jun 2025 20:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9xRteoTjzUcVi04t/BSk3t
	zWA8ELu4+eFjSMTL0TuzI=; b=KMJGfJBEscXxYRp84To5S1EAxZ6NKtE1BCnzxx
	hIpzvEbdeZ+azRpF5ALvG/eIv6HRlFL5SVcaau8ZAw8zFKiVIUXqCTD372GVKMWv
	71KUBPIe9HGCTcOWAeSJ3CMmjHe2Hkl8pzaHUf0E1JQoBj6X9NZVOHGNxmB8nk2Q
	Z7NX9gSrNDf/7G4ZmY4+XfiYF4+eo8atvoEBb4+UAP6yX1NoJ3Zn97dkhfib2y6Q
	n61isGoQ8JcJmCspo9VhU2ivYupi/bpU/nAoby1KKT+6JZouSrw5813zPayVHuGQ
	oWBafbf8MC/+FIf9TDdU9mbyMUzWfd9zMTbc0HWWGA8Y6gcg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4pv5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 20:57:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55OKvkvU024973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 20:57:46 GMT
Received: from hu-rchoodam-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Jun 2025 13:57:46 -0700
From: Ramanathan Choodamani <quic_rchoodam@quicinc.com>
To: <linux-wireless@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <quic_rchoodam@quicinc.com>
Subject: [DESIGN RFC] wifi: Robust AV streaming Design Proposal for AP
Date: Tue, 24 Jun 2025 13:57:16 -0700
Message-ID: <20250624205716.1052329-1-quic_rchoodam@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685b114b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=6IFa9wvqVegA:10 a=4kHizUjBS_yDJ6wPv5oA:9
 a=ziixI6HZIonXVpGN:21 a=3ZKOabzyN94A:10
X-Proofpoint-GUID: c8sy9uJaatHYBzbhWzIdhez6rEI5XpHo
X-Proofpoint-ORIG-GUID: c8sy9uJaatHYBzbhWzIdhez6rEI5XpHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2NyBTYWx0ZWRfX8dTL7MC0CgIA
 QqRagRMGkPjPN9hcN0xJ5XmbYrsI4dsiR3L7vWR7pdDWDQSGT1ziPMJV0MqW7w1fzXwKiXD8Ucn
 YrMryjQrdV6X4+pZoMmsCNwIK8wL4k/FciD+lI//fnShuIoitTHeuczJQEYa/l4W459yFyVyZxZ
 z8kXVBbU94tMbeq0b4U6NOgjgjv7oLh1WbrN7Zcmqfd9Gaf07d7Fq+gp8uq77iox9B+eTBH6ctD
 3fG2qoj9MMAwYLcwN+Q6a84Jh0bEIX7Y2yC6kQHLE3dBb/5cs93p/FaRE2AxIFjma8/7vcS8cAg
 +TJFPYILSEBYSgHGF+MHhAAvrakkiJcjAoOXL1WDFN2beCXCh74eiLaqgGOaFVgNMeEo+V1JUVL
 d57aZNJpt1q6OTS97LCgx1ZLCIIBYD+tqtNNwX2zs0MlC6wmZSOeoXeBAAVlMnSTELRxkeXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240167

===================================
Robust AV streaming protocols - QoS
===================================

The Robust AV stream protocols are mobile centric protocols - meaning they
are initiated by a non-AP STA to the AP. These protocols are implemented
at the Access Point (AP) to classify packets sent to the non-AP STA which requests
classification using action frames. The non-AP STA initiates Robust AV streaming
action frames requesting for specific classification for the IP packets
destined to the non-AP STA from the AP. These parameters can be negotiated by both
AP and non-AP STA.

Upon successful handshake, The AP classifies incoming individually addressed MSDUs
(Mac Service Data Unit) based upon parameters provided by the non-AP STA or
notifies the non-AP STA to transmit MSDUs with preferred parameters based upon
what was exchanged.

Robust AV streaming improves AV (Audio and Video) streaming performance when
using IEEE Std 802.11 for consumer and enterprise applications.

Let's look at the Robust AV streaming protocols which are implemented as a
part of this design.

1. Robust AV streaming protocols - A bird's eye view
=====================================================

	1.1. Stream Classification Service or SCS
	------------------------------------------

		In SCS - the non-AP STA specifies what level of classification it
		expects from the AP beforehand, by specifying these things explicitly
		in the Robust AV action frame:

		1. Traffic tuple parameters - The description of traffic that has to be
		classified by the AP
		2. QoS characteristics -  How the classification has to be done
		3. UP value to set

		SCS can be also used for Uplink traffic classification.
		The AP fetches the UL data from non-AP STA by transmitting the
		trigger frames containing RU allocation for non-AP STA with
		Preferred AC field equivalent to the UP value specified during handshake.

		Once accepted, the AP uses 2. and 3. to classify the traffic
		matching the exact parameters as 1.

	1.2. Mirrored Stream Classification Service or M-SCS
	-----------------------------------------------------

		In the mirrored SCS as well, the non-AP STA does not specify
		the actual traffic to be classified as a part of the action
		frame.

		Instead, the AP is expected to monitor the uplink flow sent
		by the non-AP STA and use the same UP of the uplink flow, for the DL
		traffic if the DL flow is the "mirrored version" of the previously
		received UL flow.


For more details on the protocol aspects, refer to Section 3. first
which talks about the protocol in detail.
For design, refer directly to the next Section 2.


2. Design Proposal
===================

	2.1. Overview
	-------------
                 ┌─────────────────────────────────┐                                   
     MLME        │                                 │ N/W provisioning                  
 QoS Provisioning│           hostapd    ┌─────────┐┼────────────────┐                  
 QoS accounting  │                      │libnftnl ││                │                  
                 └────┬─────────────────└──▲──────┘┘                │                  
 user space           │                    │                        │                  
                      │                    │                        │                  
        ──────────────┼────────────────────┼────────────────        │                  
                ┌─────┼────────────────────┼─────────┐              │                  
 kernel space   │ ┌───▼────────────────────┴──────┐  │              │                  
                │ │        nl80211/cfg80211       │  │              │                  
                │ │                               │  │   ┌──────────▼────────┐         
                │ └───┬────────────────────▲──────┘  │   │                   │         
                │     │                    │         │   │                   │         
                │ ┌───▼────────────────────┼──────┐  │   │     netfilter     │         
                │ │           mac80211            │  │   │                   │         
                │ │                               │  │   │                   │         
                │ └───┬────────────────────▲──────┘  │   │                   │         
                │     │                    │         │   └───────────────────┘         
                │ ┌───▼────────────────────┼──────┐  │                                 
                │ │                               │  │                                 
                │ │                               │  │                                 
Resource alloc  │ │           WLAN drv            │  │ Flow monitoring for new Rx flows
HW programming  │ │                               │  │ Sending flow info to hostapd    
                │ │                               │  │                                 
                │ │                               │  │                                 
                │ │                               │  │                                 
                │ └───┬────────────────────▲──────┘  │                                 
                │     │                    │         │                                 
                └─────┼────────────────────┼─────────┘                                 
                ┌─────▼────────────────────┼─────────┐                                 
                │                                    │                                 
                │             Hardware               │                                 
                │                                    │                                 
                └────────────────────────────────────┘                                 


	2.2. Control Path (MSCS/SCS)
	----------------------------

		The control path for the QoS management could be handled in the user space
		- hostapd.
		The kernel layers - cfg80211 and mac80211 could pass the required information
		to the WLAN driver to program the underlying Firmware/Hardware
		to achieve the expected prioritization.

		(A) Hostapd
		------------
			2.2.1 - Capabilities advertisement
			----------------------------------

				The MSCS/SCS Capabilities Advertisement in beacon, probe
				response and assoc response frames will be done at hostapd.

			2.1.2 - Protocol Parsing
			------------------------

				The support to receive, parse, process MSCS and SCS request
				action frames from non-AP STA will be done at hostapd.
				The NL cmd NL80211_CMD_QOS_MGMT is used to send the parsed
				SCS/MSCS descriptor data (Dialog token, QM type, Mac addr,
				QM ID, QM Request type, TCLAS element, QoS Parameters,
				TCLAS mask) to the kernel from hostapd.

				Driver will advertise its capability to hostapd whether it
				requires TCLAS rule provisioning in NFT to be carried out by
				hostapd or it can take care of handling/provisioning the
				networking rules.

				The support to send MSCS, SCS response to non-AP STA will also be
				done at hostapd.

				IEEE Std 802.11-2024 Section 9.6.18 defines how the
				Robust AV streaming action frames look like.

				IEEE Std 802.11-2024 Section 9.4.2.120 specifies
				the details of an SCS descriptor

				IEEE Std 802.11-2024 Section 9.4.2.242 specifies the
				details of an MSCS descriptor.

			2.1.3 - QoS Provisioning
			-------------------------

				Hostapd extracts the QoS parameters from SCS/MSCS request, and
				sends the parameters via NL80211 command (NL80211_CMD_QOS_MGMT).

			2.1.4 - Networking Provisioning
			-------------------------------
				Hostapd if required and as indicated by the WLAN driver
				capabilities, would add rules in the netfilter subsystem
				via libnftables, such that flows matching the TCLAS
				parameters are marked with certain meta data using skb->mark
				to assist in prioritization in the MSDU processing in the WLAN
				driver data path.

				In MSCS, hostapd will receive the Rx flow tuple from WLAN
				driver using NL80211 command (NL80211_CMD_QOS_MGMT) and then
				make a decision to install an nftable rule in the netfilter
				subsystem based on MSCS parameters exchanged
				during handshake.

				The WLAN driver will be responsible for classifying the
				new flow received and parse the tuple information from the MSDU
				and use the framework to send event to hostapd. For
				identifying a new flow, the WLAN driver can make use of
				any HW offload assist features it supports, as maintaining
				flow information in software on a per-packet basis will be
				expensive for flow classification.

			2.1.5 - Flow cleanup and Rule teardown
			--------------------------------------

				During scenarios, where non-AP STA sends a Request to delete/teardown
				a session, the hostapd will be responsible for notifying
				netfilter and the driver to remove the rules and associated
				context.

				The support to send unsolicited response to non-AP STA for rule
				deletion or session teardown will also be present in hostapd,
				after which hostapd will clean-up it's context and also notify
				to WLAN driver and netfilter.

			2.1.6. QoS Accounting
			----------------------

				Hostapd will maintain information per non-AP STA for the different
				active QoS request.

			2.1.7. User space cli commands (Proposed commands)
			--------------------------------------------------

				2.1.7.1. Config option to set MSCS/SCS during bring-up
				------------------------------------------------------

					MSCS and SCS features will be enabled during AP bring up.
					The options "mscs" and "scs" will be added to the hostapd
					config file.
					mscs=<0/1>
					scs=<0/1>;
					where 0 - disable, 1 - enable.

					Since these options are enabled only during bring up, they
					will continue to remain enabled during the lifetime of the
					BSS.

					Once these features are enabled during bring up,
					AP starts advertising MSCS and SCS capabilities in it's beacon,
					probe response and assoc response frames.
					The non-AP STA seeing these frames, realizes AP supports these
					protocols and then sends the action frames.
					If the AP does not support these protocols, then the AP
					shall discard these action frames/descriptor elements sent by
					non-AP STA.

				2.1.7.2. User cli commands to send unsolicitied MSCS/SCS response
				-----------------------------------------------------------------

					The commands to set unsolicited response from hostapd will be
					as follows:

					To send unsolicited MSCS response:

						hostapd_cli -i <interface> send_unsolicited_mscs_resp
						<peer_macaddr> <status_code>

					To send unsolicited SCS response:

						hostapd_cli -i <interface> send_unsolicited_scs_resp
						<peer_macaddr> --scsid <scsid> <status_code>

					The unsolicited Robust AV responses
					(SCS and MSCS responses) are sent by AP to a non-AP STA to
					either teardown an MSCS session or terminate a SCS based
					rule for reasons like TCLAS_PROCESSING_TERMINATED when the
					AP is no longer able to classify the traffic with the
					specified QoS parameters.

					The AP should send Action frames with SCS/MSCS response
					to non-AP STA with the status code specified in the user
					command cli.

		(B) cfg80211
		-------------

			The cfg80211 layer receives the  NL(NL80211_CMD_QOS_MGMT), parses
			the parameters and passes further down into the mac80211 layer.

		(C) mac80211
		-------------

			The mac80211 calls into the WLAN driver with the QoS and
			networking parameters.

		(D) WLAN driver
		-----------------

			The WLAN driver receives the QoS characteristics and the
			TCLAS elements and can do the required resource allocation and
			the Firmware(FW)/Hardware(HW) programming based on the underlying HW
			capabilities.

	2.3 - Data Path (MSCS/SCS) - done at WLAN driver
	--------------------------------------------------
                                           3. Hostapd provisions the rule to NFT
                     ┌─────────────────────────────────┐
                     │                                 │ N/W provisioning
                     │           hostapd    ┌─────────┐┼────────────────────────┐
                     │                      │libnftnl ││                        │
                     └──────────────────────└──▲──────┘┘                        │
     user space                                │                                │
            ───────────────────────────────────┼────────────────                │
                    ┌──────────────────────────┼─────────┐                      │
                    │                          │         │ 4.                   │
     kernel space   │ ┌────────────────────────┴──────┐  │ NFT updates skb->mark│
                    │ │        nl80211/cfg80211       │  │ while adding the rule│
                    │ │                               │  │   ┌──────────────────┼──┐
                    │ └────────────────────────▲──────┘  │   │                  │  │
                    │                          │         │   │                  │  │
                    │ ┌────────────────────────┼──────┐  │   │  Linux N/W stack │  │
                    │ │           mac80211            ◄──┼───┼                  │  │
                    │ │                               │  │   │       ┌──────────▼─┐│
                    │ └───┬────────────────────▲──────┘  │   │       │netfilter   ││
5. The DL packet    │     │                    │         │   └───────└────────────┘┘
 comes with         │ ┌───▼────────────────────┼──────┐  │
 skb->mark          │ │                               │  │
 which is used      │ │                               │  │
 for classification │ │           WLAN drv            │  │2.
 along with         │ │                               │  │Driver then programs the rule to hostapd
 stored QoS         │ │                               │  │using NL80211
 params at the      │ │                               │  │
 driver             │ │                               │  │1.
                    │ └───┬────────────────────▲──────┘  │For MSCS flows, driver learns a new rx flow
                    │     │                    │         │using HW assist
                    └─────┼────────────────────┼─────────┘
                    ┌─────▼────────────────────┼─────────┐
                    │                                    │
                    │            Hardware                │
                    │                                    │
                    └────────────────────────────────────┘

		* The Datapath decision making logic for the QoS features
		would be handled in the WLAN driver.

		* In MSCS, Driver will be responsible to track all the uplink flows
		for a non-AP STA with MSCS session, based on
		TCLAS mask and should prioritize the corresponding downlink flows.

		* For prioritization in DL for MSCS, the driver should notify hostapd
		using NL80211 framework (via mac80211, cfg80211) to program the
		netfilter rules, when a new Rx uplink flow is received.

		* As mentioned in Section 2.1.4., In MSCS  hostapd receives the
		Rx flow tuple from the driver via NL80211_CMD_QOS_MGMT,
		then decides whether to install an nftables rule in netfilter
		based on MSCS handshake parameters.

		* Based on the QoS parameters maintained at the driver, and the
		skb->mark as received in the flows and the QoS parameter requirements
		should be met as specified in the request.

		* Maintain telemetry for active SCS/MSCS requests per non-AP STA for
		debug purposes.

		Considering a lot of Hardware(HW) and Firmware(FW) assists would be required
		for the following, it would be appropriate to implement the
		Datapath in the specific WLAN drivers.

		The WLAN driver responsibilities are as follows:
		1. Learning all Rx flows in the uplink for MSCS clients
		2. Prioritizing downlink flow with stringent latency KPI for AR/VR and
		gaming use cases
		3. In cases where vendor HW have offloads for such use cases,
		where the HW can prioritize by just programming the TCLAS elements
		and mapping the relevant QoS characteristics


3. Additional details - Protocol overview
=========================================

	3.1. What exists today in mac80211? - DSCP-UP mapping and QoS Map set
	---------------------------------------------------------------------

		An Access Point supporting QoS Management keeps a default DSCP-UP mapping
		table (RFC 8325) to map a DSCP (IP packet header field) to a specific User
		Priority value in the QoS-Control field of the IEEE-802.11 header.
		When DSCP-UP mapping is enabled, The Access point uses this table and
		assigns UP of the IP packets sent it to its associated non-AP STAs
		based on the DSCP marking.

		The AP even has a provision to configure a specific DSCP-UP mapping using
		QoS Map set (instead of using the default table). When this QoS Map is
		configured, the AP sends a QoS Map Configure frame containing this
		QoS Map element to it's associated non-AP STAs that indicate support for
		QoS Map. The AP then shall use this table instead of the default one
		for mapping UPs of the IP packets.

		The implementation to use DSCP-UP mapping table exists in mac80211
		datapath today.


	3.2. Robust AV streaming Features: A closer view
	---------------------------------------------------

		Reference: IEEE Std 802.11-2024
		Section 11.25

		3.2.1. SCS - Protocol details
		------------------------------

			Refer to IEEE Std 802.11-2024 Section 11.25.2 SCS Procedures
			(Stream Classification Service) for more details.

			A non-AP STA can request SCS by sending an SCS Request frame with a
			Descriptor element marked as “Add” or “Change”.

			The non-AP STA specifies the below elements in the SCS descriptor
			in the SCS request action frame.

			Downlink (DL) SCS:
			   - Either the UP (User Priority) (or TID) alone or additionally a
				set of QoS characteristics(eg: Service Interval, Delay bound,
				Throughput) with TID.

			   - TCLAS (Traffic Classifier) element (eg: Type 4 - Source IP,
			Destination IP, Protocol, Source Port, Destination Port).
			These parameters define how MSDUs are classified and prioritized.
			The AP prioritizes the flow (as identified by TCLAS elements)
			in the Downlink Tx Direction.

			Uplink (UL) SCS:
			   - Set of QoS characteristics for uplink prioritization.

			   - No Intra access category and no TCLAS element is present in
				the request frame.

			The QoS parameters are programmed in AP to fetch the UL data from
			non-AP STA by transmitting the trigger frames.

			The AP can choose to accept or decline the request sent by the
			non-AP STA.
			Once accepted, for DL, the AP will classify the downlink packets
			matching that TCLAS element traffic parameters and set the
			TID value for the DL traffic flow to prioritize.

			For UL, AP will start sending trigger frames to station based on the
			QoS parameter values.

			3.2.1.1. Protocol handshake diagram
			-------------------------------------

┌─────────────────┐                                                                              ┌─────────────────┐ 
│                 │                                                                              │                 │ 
│      AP         │                                                                              │       STA       │ 
│                 │                                                                              │                 │ 
│                 │                                                                              │                 │ 
└──────┬──────────┘                                                                              └────────┬────────┘ 
       │      ┌───────────┌──────────┌──────────┌──────────────────────────────────┌───────────────┐      │          
       │      │Robust AV  │          │ Intra-   │         TCLAS element            │               │      │          
       │      │           │ SCSID = 1│ Acces    │type = 4, mask = 01011111         │     QoS       │      │          
       │      │ SCS.req   │          │ category │params = {v=4,sip=192.168.1.100,  │               │      │          
       │      │           │          │          │          dip=192.168.1.107,      │characteristics│      │          
       │      │           │          │ UP = 6   │          sp=5400, dp=10400,      │  (Optional)   │      │          
       │      │           │          │(Optional)│          proto=tcp}  (optional)  │               │      │          
       │      └───────────└──────────└──────────└──────────────────────────────────└───────────────┘      │          
       │◄─────────────────────────────────────────────────────────────────────────────────────────────────┼          
       │                                      SCS Request                                                 │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          
       │       ┌───────────┌──────────────┐                                                               │          
       │       │           │              │                                                               │          
       │       │ Robust AV │  SCSID = 1   │                                                               │          
       │       │           │              │                                                               │          
       │       │ SCS.resp  │ Status = OK  │                                                               │          
       │       │           │              │                                                               │          
       │       │           │              │                                                               │          
       │       └───────────└──────────────┘                                                               │          
       │                                                                                                  │          
       ┼──────────────────────────────────────────────────────────────────────────────────────────────────►          
       │                                      SCS Response                                                │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          
       │                                                                                                  │          


			3.2.1.2. DL traffic classification using SCS handshake params
			-------------------------------------------------------------

┌────────────────────┐                                                     ┌────────────────────┐
│                    │                                                     │                    │
│        AP          │                                                     │        STA         │
│                    │                                                     │                    │
│                    │                                                     │                    │
└─────────┬──────────┘                                                     └──────────┬─────────┘
          │                        DOWNLINK CLASSIFIED TRAFFIC                        │
          ┼───────────────────────────────────────────────────────────────────────────►
          │         ┌─────────────────────────────────────────────────────┐           │
          │         │mac hdr           mac_addr = sta macaddr             │           │
          │         │                  up = 6                             │           │
          │         ┌─────────────────────────────────────────────────────┐           │
          │         │ipv4 hdr                                             │           │
          │         │     v = 4                      dscp = X             │           │
          │         │     sip = 192.168.1.100                             │           │
          │         │     dip = 192.168.1.107                             │           │
          │         │     proto = tcp                                     │           │
          │         ┌─────────────────────────────────────────────────────┐           │
          │         │tcp hdr                                              │           │
          │         │      sp = 5400                                      │           │
          │         │      dp = 10400                                     │           │
          │         ┌─────────────────────────────────────────────────────┐           │
          │         │                                                     │           │
          │         │                                                     │           │
          │         │payload                                              │           │
          │         │                                                     │           │
          │         └─────────────────────────────────────────────────────┘           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │
          │                                                                           │


		3.2.2. Mirrored SCS - Protocol details
		-------------------------------------

			Refer to IEEE Std 802.11-2024 Section 11.25.3 MSCS procedures
			(Mirrored Stream Classification Service) for more details


			Initially, the non-AP STA specifies the UP(User Priority)(or TID)
			and the TCLAS(Traffic Classifier) mask for prioritization via
			action frames.

			The TCLAS mask element consists of Classifier mask which specifies
			what params to compare with the UL traffic received while
			classifying the DL traffic.

			The AP checks the Rx Uplink flow from the non-AP STA matching the
			classifier mask and classifies the mirrored flow (by reversing
			the 5 tuple of the flow as seen in
			uplink) in the downlink direction with the TID of received Rx flow.

			3.2.2.1. Protocol Handshake diagram
			-----------------------------------

┌─────────────────┐                                                                   ┌──────────────┐
│                 │                                                                   │              │
│      AP         │                                                                   │       STA    │
│                 │                                                                   │              │
│                 │                                                                   │              │
└──────┬──────────┘                                        TCLAS Mask element         └────────┬─────┘
       │      ┌──────────┌──────────────────────────┌──────────────────────────┐               │      
       │      │Robust AV │ User priority bitmap =   │                          │               │      
       │      │          │  1111 0000               │  type = 4                │               │      
       │      │MSCS.req  │                          │                          │               │      
       │      │          │ User priority limit = 7  │  mask = 0101 1111        │               │      
       │      │          │                          │                          │               │      
       │      │          │ Stream timeout = 60000 TU│                          │               │      
       │      └──────────└──────────────────────────└──────────────────────────┘               │      
       │◄──────────────────────────────────────────────────────────────────────────────────────┼      
       │                          MSCS Request                                                 │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │       ┌───────────┌──────────────┐                                                    │      
       │       │           │              │                                                    │      
       │       │ Robust AV │ Dialog token │                                                    │      
       │       │           │              │                                                    │      
       │       │MSCS.resp  │ Status = OK  │                                                    │      
       │       │           │              │                                                    │      
       │       │           │              │                                                    │      
       │       └───────────└──────────────┘                                                    │      
       │                                                                                       │      
       ┼───────────────────────────────────────────────────────────────────────────────────────►      
       │                              MSCS Response                                            │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       │                                                                                       │      
       └                                                                                       ┘      



			3.2.2.2. DL traffic classification using MSCS
			---------------------------------------------

       ┌────────────────────┐                                                     ┌────────────────────┐
       │                    │                                                     │                    │
       │        AP          │                                                     │        STA         │
       │                    │                                                     │                    │
       │                    │                                                     │                    │
       └─────────┬──────────┘                                                     └──────────┬─────────┘
                 │                          UPLINK TRAFFIC                                   │          
                 │◄──────────────────────────────────────────────────────────────────────────┼          
                 │         ┌─────────────────────────────────────────────────────┐           │          
                 │         │mac hdr           mac_addr = ap  macaddr             │           │          
                 │         │                  up = 6                             │           │          
                 │         ┌─────────────────────────────────────────────────────┐           │          
                 │         │ipv4 hdr                                             │           │          
                 │         │     v = 4                      dscp = 30            │           │          
                 │         │     sip = 192.168.1.107                             │           │          
                 │         │     dip = 192.168.1.100                             │           │          
                 │         │     proto = tcp                                     │           │          
                 │         ┌─────────────────────────────────────────────────────┐           │          
                 │         │tcp hdr                                              │           │          
                 │         │      sp = 10400                                     │           │          
                 │         │      dp = 5400                                      │           │          
                 │         ┌─────────────────────────────────────────────────────┐           │          
                 │         │                                                     │           │          
                 │         │                                                     │           │          
                 │         │payload                                              │           │          
                 │         │                                                     │           │          
                 │         └─────────────────────────────────────────────────────┘           │          
                 │                                                                           │          
                 │                                                                           │          
                 │                      DOWNLINK CLASSIFIED TRAFFIC                          │          
      ─────────► ├───────────────────────────────────────────────────────────────────────────►          
                 │         ┌─────────────────────────────────────────────────────┐           │          
AP sets the      │         │mac hdr           mac_addr = sta macaddr             │           │          
same TID         │         │                  up = 6                             │           │          
for the mirrored │         ┌─────────────────────────────────────────────────────┐           │
DL flow          │         │ipv4 hdr                                             │           │          
The tuple params │         │     v = 4                      dscp = X             │           │          
of DL traffic    │         │     sip = 192.168.1.100                             │           │          
are the exact    │         │     dip = 192.168.1.107                             │           │          
mirrored values  │         │     proto = tcp                                     │           │          
of the UL traffic│         ┌─────────────────────────────────────────────────────┐           │          
which was recvd  │         │tcp hdr                                              │           │          
                 │         │      sp = 5400                                      │           │          
                 │         │      dp = 10400                                     │           │          
                 │         ┌─────────────────────────────────────────────────────┐           │          
                 │         │                                                     │           │          
                 │         │                                                     │           │          
                 │         │payload                                              │           │          
                 │         │                                                     │           │          
                 │         └─────────────────────────────────────────────────────┘           │          
                 │                                                                           │          
                 │                                                                           │          
                 │                                                                           │          
                 ┘                                                                           │          



Public comments on this proposal are welcomed.

/ram

