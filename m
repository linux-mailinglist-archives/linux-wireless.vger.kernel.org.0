Return-Path: <linux-wireless+bounces-24743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731BAF03C9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 21:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B470487148
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDE1E5B6D;
	Tue,  1 Jul 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VWatGXw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59218D;
	Tue,  1 Jul 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398251; cv=none; b=p/KXXxmwAhNpeQwT8zgVqzFoTv8wHsAqU4Sk2mx54b5mOHiwdB5W2NmdcQSHqTFL6cZt1VpgY3uLiF4RsnZz5v5briFsQF8EmEN7SA576w0KyRzHJDweO+hSuS3CRmVLB5MXKbXYHo2Jmfrn99PF2uSqiObnsJF1tyRKMG5LTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398251; c=relaxed/simple;
	bh=uOMTOwYBtlYknp/LebuCS4PU/LoNnMyiqawK+JH9ysg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YV5iWAXommgbQSEovZmhMcTTFZqWYfs/1c1O2L7jRx65vnBQquEFbnKSoYcEfldW1hhstxEJXcRPQBuI6GRmg1RUvKeJUSmNGA6MVqPSPbhmTSN9viZQqJIdo95WM8Xr+hX6Pka0FHknpsdMCFYt90vr1ufBupJlLeUfOy80mEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VWatGXw0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561HUMLk018912;
	Tue, 1 Jul 2025 19:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xyX7q+Nr/jJb1oSpjbVoinC5EgqNbE1uHVbMdELnyLo=; b=VWatGXw018XVthuy
	SImDSgNRYb3MQnQ7C24Q/XpceQ9w2t6nJk7aGZW3EpfOEGR62JVkKy9L1+uLisjB
	w1uVuSVcooBmuGMuXMMSu/E81catj6lBb0fymm39dAF4WEbRMmvXdpDUCiBYX69R
	rHwXJwPlwfWl13ru8jp3QPbvbgjKsP8+g+ePnmSAKdt+pKQ0elsQvtAa7Ah3NF1E
	8gnQ/e+Tgg/gko8Em19IYyZsd4jnXACvnvnz5ZsiVlmHUtTKnxzCP5CG252rwNFo
	nI/DkfEzQ4aH10m+HssryJl1KUFRxOLeyve9pMlQKcnPBEdy1i7Uz/kXsCP1JbTu
	hsK/tw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxj574-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 19:30:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561JUeBZ006410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 19:30:40 GMT
Received: from [10.110.78.36] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Jul
 2025 12:30:39 -0700
Message-ID: <f71dfcd6-361f-4e6c-9941-599d600cb1af@quicinc.com>
Date: Tue, 1 Jul 2025 12:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC] wifi: Robust AV streaming Design Proposal for AP
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20250624205716.1052329-1-quic_rchoodam@quicinc.com>
 <ffc40c71b73eb1366435c09bd5cc25dd9e128c72.camel@sipsolutions.net>
Content-Language: en-US
From: Ramanathan Choodamani <quic_rchoodam@quicinc.com>
In-Reply-To: <ffc40c71b73eb1366435c09bd5cc25dd9e128c72.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEzNSBTYWx0ZWRfX2+o+XXbVkCMe
 EgZI3Otm+LDtrDgqnDwUJhxoQYqOFmM3dYNeYT8ZYOvu/3p6KApWQuFLMnqkaPM3p9wjSUzldBO
 GxxB1LhsFYL66CmfJm2ZxyvpxsWteb7VIkCQEM3DU28HX9WHEmgI7wirDnvJ6/MAwIVavw5sELu
 Kkm3p3s3spaQAJahYXY3E6nwaXTkn6RivXNSGS8vRmU2rJBKVbme5qo4tm3O3OL1yK1K+P9hTZ4
 97RqMZ2FCSCz29P1FrbEwMKBidTa05Uy5/w7xc/pUze7/TwSnqffoerNU9mQsoanItAzSHOXum1
 HpstWrwTA7bugL80fTbNxTMOOIpmbaEhUrgzfrEpE2T9mSSD9TBbAqvwlqj3HiWgY5OOsoRQBZR
 IDpXV+3+NyPeRVaCFsXwvSrYxxI0rHBVQSj6/wZzKPgnOTCeFYa0CPUeovfFgu99+P6gf5xL
X-Proofpoint-GUID: 92y1Mzj2TN4ZIP3Rd1YoQKB1F7wcF27a
X-Proofpoint-ORIG-GUID: 92y1Mzj2TN4ZIP3Rd1YoQKB1F7wcF27a
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=68643761 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=gN6Rxxx1YiIuJ-qI2BQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010135



On 6/27/2025 12:24 AM, Johannes Berg wrote:
> Hi,
> 
> (With my cfg80211/mac80211 maintainer hat on)
> 
>> 			2.1.3 - QoS Provisioning
>> 			-------------------------
>>
>> 				Hostapd extracts the QoS parameters from SCS/MSCS request, and
>> 				sends the parameters via NL80211 command (NL80211_CMD_QOS_MGMT).
> 
> Do you have any idea yet what that would entail? I'm thinking it would
> also need add/remove, perhaps, and some kind of lifetime tracking on the
> station?
> 
Yes you're right Johannes! The hostapd will maintain a per-STA based database of 
each and every param within a request received.

