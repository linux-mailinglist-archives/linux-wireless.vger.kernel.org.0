Return-Path: <linux-wireless+bounces-30171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5ADCE9054
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C659D3032A8B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E430499A;
	Tue, 30 Dec 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMXf6/Ku";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sn+vXNCg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DE303C87
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083129; cv=none; b=ZG9VEKHmfwdURwcQFNXTksVtsp8XLA5qikekyWsQ0HdF2I2Nfv9HVPatAKZJYISF9s+pz4L3v0tbQM9rACq6DX0a71bg2ofZbC546K86O9K8Bh1Fs3UWngS5m2rcUixcOTLhGBbVlrYktkuPAeRR4/WtB9EvijjQDqM4z+QQ9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083129; c=relaxed/simple;
	bh=6Z8qJiihSl+o8S3gEAXs1dF1AtZckX3e9qLUURbmIHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clGTqoUL17MarqA2dvlIsRO7xVXnV0Gu1mARFywrFIrYUipAHwadoNoVP+ebOEN2d/df/HOf416DN/vTDLs1H6nnr1j716j6EMJWMTgOvb11vb0udR0Bb7V33M5IQ2zHyO/SB9iqbevNl+7k32AZ/YyfYouEs4jB+h7XFKLr+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMXf6/Ku; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sn+vXNCg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU3ijer2548850
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z6kIqpz/Ze0IIYsOgToqHSxZLG/w25D8IPx
	klemj1SE=; b=cMXf6/KuZwLvFaXbwDBdZplu6duGwaltrNZoEfyuFbHbzKXhMdS
	BdchspRTRY8JpXm60+mfRDQ3h+WEs0OWzsR2+YtZHhMeZGUyOeVjq6/fHNrbxHVG
	fOTdwC3lzIujhRSL+0xk0PSwiYaTpsZoV1x+1EFf/zTQzdgWUszLw7usgNgKDoqq
	c+1/W6oTaKNLLFKQbvp59gUBI0YHShwgyJdGc0/BBXnmSIwKA05X0goIXHg4IIpg
	RxqRp5Gl7uN6WSGlO1+QSxsIpR9Kva5iCOQLIP0q66asI0H/LmryTxwxqB9+1PM2
	re6MnJQTNdTk+rLaptHZlOKQnW1nEnMeovA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc7398k6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c1290abb178so17375130a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767083126; x=1767687926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6kIqpz/Ze0IIYsOgToqHSxZLG/w25D8IPxklemj1SE=;
        b=Sn+vXNCgcMVOS3FtixRFBrP6ZjVWGBy490vfJvo16D+lWiz3UzMKZqNSwsxGtEOqCa
         /TVU+3GCivFETCWwMfwwlZIu+ZmdbTD9xZdTogBtVpUwiY32TlhmvV70E/V7vTgBys0B
         ttoxwgxuuigBKyHUccgaNc1YIbMjSC2/jt8yMwwV+xBA3sC1B/KGunpAJb/RyiwaGpxq
         YSM3FAxJfu9+/K2bQJS43rzf45o+pyZJP0l2veL/uJK/a483+Qk6oX2NL9yR5A/sqLY3
         OAP5ltWGVYint9ddMq2HaJfa7o+k+5Le8llCK1oJW7F2oB1JqPUBSgYCvsDIUdRNcj8m
         bJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083126; x=1767687926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6kIqpz/Ze0IIYsOgToqHSxZLG/w25D8IPxklemj1SE=;
        b=parTJWlaIf4FTFanJb9EO3ZwTUvIqgjR04Wu6JLtx4NwMhlAEnVMDzDEfr0xx3kcS4
         YqPnDrIuf7bMEpProgcvvCZaGNZ1wGCaeHwrwfgwPsKwfemXNtTx9gHdztosMhEjUVYb
         I7f9tZYBhkgQ0hAs+h/au1pm72q9PWBbh0NLjvgJxWcSJm13+ZK/affJfyv2/Nvh+acW
         fmCVhg5prsp7OdjWQNCVvkdlrbks+EZQBGaDlQeKIB/psKaSCn+diJoZUKDC8kjk6TZM
         DqvTcZmBf1nb7QGg3jeBxIN3QiXUOPO9qVjjaw8bx1P84Si+65cdgGQBbMX7vHzYE02O
         4xGA==
X-Gm-Message-State: AOJu0Yy7zqZitRpMmMlmlRb8giODDyYJLoWPP5LdTjpdLX/jNgl95nFu
	rKOSXQBj8YTT4LD6WWRqYa993IyT//R1aWDOu5vukO6uzBOo6I+cpkqfim/0Foo+f3NLzgUdy0N
	UsPpOveIZR+VjG9ymBgMuTRvDeKkd0WW9UUPPIO7Yhfkimnb91ieaVopQQPr8neyO84PLHqc8NH
	lMPbl/
