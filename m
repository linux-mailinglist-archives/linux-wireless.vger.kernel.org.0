Return-Path: <linux-wireless+bounces-34217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDzgAu/Zy2kaMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1336AF2D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CC653026327
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D883F23C7;
	Tue, 31 Mar 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQGoefPY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPvaewTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED993FADEC
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967117; cv=none; b=mTnb9Vl5bdtGkM542aNkcI+OEfSeppqUW2/rnkkVzn82fspHV41gyonZa+JXRONiFVMQ2hBVEYe9A/1XOv7OiKmCnuzfGymyAIeMHET0ZjSeU/ZEW0jJmorBaAqbwJ5YiADMsnNzYPMSXoxgV8PhxHWF2Fl7yRimhkj47HlJlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967117; c=relaxed/simple;
	bh=teJmW1oSvif3QibAl+oHsAOLOWfSqfg8HQyk1FnTMag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mh22PQ3qRddCwx3D1HIVPM6UFh31aGw6TeWxohxfJzX/bVs75Ox9uitmgGy++V1/AahlQ37oARROVVVNcZ9MKZ1L2g10d1HfMujpCQ07YLgjrLZXnmmopx9IM2ctviEoWxoduJQp0waL58i4qsppcpVhusM695OSpDfLOJ3Qti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQGoefPY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PPvaewTk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8jsR82049373
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TZTsrksisFx
	LaWu20Z7AaA5AMHfImBufO5srupJpSUo=; b=VQGoefPYNjqCzv7zeA5uGKKaqtW
	VIJ/k4v42mZXUtbBFUsvSWIiMK0Bv4+cEiAhs9U31emVFGRWdZhHPDhrHYD9C3U+
	n8rElOKIX3ycdQfXcd2d3Jt0WRWCDnF0ymPvl235RKOdLssctVwSX78lGWFMvD+W
	laA2WxK0wHX8xHQAswzlvC5bazXwcTrd47s9L+ilMzcHL7jyopiehB9XeAh+nX9+
	PhszPEZolVBaK1lSZgk7oPVFKVxh81KFSotbHYIEW10PZxBp//VjdhPA/n/hdH/A
	ZAfQ9fq1Kx3koXdLZDQXcvczBolmEmzeByz2XnwPalTTKvBgNVonkBR94Zw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1ysck8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b23c909256so49264065ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967114; x=1775571914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZTsrksisFxLaWu20Z7AaA5AMHfImBufO5srupJpSUo=;
        b=PPvaewTkXrBLWeeyGTQ7MXfLzAqXDilGT+xYaOTrWULiKQ68cSJdB9afKlg6wpEYrD
         /Tcvfb3SnHTY0Bt+z1wNowu/K0VxjJE1GyiH9vdDsONPpS5SJAgBs1baWfSrd76o0VQp
         rHXFP4LyYHSlwhEABxHD2DtHJyCOVxOEkJTj+tTlTzae0HGLp/oyn9ARm7JhaKBpe7XE
         EBHA/mKUxs5toS356aAJhORGDzvQnw8XJspxeS6ul1k8u7Oqq3SqOgw6X5ZUV0oVRQEy
         54SKvFVlWUzTx029TNu5UdVx3Knfwnl+GT2soCkgV61MpNF3LfinCPv1ZclXpZe0d6Ak
         ppIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967114; x=1775571914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZTsrksisFxLaWu20Z7AaA5AMHfImBufO5srupJpSUo=;
        b=c3GZIlISfUK+cv6/PGPGMt75AogZ+CkoTcUFnZ7nOcjcFfsCdNqhlF64w9ytzsuWtb
         tRB5qHHm12nquvgpAGRjwRruoDUfDgjbtQkzh1IL+B1of7RawK+yeVDWm0bDL10pm6Jg
         WTKY2FBJyQYsnNMuLhsSZytbFgWBJWdM4ofwm2QrN9kppERfV1MzkdrOPuOxwyQf1Wk2
         pkN5BP6nt+Gno+c5aHo5/uGni7wAcaxZsHCYTYI0K8VY4QljwidxSL14YbHALV++rHOO
         kHyt//W3jAQnqRmXfCQaau+ff/LqOM4ICRb4w80OAZBXbg8j97J3Z6N3P/RpFOcSkmkw
         iWfQ==
