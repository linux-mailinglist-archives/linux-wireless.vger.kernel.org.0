Return-Path: <linux-wireless+bounces-4325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB986F871
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B245B20C0F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94494691;
	Mon,  4 Mar 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TeYDmS8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167A3C38;
	Mon,  4 Mar 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709518586; cv=none; b=m+cUAv88iFv6JxT/WuN7nPujHeFnZDIHltyGdErfBzcFHVEQpJyua8avpNFQaEa9cBK7mafNY0bkTA7TXag1Z2idLtnnZ1P6I/8h/WLctAidPO8gfTbIKQnR/Uj4JxwRXI2z8F46CK4v6k9PYpj18ei0BppghGMfKUYSD1oayUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709518586; c=relaxed/simple;
	bh=oE3m7Dp38KPe6mq/9hc6ZjrebiPai2WSQhcVljdiT8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqwLweMjE2tFJ3Pm9Y+pH1tBeKJpX3raLTXfGNvfGhn7axG+oKakPjj6D8o8SPWCYVFhqZ93m3Y3L3Z/yX3E9tQbPb2hFwLtudHG87fTayyatLWXwhCPKqhqgImlFaQF2ojyjtXloGhm8P5ns4VKNAdQ3yBRs0EBLIT4Gda7mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TeYDmS8Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4242GFCA003714;
	Mon, 4 Mar 2024 02:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+IpoNyuiAtv2+EoBg+w1v8CjyX44W22D8SIaFGXZ3BI=; b=Te
	YDmS8YEVV3VIbTBKrxoRzTS+W6WNeJDXevxCxzgcy9XlIEfL3xA9VfvSuiqlamLY
	c8Hmi8dftQ7L3F2sxxfbl+uO/fRocOjE3NvOVPN1WLPdSgWy6uXANN225vWpvjNf
	XEQjDNIatIPb8QtijT+GECGvbJkHHft7ABm0B7kSQOHk/ZuyoOWcWH2Okn0OvEaV
	Qg4fBwO7v+/4N2rraHDSfxvYxGH3AL87CRoHBtkxgcgPHwFDA3+YfY0gqXlxkMRB
	D5sBbEM0QYKddd5vVUDp0PoOdS0HyMcNAtJb9mr+592TsMTuEkY2m0pcBkM3TyCZ
	cbmbap+6pUf7xCBsQHug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkvb72d6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 02:16:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4242GEki013387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 02:16:14 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 18:16:11 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Date: Mon, 4 Mar 2024 10:15:52 +0800
Message-ID: <20240304021554.77782-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304021554.77782-1-quic_bqiang@quicinc.com>
References: <20240304021554.77782-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: wSBKsJRl11m4InQsGc93Xt_LzmXAWr-8
X-Proofpoint-ORIG-GUID: wSBKsJRl11m4InQsGc93Xt_LzmXAWr-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_01,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040015

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


