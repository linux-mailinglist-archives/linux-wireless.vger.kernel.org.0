Return-Path: <linux-wireless+bounces-24069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CACAD6FC9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BD017845C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0F135A53;
	Thu, 12 Jun 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="offU85YL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45C2F432A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730295; cv=none; b=VZoiLIbVAVLwGyd7nyuRYLstsyhHnq5WGjXLKqNUiq2EYXfCwxI7PFDmGk1FbjhJUx6JrSo6CS5NdBDbO8vT/BosecQQCJ7NjDrzB1QF8MlK7flF2NkdIfqXfZo9h6qmvuQZoP27RsSFAsW8706vnXi9n0VATTRp4iOuXJtn/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730295; c=relaxed/simple;
	bh=VojDJuzLvYY3RxtvAwaLNqTgzo4hUJJXqBWH07RBYcs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ewHbALzugl3VActp+jgNhPf/ruLH/HLITm13tn9O1g6hemQjPrrEXflL728uOTug/JSu8U6T994WJdRR6NZ+HwqJ9vCYYkRorgNmF2+QDHjhTUWd66Er/W/O2FnRSbfLB5oqhtk8mTxDI+RWZa2C9ifU9MnDMTy2w5ReLgJO6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=offU85YL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8ZOmW027950
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=8hbxBgPw4llG
	Sj6u438WPs5d5qRst+fKboTxqi1QmWI=; b=offU85YLEg6KcmPH54Jpk1dz0XvI
	+oYN1c7uQ9SPb0JEA2hQWH48s4mz1gmTz9w8k1LrO3azpApHF91MUz3D79xtFq5D
	PywSPJtL3fczknakS9RxKGBTnIKcYWUKU/yf4RoQ4sgiVALWeCr2DL0zoK7X7ORJ
	SL+lFLqLHLsFzxI118S3qMh5QTsRaOfogaELvERADiFVgIIaXX7wXTbqpcToiqrn
	z9o1doeqxtmO5VRwtDB4UrkIrEcDxgAm6jAZ1bCIT3wTyVEyRtG9w1fs3PpX1Rd4
	xvmwNYLqFsBMr23iENHeHrZ6iATslvX67ktvKLYI6yYXuM8ofRwy7Noj6w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvgbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747fa83d81dso817000b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 05:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730292; x=1750335092;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hbxBgPw4llGSj6u438WPs5d5qRst+fKboTxqi1QmWI=;
        b=H9uy2/BaSw+z11BBDaBzOwPvrHRHrkesq8yl2APKm6NLAW1dnZCG5fsJ/zjkkz16O+
         FOWc5cVgXiyzQXBy+M+grLbNx4z0fFll2Mn6RihR3PKxDse3bpo0+Id8YjYT9eSCoAZb
         Jt3dNonN3Bz8dkVkd3z44prDPj3iGprQjMkWDNSSHmttd/WsDS25Xs47b3Pvn1KuNJqh
         nfjbNDdWyKZ8h9EoMzr3wDZunBc31s/6gMmo0+F2MQoOJUzry8EbuzEjOYmObWZxE8Dn
         MXBm2SlqwtxrsZ14ZvydMPVb/sJ1DHMeD9o/Uod6nCiXQltEu3ox3/xm6I7lWbr3pBMR
         FP4w==
X-Gm-Message-State: AOJu0Yx56+OaG+bq9BQ3KUhRW2gDH/otDUjUDVDDZMR/XZ2X2Nub9N1g
	RaRNCm3pwmPjyBhEJSVUDqocnvpCPpT6XEokcVlB9fljrJE0f72fB4gZbHf+fUwcchmSJkikYc4
	Z2I4dk3QVBLZ1cOT6sx066dX3XqVwg/Q/5o3kwjDMDU0YO17dtMuyb2OIbBN369A5YA2cXw==
