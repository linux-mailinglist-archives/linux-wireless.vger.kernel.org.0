Return-Path: <linux-wireless+bounces-4330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58086F9DD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 07:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096701C20969
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38860D52A;
	Mon,  4 Mar 2024 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kiu36mUz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C96BE4C;
	Mon,  4 Mar 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532604; cv=none; b=ZPpbrrkZQOrq0xT0L+DmAM8N6cCk6tf27oeVjO395z43k9BjwD9J7zHKmkRMBEjdTB7veu5xLv6JWiHlHm7c0ZgRqITdeTxa+1251zKByDuIvJXdCfR8NyM2sW1tumBO0yDfiTuuLfzdzsG50g1sjfyRp98HkS0m2ou030HXf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532604; c=relaxed/simple;
	bh=O+2KVhoYhvuSVIB3GnmL6CBtXP1HmUFefsgjpTNMQ/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGN8LpRt+NK4O+ddPPCeqDXbBLus+OxxMxqrnRw4uRe4VGfTp/X+f4IOSzgVA+korGyat55dRortNsohLunasvIFrXYTcJjJY54laGtCwQiguYMCHYgKEmf+O/FH0PogcHWayDEiFxwwilipLIWeFG+EOHqlP/l1vych61h0RN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kiu36mUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245w3Se007273;
	Mon, 4 Mar 2024 06:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FCA71/EkydD6L+S5dAxH0MUxD0fxgFeRcxVO8xql+dI=; b=Ki
	u36mUzTJNKB9FvZH3vl0OCFNY3xz8LbQ3bE8viSswcrvIuuUZjBHPX2GpLlOMmJi
	Js7a28VgF6aiUCGzt8iF2F5L17/un1FAr9ZVHWsTUV/qR09rz22bzK/Z86y3mRIH
	+D2Xyv3qKUo+L4KYg5GEuA4YVLbahla6PhRW/j4x9RYrxTpTlyqjAk+n/AEtM5eG
	1buLGlO2oG5C3hwhh+XVqH4lFL/2NVKaV1YkYJyeGl40+lF4J/qD4rSSyg6U7hI1
	uKaMD+n1Qkz5cmOWYU+1Tz8rPK/xA6p9b8lkPW6O2+Jqws8fftVBWEwnVB/vp0RU
	2IQnWILHL3Z3P9MTpN9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn5qc09a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 06:09:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42469mWu018726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 06:09:48 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 22:09:45 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Date: Mon, 4 Mar 2024 14:09:30 +0800
Message-ID: <20240304060932.80839-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304060932.80839-1-quic_bqiang@quicinc.com>
References: <20240304060932.80839-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nwQ-g-tuQyr2BvfUqk1oKc8Rs14meLqq
X-Proofpoint-ORIG-GUID: nwQ-g-tuQyr2BvfUqk1oKc8Rs14meLqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040044

ath11k fails to resume:

ath11k_pci 0000:06:00.0: timeout while waiting for restart complete

This happens because when calling mhi_sync_power_up() the MHI subsystem
eventually calls device_add() from mhi_create_devices() but the device
creation is deferred:

mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral

The reason for deferring device creation is explained in dpm_prepare():

        /*
         * It is unsafe if probing of devices will happen during suspend or
         * hibernation and system behavior will be unpredictable in this case.
         * So, let's prohibit device's probing here and defer their probes
         * instead. The normal behavior will be restored in dpm_complete().
         */

Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
called and thus MHI channels are not prepared:

So what this means that QRTR is not delivering messages and the QMI connection
is not working between ath11k and the firmware, resulting a failure in firmware
initialization.

To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
the devices for channels during power down. This way we avoid probe defer issue
and finally can get ath11k hibernation working with the following patches.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/bus/mhi/host/internal.h |  4 +++-
 drivers/bus/mhi/host/pm.c       | 42 ++++++++++++++++++++++++++++-----
 include/linux/mhi.h             | 18 +++++++++++++-
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 5fe49311b8eb..aaad40a07f69 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -80,6 +80,7 @@ enum dev_st_transition {
 	DEV_ST_TRANSITION_FP,
 	DEV_ST_TRANSITION_SYS_ERR,
 	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
 	DEV_ST_TRANSITION_MAX,
 };
 
