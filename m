Return-Path: <linux-wireless+bounces-29861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EFCCA024
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4DA3019BD8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C326E6F0;
	Thu, 18 Dec 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkSSbHII";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aU0HGALm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974526F296
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022908; cv=none; b=iOQKEKpjPVxctxQc2nijRc/HFEpK4mJMsTccvW8g4R6EuTg9iXigT2KDwDySyhL3+S9hb/tafh6TisR/N0J97/vapTAvuyg6GJpxZZP1lB5POAQ5on9TcPcZ/LLdQbsJJerxJGwVVBN4cl+mzn9bmF4H20W8vtAYLqsJ5dBerLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022908; c=relaxed/simple;
	bh=m15RzCYwzK2m4zGAWd8wlqq0ArcI1Ou20ZCANbdd7dY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tSMx42FZEi9CzZs5I01dQKa2FDIZ24Clk1xJjuilK+ey/6H1bCDpXLZPKOHc5+/J1FahLUzJd8pZxehF7nlBxjwuQ9xf4diEvky60h1mVWECWASzqlZMqvnPR7Ecx896hMbptbvslNUOberudBpMu6424JT7YJK9lQzov4mMNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkSSbHII; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aU0HGALm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yc4C813839
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=56+P8TT/sBZjFdakJ5P8iK
	zWiVSHZkQF3LbiBlms2v4=; b=XkSSbHII1Mb1MwFmlob+2oVBsiw1qo5La9gyeq
	N0aCcBWpCpR6MVyv0LwtT6BRouwv1GuGe6uuZLeoPFDvcjHEdyScSNzddlhnauow
	TD4rfAJZ4AU785g/AqTShBQ9BQPocGV4+CtrkT/sXP3A96qMifBOjtK1lHUMhAiW
	SsYf73keMX+lbC5DrJzmo2R2EQsbrEtIboL8sYnRH3COAX8ZqKUQaFze9hc1n9V7
	l04uzJs0L8wrjhfy9YmV6H4dC10BZgYk1uCitkET+Q+pYEKN4Q7Tjk0DvtDfzNt/
	Ardfud8Hy9LKNt0XW5urmjWEe3U3bwh87jGgSOJ3MBi4n8eA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v796tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d058fc56so1980915ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022904; x=1766627704; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56+P8TT/sBZjFdakJ5P8iKzWiVSHZkQF3LbiBlms2v4=;
        b=aU0HGALmgJYOa6sYdBhH/wDpXLADlNESMQx6x+Zszl7JXzU990s9kR+lFMIUaKkNk7
         ShZpu0i07UBc/9JqxUmEKbtf1Q9ZwPBGlphw+PnZykyree803z6YiymXbdjuMmPMVLC7
         9FqB0d2Srk9ftyWTbjRv8g9SjActhPfXxKrEvvCrDtqVAOTlNtWdlhqWxzzI4Rxtw+/8
         zNK2ydr6rCE28fzA+5dfQuXHIozDTJdmWKwS+4hEEjAOhxD8+tHwu4dHGI0zdXb08S7H
         RY+i/5/S6Q1JL/RRT+Xenhn8OPFqUY7xqEWI95zjMHUtaEVlDgWtsHKzbDUcELi2Fl7S
         m3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022904; x=1766627704;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56+P8TT/sBZjFdakJ5P8iKzWiVSHZkQF3LbiBlms2v4=;
        b=j0sKHlMyhgqLGAj3DRTzEoHJw3KL5GOu8413p0ssYh5ZkSB1W/ga0fGzVijOZ85cWN
         7dZslqPEeizb+yBUcAA92PzI4BJjzbIGBEaCvBAG8+984cuZm0vPqMeiEjts1CcFtmD1
         lXiWdcCmBeEuBGBaO9SuUYO8hmtqF04aeR2DevTWZHGeD8LVYWVB2JFVVxCDOGUh53rL
         xz7uUC5YWECEhGBVjCSM5R5a/4RdqRo/VYSTz50MpCEKHaN2vbi8lyQXns+Bb9Iw6kW3
         Qm3zthgfBm387D9df5WRQltY+NGzEFJn1xh9kEQQfoHOQ3our2eWTsLYOdVlqfiU4q3d
         g7qQ==