X-Gm-Message-State: AOJu0Yy8a5xN/kUIE5HAtmhtJLWIPeavjLm2qykTNmg6+2IK63cXvld7
	uN2vvQcb07ibHrLikYcechUM3rr4/MbjZgeF0Pciv4yABSiCRhivHayV6AcK057dGv+p9zjDuAn
	g2VQH8Le3OkWrgSrIrOkCNb7OK/MuAOm8FcZCpGjduIO4wI8Dmo+8euWRmrhxdNi33zUhuw==
X-Gm-Gg: ATEYQzwZqLw2S/DTcynq3OlJcB5YPeVn3yulbj/e+JwXmcpxDgdCQ2XF5t6/P2rBMwg
	dQ7vTwTGjmeJE8gIsf305ENCBrKTxnPYQk/M/jNx5RS8TsWcN37nCU/+Ro3Kj9ZUc0qQML/dMQE
	wrlAJnnq/fN4Nw6v/nqArUhPmDWgmtDDJfE4f0hnhHF8UzB7Pycq2JuNq9G01KP2KSORcT3UCo0
	DnjmTz99WKdVmTS617rCDF5NqRrLnJ5USOxL++HF8y/jMm1uV9xeiVKFOok4K+Dsmmrz1qQp9D5
	fsxEJlM3/z7kuJO7SvnOOno463k+j74+Y7XDPqoee7e9Suxz8lKyuWdI94xLzNfL8krzOF7beKi
	ii6Lx8XI8QCWdBlmo4uK9LuLsvqwwqTsh4x7kaJfIqp430jRLLg2hnh4yDD0157j2rOAZAv4k5k
	7I/mjhc5zYTW+C1Q1/D+AUNzeZhBx9SeFlJqDroZFgsVgORHTUPyQ=
X-Received: by 2002:a17:903:13d0:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0cdd18cd6mr202046715ad.40.1774967113960;
        Tue, 31 Mar 2026 07:25:13 -0700 (PDT)
X-Received: by 2002:a17:903:13d0:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0cdd18cd6mr202046245ad.40.1774967113244;
        Tue, 31 Mar 2026 07:25:13 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:12 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 5/5] wifi: ath12k: add thermal cooling device support
Date: Tue, 31 Mar 2026 19:54:46 +0530
Message-Id: <20260331142446.2951809-6-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cd4nlLQPzqzXRsixsfeFDUJUhsJUA5vg
X-Proofpoint-ORIG-GUID: cd4nlLQPzqzXRsixsfeFDUJUhsJUA5vg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX/hxCDip7b9it
 evuA3TstgKVtyC1ig9LVV7qYaYlqckc1SQqO19XHpiD2i4qB2RcGOeK8x88bC7+iCoSbgAzylNB
 ZZ0Mt1ya7PcNvuZh1QWkenjO27o+xgAf6lw1wIUMgO5cMmLqpTN3TdJGhMYebaU4j8hFoSvGGVh
 SPkl4cWBBi32QGp91rOpuOh9rSpy4Vx1EN9Jdkv6DWkPW1wi9FwWsAriPbnlDL6ugk0zMCMJUR8
 uG8ODW9evTBpO2WBG5Vl1FdSibwkMpiuXl6GP7gPFUuyqEjTHBIAOPqGwyABToanZOhoVzTD8Jm
 3qLJDMMf7gph2HiYfKw7vt/zGLnlc8tKGsuhDZT75MQcuAO4Z+Fm5eEsarvbNNoWyeZ3XALEyod
 5A8Va1wTdP2PJZEbmQyjk/lzQmxb3pCjva1KAL/aubaTPAX8/KOQT/S3/l2p4VsFLmafr9Dxpa9
 B+CIj54fYqyehxF9qJg==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cbd94b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=mMz0IJLIata36CLxof0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34217-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9DE1336AF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add thermal cooling device support to control the temperature by throttling data