If a request to ADD is received with SCS/MSCS params, the hostapd maintains them 
on a sta_info struct per STA (that sent the request)and then sends them to the 
driver via NL80211 framework. 

If a new request is sent to modify/delete the params, the hostapd 
modifies/deletes them within STA struct and then conveys the same to 
the driver.
>>
>> 			2.1.4 - Networking Provisioning
>> 			-------------------------------
>> 				Hostapd if required and as indicated by the WLAN driver
>> 				capabilities, would add rules in the netfilter subsystem
>> 				via libnftables, such that flows matching the TCLAS
>> 				parameters are marked with certain meta data using skb->mark
>> 				to assist in prioritization in the MSDU processing in the WLAN
>> 				driver data path.
>>
>> 				In MSCS, hostapd will receive the Rx flow tuple from WLAN
>> 				driver using NL80211 command (NL80211_CMD_QOS_MGMT) and then
>> 				make a decision to install an nftable rule in the netfilter
>> 				subsystem based on MSCS parameters exchanged
>> 				during handshake.
>>
>> 				The WLAN driver will be responsible for classifying the
>> 				new flow received and parse the tuple information from the MSDU
>> 				and use the framework to send event to hostapd. For
>> 				identifying a new flow, the WLAN driver can make use of
>> 				any HW offload assist features it supports, as maintaining
>> 				flow information in software on a per-packet basis will be
>> 				expensive for flow classification.
> 
> How would the classification propagate through the layers?
> 
The classification happens for the DL packets as mentioned in the RFC. 
Here's a short description on how it happens:

(Refer to the diagram added at the start of Section 2.3 - 
Data Path (MSCS/SCS) - done at WLAN driver).

1. The rule match happens at NFT for DL packet arriving from the 
network stack.

2. NFT looks at the skb->mark to see if any special provisioning is done.

3. Since the rule was indeed provisioned by hostapd to the NFT, skb->mark 
will have classification details (whether the packet has to be 
classified or not).

4. The NFT gives this packet to the network stack which then gives it 
to the WLAN driver via mac80211 (mac80211 uses drv_tx() to send to 
WLAN driver).

The mac80211 layer will just pass this packet to the WLAN driver.

5. Since the classification is done at the WLAN driver, it looks at 
the skb->mark and then decides how to classify the packet using the 
initially passed on params from hostapd when it received the request 
from STA.

>> 		(B) cfg80211
>> 		-------------
>>
>> 			The cfg80211 layer receives the  NL(NL80211_CMD_QOS_MGMT), parses
>> 			the parameters and passes further down into the mac80211 layer.
>>
>> 		(C) mac80211
>> 		-------------
>>
>> 			The mac80211 calls into the WLAN driver with the QoS and
>> 			networking parameters.
>>
>> 		(D) WLAN driver
>> 		-----------------
>>
>> 			The WLAN driver receives the QoS characteristics and the
>> 			TCLAS elements and can do the required resource allocation and
>> 			the Firmware(FW)/Hardware(HW) programming based on the underlying HW
>> 			capabilities.
> 
> Without really going into the actual implementation, structurally, what
> would this contain? And architecturally, is it really just one set of
> parameters? It would seem to be more specific, like for a given station?
> 
The WLAN Driver maintains a peer STA database having the QoS params that 
hostapd sends.

This structure will be looking something like this:
struct qm_params {
      	struct tclas_params tclas_tuple[]; //the actual tclas element 
					     sent by STA in request.

	struct qos_characteristics qos_info[]; //The QoS characteristics 
						info sent by STA.

	u8 tid;
	u8 tclas_mask;
	..
	..
};
This structure will be stored inside a STA.
Every new request having new tclas_tuple/qos_info will be stored in 
this struct.

