Return-Path: <linux-wireless+bounces-37779-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pXyxD6M5LmqaqwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37779-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238AF680622
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 07:18:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LiZWEovX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=E3vr0fXP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37779-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37779-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E26D23001CD2
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 05:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA518BC3B;
	Sun, 14 Jun 2026 05:18:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975C171BB
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781414301; cv=none; b=lwUKYwrligJALiTL00g6dxOvvimKpxYi9aN/m2SA52B4SDobJ40aIV8dpPEt3PYYB81uCmJjwKARUByUDTZ3g5t4RRm+m4GWgXethmE1+eDHYCkCvFobdkvaFOf4PYLVXjkGDXaKisP7ZqhkpKaBobBgkZ3PkLt20vO7uhi9mVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781414301; c=relaxed/simple;
	bh=76KBLnYi8qmeh/cAt8Rbo6qV5FHzu8+T2mB0QfgZF1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrLIHZbUnb7cFpEAUvHAeB9MoQDaMjVtSjg/7GnpnA38G8HTYfQMNGpRPWENaAsqLHzadJO2Xcg702sEtgTRZpqeQfmso9DfJjVakaPDttCDycDOWY5Da0P4m35Vj5B/fVJ2dKSsYZr4VIPoik3c0L4/wfMGEHiq/DnHrYIU2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiZWEovX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E3vr0fXP; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65E4kl9D699356
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wgFP3UvqzIlvDi28YX756R
	6m0ZesSFOytF38ii9aXEM=; b=LiZWEovXLxq8AWi/JX9hIWpViS1h1twDo0ff/5
	WcOPvaz290vV4eiDluZc4pJ9R1Ri10m91liaaXr4W5Gbora2brAyfWfZUiMT/knT
	J8GaexaapG6ZPM5YDbhnIh0Bz8fhiM9q4nYsunN7V3nKlULA6y62qL50h2qXxRFD
	wseiOGnIXLAqwj0DaKTuoj7KBSrGkXJeqFhweEdm2lvPXJtZ5UoMZD+QWLzMxnNI
	6BQwgNzogABZbFikYgzpcqZKCj0zBNGDyc2MlOxzV0wLvsRJl+V98jMzDKHwX4AQ
	CjkabX7AKqno7e5p/WOhnsTtnqLHbVcwNbexf2+ZAj6igM2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gttks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 05:18:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf3636d6c0so22390405ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781414298; x=1782019098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wgFP3UvqzIlvDi28YX756R6m0ZesSFOytF38ii9aXEM=;
        b=E3vr0fXPvypRFr7iWQJaBhi9W8LGpPNyEelpcjlxuyO68vD4TTg1QA8ymTBSCqhJGU
         n8Gp+/1VPOTdUceHYGzwdQOXhZbJzsLbBjAh3BcuwI7QLuA/YIAVGZQNUed5Bsziv8nh
         K2vMwOXISIdOAfwrWdJX391CE7Rm8v7ceywKKG1HH1GTIDg0I/rV+apEWNLQmbY5EY7y
         NKqM4OCouba4wDvsN5i87eMsUZh6BhyZZwf69BzFVAddQbS9cufNJ4nnFRDh583qTAjs
         gxvDLb/zB62ENEf1jmGkZbSxEiXcTadYM/4q8ADV8hS0rEiI7V0s/QOWhByqsx9ueovm
         3GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781414298; x=1782019098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgFP3UvqzIlvDi28YX756R6m0ZesSFOytF38ii9aXEM=;
        b=sKvCez45SMHgy1zol1bbdGEPV/QeXv4fsmv9Yqh9cwERA0g1sbNQKKr5RVUvGXAfY0
         UnDuuo7eifFX6JOmvWNBvoCSV3EHZmipFhwbBFkp9mZxP/pGj7Kll7jrRVgBRKjKqJ6K
         ZIBcA+zKgAzRf81iEFgnASNlvhoGhUY9OMgq+f8z12uHRxRtiZJrQ+hBDToQlHS5TgPP
         xdxbK74VSS9/aIkaR7eXWPZNHOIxeN86EmybAldkXwah7oP4AaItxKcdsfYFXCPQD34R
         uYFRgdudDImbcf64dQhEk3TwDsQaOW5PedYuf4O6L09G3vTXkRCEktKzHBy7neboPX3N
         S6Fg==
