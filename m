Return-Path: <linux-wireless+bounces-25564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7FB0842D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 06:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DCDA43175
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAC4C9D;
	Thu, 17 Jul 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnrVFtTN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03D2066DE
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728172; cv=none; b=iZrthEtorO1XfRYplHafwuzRvbjtglOcCqRbd0jJonyV9zzPNKlbPzDhvGGEdaMFEcCKwLhJ0wWoLED+frRsj8oRjocBeTFISbPFgLu8CgEUKBatGr8FD9W7wLfbM4lmwRxD1cihy40h1hDjbjbOans/wqf3oG83v+wO967PHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728172; c=relaxed/simple;
	bh=iTyHI1COhCqNjauZmwP/KubATfRIWyGojwNowcZz52M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c/CgP+Hb0tnMOz+vyUKy56mcr6LIHTDn/caGw34kCnlV33qozsUES+kOcCexfIBpD3LFxkBuniEERiD6oqsDu32+um+Ur6vcI6THDFD1n/ibT5UNQ9NEyWWePgOKyCV52bpI0y4yY4hvMckNUHwp9bNn25jDOVA1aCx2qwpT05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnrVFtTN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDSW5020753
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 04:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sMBToC67fownmwdRlriPNo
	gOpeVJF9xq3PvPlF6Agz4=; b=FnrVFtTNLY4M9FYO8/88jTK5K+RDexUEH4gB27
	p8V+zobzbPcMShbuLQjbS0JwIp1g+KeLdyDJjCVaKTl/iK3AXWuWFQ29UfjM8Wsq
	37TsetgjPdOFEUqHs3/Ovai1nYicYa1Mp3xsaWhRej35krbJZfdfHI3q/Zq/E3cq
	crQ+5dqcezGBkHG5bdmuMSURNZySs1KHVR6+eahUn/na2bjW6+Rgblt0PTeUddaK
	vo3TiTDYO01UTLt+rhmHwmwv5uMx1LErmYriP3jFqZDzsVlje598vO96OarzWBe6
	ms9IEaL1XtyvO94Cxp+lYebgUlFu7RSwG38BXCEykIofT51w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dphar0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 04:56:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234fedd3e51so5695515ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 21:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728169; x=1753332969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMBToC67fownmwdRlriPNogOpeVJF9xq3PvPlF6Agz4=;
        b=TuTeAYLo9iwMNGFgJhmRqY4ZAYMDZGJ4Ll0A4xVhvOr86Ge0AuF1To1fFAc/daWOT8
         SInraWQ9MrHRouHH4VpfGkhWgNFbkZVL8srw/t1ZIXPsi6xecAI7VkvQo9AMvxdsovZp
         a+bwQb/TyBx48wWpIHgEGj9+UJgWY6/rvcfvU62v8TDJdb/62Oh1aCAuCm2zDbdxvbaE
         tEl1We4ZYINGlM+apmQhQtd6dcKOFut5Ctuik9IHdfBcKlzOLjZO6FnLbelAj45zGs4N
         KZqEENxGyXTSnmjuCv+WFR0+lqqsFHu8ELA/GcwO5IQnwShSKoqWCkBDBmIspiM6/n2g
         HBTA==
X-Gm-Message-State: AOJu0YxgUyy+eSf8nnIUQcjZcPAAxp08aYqcb8zH9yNmOjCv4/NyTQ2J
	5rQ0SSmvXTuRFYbgw7INCUhKYyEGgx7//ZMdeSwV0wx8lCvOBUxpOSdbbdsXdQQr1YEu9urC63e
	WDykE0L1cyFzzjVUfAArp55B9bL1iPCSKK0ebzfwBqhAeffBNGJbhDPMm+a9m3HbGRvKONQ==
X-Gm-Gg: ASbGncu8oZtqoLj2IKmwzSDvVik7rJTBxsyORBDEJMl5tNC09L5eDCtd7hoDqk/a0/C
	QO+SMTVRNOMrL3us2vG5Od61lRFwxl6c1dQhMn566kkGMFM9/lA0Ok0XV3EFWG6V7RIkeVfkdlo
	rdLzO56F3Yva3SBTJb4bZO3IFlG+1bLnL8SoBrYXr22Qeemg/Yej2gKI9uxUvDY0lGKBi0kBLNP
	pdWtJ4vJz1Pd0rfltbl81dEpV7swG3zNBIKmAZvAKZ5cvhGP3B2YWw5Mx2smMkTctuWarZMhDmY
	Bzk+T9Y8d7s4Q29fAj1VP+hi1pfi6BAun0N0Sooqqef5inqwv85Igqo60BQzlgz6AXIHQGpnr+y
	qZ7PsoedPfq7UIeKAGzADqiFfii43DhDzy6/Zg6zVwfbRNhOmdFHbba+KnDlV7vX5
