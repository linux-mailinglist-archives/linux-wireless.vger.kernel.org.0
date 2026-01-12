Return-Path: <linux-wireless+bounces-30673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DADD10E7F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38058300857C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08C30CD82;
	Mon, 12 Jan 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QiMsgO5O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3pktKqk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10E2652B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203415; cv=none; b=Hh6Bx1ZPkCg0G7GllaBi1CkyiOsQFM2W0mm6YN0N90fNkzaBYfCCyWTnXpIbcZIGPdjoFx4HLhST2C3GsM3JauRWFWyHTAfpPzw9DuBeIlYLRyprW5B/mGE10wc+OrY2BJSazQzd4jNwtlt9VJrGNXibykv2MQ8FhWHRCrQV7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203415; c=relaxed/simple;
	bh=zVv7BUZYz9f4++PYVk4wnP/hSZXs9HraoURDD7Z8ep8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+X+wVvD47ITxfb/L9bWUPg7Jdk0ru7YSmhK9n/UCcpbLKosTgJ9E+JUvzNkprHSZHswL/9O9uIWcfkOYfHVL0pxrHzRUY2XmOnolscD4TiFqg37fsEdaRPLKY4+61cw6EFxUnwYasXFk1AHyTcyeZJzEVzHLJG+4EOdRBKSr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QiMsgO5O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3pktKqk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNq4S53312808
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Qx/mJjNNeLOmXa/8FvgCro
	5atgbkDDhm94Fz120NVbo=; b=QiMsgO5OpnPJQQrfuGzJCwwLJmC3yn7VxP8p03
	Dy2aHkdfh2Rd5+/ig55x47bjl6eiuGekO7A6EPR2YtckUibKbvESVqhl7Bs71vZa
	tote/mXQlcPgfL7MqSow+JqLMM4TOu/GlHKlol17k8xUYuaqa2RpxCpWTkItYpRq
	wNNc9ZI80T7IYMhYHvNKk8/gAcxqLqCaSznKCNSNPfGNZbaSt0h+b07ceQvqIrCg
	17yacSwEX5Yz17T3iScangsYhZnxRiP7RosOQTTlVQV25eVCrl6gM067HNXKO8/B
	kO+74L2KrGF5HthTOE1IUhsxNJZJoHAP/b5SuBSkYwpxKMwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntukdbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so1201882a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203412; x=1768808212; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx/mJjNNeLOmXa/8FvgCro5atgbkDDhm94Fz120NVbo=;
        b=C3pktKqkjfR5hKBYpQaMua6m6wUO2pydxjkFWGvFYxbzu6KWVj7BigRn2Ye7L1zWi0
         33vEDqtsSw4G2umM46MB4GzZixShoR6aZCh7pLC8WjD62+RGr/LROZoYaox2r5XagZAv
         HYgykGxlkZCxslMGlV5QOWSz+4lfDqnnvm8u1v5XyW3RqWg4nUOwu7zgVhzmgV0+NcXd
         Xkjm0EdSjqE7Ue4cAlrzXK/Hl6flNCTBb4dhjg8fqVGd3Qjc8Sd4j+kbF3DMyZf8XoV4
         gIIDEwuQ/t8Edr4MmBqkzZwv1YmG73Ryc2rXoCcepiX+cPGpln5PCfFmi1DdPY74Kyjy
         nzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203412; x=1768808212;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx/mJjNNeLOmXa/8FvgCro5atgbkDDhm94Fz120NVbo=;
        b=PQ5LCCi+lbZUP1it7bb6sRS9to3d7Eq6IyooEf00kmxi+6ETn8Ef2cla/Png/w6mGS
         cFAc6dyH9R1GonnOm7WwBmOrVTV8LRpnQe91fUQQ+hsjeZm9N+1gWiFtnmSNrETZBrtg
         jhGPGZaqUXem7phh/PLs9vYCrJmbyj2McxKvrOFZcHUeyYc8RCjIF1LAhq1lEqQIoiIB
         58lmPm2yuGapeGJec4mKRhFG2yaeGUwGPwz4JuSv5LTdnoBmZo5n9r0APHff91i2Gnrn
         N/WvwixAt9Qao8/qEblk5e5HYDxM89k+zyGTJ07l80C3TOmpc/B/fWmZX5ToWPHEKK3A
         3xdQ==