X-Gm-Message-State: AOJu0YwKvhlz8RXnWjtSyRVAteUF/RmachfagttxmaS4FpIUPtjrbxnL
	Bf9bMnFLujxtFgWdoiq3txkhhaFgwHptfPJJRqOVbF2Ot1WexW3gYfiOitKw5CMq6rdh+ZsHA+T
	ii12pSTdQKTd7Jo+Om0TfUvgoTZ5bSnhf9Yw+7Uqe47NhXF09qH0jBQ3EBrQv8/aUHU/+2qo/pd
	H5zw==
X-Gm-Gg: Acq92OHCYsLaA8ZHU1DCEwacVHvPgLQyByT5eWAD+CR/CXcjfm9BZRncgYS3kZpinNz
	mumoYJ3YyZvGrWuuIqJCyv7Xi6MtLdmhM2vNxIG59FdmexG6YHL3WDsrAWHyiuP1PMLhhP6Fzu1
	jPphIoqDD/n5QVz+cOcwwNS79mXSDSYFp2ye74gYzfcAC729YeOmLM3iAJpcKAVGMsLsSZsgybs
	xnCs1a23SINUH5RbZYSN+cF+FrvtJMpTebLt+nIgtmNcK3yIcPFIMxWw97Vy7s8u4cyAHKXtwOO
	yDAv0G1tisPVq0pot8+UyA6zeqjKPf944E3OLjubFt0FeOObkerIR2PH5jzGR/BCCZKnzrPU0QX
	+aML3+tYB56yZ+0LjbkwAc/3Lx3h6rYPpikfRVOcbhtdfz5Aew5nRrvI2qe36VSSIe633ULLELL
	P3x9cnUBCra3TLzcn8ATaJPAJwr0GVUZ0BM+S7Vck=
X-Received: by 2002:a17:903:240f:b0:2c1:5667:2740 with SMTP id d9443c01a7336-2c4125591a7mr97800445ad.21.1781414297590;
        Sat, 13 Jun 2026 22:18:17 -0700 (PDT)
X-Received: by 2002:a17:903:240f:b0:2c1:5667:2740 with SMTP id d9443c01a7336-2c4125591a7mr97800205ad.21.1781414297033;
        Sat, 13 Jun 2026 22:18:17 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm64456705ad.26.2026.06.13.22.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:18:16 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add fragmented per-link station stats in MLO
Date: Sun, 14 Jun 2026 10:47:30 +0530
Message-ID: <20260614051739.3979947-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX4zURHiASWClA
 9vrKubacSK+B8s5FidAuVCRhPbCK0CHIKG71sTRivPLQaGSZHHAwY3aa9jHQLMv2sqX0soulCXX
 L7ivSFeNKAQuX6M2UIyNTry7iD2S+30=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2e399a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=WN52PlUurRMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=D0vhY7WTa_WH9j_4aaoA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDA0OSBTYWx0ZWRfX6lTlyD7T0q3W
 ziJfQfaQJGOHGPoLtVQrs5KNN9R0Qj3c3tOouIG25zE+H8IwP8HnKcFspmapDXRV8JxOQKMsBtV
 pnd4RG6GXdMVifCxyC1K0gp0W9x2SxmiGDIHugsXT52sfz3Z6plVzCdjV6oDI04LSlDpED7qOEr
 AGtQK3hTz01F/+SmToqnfxnX7Glm7uj0LDEVqgCGMFwnlU+Y+3kU4xRD+45FgXsmY/EYFsNN91F
 LvCib8zjlXcMzoOXwpQor92psjQUdlWekULGz2IZTayeQ7xTAeJEieFctpBND/NjQ3gPMpPDDsV
 V3UR2S0E1cWCU7XyS2sVIwJK3fOizdGW45gIAptac9qBAvn8vV9Qq1LqmLvR57Iio/04EsixsIR
 gl1KbOSOMtep84O6HhfPdV/IaYBVqt/ApuJLCJJ2iFmKRG63DUW2QPooiuK3G2jjrNbb3VljRkP
 UTg+2WuGDuhIXofOEUA==
X-Proofpoint-GUID: iQXeWHToYeyrv6zjDV0y1hCO-THgLoC8
X-Proofpoint-ORIG-GUID: iQXeWHToYeyrv6zjDV0y1hCO-THgLoC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37779-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 238AF680622

This series introduces fragmentation support for Multi-Link Operation
(MLO) station statistics in nl80211.

The current nl80211_dump_station() implementation works well for legacy
(single-link) stations, but it does not scale for MLO peers. With
multiple links per station, dumping all per-link information in a single
netlink message can exceed size limits, resulting in -EMSGSIZE errors
and incomplete dumps.

With 802.11be (Wi-Fi 7), a single station may have multiple links, each
with its own statistics. To address this, this series introduces a
stateful dump mechanism that splits station information into multiple
messages when required.