X-Gm-Message-State: AOJu0Yzdj0yvgrKCeCgXylqXowc3EOlld0va1QHBoXw7QDYAdD0cZFwM
	GqBbFcffo4Q7m1a6r1k//gpv32txYMutU/axFxMwLtOVRxpUwlJpZrzHi0y+UPxyBMcgWJ+Ubkq
	buCTDsfZwPm4V0eHGCthm4RxQ+GIeMbRyS5d6N1NBPxpfwOX/27PGqU3bBdYgKPvn+1kUNg==
X-Gm-Gg: AY/fxX7RKfJX47VS7AmeD0SJXbXN/fchw+PuqoKnbv01YAdWnhsxsCCGyXiV2+d/WAX
	5nqbcfSIFjyVMhZRgyOrN9bEU/q1AHxoDphgnzKNCDcEV5X9AS+FBP9f4yZAPEAq8ZwrPNU7Jk6
	uirXA7DYnRIY0/TSI4wsIDy3EHuR24jaXBZrjvnPOFTVRPYd3EPHOSqIis6hpmcq39H3VNjHYRd
	U8M84uuWv/d/inbtfXi0IwkKuEEUwwQnFJPhgzCNMSgwzwd4VXkKPh2yjGpMdWv/h+OoBo2i+5E
	0rLF/bjH3BleqS6bAljPmv8PWHlEN8O1JJkrm7tF9dDJtYpXuxC7a8fNArYarS03Dd2BnVPjJfI
	RZ9RurNWOaXxSSSC/FWH9V4OVNOyAH2aE8lUrMYHclzfCQa4s4PEavJdWJvTKxc8=
X-Received: by 2002:a17:902:f70a:b0:2a0:9d01:c3c1 with SMTP id d9443c01a7336-2a09d01d4a9mr144258595ad.1.1766022903891;
        Wed, 17 Dec 2025 17:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKnYFo7nzNiGaFBO1ovUKSxvb/HPdgXi09iy3bNpOGLudh+RHcD0KFDvEu7VzUuwmb+O5uMg==
X-Received: by 2002:a17:902:f70a:b0:2a0:9d01:c3c1 with SMTP id d9443c01a7336-2a09d01d4a9mr144258405ad.1.1766022903376;
        Wed, 17 Dec 2025 17:55:03 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:03 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 00/19] wifi: ath12k: add support for QCC2072
Date: Thu, 18 Dec 2025 09:54:14 +0800
Message-Id: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdeQ2kC/43P207DMAwG4FeZck2mOOftivdAqEpSh0WshzVdG
 Zr27qQFiUlQwU0k2/L3O1eScUiYyX5zJQNOKaeuLQU8bEg4uPYFaapLTTjjCoBp6sYD8Feaz33
 fDSM9hcCZ4TQKphGk8t5HUpb7AWO6LPATKTu0xctInj8nA57OJWn8GjeYs1uS9pslhzOgb0fXV
 qkp/erYubrKr6mv1Bw9CQrUY+2V3FmnrHvsct6ezu4YuqbZlmc+wLuMdG6ksagqWiFijBbq5Yh
 DymM3vC/fnvhyxV8/nDhlVEsPKgajUMHP2FmexLfGmV3VRNFCjcIGYxwzYUWTdxqoVU0WrXYBP
 TIpA8YVTd1rZlVTRePawk76WhvAFU3/T9NFc7touA1CS+C/aLfb7QMSFMeMigIAAA==
X-Change-ID: 20251106-ath12k-support-qcc2072-f306e145bbbf
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: PimN-goRGdHqHwqvOF0hSOcObzkepFcK
X-Proofpoint-GUID: PimN-goRGdHqHwqvOF0hSOcObzkepFcK
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=69435ef9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=55-7P0Cx6h0GZh4B0BcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX7Ggn1+jopXu9
 yla4GWfHa50OK0MqiaHGClIqfcflMa25pHQHTP8wOZt/Hh9Rw5UvsjpMhF3QukIHiu69ya8tP6r
 /NO5PJMoyzgAL9ULMWWq7dVJFqm2mQYIl+NQZTrg1tHEtRqRLHTF89JiJ4Blt8jgM67r4VSXJzv
 pbZvM+yCTrs2xx5j6IfRKOjAzXkwxBkrfM7nQMXvJT1hMK+A4N0SKVkiOpGzYVM96DXgl9/DCaQ
 OjtVy4ECbK6k1z57LyYrh98eC8s97UFZy/RKuE+OQ6+VNhUpwovQ4jR+zZaKmS9vzFQdkmKVLXr
 3hmBw7FvVmHZ4kVnNrbaN5Ykkf8UUr+xgpuwpFjXWM0V/qi4WQHSPkFxgcG6JcwY/Fg4xRcfadQ
 zjzqwMAoHcmrUvTOpLW5TOn6f9jurA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