X-Gm-Gg: AY/fxX7COHLSm9UOJ8iV4c4jJZHh5dObA341iBx7h459v8PpHUJ/P84Q6nGW2w9KRcL
	HwHJTxGAP8ytdTj9Zvz666iDonydt+ZzEOjSSqfvT/yMQQMZXEfs18uDottZ3Mu6J5HEmHimX2q
	w+FC0gaJvxv43Eqm4yGyxOBWe5iKjJxOvnM1CcTA8aJosVN8+n6QdlT0FlsVggJ3jxkzv9cTgCO
	CArCdPrgcDJA4U7QeOKzN0rcKjAXaeIn2JPmsfgeN5B+l0WPgy9ElPx20CQMi1b3KwsboekUx/w
	Q9MgcHONxpiZEgntHGI8L9ZFZKXOSmTcwVq8/K7n1FQylVmDygZ6o4jVNojVNfbu3aiTGnlKkrd
	uGF0mVpbDXYxMLhT0CkQGkuBvS0YxSTEZCfg=
X-Received: by 2002:a05:7300:881a:b0:2ae:598e:abe8 with SMTP id 5a478bee46e88-2b05ec8547amr34799899eec.24.1767083125851;
        Tue, 30 Dec 2025 00:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ03fBnJh5IVut31WCRFRfBq74vw+oTGSzxa1jpYzzB+8Z+UAHAf5MM2mbT8P0rljvnB5NeA==
X-Received: by 2002:a05:7300:881a:b0:2ae:598e:abe8 with SMTP id 5a478bee46e88-2b05ec8547amr34799884eec.24.1767083125213;
        Tue, 30 Dec 2025 00:25:25 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm73275620eec.0.2025.12.30.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:25:24 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Tue, 30 Dec 2025 13:55:14 +0530
Message-Id: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7OYHG2mzzzRwwyYivcBMis7ygNj-MlTf
X-Authority-Analysis: v=2.4 cv=HrV72kTS c=1 sm=1 tr=0 ts=69538c76 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yv3IMDKv9k7fc5CDy5MA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3NSBTYWx0ZWRfX8fhE55bCkTTb
 J6A6/zFrB42P2906hiN2yIuMhfHyFAJ7Qb6T3Ut1VyLHpKB81Z2EwDicVUpjzVCogI7YQmeMCYa
 AelHBSZ5KjVbaN2dq9AWfZ7dxa4xCh+9BHUIeqAoU9OaOafXDVMl32/v6fNGxm3OmpAjS5D56Qs
 ZeqgJ3n/GxwX2IBACXcVrsY7jYZz9UcZ5b//DY7Ym4gizAbhP8TPUq2zzrGsyETO4WfiVTBn94Z
 G/n7557qLkEuFG/insFugkLE21nh3B8V5sXPfYomWqdUljMceEBbDxokAURfjbe09b1ws7GQgyf
 0QMhNenM7rM/9E/hIZVrTysp3NtrHrm02yJb4dvN1Omfa/oNK54VACMPbtUsAvE+V4ihfOQTsFe
 d7wNKY0nweokIiGUN+qcdLWS1WDGdd3K0cKrXzWRMUG1kOOsQ9Q4ipv3LbtnaAET8MM6hzRmgM/
 uqVoBPgoP4OoZjGOywQ==
X-Proofpoint-ORIG-GUID: 7OYHG2mzzzRwwyYivcBMis7ygNj-MlTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300075

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
Changes in v5:
 - Restore the author in all patch commit messages.
 - Update patch 6/6. Cache the phymode during association and
   use it to replace phymode reported by the firmware.
Changes in v4:
 - Update patch 2/6. Remove redundant bw parameter check in
   ath11k_dbg_sta_write_cfr_capture()
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
 drivers/net/wireless/ath/ath11k/cfr.c         | 1022 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         |  308 +++++
 drivers/net/wireless/ath/ath11k/core.c        |   41 +-
 drivers/net/wireless/ath/ath11k/core.h        |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   19 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
 15 files changed, 1855 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 4465d808fda12fa47f83733a9f7b7dbc29d0ea54
prerequisite-patch-id: f44bdcbd36af0c3fd57b477848bf4699cade9389
prerequisite-patch-id: 76c61f8f00aac2a3b9ff31e0166bb12997c2b0cf
prerequisite-patch-id: 886b24b2496167c304e8ed42b5d879e0ecab111c
prerequisite-patch-id: 672baf608620c531b3765941c2719ad9d34b99c1
prerequisite-patch-id: 07c9ff6fcaf4ba464be993caa19eb49113eedbdf
-- 
2.34.1


