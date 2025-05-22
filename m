Return-Path: <linux-wireless+bounces-23311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CEAC0C88
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161279E39BC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130B286D65;
	Thu, 22 May 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Axp2lyKP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE52F85B
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919831; cv=none; b=oL6HcbV+dAo4EmNpDolu1Ir/b3TRyOoi77lF8V7hRpmnCLl5RkLNusFq6kJmPSHYZ+FQ84lKGnW8HQqhuZU9GaWcX9oxAg7qxUvSVIWFuIwlV6qB9wKa2f/DJLcQtAD4aPFOnICV2TtYwYiK5PDqYU6oz/bu5l0CLh3vo/PSRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919831; c=relaxed/simple;
	bh=RSwQl3JZI0zqWFzhajklchAACege2EEFN70e8Yj/Z1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kV9+uxAj0E6YADz9dzanFaqfeG+4mmQyu72/HjEssdJVduFtVWZ4JbidViz3HnrMgkqxRjh2Vzbm7KpN/UP5Esz7M3S1oLT13uEU+CZQEkp/s3SEQb/MtHRrMcVgnrSk+0iqxD60NGOjZmsk3Ld+rZgyDxXmBk7onGMGXMhsVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Axp2lyKP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7hBir031739
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 13:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Xv+dLfIlgEKxHBEJuwgEq4mtTaTF543E1/R
	XKGoWHO0=; b=Axp2lyKPZ5EvyB8wQzk3I8YCAa+nZul6ZeV3xCrRg8bR2OB2vJ4
	NbferIpAlpYLBKIhRC3XqumnWf4fZC5XrhvI00G2Zy00scnuLFNWJOYNO6QDYE/U
	bp5FwtufukFXS50eaIPn71HC0yhT5v1+GkIAR4SC7k4InqtYVLBtZXU+HIokINuv
	1CmyJUJlf1xVK2rWU9NS/cqneZcrw5iswuTLgLjXrhrm6JvziiQPXvXrsb76V0HO
	lO66hEwZjQ/iCEe/J+ytDcWJv1x2GjPuOKrcuoWjwIOn74L7a1GPSBaGNSiChQE+
	yg0lALTLM27ukK5mGTJJlAf9RE6cFVcsxTw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c251ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 13:17:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c543ab40d3so1187268085a.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 06:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747919827; x=1748524627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv+dLfIlgEKxHBEJuwgEq4mtTaTF543E1/RXKGoWHO0=;
        b=VOk5rwPgGqhxPt108kKWjGQK6XPBaPjIl+pl0/EEr39etAqEwMKiDbWvck/TTy4X7N
         NNsgjqXiFrQeNPZ88Wn/zJrvBTYFpkWDqqPrDxjqOGNP3URXLnyZ2nkymH/zRkob0RNQ
         WKp3CzHK25olpEj77+xDS7/asIIxmhDhSzAA0awrkwjQesOR1pmZjKFswNnSl9VuNQkE
         3wYbnSFiyzQZvocdSc39bwMOucrFsldHSlgE/k76NoXwOW8gQBol7LUktgow5vk4a0de
         fzapIUISVaMl4E9/lAtC3m2cvoql3f03GoCnEroigz4Kt2qDUQ6RfF8rgKBUmNHZrnTu
         KPtg==
X-Gm-Message-State: AOJu0Yyss8gkxGn5hfPLFADgAmwd83QmjImyqCAXVfgM1LdO8STc608M
	J+bQpzNiKMM3PNT9ylCXjjdEiJJ20Fx2Kcb8lnKlAoLahrWSOZ+qtM+36Jw5kAHVNuGBmanfxmU
	AkVm0146sXHuWZ7Q42UlUJlqHNWJ/U/m+crgDclbTgHBu0hmYmxgtizmGFNnt7d6T4RvYdQ==
X-Gm-Gg: ASbGnctGsN79dpYMXGQ1S7JO0NsoutG99G2FbTCnSQ5/KUQYStFiWWMJNaKEhAEMtx/
	+PmvEL74hirsR7404apfH1xjrQoJ2VHns/7xFId8pk3lrueXqNWbHl7YIHSjgkU9/B167+ndhOT
	4cUm8LrxyG3GfG0x7G+34AUAlHJaXjG1dAIh1BNd3pLRVbNHq4zedbZIJKkpNbFbSmsglKXhhEo
	EQ8UnBAxaL25bJfZssMJ9H8Ir+TgrsJq+K9XgcjWj4GYOC9ORXTHNmepzJSuCXTmBc2TlHiAbYc
	/o6BkpwVfrlRCQQAREOWESkZhyfzgH5CGMOK2PeLm8/jCdk=
X-Received: by 2002:a05:620a:4493:b0:7c7:6667:ade5 with SMTP id af79cd13be357-7cd46733233mr3097575885a.27.1747919827516;
        Thu, 22 May 2025 06:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50oZ4KZSZvY1ONbiRasISJNNHhay39+Eu0obi2aFnFlLHSm2lwNV6tT9/2rbZj8GX6Bi7IQ==
