Return-Path: <linux-wireless+bounces-25168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBDAFF883
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 07:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883675A41E1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5928467B;
	Thu, 10 Jul 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDQY2Snw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132C35958
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125683; cv=none; b=dpdlLUvWxO1vCArAfruVkJxx0d6KCIKhslMPHSWqLIWbCNjETiL1TrDBDdZeFz7s4Uf0bpCfTI93lm756JiGJcGWvblpdubdPrbHYnvWRF1mzxzu3TqFEGh2i2vuS9ji98aHTe91D0K0mkkqdatBsAcMkqVXfvTc7POv2dozBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125683; c=relaxed/simple;
	bh=mvZIts8B4Yr67O0UdJmaYEE5XA8JrdqL82iVA7D7HZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mAa4XX93OjbKpLSxFlUqU74hwinF4cqZxpO8c/RsaRsXQHETiqOpWXY0KwiekXXHZdYW3154y80DZjEOHsDf6+6WUqiGNlD/K+c+VFhTzYzQQsdp7KKMMU4edWptOAjcyFRhtAOM204TLLq47ttKyfPcA9azBRfhClgnRXEzOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDQY2Snw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0vjGU023127
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bIrjVST+P4OHo6l/rvg23B
	t2hUu0jOXrzeSHr1l+LOM=; b=aDQY2SnwK1k25PXgRRb6gE9oNlq05EbJeDIX1A
	obnofwyQFUFyVqWEXp/EJqgUgXQYD1GXf+8T/NqbZ9sjQMQtl47jQtx5RXChy/H5
	j8fE3WSMQAL8p+JxXvmopE0QTjuVj+PkE6Ixrt3113PcjglnlkTICG0RDMqhhRzW
	Ep76EXM68P7Qg1TbCqOUjALCdEtt+MBG3zyNehr3xgTpcAnpx/4AjYdYOlGVeqT+
	IJdpB6E2AAxlVqmh16zknsYjD03zeoGTq6H0dHswQCU6XSib38VKLW5QE4NvS/0y
	2/dc0olMe9Yy6Ji4fTLZWI3QkCJIqBwag0YDl1iesz0s3K/w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbekn7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 05:34:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso563424b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 22:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752125679; x=1752730479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIrjVST+P4OHo6l/rvg23Bt2hUu0jOXrzeSHr1l+LOM=;
        b=cr6uYxG6ZG/taFPs8utaoNJsca+EwyQ4cH8ehxUdjNHkRWhg/RgHsX8KLB2NQgSsqO
         DAAtFQPK71Yla5WOtsX4XvtOLd7eukk3JhMuvywnN0TsoGbZth8hHNWOnIlNBClenKcH
         hsx0/J38snHa5AX5jCBC5BG7FczniME1t87R7BtkJMzzMtugxX664196IZc8sIUFBewc
         h0fCpuQQpBwkiUaPYUu7wFP2kn2JkEYb/Nijwkjsmw2vdwVFKs1HPw6dANwf4KY3ACjn
         x/wNBqmkDk3TNyXcioce8uVoBr/DF828SENnzO+2l1oPilMN+ZnLvPReQw38M0zfPCtv
         QaZg==
X-Gm-Message-State: AOJu0YwGXuuu16xZFgwLcOkwMt9L0YmV07gmRIycW7xDGnYiezzQV6oZ
	Z7J2mjeqzyRaTomgAPldksPiVBCQoVr+zF1eLkdmDhx/TmmSENWEko5SfTiHABGhOYOf2GThxtS
	PN+Eg7FOj3FKI4MekqZIbsjwicuLf6d5RhqFEX/N2iefy3XBFXXrJVNYy2KYhJ+Ik/jR0ow==
X-Gm-Gg: ASbGncu1KJvKFb0zu/WpuERIlFzJbUAcnzeD2F7QOTydcNc3m3OZ8jb5kqs8iFDhsuq
	LvKBeCmSJT5hAD6n5hi3GJHQnm/Vk1Xf2A0HI02NkqRyFXxJ0lA1rTj96QOsQElJVgJYFVIQJe4
	o3A4zKLUL1bUqaIMz8gAzZUd3SqXGkfy+caSGDvNQVbtjHmyNE70d/2U0cHpKh7mZyN0SWkEhGv
	04W75h7sGKuBPEN2LptpJ3FBHnKI1me+zKrqfJHnB9YLYvq63bfiNtB8W5C/vjSmSqIyO683fl8
	3OUlJ++Mj/K48lJ/dZZnKeWonIlmSzaierE3i31eVX+0byUGsyglyxr5vK8Kmx/SZNOnnlEdGcU
	aCwJ+G3X92xmQwKxKVRQfQdETCJocBbs40xw5Mn1jZyWCqh8=