The dump is performed in two phases:
  - Phase 0: Aggregated (station-level) statistics
  - Phase 1: Per-link statistics sent in separate messages

This ensures:
  - Reliable delivery of complete station information for MLO peers
  - Backward compatibility for legacy stations
  - A scalable design for future extensions

Summary of changes:
  - Drop unused per-link stats handling from nl80211_send_station()
  - Introduce a helper to pack common station-level STA_INFO attributes
  - Refactor nl80211_dump_station() to use a stateful dump context
  - Implement per-link stats fragmentation using a two-phase approach
  - Add optional MAC address filtering for per-link station dumps

Message Layout Examples:

Aggregated Stats (Phase 0)

NL80211_CMD_NEW_STATION
 ├─ NL80211_ATTR_IFINDEX
 ├─ NL80211_ATTR_MAC
 ├─ NL80211_ATTR_GENERATION
 └─ NL80211_ATTR_STA_INFO
      ├─ <aggregated station attributes>
      └─ ...

Note: No NL80211_ATTR_MLO_LINKS is included in this phase.
Per-link stats are sent in Phase 1.

Per-Link Stats (Phase 1) - one message per link

NL80211_CMD_NEW_STATION
  ├─ NL80211_ATTR_IFINDEX
  ├─ NL80211_ATTR_MAC  (MLO MAC)
  ├─ NL80211_ATTR_GENERATION
  └─ NL80211_ATTR_STA_INFO (empty - present for parser compat)
       └─ NL80211_ATTR_MLO_LINKS
            └─ [linkN]
                 ├─ NL80211_ATTR_MLO_LINK_ID = N
                 ├─ NL80211_ATTR_MAC = <linkN MAC>
                 └─ NL80211_ATTR_STA_INFO
                      ├─ NL80211_STA_INFO_RX_BYTES
                      ├─ NL80211_STA_INFO_TX_BYTES
                      └─ ... more linkN stats ..

Testing:
  - Verified using "iw station dump" on a 3-link MLO station
  - iw requires some updates to parse fragmented per-link stats
    (e.g., NL80211_ATTR_MLO_LINKS handling). Those changes will be
    submitted separately.

Sample station dump output:

Single link EHT STA:
~~~~~~~~~~~~~~~~~~~

Station ff:ff:ff:0f:f8:64 (on wlan0)
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        inactive time:  182068 ms
        rx bytes:       1567
        rx packets:     15
        tx bytes:       1083
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   0
        signal:         -30 dBm
        signal avg:     -27 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    3136 us
        rx bitrate:     1441.3 MBit/s 80MHz EHT-MCS 7 EHT-NSS 4 EHT-GI 0
        rx duration:    0 us
        last ack signal:-31 dBm
        avg ack signal: -31 dBm
        DTIM period:    2
        beacon interval:100
        connected time: 185 seconds
        associated at [boottime]:       157.326s
        associated at:  157326 ms
        current time:   342408 ms

        Link 0:
                address: ff:ff:ff:0f:f8:64
                inactive time:  182068 ms
                rx bytes:       1567
                rx packets:     15
                tx bytes:       1083
                tx packets:     6
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -30 dBm
                signal avg:     -29 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    1568 us
                rx duration:    0 us
                last ack signal:-31 dBm
                avg ack signal: -31 dBm
                DTIM period:    2
                beacon interval:100

3 link MLO EHT STA:
~~~~~~~~~~~~~~~~~~

Station ff:ff:ff:ff:5f:23 (on wlan0)
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        inactive time:  173476 ms
        rx bytes:       1036
        rx packets:     9
        tx bytes:       1694
        tx packets:     6
        tx retries:     1
        tx failed:      1
        rx drop misc:   0
        signal:         -20 dBm
        signal avg:     -22 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    2476 us
        rx duration:    0 us
        last ack signal:-22 dBm
        avg ack signal: -22 dBm
        DTIM period:    2
        beacon interval:100
        connected time: 174 seconds
        associated at [boottime]:       168.236s
        associated at:  168236 ms
        current time:   342412 ms

        Link 0:
                address: ff:ff:ff:ff:5f:23
                inactive time:  173476 ms
                rx bytes:       138
                rx packets:     3
                tx bytes:       0
                tx packets:     0
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -27 dBm
                signal avg:     -28 dBm
                tx duration:    0 us
                rx duration:    0 us
                DTIM period:    2
                beacon interval:100
        Link 1:
                address: ff:ff:ff:ff:5f:24
                inactive time:  173976 ms
                rx bytes:       898
                rx packets:     6
                tx bytes:       1694
                tx packets:     6
                tx retries:     0
                tx failed:      0
                rx drop misc:   0
                signal:         -20 dBm
                signal avg:     -22 dBm
                tx bitrate:     6.0 MBit/s
                tx duration:    2476 us
                rx bitrate:     6.0 MBit/s
                rx duration:    0 us
                last ack signal:-22 dBm
                avg ack signal: -22 dBm
                DTIM period:    2
                beacon interval:100
        Link 2:
                address: ff:ff:ff:ff:5f:25
                inactive time:  174188 ms
                rx bytes:       0
                rx packets:     0
                tx bytes:       0
                tx packets:     0
                tx retries:     1
                tx failed:      1
                rx drop misc:   0
                signal:         -30 dBm
                signal avg:     -31 dBm
                tx bitrate:     12.0 MBit/s
                tx duration:    1920 us
                rx duration:    0 us
                DTIM period:    2
                beacon interval:100

