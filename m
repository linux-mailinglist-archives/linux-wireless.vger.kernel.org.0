Return-Path: <linux-wireless+bounces-22694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF2AAD067
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06226987573
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF121930D;
	Tue,  6 May 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlBoKgbq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D8217642
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568178; cv=none; b=WGHpu0/7yyTv4Xq8KQSr5tvGb+ApcyNNpnhVJkz+brfmWkG/goAykex4UJ6PRSuumo5ym3NQ8m35i7eY9HML10mZLR8m2ndOuu6rLDqt894CxMy2XsF2YQechd1sJDpprlrAa8MvQziFJmG4fIPmQmmcdE5qpG3gPxx+R7tTSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568178; c=relaxed/simple;
	bh=JYIXCtF6UkvyNmPkcQXAeyXEohZIlLoCQZSNaYklCFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s2bEm9FtAyPTTA0J3Pe38v9uBGqpw9vRAsPWMRt1zNXXJV3yvDiPx5a7NvD+xwxcprpTVvtAa1MFT64aeJkJJaDPLe6ucXf4SKZGzY1BWuZe12Dz9KXJKw1XCuaDxY7rgNk6tu5aWuPr5vscL42Svyh+XPIPFXHSMNlL7Q+8Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OlBoKgbq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546I1VUQ010433
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 21:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W9HX03+YwTjD0p3Pm9mbuzNSJnPwRup4V0f
	UOLX2ono=; b=OlBoKgbqO6U9BX3Rgi6xRYK+ipFWBQehjGCalFNohhsDsEEW+K4
	DCKIZ3PMqGZu6UOGX8wdSGdFYPXxgRAbiIZyBFK338AOJQ2hnZKcBn5AjaPitYgk
	8v+wzsWmRqdtlseA7eTANL1wRGyB2vq0HAItIWrDmYRfKIOcF6uI9PrTqSB8Moec
	m6qv5118MiMb63MpKeO1aiF/S3fUz65CenzPevfg84igPKyAtWm88ZbBMzqlJHNy
	522VPWUhRY9OSpqf/wZ8dBYtm2MFlQFldppa6zD37QgMDUNCHk03MXwqAENeO0Ir
	TXtomPPPrlDRR5X7EnCRBoLLqbV+HcNAOLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tbbmw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 21:49:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30aa397f275so423147a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 14:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746568174; x=1747172974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9HX03+YwTjD0p3Pm9mbuzNSJnPwRup4V0fUOLX2ono=;
        b=uwGn9JH0vdaiyMgZewzG6bLQdUE1g0Iym1QnBt2y60dDPW0UMUOrKxI7+NYV7vaF91
         pwnZyr2gJsQuG3o6pmNrI4DecHtxPIXm26CAtEsEPNYdxzvXORs2HeDhjXF3mt/II3YE
         l8+Y3Kg0nqQ6Z/PGDBlfn8dw7nbvYU3PlzoQpph8NaiIsrW3va6+7UhgxX+bPINlasEu
         bkJxoAt2qsC1Miv0VgC4Nzzde6HP4XAaEWFt9pMfQjZdCGy5ZliqlZhCSCwpjdBhax3y
         ej2P1ZZvOff9F4XudyYCiTO34lHyOlYfnshsqdNB3tcRyrR19j2ASuBqZf2aYE6G7hFE
         mXFg==
X-Gm-Message-State: AOJu0YzBk5uYDTLFiumoiLADM/FkEEt5jvueo727eeVd5Qef0ZkDu40w
	ahjsbXfcPU/N9572T5q3hCvSAvJP1H/eyCvPDdw6642E4Qv479eFFmpw93JnSFfoi36zUw9tY0O
	r/ZMju0vKemD3L1cXhFHqrFxe6dTKEgbgk0i47zS4ULf3tEP7t1atP2hLdETWCL2xnQ==
X-Gm-Gg: ASbGncvRAsIss6CLSVgqYVJziPjLMPd1pNZoSJ4RRHRb84VQlyWhDPiQ//K6nX+Zp96
	wZnjT7BLeN1hyiNCm14VBWZDbbuuCNK2ZcDzt9KA1xlPd+dGRPhUu5b99HtGjVMgB9NnA34DA4o
	bsfuIdvUJoYppOH+zi/6vbt0fRFSV7j2bxZ/HN4dJLboMik+quQDptSbaSXCAPkKpvYjg6bySmv
	anAqY3GJ2P5FWAN9zr1clRwKWk6JcaRmHGkfW1IhlvuxTH6XtGBUwla4asgeHaE2OHLjwOOdM9T
	LlPbXHrrl8Lyk7lUfd1g58QYSoaYSEjcKAnLii8kOCCHDZGPbizxkNlUg4ByeZn9g+4/