transmission. Throttling is performed by suspending data TX queues according to
a configured duty-cycle off percentage. The thermal cooling device allows users
to configure the duty-cycle off percentage and operate the device with the
selected value.

User configuration updates a single duty-cycle off percentage, which is applied
uniformly by the host and treated as only one temperature level. This value
remains in effect until updated again by the user. All other thermal throttling
parameters continue to use their default firmware provided values.

Reject invalid duty-cycle off percentage values that fall outside the supported
range. Register a cooling device to allow the thermal framework to query and set
the current throttle state, report the maximum supported state, and keep the
host state in sync with successful firmware updates. A throttle state of zero
restores the default firmware thermal configuration.

Command to set the duty-cycle off percent:
echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/cur_state

Command to read duty-cycle off percent:
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/cur_state

Command to read the maximum duty-cycle off percent:
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/max_state

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c     |   1 +
 drivers/net/wireless/ath/ath12k/thermal.c | 107 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/thermal.h |  14 +++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 21430a70aa7c..40395c9a8bea 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14821,6 +14821,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->completed_11d_scan);
 	init_completion(&ar->regd_update_completed);
 	init_completion(&ar->thermal.wmi_sync);
+	mutex_init(&ar->thermal.lock);
 
 	ar->thermal.temperature = 0;
 	ar->thermal.hwmon_dev = NULL;
diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index 6f70c11c1098..97fc49c40ac1 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -76,6 +76,73 @@ void ath12k_thermal_init_configs(struct ath12k *ar)
 	ar->thermal.tt_level_configs = &tt_level_configs[cfg_idx][0];
 }
 
+static int
+ath12k_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	*state = ATH12K_THERMAL_THROTTLE_MAX;
+
+	return 0;
+}
+
+static int
+ath12k_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	struct ath12k *ar = cdev->devdata;
+
+	mutex_lock(&ar->thermal.lock);
+	*state = ar->thermal.throttle_state;
+	mutex_unlock(&ar->thermal.lock);
+
+	return 0;
+}
+
+int ath12k_thermal_set_throttling(struct ath12k *ar, u32 throttle_state)
+{
+	struct ath12k_wmi_thermal_mitigation_arg param = {};
+	struct ath12k_wmi_tt_level_config_param cfg = {};
+	int ret;
+
+	param.num_levels = 1;
+	cfg.dcoffpercent = throttle_state;
+	param.levelconf = &cfg;
+
+	ret = ath12k_wmi_send_thermal_mitigation_cmd(ar, &param);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to send thermal mitigation cmd: %d\n",
+			    ret);
+
+	return ret;
+}
+
+static int
+ath12k_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long throttle_state)
+{
+	struct ath12k *ar = cdev->devdata;
+
+	if (throttle_state > ATH12K_THERMAL_THROTTLE_MAX)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ar->thermal.lock) {
+		if (ar->thermal.throttle_state == throttle_state)
+			return 0;
+		ar->thermal.throttle_state = throttle_state;
+	}
+
+	if (throttle_state == 0)
+		return ath12k_thermal_throttling_config_default(ar);
+
+	return ath12k_thermal_set_throttling(ar, throttle_state);
+}
+
+static const struct thermal_cooling_device_ops ath12k_thermal_ops = {
+	.get_max_state = ath12k_thermal_get_max_throttle_state,
+	.get_cur_state = ath12k_thermal_get_cur_throttle_state,
+	.set_cur_state = ath12k_thermal_set_cur_throttle_state,
+};
+
 static ssize_t ath12k_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -132,6 +199,7 @@ ATTRIBUTE_GROUPS(ath12k_hwmon);
 
 static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 {
+	char pdev_name[20];
 	struct ath12k *ar;
 	int ret;
 
@@ -139,6 +207,28 @@ static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 	if (!ar)
 		return 0;
 
+	ar->thermal.cdev =
+		thermal_cooling_device_register("ath12k_thermal", ar,
+						&ath12k_thermal_ops);
+	if (IS_ERR(ar->thermal.cdev)) {
+		ret = PTR_ERR(ar->thermal.cdev);
+		ar->thermal.cdev = NULL;
+		ath12k_err(ar->ab, "failed to register cooling device: %d\n",
+			   ret);
+		return ret;
+	}
+
+	scnprintf(pdev_name, sizeof(pdev_name), "cooling_device%u",
+		  ar->hw_link_id);
+
+	ret = sysfs_create_link(&ar->ah->hw->wiphy->dev.kobj,
+				&ar->thermal.cdev->device.kobj, pdev_name);
+	if (ret) {
+		ath12k_err(ab, "failed to create cooling device symlink: %d\n",
+			   ret);
+		goto unregister_cdev;
+	}
+
 	ar->thermal.hwmon_dev =
 		hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
 						  "ath12k_hwmon", ar,
@@ -148,14 +238,22 @@ static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 		ar->thermal.hwmon_dev = NULL;
 		ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
 			   ret);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	return 0;
