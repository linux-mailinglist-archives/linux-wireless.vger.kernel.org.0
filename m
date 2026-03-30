Return-Path: <linux-wireless+bounces-34193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDGqObLfymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:40:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49862361094
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEC1302A537
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0416373C1E;
	Mon, 30 Mar 2026 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fv7oSYJ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsbK9+Sf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541C33D4E9
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903159; cv=none; b=MKJia7ybPFR/4FEuDR7xAxkO+Jxt7yPNij8QIyPN5Ig0YN/8gauCL9pezzm2ZdWttWef1dkoXMWNJhrklxRf1a7LkGPDOCF1r2gwC94dpLkmRj13YvHyWw4Vxr9Gb5WQ3zefYRAOj5SGHXGYRMXXeWSXnq10Jlwii+twHhleUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903159; c=relaxed/simple;
	bh=RBM74awl7F+jck5gUr4QiFYYj0CQwMI2sS4425BBhGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oj2U59EtbguD2zl30hZOQbeDmlTurppSv/Qmt1M4lGbCkJwVXN0vW5Gz/+6zRse37ENqDOyy6nCzdtfyQ1PU6uf5PrbhxJGAd163eWrJEo8PGVXwrNPmUMY1Bkw3Vf1HlfxIqbBbsmYL84mMSD9T2ARHH+cPfwDbJKSBON7RCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fv7oSYJ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsbK9+Sf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UIWNKM703510
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=j38a35G67aNiYuFO4syzf5
	Rj5+1OXxDU3StCqGCqLKI=; b=Fv7oSYJ81D81LYlOITs3d988zFkREgiMaolNIg
	RtMbK88VUw2xvp6RmZOMV7zF/mQQA7ibIqXm1XDQW4GhzTlWAw+A4DfXayW4mpIK
	QtRZX4kUvAB6VYbuq0q7OE6p0/OhQCG3XfMXqAcBBmZgIp2oWSsEaMh4hnqtgQAb
	iJ+aB+Rk7BPB8W65WnNonttNwjQikbQt6bdhJnxxWntqbrzCG/4nttziYVpcxdRM
	EwGYIwE1gdj+R2kZlEDPsqastipx91/NxTP4mK5IeHQXoTyMPrPZABdta//eMUB0
	dc2iOZucHmYaFMcbBAW1qC4G20JrXC2rDNd81exNsQ9iau4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7sansv6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0f4e632caso46495905ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903156; x=1775507956; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j38a35G67aNiYuFO4syzf5Rj5+1OXxDU3StCqGCqLKI=;
        b=BsbK9+Sfzs9B8a5kZg3jT4g+8EOM4AkRtL51PPgSTlAutU+xRhEWgYlfubYo5S7MrL
         lP6tS3gNCwyTmN+hCHBC2DWg56BSdxG/si0NQZp05QA5JKmMikA3nSs4OYE05rFi1a58
         R/wMUi36/ch3LzZRs2MVRMVSW51CFGNhgwlWoCCUi8NrZpP5p/PTGi1+sj92NsqEnYRH
         pbsvYYWgh4bG+dcbqJsi5UawTUKeCxyT4TK/MlZ5Xu1aNVbmDHMNRqZPHN/Ek1W5MS4h
         pk5+OxgNgTo/wVt18Y/oM5rJKgR61zXP0PIXE9Sln9O12QSLeqZ41kJLeI90Uqqe6uRL
         D4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903156; x=1775507956;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j38a35G67aNiYuFO4syzf5Rj5+1OXxDU3StCqGCqLKI=;
        b=MLWLEjkTAtjnJ7Y7LaTFiKZKkkeNjTigFkeV214dXHmhDm9R+3JEsLlIggtx/+tNz/
         55Ogqie/q6Vg6oO/W2b8sqDQeYGiMwaWBb1vG5HqJ0/F33/c3EDejhb/hlvckfgqdWZV
         HmgVAbjoIDMLT4pnJ5OBIIn4/h7SEB9flsFvO3VwzPJF8TuTJdiC2uRfHjoIASWO+no6
         6EbIdrnT/uP8Zj5LxOCyUXbWK8s2Yn5DMCKSVbuqvSB6m98BTOk+jasNFw4xPACza/CT
         xAu3Isfhvo06V7fzWoKmbkCUBgsqlIzt4XU0BpeQi+MbiHVhXztuCoAKjTrzlYbIp3lZ
         UvvA==
X-Gm-Message-State: AOJu0Yz7b1jbiP+wyVlAU1htzPECUQVIFq5xluQQ212GBaxTgAOX7jaI
	Wb76ZDA3UG4V12+MIgFnSrz86Dt5oaCsaC2CEba9hiLtcHU5Kf1ehmp51LUxi31/9hSAihtrCtS
	OajA/Dw0kOLFKEnFpm9qjrBpR7pxX60nTLAVdYr0pOMiBZii4tE+XDfkRIdSIqgCP9j2GTg==
