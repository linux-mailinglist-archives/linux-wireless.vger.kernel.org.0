Return-Path: <linux-wireless+bounces-30082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45669CD893F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 10:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B44013000E90
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195E30B521;
	Tue, 23 Dec 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yn0KRnQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNpEUCwY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76EDDC5
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482059; cv=none; b=BFKgFcLYXY1Fg2ci43yY2NYAz6RGuu2wcI091uXCkv6b8lV3T+wgHbGAzZ2Whlh0Hi/HNBjgbaIoSWAZ3bIqBQ7TwrWb6aF3q7ZGRFvEjYmnF5KRuHdn+dbeHEkWD8J+UAk+pt4WRWWdyDbUYTX2OSOBjWhCvCoq06bPhof9w98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482059; c=relaxed/simple;
	bh=6Fnml3LSpB2v4PxiNUFP2mAmcuGPuWTZ+Ym3IJTz240=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ywk1Z1waIhxIsQCWU65BGqXM2g3DEyT+YD3b4Khxb3iqpPmJZqGllXyZOwtn4icA2whNiHYR9eth2k2pUtJAFAenp/i6j+49rbx85jq0VgXwAcMyn5WMV6JNwaPQ6MsUP8fCeTI6k/rvtv17AhgViXutKGs2+t8KsusGLotzpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yn0KRnQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HNpEUCwY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN2UNEt1889180
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xdv+Kw434solMCgNe+PG6ZV7uuga6N23qYD
	P/e0DdwY=; b=Yn0KRnQGGxQI12/9hJDKqeQstctPpweVc/H34FAuRYN2tLNdOhy
	az97RFpvBdu+AJshm5Llu2lfnBpMLNG+7C2O4QzoXKDbmR8Yl/397pue2puaAGei
	NaSZdOT6uRMU2ENSQe8wmWhwawsUBB/EOWASsf0e35we3XYDnA3QO4LkEsj1RFzv
	PUglg+oKtWROBG7p1+QqnizSzk4z9OQLd7Q2EhmOYt6kRgNQ8vyRn+KpmSI3NwDE
	Dpjd/FBA88gmCJoFWaM2aaMJAI3HO55+zbi6tgw11m8rcr42qsnOmkXA3nna2ulT
	SSowEb25eLRyTsX/hxNuhVuSJS9UtjzFAUg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b770ak11v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so9753831a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766482056; x=1767086856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdv+Kw434solMCgNe+PG6ZV7uuga6N23qYDP/e0DdwY=;
        b=HNpEUCwYPKJ8yltsr2PSHndktD9aPJgFMN40vz4a/Bfjf1QJKOxt+40sixpqUr7SwG
         eC96w13ArHwNtXx4sJNgRDbTj/OLXyOvPxW9HrG97IQKptkmfhN89DigH4Ix76snpEX9
         s/z+PtPDjNZqIs4CLQYlI3DANn/RTVtF+dvj+Vy/CcVKfyt9RHieX+YhnnZQPQOKzJRh
         4wxwgEh5zUdjWemDYMbW0KvNhCF4r5iS+4EJDjc3bIxAV0mrJM7cUk0vU/TUhCF9zZps
         eK925WQC+IHT27CTkfRYMv4jOgGUrr7buJ3PnCXEjzaCexw/3ICCw2hMQXe3yqvdBAnh
         sREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766482056; x=1767086856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdv+Kw434solMCgNe+PG6ZV7uuga6N23qYDP/e0DdwY=;
        b=cqxngv16AYxkwE3zQJ6dxM9dpkZ+BvILONyQQASwB/bQZxGvtCk8znTch+BYZu6sRN
         wqhskpMAbmO4EQ04qEB4hMyZgRR540jp0SwvwY0HSpS2gHulXYZOxVjU+mfG/gD/8FeL
         Tr8yJGDwODM2IzQRUKkxYdt/10cnpAGvQK0gyCXp4Uwu0amuhSB6M+i8+DLPqhsxWx4f
         jD25ZqekXk/ZGw2N10l95wRIhSppZs5MZn+GKlgqZzO0L42dmawK4nh13dDr+bRJMgbU
         2AMf/w56nFXYg6fCHwUR1uJZyBQUxjkli/K1soUE0/vIuA1q17xyVTZGXIwAcLJCOjPH
         e9qA==
X-Gm-Message-State: AOJu0YwkKKRAa32XRmi9/wSc6V+F9U1O4Qx3t59m8dC8sX20GuC1Muyx
	WS4W/FsylbVK4TVGzAulxaeSKXxufvmx4MwpKZFZIzAY53e8atC6EPjIz7OAH4+RorVELiQDSE5
	OLfBZowaPr6IiCFFYw2CRt2o3CW99cMahUSd6YKFhQMD9NUvw/yS1Ht0qx1ycsQ/wYCx0hA==
