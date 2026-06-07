Return-Path: <linux-wireless+bounces-37465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i91fGaaxJWpXKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDB65126F
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Oa8SfcsT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="TFVD/Cv/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37465-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37465-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7DBC3002B47
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70382324B2C;
	Sun,  7 Jun 2026 17:59:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182531AA94
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 17:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855191; cv=none; b=gbGHOYFvgWzcC+tYvWbGQ8v8QAjvrqDINP12RTrREZthDGAtxS/rADEE5K/Ybmxm1rDCJnJzZTzJFHgX4W/dQN52TsoSUAa54kLUkEm59YWJZAtKVWg7L6BF81fH3VWQxYF6VSbxJqB6p77G4IMcFiXiSfkPzpcS3U+S5cNNcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855191; c=relaxed/simple;
	bh=e9gB7m0xVNdrpklnXnvsx/Nsjw69yHNeBF8zt499M1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZQhEIteHWkWTt8nP0dNzlPEse7va/NnjcZa2K2dKmvH1gtjT5vdVlJ1d678HgVFW3dBTJw0bgTGg1fAl8hoYTnY13/KYJCIpere4b7tR34Lwrsb00pWMZc3X+X0cIkWhkINpjswKLOf+TfY/22g8StiJSRLwoxNp9J24DpLz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oa8SfcsT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFVD/Cv/; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkDAp845819
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 17:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IIp0JgIJ7UwPVe1mRloaHo
	7yUoyak66S6LBfPJ02ors=; b=Oa8SfcsTFouf9Wp8eGDClO252L46ckRvhghCXR
	WnNqfElUAa7Y0VZKV0ifmWfCsEK8hAstBv6EyZOVcWf+628zBCRGqGHuXMO66NG3
	aeT82DjNA7JyQEHYR5KgcIv/qgoiOHho75C35VlYZ1xcxDLLZwgGrUIsHvAisBB2
	um/mJU4DqFYvLNIrI7lO9/6+8oK5gs29RyP8WI1jKZuPwT6m/tLm0tjgU7H1QHqt
	frzwVf9an9CCOa7Y+zvQyP939eFl0nCAvIVpboTF4IBm2Hir7hcDjyJDhBxCBIDU
	2WSCChjqhAxVSv0UJxApe+M63glfDuFopNzOLbzgorRDt6Tw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3mu5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 17:59:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8425a9979e1so2345901b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780855179; x=1781459979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIp0JgIJ7UwPVe1mRloaHo7yUoyak66S6LBfPJ02ors=;
        b=TFVD/Cv/aVPwA2v+FzyxDACxb2/R8zjyg7xI8r3qDK77RqV6hmUA2n4/oGvEnMqIhl
         ABNRoRXcUBXGjMmpw4LyDwwQypqNOmNHUrxPdyXbjrVX5zZ0dIxIFgHyruKKAK8ahz/V
         8B9lgZAm5F4CkubMqgq096ow0w5T6O93WcrGnuZbB76+XPaOK/TAqqfc8c850d+zDNub
         RA4rEyxVAfhg5tkMF6dd0l7ibNCX10IRwzKXSxAXctOCtOgJI2QEfU170tNt1f4F91Ac
         BlYI/3YcKAU8zgfL/UdtTXO+UVMmu8IwU6vnWeQGYxItO/Ht7HiXM2Ko2ko/cGsh0rfl
         sJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855179; x=1781459979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIp0JgIJ7UwPVe1mRloaHo7yUoyak66S6LBfPJ02ors=;
        b=eFGbujEWksZfWD/RE4Zb/9ZbfhN2PifWy+zsGGU+JG3Yot6B1q05FnJ7CxuF2M0BG2
         DBkDdY9uUCC/O6lK1qVCl8bjzdSakszYoHSPLbe9osgqw90LOAjiwjZpbV36bUOn/iFZ
         1xGZ7G2W/79d3IaZ4FlKq/7lcL7/2lj2o1XVAa1TUV0FRnz7fnWndBkSDHRaDoataRku
         bI4xxe1Th0xJmB6CPfZzLP7FP7y+BKY3Q/H6Knu+We4UTjK5SD0M1LHe14Pkdu3B2paD
         59x3mw9oahf3D15ME58gYN9bXhjs0tC7CNLpv+qUarVDtTkMc6SUBeFMkfnfYx4jTj2F
         Jkvw==
X-Gm-Message-State: AOJu0YzU+Xhgco1SKljPeS9rFJhqcZA4vMkUqun868rsYXpAymn8sNT6
	CKnVCoGE8G+4bgpRyBn8jQBzh/53EZyvClL55X6kW3ktO06HjC3Y541g1pTiE9hRImDbUmIV1v8
	U1aGQrNAg0Sk+aiKTj13fD6RxQNOTYHIAN6BgVGxw5WsHS2VsjkcN5bsqLo+MfreHDqADxrjun8
	Zryw==