X-Received: by 2002:a05:6a20:3ca8:b0:220:689c:315c with SMTP id adf61e73a8af0-23003af6339mr2352054637.3.1752125679166;
        Wed, 09 Jul 2025 22:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Jtm115d2Fx9f48mUPoH/rzM6XBjf84mmoglbsbzGl+ptQ4J5rEMTNPi0phIoRFtvfvPPIA==
X-Received: by 2002:a05:6a20:3ca8:b0:220:689c:315c with SMTP id adf61e73a8af0-23003af6339mr2352007637.3.1752125678730;
        Wed, 09 Jul 2025 22:34:38 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0201sm1014043a12.31.2025.07.09.22.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:34:38 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211: parse and
 update unsolicited probe response template
Date: Thu, 10 Jul 2025 11:04:26 +0530
Message-Id: <20250710-update_unsol_bcast_probe_resp-v2-0-31aca39d3b30@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJQb2gC/43Oy2rDMBAF0F8JWldBT1vJqv9RitFj0ggcy9XYT
 kLwv1c2XWSR4m4GLjOcOw+CkCMgOe4eJMMUMaauBPG2I/5suy+gMZRMBBOaVVzQsQ92gGbsMLW
 N8xaHps/JQZMBe+qNqU0FTleKkWL0GU7xtvof5BoztIBIO7gN5LOszxGHlO9r+8TXo98is1E0c
 cqoAx9AccGc1e8Jcf892tany2VfxlK/YjU7/AcLUgrp4WBr9wJbvp3E04eCbaGioNIbp07AgtH
 qD1Q+oXITlQuqlXJGem8Yf4HO8/wDopSvptcBAAA=
X-Change-ID: 20250612-update_unsol_bcast_probe_resp-c88786eb5640
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NSBTYWx0ZWRfX7c49ppx8iW/9
 XtcSfO6owyUuNJym6khPiu1uZ1j6lLH6h/y86qoFKA4Mvcyaho1+Ivz8jIMx6wPGGdcFcXKVucu
 ZoxsezgsE7jy4iaqnanwUnZzyADluXoz+g9COr7QJ0c/8rrW1onC+qtUP4VntGEbpjFeY8k1wti
 Bh0rj3Dst+zuaVbxYwMGObNUu+EUqZV5EW6/xmWLR4O2QY8DRIRQmY0F7qPxxuIIbCRxvGNKxn3
 BSMj0e7GRcsi0BvTViY1eQwv0L7ak/jNsXdGSCKB5Yked/vQpcwTBFA8IAzMOoLogxrL8V7TXZJ
 L9xmzSIa3X22ZLvu3xBAOXWezDqsrW4BNav2g2MLLOvzCcZxtLJscqR+vh1cEFnDpYcjt/UizrO
 0QWvElCiyiy0wj6DjulmA4G8M1HSXA7Lq+Jo+zcsF/xHbkrTpn+oueAIIY7nLNvcjUHiHgiv
X-Proofpoint-GUID: wTFh58W9HwFL4ghujoy_3zKweHh2j7Tu
X-Proofpoint-ORIG-GUID: wTFh58W9HwFL4ghujoy_3zKweHh2j7Tu
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=686f50f0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wscp-l6M08ckTL7hqVEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100045

Currently, during channel switch and color change events, the unsolicited
probe response templates are not updated accordingly.

This patch series introduces support for parsing the updated templates from
these events and setting the appropriate BSS changed flag, enabling drivers
to respond with the necessary actions.

---
Changes in v2:
- During CSA, add P2P interface check as well [1/2].
- No change in [2/2].
- Link to v1: https://lore.kernel.org/r/20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com

---
Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

 include/net/cfg80211.h |  4 ++++
 net/mac80211/cfg.c     | 12 ++++++++++++
 net/wireless/nl80211.c | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)
---
base-commit: 6b04716cdcac37bdbacde34def08bc6fdb5fc4e2
change-id: 20250612-update_unsol_bcast_probe_resp-c88786eb5640