X-Gm-Gg: ASbGncvhpFq6NLmZQrp0nEY76qASiyntdaNlFZDm2l5YtSDJu4+nzZNBTp2QuEp1Szb
	4UjL6wZD+5p2bW04uzXPHbVsjNPUZSFA8i70KJ/Kh11rWPS5HpFfsVAiXqplecjSK2MYdgp1dNy
	fNOL24Qpog27WiMHRe97gH3hEbDuqss50qgFU763s0b9SCdBpAG3vcNm6g598PHKhKfmDodLo9t
	YJzHd81v6QLhV2uvEHJ+rFFclVyOeABIL/NPvO+uceGeuwwBQTeqL/Rnb/9XXoqxtVoqT4lO9qY
	YS/r2Jjn2tleXMapX1WK7LKGb1Zwez8Hn1yL448nW1PJ0WuS5tbDqQil8NgHgvSgqe/dUEHm7SC
	7i0b4FSCzIMKFEpNpv7IqhhkQ5i5oYsVLhGcx7rFfKrpbHRkVbuM3yIZw
X-Received: by 2002:a05:6a21:398c:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-21f978de4b6mr5311034637.38.1749730292165;
        Thu, 12 Jun 2025 05:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDtG3c+rqcvtaC6ScBrjDxuhoRS/0QoCgnBtJrJQxY9Ajx0+VXFaLooqsbWIhdjwg0dNtEhQ==
X-Received: by 2002:a05:6a21:398c:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-21f978de4b6mr5310991637.38.1749730291623;
        Thu, 12 Jun 2025 05:11:31 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd6376366sm1189405a12.68.2025.06.12.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 05:11:31 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 0/2] wifi: mac80211: Fix Rx packet handling in multi-radio devices
Date: Thu, 12 Jun 2025 17:41:25 +0530
Message-Id: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: qiiym5wb5ZdiUwljmWVPhg-dpqFofCwX
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=684ac3f5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=FYtan9AznsI-kIebVFUA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: qiiym5wb5ZdiUwljmWVPhg-dpqFofCwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA5MyBTYWx0ZWRfX/9eO82d3ovjq
 U3Drai+G+3HBLkgfofju+VPTVpkbBfu3y1DApw0DkwYIdVfYSkwRvNOS6UqVvJsLQipdfQNqynH
 KXvgKkG3xpn3cmxDuxUw4ocg43XEtmM5Ckuejh3bxcdWT3a0069LnuuDXe5xPaHwPLM98srew8E
 YGGradcaH3Ha47yz7yLOvvanyjk/pmO94E/PxWVYDtrIgTg3gIrdBp9MmqOouRfovGjENDjRMQM
 I8og2scklsfj2yssLH0sxeTEzelSP8Arn20ZDxwzAsrSCQ3ZLjgUVMHDI7Y4yo2WmC4moKhqc8x
 E72+yHQaqlDLtLIubKCFwCRlV0hoITNZ1N9vdfIDNKuxGHl+Bt71Mmelk02M1dTWXCAVNHdRGG9
 e62EOMuv8OjDw9Ew51sjreWxYVm088ltxnnYZV0UuEG96uJ+NlQkiLtPi4rvW/gns0VUraES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120093
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

This patch series addresses issues related to the handling of Rx group
addressed data and management frames in multi-radio devices with ath12k
driver. These frames don't have the destination station information, unlike
unicast Rx frames, and are forwarded to all the active sdata of the device.

This happens because currently there is no check to ensure if the sdata is
running on the same band as the frames are received on before start
processing those frames.

The patches ensure that packets are correctly processed and forwarded only
to the appropriate interfaces by mandating the ieee80211_rx_status::freq
for group addressed data frames and check the operating frequency against
the rx_status->freq and forward to the appropriate interface when the
frequency matches.

v4: Addressed the kernel test robot reported failure.

v3: Changed from RFC to PATCH.

v2: Addressed Johannes's comments.
    * Changed to for_each_link_data() from for_each_set_bit()
    * Removed boolean variable and return with bool value.
    * Combined the if condition.

Maharaja Kennadyrajan (2):
  wifi: mac80211: update ieee80211_rx_status::freq documentation for
    multi-radio
  wifi: mac80211: process group addressed Rx data and mgmt packets on
    intended interface

 include/net/mac80211.h |  6 +++--
 net/mac80211/rx.c      | 50 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 10 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.17.1