QCC2072 is a PCI based device that is very much like WCN7850, the major
difference is that QCC2072 has only one phy hence does not support DBS.
Due to such similarity, lots of existing WCN7850 code can be leveraged.
While to handle the difference, separate operation is added, necessary
configuration is changed.

Overview:
- The first 6 patches refactor/fix current code base to prepare for QCC2072
  support.
- Patches [7,8/19] add hardware registers and parameters for QCC2072.
- Patches [9,10,11/19] add support for new QMI memory type, new firmware
  download etc, these are specific to QCC2072 hence necessary configs are
  added to make sure other chips are not affected.
- Patches [12,13/19] add new callbacks for QCC2072. These callbacks are
  actually taken from WCN7850, with modifications due to the different
  HAL descriptors.
- Patches [14,15/19] add 32 bits variants for QCC2072 REO CMD/status ring
  handling, as existing 64 bits functions don't work with QCC2072.
- Patches [16,17/19] contains changes required by QCC2072, but those
  changes are made common to all chips. They are not expected to cause
  any regression.
- Patch [18/19] add QRTR node id register such that QCC2072 can work when
  firmware-2.bin image is used.
- The last patch enables QCC2072 support.

Depends-on: 20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (18):
      wifi: ath12k: refactor PCI window register access
      wifi: ath12k: refactor REO CMD ring handling
      wifi: ath12k: refactor REO status ring handling
      wifi: ath12k: fix preferred hardware mode calculation
      wifi: ath12k: refactor 320 MHz bandwidth support parsing
      wifi: ath12k: fix mac phy capability parsing
      wifi: ath12k: add hardware registers for QCC2072
      wifi: ath12k: add hardware parameters for QCC2072
      wifi: ath12k: advertise standard ELF image format for QCC2072
      wifi: ath12k: support LPASS_SHARED target memory type
      wifi: ath12k: support downloading auxiliary ucode image for QCC2072
      wifi: ath12k: add HAL descriptor and ops for QCC2072
      wifi: ath12k: add hardware ops support for QCC2072
      wifi: ath12k: handle REO CMD ring for QCC2072
      wifi: ath12k: handle REO status ring for QCC2072
      wifi: ath12k: limit number of channels per WMI command
      wifi: ath12k: send peer meta data version to firmware
      wifi: ath12k: enable QCC2072 support

Miaoqing Pan (1):
      wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072

 drivers/net/wireless/ath/ath12k/core.h             |   3 +
 drivers/net/wireless/ath/ath12k/fw.c               |  10 +-
 drivers/net/wireless/ath/ath12k/fw.h               |   3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |  46 ++
 drivers/net/wireless/ath/ath12k/hal.h              |  34 ++
 drivers/net/wireless/ath/ath12k/hw.h               |   3 +
 drivers/net/wireless/ath/ath12k/mhi.c              |  10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  17 +-
 drivers/net/wireless/ath/ath12k/pci.h              |   7 +
 drivers/net/wireless/ath/ath12k/qmi.c              | 180 +++++++-
 drivers/net/wireless/ath/ath12k/qmi.h              |  16 +
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  62 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |   8 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |   3 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |  33 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 503 +++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |  13 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   8 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     |  97 ++--
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |  30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |  17 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   8 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 106 +++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |  26 +-
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |   5 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  54 ++-
 drivers/net/wireless/ath/ath12k/wmi.h              |   7 +
 30 files changed, 1174 insertions(+), 140 deletions(-)
---
base-commit: 25f833fff81de4fbb9b5382806860b63768567e8
change-id: 20251106-ath12k-support-qcc2072-f306e145bbbf
prerequisite-message-id: 20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com
prerequisite-patch-id: d5a84e00e749b9332179b8ed7d2736b42d33fde2

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