X-Gm-Message-State: AOJu0Ywb+Yh6UFKx1X5r9D4aUvrvEhSddAOUJBCM6QdrhmeihMZxzur2
	LAq594bJaagw1hpvu8Ldac1dRR8U8TzyDaXbyJC8NqcAIJDoDvFnJpZp23Al6ZZxUhsPGU+QFy6
	vFqy8y6oT35z/0lK7HysTN5/moJ+lXVyzo7SDZxSrvrGebF3NB6KMRPhXNsiAIxCO8MASlL3F2N
	nS/KoK
X-Gm-Gg: AY/fxX4rPs6vtQA/yuB+rTnhnWpRvjj8A811sgT17/FlCDHZMWlj7ImDw7gHNn58Op8
	nV63cNSnH8V+ZFTRkvh1nzEnFCNffydBnXx+/RZogdkJ1yeWWL4KTaKebKGswasi5VC/Zk8m3wj
	JWOR4xp/h5SISDUEH4P2ZdGGz2WqA/JKFXLR1brv+zsMorV/sEKYV6huo55mfkUzsqo5BMbmzcS
	FaXToISDyo2sSduRM1ulmjZJoWop2NTwD+DSLwGXcE5ltuoqE0srmkYUykk4unxlZn/IOBCWKgj
	mry/WWJ5q7hN09WuZQGOh+EQftI2BL1TCu0GvzS0Uxa+PIxyF9v3eJvXyCEJEAda3Z80VyNc6SI
	FUVn+PjD+Xj8vliz1i147harPAtQYJpkHToS86EUcdVWa0iP3ZTwvq2f8RHtcy9g=
X-Received: by 2002:a17:902:ce87:b0:2a0:9411:e8bb with SMTP id d9443c01a7336-2a3ee4c45d9mr138368165ad.60.1768203412313;
        Sun, 11 Jan 2026 23:36:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+fKPR/h6lQXVB0VxBEXoa/BO/EGtnYfpxxYnr2TC6bjXxea3SFrZmy7GX3BG/tXrqNTjs8A==
X-Received: by 2002:a17:902:ce87:b0:2a0:9411:e8bb with SMTP id d9443c01a7336-2a3ee4c45d9mr138368025ad.60.1768203411845;
        Sun, 11 Jan 2026 23:36:51 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:36:51 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v2 00/18] wifi: ath12k: add support for QCC2072
Date: Mon, 12 Jan 2026 15:36:20 +0800
Message-Id: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWkZGkC/43Qy27DIBAF0F+JWJcIMA87q/5H1QXgoUZt/ADbS
 hX53zt1FvWiqN0gDaN7LuJOMqQImVxOd5JgjTkOPQ7i6UR8Z/s3oLHFmQgmFOdMUzt3XLzTvIz
 jkGY6eS+YETRUTAOXyjkXCIbHBCHedviFYIb2cJvJ62OTYFqwaX6svy+7mOchfe7PWMUe+qtxF
 ZRRLR1XwRsFij8POZ+nxX744Xo947HXrdWPJlhd1CrUfAtV7Y2xzPiCJg8aV0VNotZaDw6YlB5
 CQVNHzRQ1hZrQNW+ka7XhUND0/zSNmm2CEbWvtOSioPGjVv43jlptGsRCDUqaX7Rt274AzOyJa
 mgCAAA=
