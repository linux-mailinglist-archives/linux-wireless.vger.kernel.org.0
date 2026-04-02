Return-Path: <linux-wireless+bounces-34300-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MxyUMWzozWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34300-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:54:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD6383444
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ADD0303A197
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E22227B94;
	Thu,  2 Apr 2026 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iF0xJUpE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OvE9Lfgk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628583264D2
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102058; cv=none; b=CEF3ozTnWhg0AAeo6FmwfQRdb/qPVHy0BGydAL74qXlWXyud0mcuu1ljfh8DtrRkEkv+cY+o8AwfOwkqsUMoiwNz9qAVAmURWo0l1CNcV3d1ZkALl/v80Tk4R0UHAFjLGCuIcdEYtJPgE/i6q00Lf8ihjE9Dizo9WZBP/r6mriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102058; c=relaxed/simple;
	bh=0yGPmguvPqcmAuI1dBu0bsIItGxwXkpDtxOYuGehWlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gw7b+Ydr/Kl9QPOCos6KGdUaPxB6ii58IL1DnCwicZLIx5iu+bzaB1cWaVoZ1VuuTJb11tJ4ovvaQFcbKq0llms2DlPBKVhb5Ql5jxuw6O/L2VRRyC+AmewxXXrKvLhXdDWzKeLC9p/Ah+mnL2i4BZgjKX2Qu4U7UkX2xdUA3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iF0xJUpE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OvE9Lfgk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M473O1964872
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ri51iB5cXCkdkK8wdR2vo1
	E/J9EV+x74w3mmVibn3Jo=; b=iF0xJUpEvDHikaWs8n4gMtIdEJP8ySAMHgVEnC
	tqj/8zW9yOC0+VWjlM2AOLaYnNFASRIspQzijFjC8E4L9Avkg12xdmUpsnYLVvf9
	aPVGpf8uHHQdOYUOMcaYnMNXzeiRYRaY/JS5u5tUU0h3Qm3nAcIoj+SzugZ2uFDH
	RT9PHPjzfIjMo5WInv4flxF3giAI8fJlAl18TQFbTMeL841YDz+E46bFDQXMy7LU
	DTzWz948pZUOHlVxnPQzn8EjjcILx/xSzs3rn5gQ+EJ/AXvPCNdNKEyhkHQ/OXwO
	eJFHRQut/3XHh4I3n4ZDz6teE88TsDcISw0GqQmybj3OFLsg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h1225-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so704084b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102056; x=1775706856; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri51iB5cXCkdkK8wdR2vo1E/J9EV+x74w3mmVibn3Jo=;
        b=OvE9LfgkPOR0buIXJo33eiAXmEZTBsDoKKYCd8I7eziKRJWCHiY7Pr6Be92gL+Ejdb
         SHM3fxcNnPtCPpwMxbt7qpoq+WtlS4oFso9Y9bjBit6eEfgIiPxoU2GxdU1Ctem0hrnN
         Jr8HQ1mN2yS6Oek1K0jI8g+Fuuo21WNkGGLCVbIX4g2xU57xszton9kVevLCSWGJUBsF
         /UFVEMBt3xsYuPRbwjz4BKCScorYfQyVOG2WTCr9lNDtUHGypKBLceIRPLfxL8dzUPRH
         gf2dDkwe/I5eg99uQHrGynoKfkA2lefysOe8emYVrg8S5FUin3eMnFUiTIv24vQ2M4z8
         xhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102056; x=1775706856;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri51iB5cXCkdkK8wdR2vo1E/J9EV+x74w3mmVibn3Jo=;
        b=L0U+k4wV7HSBv57hJDDroV9VqkH91nIrqcfDjwWnsUHGHPIP/Mu6kTvUfsh8WIX7Oj
         Y/S85OmlghEGFBMc98Lk5lI55E0FNmZrhpuPgm0qfefBxIpsnsIo5qx9ps8oP3wvG5Xm
         C+zajSUrVWeNG+meh59w6OS3EybdDCPn03OPqVXESf5tI94kVsqOhIE1FJR+MEQZ8BVD
         ySMtgLPmXcJZ1sIz1PPX0gyn4mp/RWDMeTFIOLRPVZFbkMo3js37f0BzOXTF8cSEbQzD
         p6Zj5ke/ADy2njzYIYSG6YNsivG4JDonuh/0yGRsMucSzh+tpU2xx/MmBsSf4VKbEl3c
         QLRA==