X-Gm-Gg: Acq92OF4ueUWdPm2iFa/RzRN9ISbQftWJI9qLpvQ0d121odptzYqty4/doEOMxwEwOO
	G4GDutNUE69liITKt4XmdmFvRYKR/qWRN/lRCe9rfoccwuy2qgnKvVMNUekdyb/i9F9fkTUN4xb
	fyhRVJnFOGnUF8+H+ms8a+JE+KoQ/aXON1GqIABXaUP2YM71K9h6CRBeVGkfiIUHNHWB7p0HzVa
	Ux+bBNbiN284arJV3/IKhzpVymTt1MsrNBr99vqOE84KUjSbhKxgDh0sL2jesYtd3aYd+A3cTJO
	IDiEeq76PipvQfLXLXpCvDr2tXEIplpvoMeH0XQeqfuy/fnmTCneTBpLO/brV9aUmxh2HEVt0Rv
	8MULHbZ22clacg7SU4WjVAYZcD6DwrMW4t2bz7tXwTLLAQyxzS3qS4Ma0Hgn5ic/KdLIWMpg+CK
	UyOmTN3GM6cd+XFvv4A/ChwJ5bXTrM09Ti2AOcl3+mI7gu7Jv0mA==
X-Received: by 2002:a05:6a21:685:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3b4cd091965mr14581020637.46.1780855179032;
        Sun, 07 Jun 2026 10:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:685:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3b4cd091965mr14580998637.46.1780855178509;
        Sun, 07 Jun 2026 10:59:38 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm13078522a12.18.2026.06.07.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:59:37 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next 0/5] wifi: cfg80211: Add fragmented per-link station stats in MLO
Date: Sun,  7 Jun 2026 23:29:07 +0530
Message-ID: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4MCBTYWx0ZWRfXy+Ustn+oUWg/
 VftpGz/mj+Gl5TYNmpPQs/SPxLJrtEluhAUcZ8Fp7c7fgTeo/XrsEOKeRWTqo2PiASjVHo7iLyj
 TCeOAL29fD3sqISJil/yGRhuB0D3TpTSma0ZHDI8CqYCRYvj+V+4q4gXmHYuqrLiE3PtD2JsPYv
 OISNwDWqYLVs4KFXkviTfBTc6Dcu0tuOYQ3JDd57DOa5u6TbHrS6XnljGoR7+G5MSl3XPABWnLU
 cYsrWq/fhR9USubZ5EqHXvQwRhA15uE9ZlVPWuJDcFo6kIQJ/r3Y7v5zZt4yVvDDiip+wXdqkxA
 kJQqcdr5IG9nB2XSDRKLEWjaRztcwo+kZsVC5xTJWy+Om+2KskucagiAN0HmM2K7HIusaQxpBYr
 YQ74VsGt9mR5urtOpj3YijlhW3R1DgAEFnxOyAGtOKVJOF6AKkg+eJKfoAmBDOZaNGCnceKsfKC
 EODYK8CnRBtZpyIcLcg==
X-Proofpoint-ORIG-GUID: p41jKT8AWiCFoREq63PSRBzkEmhH7_99
X-Proofpoint-GUID: p41jKT8AWiCFoREq63PSRBzkEmhH7_99
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a25b18c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Svp6a0_rgz3mg1QtYSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37465-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60EDB65126F

This series introduces fragmentation support for Multi-Link Operation
(MLO) station statistics in nl80211.

The current nl80211_dump_station() implementation works well for legacy
(single-link) stations, but it does not scale for MLO peers. With
multiple links per station, dumping all per-link information in a single
netlink message can exceed size limits, resulting in -EMSGSIZE errors
and incomplete dumps.

With 802.11be (Wi‑Fi 7), a single station may have multiple links, each
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
Per‑link stats are sent in Phase 1.

Per-Link Stats (Phase 1)

NL80211_CMD_NEW_STATION
  ├─ NL80211_ATTR_IFINDEX
  ├─ NL80211_ATTR_MAC                 (MLO MAC)
  ├─ NL80211_ATTR_GENERATION
  └─ NL80211_ATTR_STA_INFO
       └─ NL80211_ATTR_MLO_LINKS
            ├─ [link0]
            │    ├─ NL80211_ATTR_MLO_LINK_ID = 0
            │    ├─ NL80211_ATTR_MAC = <link0 MAC>
            │    ├─ NL80211_STA_INFO_RX_BYTES
            │    ├─ NL80211_STA_INFO_TX_BYTES
            │    └─ ... more link0 stats ...
            │
            ├─ [link1]
            │    ├─ NL80211_ATTR_MLO_LINK_ID = 1
            │    ├─ NL80211_ATTR_MAC = <link1 MAC>
            │    ├─ NL80211_STA_INFO_RX_BYTES
            │    ├─ NL80211_STA_INFO_TX_BYTES
            │    └─ ... more link1 stats ...
            │
            └─ [link2]
                 ├─ NL80211_ATTR_MLO_LINK_ID = 2
                 ├─ NL80211_ATTR_MAC = <link2 MAC>
                 ├─ NL80211_STA_INFO_RX_BYTES
                 ├─ NL80211_STA_INFO_TX_BYTES
                 └─ ... more link2 stats ...


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

 include/uapi/linux/nl80211.h |  32 ++-
 net/wireless/nl80211.c       | 473 ++++++++++++++++++++++++++---------
 2 files changed, 392 insertions(+), 113 deletions(-)


base-commit: 4cc0cc0b297c17c2b106d6892bd13d9c32fe66ce
-- 
2.43.0