+
+remove_sysfs:
+	sysfs_remove_link(&ar->ah->hw->wiphy->dev.kobj, pdev_name);
+unregister_cdev:
+	thermal_cooling_device_unregister(ar->thermal.cdev);
+	ar->thermal.cdev = NULL;
+	return ret;
 }
 
 static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 {
+	char pdev_name[20];
 	struct ath12k *ar;
 
 	ar = ab->pdevs[i].ar;
@@ -164,6 +262,13 @@ static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 
 	hwmon_device_unregister(ar->thermal.hwmon_dev);
 	ar->thermal.hwmon_dev = NULL;
+
+	scnprintf(pdev_name, sizeof(pdev_name), "cooling_device%u",
+		  ar->hw_link_id);
+	sysfs_remove_link(&ar->ah->hw->wiphy->dev.kobj, pdev_name);
+
+	thermal_cooling_device_unregister(ar->thermal.cdev);
+	ar->thermal.cdev = NULL;
 }
 
 int ath12k_thermal_register(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/thermal.h b/drivers/net/wireless/ath/ath12k/thermal.h
index 33231bb3683c..30e7b0880e05 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.h
+++ b/drivers/net/wireless/ath/ath12k/thermal.h
@@ -7,9 +7,12 @@
 #ifndef _ATH12K_THERMAL_
 #define _ATH12K_THERMAL_
 
+#include <linux/mutex.h>
+
 #define ATH12K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
 
 #define ATH12K_THERMAL_DEFAULT_DUTY_CYCLE 100
+#define ATH12K_THERMAL_THROTTLE_MAX 100
 
 enum ath12k_thermal_cfg_idx {
 	/* Internal Power Amplifier Device */
@@ -26,6 +29,10 @@ struct ath12k_thermal {
 	int temperature;
 	struct device *hwmon_dev;
 	const struct ath12k_wmi_tt_level_config_param *tt_level_configs;
+	struct thermal_cooling_device *cdev;
+	/* Serialize thermal operations and hwmon reads */
+	struct mutex lock;
+	u32 throttle_state;
 };
 
 #if IS_REACHABLE(CONFIG_THERMAL)
@@ -34,6 +41,7 @@ void ath12k_thermal_unregister(struct ath12k_base *ab);
 void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature);
 int ath12k_thermal_throttling_config_default(struct ath12k *ar);
 void ath12k_thermal_init_configs(struct ath12k *ar);
+int ath12k_thermal_set_throttling(struct ath12k *ar, u32 throttle_state);
 #else
 static inline int ath12k_thermal_register(struct ath12k_base *ab)
 {
@@ -57,5 +65,11 @@ static inline int ath12k_thermal_throttling_config_default(struct ath12k *ar)
 static inline void ath12k_thermal_init_configs(struct ath12k *ar)
 {
 }
+
+static inline int ath12k_thermal_set_throttling(struct ath12k *ar,
+						u32 throttle_state)
+{
+	return 0;
+}
 #endif
 #endif /* _ATH12K_THERMAL_ */
-- 
2.34.1


