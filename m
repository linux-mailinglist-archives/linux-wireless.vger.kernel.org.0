Return-Path: <linux-wireless+bounces-16016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E370F9E8B0A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A65280F17
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFA1553BC;
	Mon,  9 Dec 2024 05:35:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC99148855;
	Mon,  9 Dec 2024 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733722553; cv=none; b=kW2zJCiApPs5ahEnEYq/vuxf8Y+aFmWR188LLC6vi30SwaSfz2IK4cpH1AN5Hlo6A/Mn7r6iRUSkjs3wXIUfTJrfQKd4YvhzqJ6GNazi8LNelIyyV/NWEqtxxN2A0wkIcjBOycNST6hfxPI39y0fn7P/tGkL2Nhln3EkX89Bivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733722553; c=relaxed/simple;
	bh=z7iM/covW97ys+D32rC5qV8I6qBJB+AFReA3wSZATSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVS8guwnWoThS26dPnDhKwtiM2riDxoMz3Vwkh1fjx+jYbsa3ukxldA7exP+3HlMY/Eb9TuZCbSKt8R8K058AErMz2DBNe/9/evGOm8iJqedwBkIb2OhY37OFYjIukF8Lorqef/MCMZyH+EsCK3YPSPAdAU02iRIJrWYenRh3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B95RCwE025154;
	Sun, 8 Dec 2024 21:35:43 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1s0q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Dec 2024 21:35:43 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 8 Dec 2024 21:35:42 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 8 Dec 2024 21:35:40 -0800
From: <jianqi.ren.cn@windriver.com>
To: <rand.sec96@gmail.com>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <m@bues.ch>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon, 9 Dec 2024 14:33:33 +0800
Message-ID: <20241209063333.3426999-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SiBZPaKevIPTTAKJ3DrdTYBHXsaLpCLe
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=675681af cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=maAJvPpQ-1jnF_CgM8MA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: SiBZPaKevIPTTAKJ3DrdTYBHXsaLpCLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_02,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=686 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090044

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]

The ssb_device_uevent() function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
ensuring that the pointer is valid before attempting to use it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index d52e91258e98..aae50a5dfb57 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.25.1