@@ -90,7 +91,8 @@ enum dev_st_transition {
 	dev_st_trans(MISSION_MODE,	"MISSION MODE")		\
 	dev_st_trans(FP,		"FLASH PROGRAMMER")	\
 	dev_st_trans(SYS_ERR,		"SYS ERROR")		\
-	dev_st_trans_end(DISABLE,	"DISABLE")
+	dev_st_trans(DISABLE,		"DISABLE")		\
+	dev_st_trans_end(DISABLE_DESTROY_DEVICE, "DISABLE (DESTROY DEVICE)")
 
 extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
 #define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8b40d3f01acc..11c0e751f223 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -468,7 +468,8 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
 }
 
 /* Handle shutdown transitions */
-static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
+				      bool destroy_device)
 {
 	enum mhi_pm_state cur_state;
 	struct mhi_event *mhi_event;
@@ -530,8 +531,16 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	dev_dbg(dev, "Waiting for all pending threads to complete\n");
 	wake_up_all(&mhi_cntrl->state_event);
 
-	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+	/*
+	 * Only destroy the 'struct device' for channels if indicated by the
+	 * 'destroy_device' flag. Because, during system suspend or hibernation
+	 * state, there is no need to destroy the 'struct device' as the endpoint
+	 * device would still be physically attached to the machine.
+	 */
+	if (destroy_device) {
+		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
+		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
+	}
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
 
@@ -821,7 +830,10 @@ void mhi_pm_st_worker(struct work_struct *work)
 			mhi_pm_sys_error_transition(mhi_cntrl);
 			break;
 		case DEV_ST_TRANSITION_DISABLE:
-			mhi_pm_disable_transition(mhi_cntrl);
+			mhi_pm_disable_transition(mhi_cntrl, false);
+			break;
+		case DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE:
+			mhi_pm_disable_transition(mhi_cntrl, true);
 			break;
 		default:
 			break;
@@ -1175,7 +1187,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_async_power_up);
 
-void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+static void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
+			     bool destroy_device)
 {
 	enum mhi_pm_state cur_state, transition_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -1211,15 +1224,32 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+	if (destroy_device)
+		mhi_queue_state_transition(mhi_cntrl,
+					   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE);
+	else
+		mhi_queue_state_transition(mhi_cntrl,
+					   DEV_ST_TRANSITION_DISABLE);
 
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
 
 	disable_irq(mhi_cntrl->irq[0]);
 }
+
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	__mhi_power_down(mhi_cntrl, graceful, true);
+}
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
+void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl,
+			       bool graceful)
+{
+	__mhi_power_down(mhi_cntrl, graceful, false);
+}
+EXPORT_SYMBOL_GPL(mhi_power_down_keep_dev);
+
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
 {
 	int ret = mhi_async_power_up(mhi_cntrl);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 77b8c0a26674..cde01e133a1b 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -630,12 +630,28 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
 
 /**
- * mhi_power_down - Start MHI power down sequence
+ * mhi_power_down - Power down the MHI device and also destroy the
+ *                  'struct device' for the channels associated with it.
+ *                  See also mhi_power_down_keep_dev() which is a variant
+ *                  of this API that keeps the 'struct device' for channels
+ *                  (useful during suspend/hibernation).
  * @mhi_cntrl: MHI controller
  * @graceful: Link is still accessible, so do a graceful shutdown process
  */
 void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
 
+/**
+ * mhi_power_down_keep_dev - Power down the MHI device but keep the 'struct
+ *                           device' for the channels associated with it.
+ *                           This is a variant of 'mhi_power_down()' and
+ *                           useful in scenarios such as suspend/hibernation
+ *                           where destroying of the 'struct device' is not
+ *                           needed.
+ * @mhi_cntrl: MHI controller
+ * @graceful: Link is still accessible, so do a graceful shutdown process
+ */
+void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl, bool graceful);
+
 /**
  * mhi_unprepare_after_power_down - Free any allocated memory after power down
  * @mhi_cntrl: MHI controller
-- 
2.25.1