X-Gm-Gg: AY/fxX53iDhRB8XIPNn143q8abM1Hotee12DVFy8Mmyns/jzN1DC/G6zFEeMGCTQUy5
	G3kwS8XnctfakrEvIATRpbR14Q7rUhvS2IV+TmCU6/N0MkQ1x/jCazkByYrOlvxO6tHlRS4U5H0
	yt+xxuJD3+JS0x5I1Fb4h3DT2NYuIzp5WM+Tccv0EswqpWeL5I7eKc46pLf0vX9jKALLOI++M2q
	A7Hyn365JlZqTgsQ39upLc1DQL2eOEKmIJdryMKHTKlrrxtA7kbgyu0FGPzy6cQyNf6v7zDIw+i
	F3NB7Itn9eNfJDyRqIBtnUZDGnJ9jhEgNQaWCl2ovOO1nQD3/peuO4etXaUjPVTShDdFWdCIcxQ
	S2Xc+33VWK0iIutE9irEbGeapndox+kGK/oI=
X-Received: by 2002:a05:7022:7e83:b0:11b:ceee:b78a with SMTP id a92af1059eb24-121722ac4eemr11979042c88.19.1766482056218;
        Tue, 23 Dec 2025 01:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyn225g2T80mOS4H2fFQrWlbxZvcFkZaDRaP7g/bLR2CUsoMDX7EaVQ9RKV9YV5kMu4Nw6NQ==
X-Received: by 2002:a05:7022:7e83:b0:11b:ceee:b78a with SMTP id a92af1059eb24-121722ac4eemr11979027c88.19.1766482055701;
        Tue, 23 Dec 2025 01:27:35 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm56130940c88.0.2025.12.23.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:27:35 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v4 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Tue, 23 Dec 2025 14:57:22 +0530
Message-Id: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NSBTYWx0ZWRfX8VF64EH1WdPx
 5krtzTgoGJVLqzwKmzM0xTof6vlrqKRUL3mKMvQQOLoGtR8AdsUUBX1Y7pBvex7MhG9ICon8sX7
 OzOUgwd3Efg7jixUJN/hMy+ejvOXwF901JRtC3iwNpK0CXZZb8GV98ugt+B1HuN96s6bKpmpVvJ
 jfHEYBZvFsQh9sDmzB/OeHUGDlBDwcyA9ZSa8RY/hjXkdBN/Z2xJYhk9qgnhwSlIYwhkk04q9fh
 CPfuIDR9xJq98ll/u+8GSdt1BcTZI8/AK2OPxqEjhlAcTNHTwHWVRZj1I39VqNINi6Ii1Alagjv
 JKd2SE6D0loD1j17vWxRvuIJmYb46qJrugB/m95pVF//P82HVoInqlWftIFD4ea6g/4UtoWvlq0
 x8DjsebemaAN87FpEQ1+awFymErL0vY0o4Zk2Vv343e9QgRryCi8FyX6fZLRUklyvik9sSUD/zV
 /a0jeJezeJC4b+kDLfg==
X-Authority-Analysis: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=694a6089 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9BubwUf0Dsy1eebtEi0A:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kYU9fxizv5ZgveELxo3GpHw655IWTxi_
X-Proofpoint-ORIG-GUID: kYU9fxizv5ZgveELxo3GpHw655IWTxi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230075

To enable/disable cfr feature use command,

echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr

where, val: 0 to disable CFR and 1 to enable CFR.

To enable CFR capture for associated peers,

echo "<val> <bw> <periodicity> <method>"
 >
/sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture

val: 0 - stop CFR capture
     1 - start CFR capture
bw: CFR capture bandwidth
     0 - 20MHZ
     1 - 40MHZ
     2 - 80MHZ
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)
method: Method used by hardware to collect the CFR dump.
     0 - from the ACKs of QOS NULL packets.

To enable CFR capture for unassociated clients,

echo "<mac address> <val> <periodicity>"
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 - stop CFR capture
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)

To collect the cfr dump,
cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin

Previous link:
https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>

---
Changes in v4:
 - Update patch 2/6
Changes in v3:
 - Update related comments.
Changes in v2:
 - Update related comments.
---

Venkateswara Naralasetty (6):
  wifi: ath11k: Add initialization and deinitialization sequence for CFR
    module
  wifi: ath11k: Register debugfs for CFR configuration
  wifi: ath11k: Add support unassociated client CFR
  wifi: ath11k: Register relayfs entries for CFR dump
  wifi: ath11k: Register DBR event handler for CFR data
  wifi: ath11k: Register handler for CFR capture event

 drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
 drivers/net/wireless/ath/ath11k/Makefile      |    1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
 drivers/net/wireless/ath/ath11k/core.c        |   41 +-
 drivers/net/wireless/ath/ath11k/core.h        |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
 15 files changed, 1832 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 25f833fff81de4fbb9b5382806860b63768567e8
-- 
2.34.1