X-Received: by 2002:a17:902:d54a:b0:235:27b6:a897 with SMTP id d9443c01a7336-23e257300ddmr78181875ad.34.1752728168381;
        Wed, 16 Jul 2025 21:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7NicCsd0n4RRF/0Y6gaSocEg9jfxM4G6NoroagLVvxzbbz7cCzIYsuNgKYXM10GyjLiuHuQ==
X-Received: by 2002:a17:902:d54a:b0:235:27b6:a897 with SMTP id d9443c01a7336-23e257300ddmr78181435ad.34.1752728167674;
        Wed, 16 Jul 2025 21:56:07 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm136269665ad.78.2025.07.16.21.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:56:07 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [DESIGN RFC] Critical Update handling in the kernel
Date: Thu, 17 Jul 2025 10:25:40 +0530
Message-Id: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA0MSBTYWx0ZWRfX7NUZ8+GObpg6
 FI/YGlCJqntp130Qj80B5MKwcLA/n7/bVRWI8CMV1PZftAP0tjM6Y4MzhU79lnoi0VsA2+3aWzI
 Whn6sCE2IycuT3mVgyl4Ujmm4CE/Ik2c9E4FMKUIeqDphVifgF9zXSs2V+W19JjdE/TCBM/jsxC
 UbHu52nmXtIkBg4IhkOC9z2c/eJjEfoeKdBdZuVQFqvL3rR/jGhA7CZTn26RBJuxdW+EiKhrkc+
 MhdYFroJ3pNe0zFy6kBU5zI6cNMW/KWiHg6dJrVkEKdKjiMx4iE9TRgGL+h/Q81bQclT1qrW392
 vFtAd7gFP8aa+pQrnITEEL3JA7WuRi5jqBDWROImLsvXY0DUuWSQvq0FbMAkpXYCxq9cZFHTOSJ
 ys83rGZLjppGqSxNJjCeoAuHsiTFY07JkXRFaX+3v6c9a4qTwIRf1pX/S/RCbMbgolvieiYG
X-Proofpoint-GUID: 6_CtDvwLOWF6hw0oUILTVLlfnc5xrnUC
X-Proofpoint-ORIG-GUID: 6_CtDvwLOWF6hw0oUILTVLlfnc5xrnUC
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68788269 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=kDxmFn6s7itEDciakTYA:9 a=CJYILJ9lChCZOd2d:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170041

Hi,

Some time ago, an approach was proposed [1] where all aspects of critical
update handling—including BPCC management, element propagation, and
timing-sensitive updates—were delegated entirely to the vendor's firmware.
While this design offers tight timing control and efficiency, one of the
key concerns raised was:

"What about vendors whose firmware does not support this functionality?"
"What about mac80211_hwsim? How this is supposed to work with
 mac80211_hwsim?"

[1]: https://lore.kernel.org/linux-wireless/20240403162225.3096228-1-quic_rrchinan@quicinc.com/

To address this, a fallback mechanism in the kernel (mac80211) is being
proposed. This kernel-side implementation ensures that the feature remains
functional even when firmware support is absent, albeit with some
limitations in timing precision and certification readiness.

===========================================================================
                            OPEN QUESTIONS
===========================================================================
Before we move forward with implementation, we'd like to confirm whether
the proposed design looks sound. Are there any concerns or potential issues
we should be aware of?

Out of curiosity, we're also interested in understanding how other vendors
are currently handling this feature in their downstream drivers. Is it
typically offloaded to firmware, or is the logic implemented in the kernel?
Just want to confirm whether all this will be used only by mac80211_hwsim
or will there be any actual users?


===========================================================================
                              BACKGROUND
