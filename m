Return-Path: <linux-wireless+bounces-26031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52817B12FC7
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Jul 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF79A3B3C62
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Jul 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D3A1D54EE;
	Sun, 27 Jul 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YtM7sJBF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25A1114;
	Sun, 27 Jul 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753625086; cv=none; b=Z4LdK3pb9SOfPb8864OOg6eiD/xX4Tbw8+L/7LgYGbNwtivlY6Yb8oHy+z0YxFIdC//TsFZWPGVpB3xqtSwOJk5RONv4fGf7GkfgJr9/exPX6OQaBwA1CpZFzfw3SL9djv2smWvhYKmxKxSFuYGhwconMXPTD/6RKhfgE66yBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753625086; c=relaxed/simple;
	bh=SdbboYZMX+ZiTNfBT6xz9dAEist8+F/lZz/mYO2uahM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNTYPy8PMwo29uN+U1ccAU5ziq8gQb6DrRgk3+V1FqU8RMaL8w80omu+6qWvE822GFyL2CNJQUCsZDAw/m5Oal6jt3F6H0oTjYFtn4hVf6EFjdES4VQPWu193Y0SwTpe1IOCRHf5OcZYuv7DAoUvvXpwfxPEcCX/eR/c6HEZ3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YtM7sJBF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RBiNvZ015426;
	Sun, 27 Jul 2025 14:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=JITwHwwC4cc+VUUtN+UwSJstV1cb4
	SvU5OlXX2YyGAQ=; b=YtM7sJBF2LGyPgk8WB5zKkRS44nkf+0TuOHEmaH0pOpiP
	X+EKn6+aVOxJCeKibfV/r+m1cX6GCprlzyFLEbnJlwrQEdE92A3cMTNGtDzxk+gv
	ZoTGync9MhZ6q9zSwrCBfPIoqWNhHnSVfhc6AIwTLskCnfJo3N73jZ8asBC0bsF3
	Q/PvHd/YbXc6nCabQBl0a3FNmctutuUTcd1Opsq03Luf804Yw3fRm/3rN9id+GRJ
	A7TyACuHRz3E2Y3jS9MpA78XQqNNfZDCUD/eTxF2pQCMaW2lhGokFma8j05VHUP3
	Mmusw5D7Cy4UJqXtk/zjNWM65YFuK0Tnu50a/W/cg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dss7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Jul 2025 14:04:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56RCIZlH038511;
	Sun, 27 Jul 2025 14:04:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf7cycm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Jul 2025 14:04:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56RE4KTQ035509;
	Sun, 27 Jul 2025 14:04:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 484nf7cyc4-1;
	Sun, 27 Jul 2025 14:04:20 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Allan Wang <allan.wang@mediatek.com>,
        Michael Lo <michael.lo@mediatek.com>,
        Charles Han <hanchunchao@inspur.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()
Date: Sun, 27 Jul 2025 07:04:13 -0700
Message-ID: <20250727140416.1153406-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507270126
X-Proofpoint-GUID: AorprVRinTR-c26oWrX1RvFYmdxKkJx4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDEyNCBTYWx0ZWRfX8uP/g+uxgkqx
 BewC63GcNLD+7uhitQraW6hBfIEuw+JiN+1tWOWBdJnYqytoHhqws91j+JHdSMjZPYMh9DI5urs
 +BESRN+OIstW3t9Fy6aSMA0wK/ThrtPg0u+6fzwkb1Z5UdUFj8RNe+c7Yb5qtZYFuOPFmXX25Qn
 BuL6kah1YXV90q0Uxjsovoo4KQw+eBp5ZKEMv1Ts2KIe64ep4lHB839Z82cNrEVNtFQFMhJgGao
 zIHroE9KVLJF0ZnYGAJHjcoxVHzz6JmcjtsydBgX9E3yw/TdwN1EgTBkUdcwyjYo6W44ftQ5F3v
 Xu7yo2bKz8y0zlY5r8oLm73DY9m7eueV8zmp8ieLwvQ1CqNiYT2sbJ5d8l9//OlRoify3GMjsJy
 rnyQxfqIKMWEIg2lxQJM8vedQdBkzhu4u/1fKYDn/aVs+OaAeWCh6dr/Yk/HB4Toucrq7TSX
X-Proofpoint-ORIG-GUID: AorprVRinTR-c26oWrX1RvFYmdxKkJx4
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688631e5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=oq3m51LP4hL1v8Vnt5UA:9 a=cvBusfyB2V15izCimMoJ:22

&dev->mt76.mutex lock is taken using mt792x_mutex_acquire(dev) but not
released in one of the error paths, add the unlock to fix it.

Fixes: 5cd0bd815c8a ("wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202503031055.3ZRqxhAl-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis, only compile tested.
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a8d25b7d47d0..103909307518 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2069,8 +2069,10 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					     GFP_KERNEL);
 			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
 					     GFP_KERNEL);
-			if (!mconf || !mlink)
+			if (!mconf || !mlink) {
+				mt792x_mutex_release(dev);
 				return -ENOMEM;
+			}
 		}
 
 		mconfs[link_id] = mconf;
-- 
2.39.3


