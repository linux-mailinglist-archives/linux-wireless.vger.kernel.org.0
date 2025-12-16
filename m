Return-Path: <linux-wireless+bounces-29774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B0CC125A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC13307FC26
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0A342534;
	Tue, 16 Dec 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6MMY0Zx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIW+9rdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEF342529
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866445; cv=none; b=roK8Z5EqQyAdYapgwPtoNCwLWI7DWXjm44uP7gBQE+oqYJvLCAnD9A6L0N60cIFUhh5WKhXJXQxVq5FhjuEb79Wn8pe2z8EhgEFXvdSnAsr8Ya074+aVWatgJDuGJN4TJzTG1YLV6GHNIGWN+95EMwYgw2Uml3HUSZG3Exw7O0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866445; c=relaxed/simple;
	bh=Sdau5XwEwwu40JGGAZdE0wRGF9t4OaAFTV4e4X6UUhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JwUbxUI2AxgSUnb+SpAyFEaBSh+rLeVUteBWRBy0YAZH0xY1Ha1XnkmAfFLDOqzH1PybJGjsEc/RfWRm6myDAvDhbsZwVmIMa0ki2HShlAtoP9I7J1bgJ2a87neO3z2gdadfqBnrib43smdLv1Vzcndoif8yZad6aUpiIunAFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6MMY0Zx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WIW+9rdL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG1pGa31396476
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9yRtVNvotwOm81nqTsUioBrQTDEgivMUyK9
	QrYaIlTI=; b=O6MMY0ZxoQBeL9dNCiTRdmGLZzrdXrY52tG8+/NqXGVau8nDmbl
	/QW/13T4RgxqpI6irJTHQ24a9vmYDl8xJrUjwMEWCOhRU2Kz9tNFX9B3zbu92kwf
	I0o7VmWToTpSya/ors+vyx5uw+LjcvhCy7ZOfjhCLftJHqBiHMOVUm96/nASfVu5
	sOb3fLw1pB3jRNE4B9BuwLWW0ZydiX2Vzos6yYDKwU9dwxoMDcOyvKrDLfyege4C
	ZZAleslpvSpAvUSmSDLf7X3t3xTqG0E0RyVbghLJnd5vefR1Md66OcAIntMJKO8H
	MC/VyQ2pbv+fTq58Q0UBCJcjzHuLPDiYI0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2nu1jkxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f4822f77so51014765ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866435; x=1766471235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yRtVNvotwOm81nqTsUioBrQTDEgivMUyK9QrYaIlTI=;
        b=WIW+9rdLchQZr3t/LpXAojiJkcVmqHgy12vwGi2ByIxwTP6hdKYgHpu1bZSPBThVu5
         iTr0UmDjZ+B5eLrklIshCZmoDehDxAv6urUGwwoeIrRzSukPyTbniWECATsgfeQ9AP2H
         V5jW2w6sItlJi/nUtMLbEvUMLXtlWqRL9Vm42kc/0cS7mbS5adihkG7fzxsu+64SEN1D
         xT+ribO2zITtf8vI8cRNrqZFCUR8hK612TS2NARKWyTJojvOVFq9frZdiTgmhoKHbOf6
         ya28+B5ovWqQG6c72UXlYi97tnVDuQuX88KPJu9/NzpG6gVVXr7kNzfmVwbZ2ivuE5rc
         lHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866435; x=1766471235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yRtVNvotwOm81nqTsUioBrQTDEgivMUyK9QrYaIlTI=;
        b=HZ4N0A7fCKZS+EWB/cTt0+gRlmHABOyPBSChgI00EtszOnYngextHK9FTWBa3egwiQ
         wk3QmKBT70x3vQYgdwjUQsaKjMEASbBy8pfkSjU/QOO68h7D0lyMwM1CBqyi6B+c3NUB
         QNXzKe7q+9sPBIs07+vOVPTM4L/NWqzYrqK19aR/FTYgY1xLZoBa/qucCAKlU6xhIbvb
         4pYAEuiLwb2HT+lVbQCinwGsuku/Sw+5l8F7fM2FaLoOIarUIxf7mOYU41AHe2RtZEQq
         0CRntthatGMC9UZJq/Flkhp41Qts/MrjpPD9AKXVZ+iiB3tgYYVcRv5afdgs3SI6zpbN
         ewzQ==