===========================================================================
Critical Update is a mechanism where, if a BSS parameter changes on one of
the links within a Multi-Link Device (MLD), that change is also signaled in
the beacons/probe response of its partner links. This allows the multi-link
client to be proactively informed of the update through any of the partner
links, rather than waiting to receive the updated beacon/probe responses
from the affected link itself.

For instance, if Link A initiates a channel switch, it will include the
Channel Switch Announcement (CSA) element in its own beacon.
Simultaneously, Link B will reflect this change by embedding the same CSA
element within Link A’s per-STA profile inside the Basic Multi-Link Element
(BMLE) of its own beacon.

This ensures that multi-link clients monitoring Link B can be promptly
informed of the change on Link A, without needing to wait for Link A’s next
beacon.

The below diagrams tries to depict the above said behavior:

Link A and Link B (part of MLD) originally beaconing just fine:

┌──────────────────────────────┐ ┌───────────────────────────────┐
│         Link A's beacon      │ │         Link B's beacon       │
│                              │ │                               │
│......                        │ │......                         │
│┌────────────────────────────┐│ │┌─────────────────────────────┐│
││RNR Element:                ││ ││RNR Element:                 ││
││  TBTT INFO:                ││ ││  TBTT INFO:                 ││
││    MLD INFO:               ││ ││    MLD INFO:                ││
││       LINK ID: B           ││ ││       LINK ID: A            ││
││       BPCC: 1              ││ ││       BPCC: 1               ││
│└────────────────────────────┘│ │└─────────────────────────────┘│
│......                        │ │......                         │
│┌────────────────────────────┐│ │┌─────────────────────────────┐│
││MULTI LINK Element:         ││ ││MULTI LINK Element:          ││
││  COMMON INFO:              ││ ││  COMMON INFO:               ││
││     LINK ID: A             ││ ││     LINK ID: B              ││
││     BPCC: 1                ││ ││     BPCC: 1                 ││
││                            ││ ││                             ││
││  Basic STA profile count: 0││ ││  Basic STA profile count: 0 ││
│└────────────────────────────┘│ │└─────────────────────────────┘│
└──────────────────────────────┘ └───────────────────────────────┘

Link A started CSA and during CSA, the beaconing would look like -

┌──────────────────────────────┐ ┌──────────────────────────────┐
│       Link A's beacon        │ │       Link B's beacon        │
│                              │ │                              │
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││Capabilities Info:          ││ ││Capabilities Info:          ││
││   BIT 6: CU Bit: True      ││ ││   BIT 6: CU Bit: True      ││
│└────────────────────────────┘│ │└────────────────────────────┘│
│┌────────────────────────────┐│ │ ......                       │
││CSA:                        ││ │┌────────────────────────────┐│
││  CS Count: 5               ││ ││RNR Element:                ││
│└────────────────────────────┘│ ││  TBTT INFO:                ││
│......                        │ ││    MLD INFO:               ││
│┌────────────────────────────┐│ ││       LINK ID: A           ││
││RNR Element:                ││ ││       BPCC: 2              ││
││  TBTT INFO:                ││ │└────────────────────────────┘│
││    MLD INFO:               ││ │......                        │
││       LINK ID: B           ││ │┌────────────────────────────┐│
││       BPCC: 1              ││ ││MULTI LINK Element:         ││
│└────────────────────────────┘│ ││  COMMON INFO:              ││
│......                        │ ││     LINK ID: B             ││
│┌────────────────────────────┐│ ││     BPCC: 1                ││
││MULTI LINK Element:         ││ ││                            ││
││  COMMON INFO:              ││ ││  Basic STA profile count: 1││
││     LINK ID: A             ││ ││  Per STA Profile:          ││
││     BPCC: 2                ││ ││     Link ID: A             ││
││                            ││ ││     ┌─────────────────────┐││
││  Basic STA profile count: 0││ ││     │CSA:                 │││
│└────────────────────────────┘│ ││     │  CS Count: 5        │││
└──────────────────────────────┘ ││     └─────────────────────┘││
                                 │└────────────────────────────┘│
                                 │......                        │
                                 └──────────────────────────────┘



===========================================================================
                            DESIGN PROPOSAL
===========================================================================

Assumptions:
------------
The critical update procedure is highly timing-sensitive. Ideally, this
should be handled by the firmware to ensure precise synchronization with
DTIM beacons. However, since not all firmware implementations support this
capability, the proposed kernel-side handling serves as a fallback
mechanism.