X-Gm-Gg: ATEYQzwuoZiubxMQZy6Wx+r4GVx0+gB63o2U416Coj+aps84S2C0KIpb2h2Dht5BR/J
	wO0W8tuYkA9nD5zjL2+iLoGvZtSFeatCYx+bUl8nbrdoEbiluFXUodUGjiZs07FOMPrLBtMilT4
	LQN7jqDJJJxNXs9YEUbE25XdxwB1xonD2kG9mff9uwfNUy9S/EkoEqy/skzDwZJsUITmTKzyCqA
	3xp6d2pGkGqN6LqwVUxPNWmXP8sHlrnHd21hE8uwEgrm5GY4Ga+3FA1XHEQYl6pAr3FKyVGr14n
	63pnZyL48Q7XZEbGqF6m96cm/zgQp0Ay4tpFI+C4DlaxqqxIuu83ZQvyu10eD8oHeSdAKyXUatf
	/3G9UjzzNSVeGCoY5UTPL5Y4sgtFXng2C9qr1ccpJEVJQgDshySXJ0d6ylya2WkbfK2O3cexgXv
	NmExXW06661TFkntEwFBaZ6YAv4XF/fqjB29YB/jE=
X-Received: by 2002:a17:903:240c:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2b0cdcba093mr134968785ad.37.1774903156252;
        Mon, 30 Mar 2026 13:39:16 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2b0cdcba093mr134968535ad.37.1774903155765;
        Mon, 30 Mar 2026 13:39:15 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:15 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Subject: [PATCH ath-next v3 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
Date: Tue, 31 Mar 2026 02:09:05 +0530
Message-Id: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnfymkC/yWMQQ6CMBREr0Jm7U+grTV6FcOitF/5mlRsqyEh3
 J2Ky5eZ9xZkTsIZl2ZB4q9kecUK+tDAjy7emSRUhmqVbbXuyJWxU0+S6X00ypAPYbDaGevOJ1R
 pSnyTeQ9eUb8UeS7o/0v+DA/25dfDum5aiqeUfAAAAA==
X-Change-ID: 20260331-ath12k-ipq5424-cddb63a46a97
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: s9lTJAol2TZqPuoVyhNXecOEtq2hztho
X-Proofpoint-ORIG-GUID: s9lTJAol2TZqPuoVyhNXecOEtq2hztho
X-Authority-Analysis: v=2.4 cv=NofcssdJ c=1 sm=1 tr=0 ts=69cadf75 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gShIAut8tMQcv_q5NMcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX5A4SaG0W+nuS
 VurMUGOwhuxWq+NPgtOlIvCcpNsqT4rfBePqsnTnElixgcPn+94294PJu/WkB5dDVYhgRJ4MS4V
 IwIYQn82wn/AJG8BnNkhazVwfG+zOqGHZhSeV9neYlAStcvIKIdan7JrDKJttikYOB2upFqVAH2
 xkNNiST89dsRgSF/nIqL6O4JdTjL/+cYXA145VwyGpEW6IAETL+SBOQSm+faXBhJKJICJhKnONR
 0R+cVED4R/pfLQMyn5Gl3iNgnYtfBAZEmnUR8dJnyGgn3i1qgZT0omlI9W86qaEkTumnXeW0yau
 M+pcKa3/fwA7IyN7LSocbdX4KtUTMyZD5f49vdDZvhAQ31RdZqk9Ew8PfixtlQ5ViGw4SNpL1Vx
 KN5lsH1jxnAkkT2RPenLzzIqH3xo/W29JZ/r4nWGIwa/axuVuDGJDWYdLSSM6B9ejW8s/9mYV3F
 DM+Tu+57z/0RQ/dhW/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34193-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49862361094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the new ath12k AHB device IPQ5424, as currently, Ath12k
AHB only supports IPQ5332 WiFi devices.

The IPQ5424 is an IEEE 802.11be 2 GHz WiFi device, supporting 4x4
configurations. To enable the IPQ5424 device:
- Add the necessary hardware parameters for IPQ5424.
- Modify the boot-up sequence for ath12k AHB to accommodate the
  requirements of the IPQ5424 device.

---
Changes in v3:
- DT binding: updated copyright.
- DT binding: Dropped Acked-by tag as copyright is updated.
- Rebased on latest ToT.
- Dropped ath12k_ahb_ops because qcom_mdt_load() and
  qcom_mdt_load_no_init() now have different number of arguments.
- Link to v2: https://lore.kernel.org/all/20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com/

Changes in v2:
- DT binding: Removed the redundant example for IPQ5424, as it is similar
  to IPQ5332.
- Added driver probe data structure to eliminate the redundant switch-case
  logic in the ath12k_ahb_probe() function.
- Validation completed, hence changed from RFC to PATCH.
- Link to v1: https://lore.kernel.org/all/20250130051838.1924079-1-quic_rajkbhag@quicinc.com/

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

---
Raj Kumar Bhagat (2):
      dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424

Saravanakumar Duraisamy (3):
      wifi: ath12k: Add ath12k_hw_params for IPQ5424
      wifi: ath12k: add ath12k_hw_regs for IPQ5424
      wifi: ath12k: Add CE remap hardware parameters for IPQ5424

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Enable IPQ5424 WiFi device support

 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  3 +-
 drivers/net/wireless/ath/ath12k/ahb.c              | 36 +++++----
 drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
 drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
 drivers/net/wireless/ath/ath12k/core.h             |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 93 +++++++++++++++++++++-
 11 files changed, 232 insertions(+), 22 deletions(-)
---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260331-ath12k-ipq5424-cddb63a46a97