X-Gm-Message-State: AOJu0Yxis3pQQTPPwQXMJmqKW0eH28dCkCVjGUU3wpQ9zCbNzkL352Ct
	Lr61lYyoElz8kR+FvaNTtlSM13UtWU3mpTPuVUeC98XWKJ8cTMymG/AltbmpATmnGy7LiG0ioKR
	t77tlujXuj8N0Z8mdBngbCMpj0155lfMpb100RjLtTyg6PD2/IjnQvY7BOhAGhz8jL0tVkA==
X-Gm-Gg: AY/fxX4A8nuqiI5b4mjMcsMy9E0HgWF1ZT/b8otRfHvQ6G7gkYkIcgiOKfQuZKt7Ql5
	8vxISHVUfC3VxmlAaLzXrXpOpu0Rkmj66CHuBeh1F0UX6iILaJ+Wt7Gzt+vB0udJNVaqd9EKRtb
	r4tjzYt86r8sIHV1SGQbnOL37pg3PG5VJ0IynggifYPR/xN09gPoV/BKsBmcmkYX0WFIo6WO5kJ
	LqJY/pm+7dOTcJT8xlr/BGaQOhhawshX7No4YMHqFDkMHEakPBjhXtsV3VEPS5BPQQjl7c58zUa
	Oj0HHwaa2DaOv0QGT/9jWt2TyAGBjC3icCsFnSYt9C0c1jOfStobwDpM5iaAhc+kLpp59wibonD
	BBEhsWRVp8QoEDLPP1QEH9n/PyFsQ5H7Tc4arjCf04wVZ5xxrJz6T9Q==
X-Received: by 2002:a17:903:120f:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a0b62ee090mr77067505ad.38.1765866434761;
        Mon, 15 Dec 2025 22:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0ZG+taiBml2NcUWRO29VFmeVAelqH+Cetk+5JP1dyeVFSCLx1wS7xiRoZDOHkaDjX0yetSQ==
X-Received: by 2002:a17:903:120f:b0:2a0:b62e:e012 with SMTP id d9443c01a7336-2a0b62ee090mr77067265ad.38.1765866434268;
        Mon, 15 Dec 2025 22:27:14 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:13 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 00/13] wifi: ieee80211/cfg80211: Add UHR (802.11bn) Capability and Operation support
Date: Tue, 16 Dec 2025 11:56:43 +0530
Message-Id: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MNJFBXGSgvEPUo9rBQnXJNNK872faofk
X-Proofpoint-GUID: MNJFBXGSgvEPUo9rBQnXJNNK872faofk
X-Authority-Analysis: v=2.4 cv=AOuEbwt4 c=1 sm=1 tr=0 ts=6940fbc4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MUOQkJ1lgydsUBY8deoA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX/vV0Lvc+2BB3
 UJLzB0vPYlUKHiS1j1ccGpHs262QRksKPADtb95I7nRyarLoRDL6sXBMj77OarLZyFI+clsD4wz
 IEH+NqnjzUZzKAtMPv2zDUc5nMAdfoTYAKPsiwptF+rI3Wk9w4vEZxlGLhc4F1YQfHFZF2ujFyN
 KzMB1lwl0wmfI/ILoNU7xZf9NoD+rolheh9+6J8F/hDWPS0b1vCez93Q8Eytyc5nGcHL59RSrOu
 FFnETS4bJ1KzUJc62SecBZo3wUvrzb8F2FT+0dxlHVX67O1WMB1GwwlwS2mVlME911L42IELVSE
 WFKhpPlzAg3y/Z15X8Ie86gSPfVvJetNruTkkiWdVZHg1pioUDtcDHBzndxi8bW2qFj5HfAVT0u
 ybFB7o89672O67SCy8ycJ1ujt/ebeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