That said, due to inherent limitations in kernel-level timing
accuracy—especially in offloaded beacon scenarios—this approach may not
fully meet the strict timing requirements expected in certification
processes. It provides a best-effort solution but may not be suitable for
deployments where certification compliance is mandatory.



Extended feature flag:
----------------------
This design introduces additional computational overhead, which could
potentially delay beacon processing. Since not all mac80211 drivers may
prefer this behavior, introduce a new extended feature flag -
CRITICAL_UPDATE_SELF_MANAGED. mac80211 will NOT perform these extra
computations if the driver advertises this feature support.



Parsing the beacon update:
--------------------------
During the ieee80211_assign_beacon() call (where link->u.ap.beacon is
updated whenever the beacon content is initially set using
ieee80211_start_ap(), modified through ieee80211_change_beacon(), or
changed as a result of channel or color switch events) -

1. Store the new beacon data in a new pointer, following the usual flow.
2. Parse the beacon (using the head and tail pointers) and record the
   starting offsets of each required Element (earlier referred to as IE i.e
   Information element) in an array, indexed by element id or extended
   element id. This is done per link object.
3. If a previous beacon exists:
    3.1 For each element related to the critical update, perform a memcmp()
        to detect changes compared to the previous contents.
    3.2 If any such element has changed, set the critical update flag in
        some link-level object (e.g., link_conf). (this is for the affected
        link)
        3.2.1 At the same time, set the critical update flag for all
              partner links as well in the same object.
    3.3 Increment the BPCC[2] value (modulo 256 excluding 255) for the
        current link.
4. If critical update flag got set in previous step for partner links, call
   link_info_changed() with CHANGED_BEACON to notify lower layer that
   beacon has changed. This applies only in case when beacon is offloaded
   to firmware. In case beacon is given to driver at every TBTT, there is
   no need to notify since at next TBTT, driver will fetch the latest
   beacon anyways.



Forming the new beacon:
-----------------------
In the __ieee80211_beacon_get() function, where the beacon SKBs are
constructed:

1. Allow the existing logic to generate all beacon SKBs (including multiple
   SKBs in the case of MBSSID-EMA).
2. For each beacon SKB:
    2.1 Parse the RNR (Reduced Neighbor Report) element.
        2.1.1 For each TBTT Info entry:
            2.1.1.1 Extract the BSSID
            2.1.1.2 Retrieve the corresponding link sdata from BSSID
            2.1.1.3 fetch the latest BPCC value.
            2.1.1.4 Update the frame with this latest BPCC value.
    2.2 Parse the MBSSID profile element.
        2.2.1 For each non-Tx profile:
            2.2.1.1 Extract the BSSID
            2.2.1.2 Retrieve the corresponding link sdata from BSSID
            2.2.1.3 If the critical update flag is set in link object, set
                    the CU (Critical Update) bit in the capability element.
            2.2.1.4 Set non_tx_update = true.
    2.3 Parse the multi-link element.
        2.3.1 For the self link (already known), fetch the latest BPCC
              value.
        2.3.2 Update the frame with this BPCC value.
    2.4 Update the capability element in the SKB:
        2.4.1 If the critical update flag is set, set the CU bit.
        2.4.2 If non_tx_update == true, also set the non-Tx CU bit.

This mechanism sufficiently handles critical updates due to modifications
of existing elements (elements related to the critical update which are
already present in the beacon and just one or more field is/are changing
its value). However, in the case of new element inclusion (elements related
to the critical update which are not alread present in the beacon, but is
getting added from next beacon), additional handling is required.
Specifically, the newly included elements related to the critical update
must be added to the per-STA profile within the Basic Multi-Link Element
(BMLE) [3].

To achieve this:

3. Allow the existing logic to form the beacon SKB as previously defined
   (this already handles modification updates).
4. Maintain an extra_len variable to track any additional space required
   for including additional elements.
5. While parsing:
    5.1 If critical update is going on in partner link due to inclusion of
        elements, increment extra_len accordingly.
    5.2 The required length is determined using the eid/ext eid based
        offset  maintained in each beacon data structure.
    5.3 Since the element offset is known, and the next byte is the tag
        length, the total length is tag_len + 2 (for EID and length
        fields).
    5.4 Account for any additional fields that may be needed (e.g.,
        sub-element ID and length in the Multi-Link IE).