With HE AP and STA:
~~~~~~~~~~~~~~~~~~

Station ff:ff:ff:f1:f8:f4 (on wlan0)
        authorized:     yes
        authenticated:  yes
        associated:     yes
        preamble:       long
        WMM/WME:        yes
        MFP:            yes
        TDLS peer:      no
        inactive time:  10176 ms
        rx bytes:       968
        rx packets:     10
        tx bytes:       856
        tx packets:     6
        tx retries:     0
        tx failed:      0
        rx drop misc:   0
        signal:         -24 dBm
        signal avg:     -27 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    1300 us
        rx bitrate:     1297.1 MBit/s 80MHz HE-MCS 6 HE-NSS 4
        rx duration:    0 us
        last ack signal:-30 dBm
        avg ack signal: -30 dBm
        DTIM period:    2
        beacon interval:100
        short slot time:yes
        connected time: 11 seconds
        associated at [boottime]:       69.552s
        associated at:  69530 ms
        current time:   80780 ms
---
v2:
    - In patch 1/5, Narrowed the scope: only drops the link stats from
      nl80211_send_station() (formerly also deleted nl80211_fill_link_station();
      that function is now moved to patch 4/5 and reused there). Also fix
      the nla_put_failure label indentation (spurious leading space).
    - In patch 2/5, Fix all nla_nest_start_noflag() calls in
      nl80211_send_station() for nested attribute types (STA_INFO,
      BSS_PARAM, TID_STATS, per-tid) to use nla_nest_start() so that
      NLA_F_NESTED is set correctly.
    - In patch 3/5, Drop nl80211_dump_station_cb wrapper struct and
      nl80211_send_accumulated_station() helper; store the context pointer
      directly at cb->args[2] following the nl80211_dump_wiphy pattern.
      Build the common netlink header inline in the dump loop instead of
      delegating to a helper. Add documentation explaining why
      memset(&ctx->sinfo) is required after cfg80211_sinfo_release_content()
      to prevent a double-free in nl80211_dump_station_done().
    - In patch 4/5, Restructure the dump loop around a switch statement so
      one netlink message is produced per iteration with header construction
      in a single place. Replace nl80211_send_link_station() helper with a
      leaner nl80211_put_link_station_payload() that only fills the
      NL80211_ATTR_MLO_LINKS nest, leaving header assembly to the caller.
      Fix all nla_nest_start_noflag() calls in nl80211_fill_link_station()
      to use nla_nest_start(). Fix the AGGREGATED phase to propagate the
      real error from nl80211_put_sta_info_common() instead of returning
      skb->len, which would cause an infinite re-invocation loop on
      -EMSGSIZE. Use __free(kfree) for attrbuf to avoid scattered manual
      kfree() calls.
    - In patch 5/5, Rename local mac_addr pointer to mac to avoid shadowing
      the outer ctx->mac_addr field. Set cb->args[2] = 0 on the MAC
      validation error path to prevent nl80211_dump_station_done() from
      attempting to free a partially initialised context.
---

P Praneesh (5):
  wifi: cfg80211: Drop unused link stats handling in
    nl80211_send_station()
  wifi: cfg80211: Add helper to pack station-level STA_INFO
  wifi: cfg80211: Refactor nl80211_dump_station() to prepare for
    per-link stats
  wifi: cfg80211: Fragment per-link station stats in
    nl80211_dump_station()
  wifi: cfg80211: support MAC address filtering in station dump for link
    stats

 include/uapi/linux/nl80211.h |  19 ++
 net/wireless/nl80211.c       | 402 ++++++++++++++++++++++++-----------
 2 files changed, 297 insertions(+), 124 deletions(-)


base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.43.0