This series covers support for UHR capability and operation (11bn)
advertisement in AP and STA mode. The objective here is to give an
idea of basic changes needed for UHR in cfg80211/nl80211/mac80211.

The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.0.
There may be changes in the code to adopt upcoming 11bn spec changes.

Here are the high level summary,

cfg80211:

The below patches defines and declares UHR definitions and its
Capabilities,

  wifi: ieee80211: Add UHR (802.11bn) definitions
  wifi: cfg80211: Add data structures to capture UHR capabilities
  wifi: cfg80211: add an API to return the UHR interface capabilities
  wifi: cfg80211: Support configuration of station UHR capabilities
  wifi: nl80211: retrieve UHR related elements in AP mode
  wifi: nl80211/reg: add no-UHR regulatory flag
  wifi: cfg80211: support disabling UHR mode

mac80211:

The below patches handles MLME of UHR for AP and STA mode,

  wifi: mac80211: Support parsing UHR elements
  wifi: mac80211: Add UHR capabilities to association/probe request for
    STA mode
  wifi: mac80211: Handle station association response with UHR
  wifi: mac80211: set UHR support flag in AP mode

TODOs:
- DBE info on UHR MAC capabilities are yet to properly positioned
  expecting upcomming versions of spec will have details on that.

Validated below things in AP Mode:
1) AP mode bring up in 11bn
2) UHR Operation IE in Beacon advertisement
3) Probe and Assoc response with UHR Cap and Operation IEs

Validated below things in STA Mode:
1) STA candidate selection
2) STA association with UHR Caps
3) Probe and Assoc response with UHR Cap IEs

Pending testcase
1) Integrate with hostapd changes "[RFC PATCH] initial UHR support"
2) Disabling the 11bn code
3) Stats code testing
4) Channel switch in UHR mode
5) Other test cases may be covered in future

Karthikeyan Kathirvel (13):
  wifi: mac80211_hwsim: Add UHR capabilities in driver.
  wifi: cfg80211: support disabling UHR mode
  wifi: mac80211: set UHR support flag in AP mode
  wifi: mac80211: Handle station association response with UHR
  wifi: mac80211: Add UHR capabilities to association/probe request for STA mode
  wifi: mac80211: Support parsing UHR elements
  wifi: nl80211/reg: add no-UHR regulatory flag
  wifi: nl80211: retrieve UHR related elements in AP mode
  wifi: cfg80211: Support configuration of station UHR capabilities
  wifi: nl80211: reduce multiple deference of link_sta_params
  wifi: cfg80211: add an API to return the UHR interface capabilities
  wifi: cfg80211: Add data structures to capture UHR capabilities
  wifi: ieee80211: Add UHR (802.11bn) definitions
---
 include/linux/ieee80211.h              | 100 +++++++++++++++++++
 include/net/cfg80211.h                 |  49 +++++++++
 include/net/mac80211.h                 |  18 ++++
 include/uapi/linux/nl80211.h           |  29 ++++++
 net/mac80211/Makefile                  |   3 +-
 net/mac80211/cfg.c                     |   8 ++
 net/mac80211/ieee80211_i.h             |  14 +++
 net/mac80211/main.c                    |  12 ++-
 net/mac80211/mlme.c                    |  46 ++++++++-
 net/mac80211/parse.c                   |  11 +++
 net/mac80211/uhr.c                     |  33 +++++++
 net/mac80211/util.c                    |  44 ++++++++-
 net/wireless/nl80211.c                 |  86 ++++++++++++++--
 net/wireless/reg.c                     |   2 +
 20 files changed, 633 insertions(+), 15 deletions(-)
 create mode 100644 net/mac80211/uhr.c

base-commit: f9e788c5fd3a23edecd808ebb354e2cb1aef87c3
-- 
2.34.1