X-Received: by 2002:a05:620a:4493:b0:7c7:6667:ade5 with SMTP id af79cd13be357-7cd46733233mr3097573385a.27.1747919827126;
        Thu, 22 May 2025 06:17:07 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:e5bc:5c94:e4b3:3c4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8d005sm23677256f8f.90.2025.05.22.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:17:06 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath10k: Avoid vdev delete timeout when firmware is already down
Date: Thu, 22 May 2025 15:17:04 +0200
Message-Id: <20250522131704.612206-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEzNCBTYWx0ZWRfX5dVj4qkw1sJQ
 rtez+wLuxWvey/3FZjEl0/v5Ikc4/lcYKm8oGCc6LH5byRyhEGxp8ujF26YKWE0nMyOL9JlfQO5
 trk2VBLPJhdNsjU8LjcGUYOumTuHQ4gCKmIy7F+SYZhbOH4f/mC5+Gz77gsjcDkabxMat8sWLuh
 jLbAiFFAXgzpTH+zDdcklEsfAczFS+Utk6cFVwflKwC8cZH6nUI5qmPEB8IDbMAmwmEZHfKXx8g
 /e64efx6vFtNJeqK6aYw6br36SKFj3+7aC0Wf11br9stLvNXoGa7VoKOLOKUBhs1lPN9vBFBx4c
 ZU3i3FErPOkeTMFibdaZ46k2yxBdlgvV5TzcrXBQQcgkc9NBo96mJf29m+wYKERCVR0vZdDiWUC
 EJdpiF+j3GGH3NLF2mApq1eXcNDBQMqFBK/VBuso2VB5cs9XXzF46Qo4zcNLOomFTBFpmlId
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682f23d4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=EUspDBNiAAAA:8 a=IzHPsgMo9mJ7Fn_I8X0A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fW1oHkodlj6p9Hp4Pg5U3fYBB5Dn277u
X-Proofpoint-GUID: fW1oHkodlj6p9Hp4Pg5U3fYBB5Dn277u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=770 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220134

In some scenarios, the firmware may be stopped before the interface is
removed, either due to a crash or because the remoteproc (e.g., MPSS)
is shut down early during system reboot or shutdown.

This leads to a delay during interface teardown, as the driver waits for
a vdev delete response that never arrives, eventually timing out.

Example (SNOC):
$ echo stop > /sys/class/remoteproc/remoteproc0/state
[ 71.64] remoteproc remoteproc0: stopped remote processor modem
$ reboot
[ 74.84] ath10k_snoc c800000.wifi: failed to transmit packet, dropping: -108
[ 74.84] ath10k_snoc c800000.wifi: failed to submit frame: -108
[...]
[ 82.39] ath10k_snoc c800000.wifi: Timeout in receiving vdev delete response

To avoid this, skip waiting for the vdev delete response if the firmware is
already marked as unreachable (`ATH10K_FLAG_CRASH_FLUSH`), similar to how
`ath10k_mac_wait_tx_complete()` and `ath10k_vdev_setup_sync()` handle this case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 32 ++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c61b95a928da..1df2617a82c0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1022,6 +1022,26 @@ static inline int ath10k_vdev_setup_sync(struct ath10k *ar)
 	return ar->last_wmi_vdev_start_status;
 }
 
+static inline int ath10k_vdev_delete_sync(struct ath10k *ar)
+{
+	unsigned long time_left;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (!test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map))
+		return 0;
+
+	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
+		return -ESHUTDOWN;
+
+	time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
+						ATH10K_VDEV_DELETE_TIMEOUT_HZ);
+	if (time_left == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int ath10k_monitor_vdev_start(struct ath10k *ar, int vdev_id)
 {
 	struct cfg80211_chan_def *chandef = NULL;
@@ -5900,7 +5920,6 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct ath10k_peer *peer;
-	unsigned long time_left;
 	int ret;
 	int i;
 
@@ -5940,13 +5959,10 @@ static void ath10k_remove_interface(struct ieee80211_hw *hw,
 		ath10k_warn(ar, "failed to delete WMI vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 
-	if (test_bit(WMI_SERVICE_SYNC_DELETE_CMDS, ar->wmi.svc_map)) {
-		time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
-							ATH10K_VDEV_DELETE_TIMEOUT_HZ);
-		if (time_left == 0) {
-			ath10k_warn(ar, "Timeout in receiving vdev delete response\n");
-			goto out;
-		}
+	ret = ath10k_vdev_delete_sync(ar);
+	if (ret) {
+		ath10k_warn(ar, "Error in receiving vdev delete response: %d\n", ret);
+		goto out;
 	}
 
 	/* Some firmware revisions don't notify host about self-peer removal
-- 
2.34.1


