Return-Path: <linux-wireless+bounces-15510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782799D2A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4ED1F2380A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3291D095E;
	Tue, 19 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TZbPbM8h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E131CD1FA;
	Tue, 19 Nov 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031275; cv=none; b=do7jifA/j9BbTXL49xAr9en2YRpZKGGF63vALZ9ie4Qx0h03ZYSPZYuKFjneiBXhNBI5jMJLf249YwxhlJ+JOgjz6fDpCsg0KlUf3JPW4wvRH/q3+5YkSYrmDqnipjcsx00F/gMbd8nrb9vTJYXupjXyNoSpcIzTqRHto1de4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031275; c=relaxed/simple;
	bh=5MF/eHFxhz4lLiYgNMoLEJmeQOGm6mspTqQslf4kDSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fe7+p7puCF+9QHwLIjsMx0oPoiN5NEXA5UgWBES5h+Hn/gd7F8ZhVLOg/2+WfuRwOsnCoN7t/4KGNiiuz1XRx3EaNWA+WfMGesFN4zUwUSON11yRzDdySOOrolG1z79xdr0nOSA46GBip6Q8mcTifOigQ5+oezQN+eRgC7oXAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TZbPbM8h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7tGMx004845;
	Tue, 19 Nov 2024 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X087BfXQg6BD2sjwe/yB8ONSWahVOcFU4h791bEZ9Vk=; b=TZbPbM8hEKGGsMq+
	vFjKsZP4Bl78ijmIuXj9kmJimJIjYXCZji2UMt0dTmwpa8tchlDy8c++rHbsp6rg
	KRaDzBGWw/I4JiJKMVaJm31U+4lyIJKM3wJk1FDur2vZIGmTCE1fUUPVn5zI+oie
	XfD//vhss4Y0XDy6iHcfuBAjhWWBGDCBh2dQqxNMzpN+k0dRubp0LPH2+9k6KbjT
	sUAhTzrJBjNmtkx/esoNcShR3oLXYHYacBkrR6ULX021DOqDfzCufNaoExGU8lAc
	8f8aU6PdFTWlCXzoaBcosg960FYKkYHNec34kGbAIXh4cxQEsDeNfyepvCbA60Hg
	SkMSgA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7ty0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJFljoW020030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:47:45 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 07:47:44 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Nov 2024 07:47:38 -0800
Subject: [PATCH 1/3] wifi: ath11k: mark some QMI driver event helpers as
 noinline
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241119-ath11k-noinline-v1-1-4ec0a8aa30b2@quicinc.com>
References: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
In-Reply-To: <20241119-ath11k-noinline-v1-0-4ec0a8aa30b2@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Arnd Bergmann" <arnd@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ANTenyc0ixLNJC7vqakfpwpD54qyl3Hy
X-Proofpoint-ORIG-GUID: ANTenyc0ixLNJC7vqakfpwpD54qyl3Hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190117

When compiling the ath11k driver using clang with KASAN enabled, the
following warning is observed:

drivers/net/wireless/ath/ath11k/qmi.c:3199:13: warning: stack frame size (1560) exceeds limit (1024) in 'ath11k_qmi_driver_event_work' [-Wframe-larger-than]

This is similar to the issue found in ath12k/qmi.c that was discussed
in [1] and fixed with [2]. The issue is that clang inlining can
explode stack usage.

Just as in ath12k, ath11k_qmi_driver_event_work() itself is a pretty
lightweight function, but it dispatches to several other functions
which do the real work:

ath11k_qmi_driver_event_work()
	ath11k_qmi_event_server_arrive()
		ath11k_qmi_fw_ind_register_send()
		ath11k_qmi_host_cap_send() *
		ath11k_qmi_event_load_bdf()
	ath11k_qmi_event_mem_request()
		ath11k_qmi_respond_fw_mem_request()
	ath11k_qmi_event_load_bdf()
	ath11k_qmi_wlanfw_m3_info_send() *
		ath11k_qmi_m3_load()
	ath11k_qmi_process_coldboot_calibration()

Of these, the two marked with * have non-trivial stack usage. Mark
those functions as 'noinline_for_stack' to prevent them from being
inlined in ath12k_qmi_driver_event_work(), thereby eliminating the
excessive stack usage.

Note that this approach is a bit more "surgical" than the ath12k
approach as only the two functions with the largest stack usage are
modified.

Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
Link: https://patch.msgid.link/20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com # [2]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 7a22483b35cd..5759fc521316 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1704,7 +1704,9 @@ static const struct qmi_elem_info qmi_wlfw_fw_init_done_ind_msg_v01_ei[] = {
 	},
 };
 
-static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req;
 	struct qmi_wlanfw_host_cap_resp_msg_v01 resp;
@@ -2570,7 +2572,9 @@ static void ath11k_qmi_m3_free(struct ath11k_base *ab)
 	m3_mem->size = 0;
 }
 
-static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 	struct qmi_wlanfw_m3_info_req_msg_v01 req;

-- 
2.42.0