6. Compute the new beacon size:
     new_size = current_size + extra_len
7. Allocate a new SKB with the updated size.
8. Copy the existing contents and insert the new or updated elements at the
   appropriate offsets.
9. Since IE offsets are cached in the beacon data structure, the entire IE
   can be copied directly without re-parsing the full beacon from other
   links.
10. Free the original beacon SKB.
11. Return the newly constructed beacon SKB.



DTIM beacon handling:
---------------------
As per requirement [4], the Critical Update (CU) bit in the capability
field must be cleared in the DTIM beacon.

For Non-Offloaded Beacon Handling:
    1. The function __ieee80211_beacon_add_tim() is responsible for
       updating the DTIM count.
    2. When the DTIM count reaches 1 (indicating that the next beacon will
       be a DTIM beacon), the critical update flag in the corresponding
       link object should be reset.

For Offloaded Beacon Handling:
    1. If precise control is required:
         1.1 Since DTIM updates are managed by the lower layer (typically
             the firmware or driver), an API will be provided to explicitly
             reset the critical update flag.
         1.2 The driver, upon detecting that a DTIM beacon is about to be
             transmitted, can invoke this API to perform the reset.
    2. If some timing inaccuracy is acceptable:
         2.1 mac80211 can maintain a timer to reset the critical update
             flag after a DTIM interval.
         2.2 However, this approach may lead to synchronization issues, as
             mac80211 cannot guarantee the exact timing of beacon
             transmission handled by the hardware.



Update BPCC back to NL:
-----------------------
After the kernel increments the BPCC value, it can emit a netlink event
containing the updated BPCC value. This allows hostapd to receive the
latest BPCC and include it in probe/association response frames, as
required by the specification.

This coordination ensures that all - beacon, probe response, and
association response frames reflect consistent BPCC values, maintaining
compliance with spec-defined behavior for multi-link and critical update
handling.



Counter offset handling of partner links:
-----------------------------------------
Note: This applies only in case of offloaded beacon case.

Since not all links operate with the same beacon interval, the firmware
cannot simply decrement the counter on every self-beacon transmission.

To handle this correctly:
Each BPCC counter will be associated with:
    * An offset (location in the frame where the counter resides), and
    * A periodicity value, indicating how often the counter should be
      decremented.

The firmware is expected to:
   * Track the number of self-beacon transmissions per link.
   * Decrement the counter only after the specified number of
     transmissions, as defined by the periodicity value.
   * This ensures that counter updates are aligned with each link’s
     individual beacon schedule, maintaining spec compliance in multi-link
     scenarios.



Complexities:
-------------
When adding elements in per STA profile, the element length might exceed
hence fragmentation needs to be handled properly.

Max Channel Switch Time element handling is still tricky since this field's
value starts decrementing once counter reaches 0 and before beacon comes up
in next new channel.



Alternative approach:
---------------------
memcmp vs hashing
=================
In the section where memcmp() is used to detect changes in beacon elements
(to determine if a critical update is needed), this logic could
alternatively be handled at the hostapd level.

Since hostapd does not retain the previous beacon frame, it cannot perform
a direct memory comparison. However, it can compute and store hashes of the
required elements during beacon formation. On subsequent updates, it can
compare the new hashes with the previously stored ones to detect changes.

If any element's content has changed, hostapd can:
   1. Include this information in a new netlink attribute, indicating which
      elements have changed.
   2. Pass this to the kernel, allowing mac80211 to make informed decisions
      about setting the Critical Update (CU) bit.

This approach offloads the comparison logic from the kernel and leverages
hostapd’s control over beacon generation, while still respecting the timing
and structural constraints of the beacon update process.

Only this comparison—and consequently the signaling of the critical update
can be offloaded to hostapd if needed. All other operations must remain in
the kernel to meet strict timing requirements.


References:
-----------
Spec: IEEE P802.11be/D7.0, August 2024

[1]: The elements which are considered for critical update are classified
     in section 11.2.3.14 TIM Broadcast.

[2]: BPCC stands for BSS Parameters Change Count

[3]: AH.7 Example of critical update operation and AH.8 Example of
     advertising quieting or channel switching information of a link on
     another link.

[4]: 9.4.1.4 Capability Information field