X-Gm-Message-State: AOJu0Yw9ErKGr7uUqPzKzjZ8uEWmQuSuf1+f9FRTyxwGv2pLS2OXdFSL
	9rQ10FXP9Y7em/+7x/f7P4BeoQjhzejlSO8UZH1Tp0BZQI069FI228A0/SmVfsRzpD9YWOryUsj
	NVOF4iyPBFD2HlheoR2PJIF1LGf4srZ/HVb6CpKuMMTMkUYs6GRVdv1vR7CeoJWrp13oNvg==
X-Gm-Gg: ATEYQzzlyZbLL05wLcJHkK/6zSvxR3UFgejDu0dQj0/aCyn4B7Q+znnHvRdZ1Zp/GZU
	3WVbbWHgJfocUbW08DYtQBTVEctw9T3InLK/taM56u25WEhrOxMR1TEDorzMHxM1EpF6E6XQleQ
	oa3JfeZSXH31jI95cLDxThoPxWMoMvVBypSFe2OxZQNRZ6PVB6r8zc9gx3iZi+fY25TFoXGeZye
	Hc/piNxam99jIFCqDrtUj5aXBWFClKKK4NNGOHuCwrsKzRJ2aJnLxfBKSLBxbNnPg2OlNXyBG0y
	/5J7+KIA7njGdcdqVUdCIvTcKNT3cHI1t59nzPI1fsLNwP/c9GsniL3SNikU+mYmZTw3drbcTBd
	AcBQfVNVVJV2a0y2afUg2mK0GWNIhfaok3wZ8sO8mRT0V3kkAxQUYxhSNJTAjGAxV5BDopP6obc
	eu9gPZG9CnVG1+AVTVCclejNTYWvOir1E1ACCI/BU=
X-Received: by 2002:a05:6a00:984:b0:829:86aa:e163 with SMTP id d2e1a72fcca58-82ce8931fb8mr7170793b3a.13.1775102055937;
        Wed, 01 Apr 2026 20:54:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:984:b0:829:86aa:e163 with SMTP id d2e1a72fcca58-82ce8931fb8mr7170424b3a.13.1775102045792;
        Wed, 01 Apr 2026 20:54:05 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:05 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Subject: [PATCH ath-next v4 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
Date: Thu, 02 Apr 2026 09:23:58 +0530
Message-Id: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbozWkC/3WNQQ6CMBREr0L+2hJoCwZX3sOwKOUrVWmhvxAM4
 e4WXLuZZDJvZlYg9AYJLskKHmdDxtlo5CkB3Sn7QGba6IFnvMyEyJkKXc5fzAxjIblkum2bUih
 ZquoMsTR4vJvlGLxBZJnFJUD9S2hqnqjDvreznaHg/Of4nsXR+HczC5axXBZFU2mFvNJXR5SOk
 3pr1/dpFKi3bfsC2Mm8Cc8AAAA=
X-Change-ID: 20260331-ath12k-ipq5424-cddb63a46a97
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69cde868 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=hcgyll2ojUKJi-iaWUgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Qlt3C-q6L3UhUCrUwbILbSsHhKhP_ziB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX0NqWp9mkiA6n
 ApTGoRcCjfMY0hQkfL/18K4Q5tUJndmPDtT5luMoyBfPNK/H5u9TT9I8WX2S0WcxQ5RJ6RS3rJ8
 /kRZ3UnKCiJl+BeDhpcpKKsUJ67bFmFl/9bzS6ZX8lHtklnjy/CWXXKQHX8348H2jUAq3AkdMkp
 asp+DvnQk+SJB2mBWtKmRM24Aj06Tbmhe8q8bpHaI309isvxd7Owheh/izUfM/Gt1vzSDfhqJwV
 gTlfqpU8J0m/2ldy6jRBJeSV0eY9CDQwYqij6dfD4QNxH1jdcHwktUZmYBZ8QAoCnTVZI+IF9ND
 CNYmcxi2eXQr/tL/n15Cu29fZNAIfwvDxa5CmZZD8ApApy0/SWwWDg4WiAnzWehxztDXFXQlIYT
 w8v8ZDkeUfYYD4Orq2z92xnUkfMewf7pgx+b3NEMcJLsyAPjFngTTiALhbROqfS4T84mcVmv6Un
 S3281fDbOt2k6J1PeZQ==
X-Proofpoint-GUID: Qlt3C-q6L3UhUCrUwbILbSsHhKhP_ziB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34300-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62AD6383444
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
Changes in v4:
- DT binding: dropped copyright update as per discussion in v3.
- DT binding: Used DT binding from v2 and retained Acked-by tag.
- Link to v3: https://patch.msgid.link/20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com

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

 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
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
 11 files changed, 231 insertions(+), 21 deletions(-)
---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260331-ath12k-ipq5424-cddb63a46a97