X-Received: by 2002:a17:90a:d607:b0:305:2d68:8d55 with SMTP id 98e67ed59e1d1-30aac16e23fmr1558272a91.8.1746568173598;
        Tue, 06 May 2025 14:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNDAOC8xgiVJIRLDotk5v4mn6JYnAC2r4DGiO6+vNgrKydCn8CW/ULlyfk64tWkX3FFLiDzw==
X-Received: by 2002:a17:90a:d607:b0:305:2d68:8d55 with SMTP id 98e67ed59e1d1-30aac16e23fmr1558247a91.8.1746568173179;
        Tue, 06 May 2025 14:49:33 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaebec8ddsm361537a91.14.2025.05.06.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:49:32 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: disable pdev for non supported country
Date: Tue,  6 May 2025 14:49:30 -0700
Message-Id: <20250506214930.3561348-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RNc8aHQrLVjLfatndbYgsllSqSL9XOrj
X-Proofpoint-GUID: RNc8aHQrLVjLfatndbYgsllSqSL9XOrj
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=681a83ee cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=HtYUS7siLqOggL-nrXkA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDIwNiBTYWx0ZWRfX1uN3P/4ZK8ov
 yHpO8sL3xP+C6pv7Sn8SgI1moB+QLVcv6iQWIKlg4pbDlw8svVNPK8wgOPWCunX+E2A6LSjWhTK
 zjTJ/SqNjYlc+p5rcmcAESuIdMBJj2EZrFLG865DY1AT22Q5TO9V+HAi2GR2+nVlcepAjdwxEnz
 +OIHbDxTz6z9J7ig55ueBoFyO/wglyR5jGUWjTmGT/cgu7UDU7F/VS/P7iOZI/A1mObAi9S5U/6
 LZ4nVUgasNJKXS9zgu8oCOBQSEMYdvJ6Fx+3UCYgVEulMzOVnSHzabnPjlZec5Yvyrj21kJ02iX
 QNavc93v+I0QF3VLpLU6nZIOMEFiSEYp8/dwVRmryv9u3fr++My8vRP6f866i3qyXbgdpojz+Pq
 Yk8zbkfBbW1R3dYNl+xkSPlCXjyFdKqHpiZ6X6r54NUf2lHcwb651Am+yhHaoc2fDvKfkOTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=751 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060206

From: Karthik M <quic_karm@quicinc.com>

In MLO configuration, ath12k_mac_radio_start() iterates through all
the radios and makes the ar state 'ON'. Even though some bands are
not supported in certain countries, ath12k_reg_update_chan_list()
tries to update the channel list for all the active pdevs and ends
up in the warn_on for non-supported band.

To prevent this, disable the pdev when the number of channels across
all bands supported by the pdev is zero for a particular country.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthik M <quic_karm@quicinc.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 +++++++++++-
 drivers/net/wireless/ath/ath12k/reg.c |  7 +++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..f731a5759ac3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7726,7 +7726,17 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath12k_reg_update_chan_list(ar, false);
+	ret = ath12k_reg_update_chan_list(ar, false);
+
+	/* The ar state alone can be turned off for non supported country
+	 * without returning the error value. As we need to update the channel
+	 * for the next ar.
+	 */
+	if (ret) {
+		if (ret == -EINVAL)
+			ret = 0;
+		goto err;
+	}
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7048834e0d14..a6c9c670e91d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -65,7 +65,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 
 		for_each_ar(ah, ar, i) {
 			ret = ath12k_reg_update_chan_list(ar, true);
-			if (ret) {
+			if (ret && ret != -EINVAL) {
 				ath12k_warn(ar->ab,
 					    "failed to update chan list for pdev %u, ret %d\n",
 					    i, ret);
@@ -181,8 +181,11 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 		}
 	}
 
-	if (WARN_ON(!num_channels))
+	if (!num_channels) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "pdev is not supported for this country\n");
 		return -EINVAL;
+	}
 
 	arg = kzalloc(struct_size(arg, channel, num_channels), GFP_KERNEL);
 

base-commit: 885e5cbaa0ee3738fcd99167439459ede2cc102c
-- 
2.34.1