>> 	2.3 - Data Path (MSCS/SCS) - done at WLAN driver
>> 	--------------------------------------------------
>>                                            3. Hostapd provisions the rule to NFT
>>                      ┌─────────────────────────────────┐
>>                      │                                 │ N/W provisioning
>>                      │           hostapd    ┌─────────┐┼────────────────────────┐
>>                      │                      │libnftnl ││                        │
>>                      └──────────────────────└──▲──────┘┘                        │
>>      user space                                │                                │
>>             ───────────────────────────────────┼────────────────                │
>>                     ┌──────────────────────────┼─────────┐                      │
>>                     │                          │         │ 4.                   │
>>      kernel space   │ ┌────────────────────────┴──────┐  │ NFT updates skb->mark│
>>                     │ │        nl80211/cfg80211       │  │ while adding the rule│
>>                     │ │                               │  │   ┌──────────────────┼──┐
>>                     │ └────────────────────────▲──────┘  │   │                  │  │
>>                     │                          │         │   │                  │  │
>>                     │ ┌────────────────────────┼──────┐  │   │  Linux N/W stack │  │
>>                     │ │           mac80211            ◄──┼───┼                  │  │
>>                     │ │                               │  │   │       ┌──────────▼─┐│
>>                     │ └───┬────────────────────▲──────┘  │   │       │netfilter   ││
>> 5. The DL packet    │     │                    │         │   └───────└────────────┘┘
>>  comes with         │ ┌───▼────────────────────┼──────┐  │
>>  skb->mark          │ │                               │  │
>>  which is used      │ │                               │  │
>>  for classification │ │           WLAN drv            │  │2.
>>  along with         │ │                               │  │Driver then programs the rule to hostapd
>>  stored QoS         │ │                               │  │using NL80211
>>  params at the      │ │                               │  │
>>  driver             │ │                               │  │1.
>>                     │ └───┬────────────────────▲──────┘  │For MSCS flows, driver learns a new rx flow
>>                     │     │                    │         │using HW assist
>>                     └─────┼────────────────────┼─────────┘
>>                     ┌─────▼────────────────────┼─────────┐
>>                     │                                    │
>>                     │            Hardware                │
>>                     │                                    │
>>                     └────────────────────────────────────┘
> 
> Terminology wise, "driver then programs the rule to hostapd" seems ...
> confusing. It's more like "notifies hostapd of the new flow" or so?
> 
Yes you're right! In addition to this, few more details:
The step 1. and 2. from the diagram are only for MSCS protocol (not for SCS).

The MSCS protocol relies on Rx packets from STA to AP, since it does
not specify any traffic tuple info in the MSCS request, unlike SCS.
(For understanding the difference, refer to protocol handshake diagrams
in Section 3.2.1.1 & 3.2.2.1)

So when an Rx packet is received, Driver learns whether it is a new flow
using HW assist. It then extracts the tuple info (src_ip, dst_ip ...)
from the msdu and then informs hostapd to create a rule in NFT.

>> 		* The Datapath decision making logic for the QoS features
>> 		would be handled in the WLAN driver.
> 
> What decision making logic is even in the datapath?
> 
I think, the explanation is same as what I described above (the step-by-step flow)
For MSCS, more details below.

>> 		* In MSCS, Driver will be responsible to track all the uplink flows
>> 		for a non-AP STA with MSCS session, based on
>> 		TCLAS mask and should prioritize the corresponding downlink flows.
>>
>> 		* For prioritization in DL for MSCS, the driver should notify hostapd
>> 		using NL80211 framework (via mac80211, cfg80211) to program the
>> 		netfilter rules, when a new Rx uplink flow is received.
> 
> Here I don't follow - I can see how uplink needs the driver to
> parse/classify the flow and tell hostapd about the mark or so, but on DL
> the whole thing starts at higher layers, no?
> 
Please refer to my response below, for your last query:

>> 		* As mentioned in Section 2.1.4., In MSCS  hostapd receives the
>> 		Rx flow tuple from the driver via NL80211_CMD_QOS_MGMT,
>> 		then decides whether to install an nftables rule in netfilter
>> 		based on MSCS handshake parameters.
> 
> For an uplink flow, I'm not even sure what netfilter rules need to be
> there be at all? Once a packet is received, it's effectively game over
> for classification / air competition / etc. no?
> 
> johannes

The MSCS protocol relies on Rx packets from STA to AP, since it does
not specify any traffic tuple info in the MSCS request, unlike SCS.

So, the driver, even if it extracts the tuple info from the Rx MSDU, it
informs the hostapd with the reverse of this tuple info (because,
the reverse of this UL flow, will be the DL flow - hence the name
Mirrored SCS)

Eg. if src_ip = 192.168.1.10 and dst_ip = 192.168.1.20 in a Rx MSDU
then the response sent from AP to STA i.e the Tx MSDU will be this:
src_ip = (dst_ip of Rx MSDU) = 192.168.1.20 and dst_ip = (src_ip
of Rx MSDU) = 192.168.1.10

Let's take one more example:
Driver receives an Rx UDP traffic packet with these tuple params:
driver extracted rx_msdu_params = {
	sip = 192.168.1.10
	dip = 192.168.1.20
	sport = 50103
	dport = 50102
	proto = udp
	dscp = 30
	tid = 4
};

The driver notifies the hostapd to program the reverse of this
flow to NFT (so that when DL packet arrives with the programmed
rule, it will be classified with same tid as Uplink)

driver programmed mirrored_msdu_params = {
	sip = 192.168.1.20
	dip = 192.168.1.10
	sport = 50102
	dport = 50103
	proto = udp
	dscp = 30
	tid = 4
};


So driver notifies the mirror(extracted Rx tuple info) to hostapd, which
then programs the rule to NFT for DL classification.
So when NFT rule match happens for DL, it will be sent with
same tid as Rx (in this example, dl_tid = 4)

You can also refer to IEEE Std 802.11-2024 Section 11.25.3.

Hope this clarifies.

/ram