X-Change-ID: 20251106-ath12k-support-qcc2072-f306e145bbbf
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX/B869K7JXi6f
 ii7FyMBrFNkfmWoquIJ4uit/8eWrXWVC7QEuADfw/hYP5RRaIWwDyxOREunvR2PD7x7ebw6Q8Xo
 G9zwTnFeC94XqosNBIsGjBrq14QXLuNP3hodW7nysTvGsqn+jvofdVdSKMEL+nhwMzkgmUNbLGb
 LEvityU3VUKOEYiwz9k0nt8dosiG4QYUJxqpabQ3V0HbqbTD5dhf7k79nDuBCdQ1wrl6pBQnncs
 uus+f5YbamAtzwZSsn7wrEuP/WfAag5Kxwj6uonkdXHqLejiohgXXWAoQrcfJl2hKbvrkp8pwy2
 aDlMJBKQP65rZQvmCMj4yhNwAuN0n3owiL2XY0qOcbah9y/hszDWrvYhQjGRQw+g2q7PJ6uQ/JA
 UlPDR/QtTeyR7QcpXWvQcl5zTRTUHq66j4J1wNblUKrUtEzdAp7JNM/7upEtdCFMv3d1J2jjbmJ
 koOPoSZxMzAdRQQKw0g==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=6964a495 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4yKLGjra7TlDbw-xlBwA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 24x5VLoNa6ovHhFGOrGxXr1t0eMF1-RP
X-Proofpoint-GUID: 24x5VLoNa6ovHhFGOrGxXr1t0eMF1-RP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

QCC2072 is a PCI based device that is very much like WCN7850, the major
difference is that QCC2072 has only one phy hence does not support DBS.
Due to such similarity, lots of existing WCN7850 code can be leveraged.
While to handle the difference, separate operation is added, necessary
configuration is changed.

Overview:
- The first 6 patches refactor/fix current code base to prepare for QCC2072
  support.
- Patches [7,8/18] add hardware registers and parameters for QCC2072.
- Patches [9,10/18] add support for new QMI memory type, new firmware
  download etc, these are specific to QCC2072 hence necessary configs are
  added to make sure other chips are not affected.
- Patches [11,12/18] add new callbacks for QCC2072. These callbacks are
  actually taken from WCN7850, with modifications due to the different
  HAL descriptors.
- Patches [13,14/18] add 32 bits variants for QCC2072 REO CMD/status ring
  handling, as existing 64 bits functions don't work with QCC2072.
- Patches [15,16/18] contains changes required by QCC2072, but those
  changes are made common to all chips. They are not expected to cause
  any regression.
- Patch [17/18] add QRTR node id register such that QCC2072 can work when
  firmware-2.bin image is used.
- The last patch enables QCC2072 support.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Changes in v2:
- drop MHI dependency as it is not needed any more.
- drop '[PATCH ath-next 09/19] wifi: ath12k: advertise standard ELF image format for QCC2072' as
  current MHI implementation supports detecting firmware format by itself.
- Link to v1: https://lore.kernel.org/r/20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com

---
Baochen Qiang (17):
      wifi: ath12k: refactor PCI window register access
      wifi: ath12k: refactor REO CMD ring handling
      wifi: ath12k: refactor REO status ring handling
      wifi: ath12k: fix preferred hardware mode calculation
      wifi: ath12k: refactor 320 MHz bandwidth support parsing
      wifi: ath12k: fix mac phy capability parsing
      wifi: ath12k: add hardware registers for QCC2072
      wifi: ath12k: add hardware parameters for QCC2072
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
 drivers/net/wireless/ath/ath12k/hw.h               |   2 +
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
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 101 +++++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |  26 +-
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |   5 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  54 ++-
 drivers/net/wireless/ath/ath12k/wmi.h              |   7 +
 29 files changed, 1162 insertions(+), 136 deletions(-)
---
base-commit: 87e9e52b4bfedea84f941c48907e0de0d70c0a7f
change-id: 20251106-ath12k-support-qcc2072-f306e145bbbf

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


