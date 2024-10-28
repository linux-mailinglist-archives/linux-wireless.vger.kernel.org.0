Return-Path: <linux-wireless+bounces-14606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F2E9B32DC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32198282721
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03C1DD550;
	Mon, 28 Oct 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hTY/NJej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D71DD547;
	Mon, 28 Oct 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124546; cv=none; b=DzTAoYYG0Q0QyrdZWxJu8JqWqfMROUdi8GGA392ATJHJ45dtL5SJYOm6OWDTmpi8NpDuoUY9Cyn1OAnsX/YfM4jZlYyXY3g7K4QxWx16OCDRDYY9BJQR7Zzm4SlYNxA4iHZHkwPoS6aRPoEHlydJEbhuxbTMBL8FZW6J+vi5SGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124546; c=relaxed/simple;
	bh=oKhIZPEnSEfcEKdXa3+2tY+wLlmSTAmm3LOY8kq93dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eV+Jz0LLF8O65HfYvNF+ZA6KMfgXlNatQg6EiHMl4pjIheini8rQFUy2DHPqML7qykMq+ToTvOymgFQfZCYLUh9L01rnYrIhXHT/Vc5i3Ty2w3/7fXwI2TsoAmzSMtqsdnox0XCFwL77VRAI6X3Z/R6kd2SF4ks3sc1i0CRryP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hTY/NJej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SAj2Uf022992;
	Mon, 28 Oct 2024 14:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=02KEb+GZb3EqyEdbi0ZKCQ
	J9sjYgLaBg4YbjIePF+Dk=; b=hTY/NJej0mzt75cQm5YqobRBZBFxY4ihZTEpgd
	FQ1ylOwveK5WxlXNKr7WbLPJ1HZffOS30CG0HFeiSDMG6t3M5b5LTj/IZS3wCGaH
	VSPR5XxgNezusB85raVvfZ0Xnc3lIfKtYVTFF3PzqI+/sisHuyzgERYivKpYUIjS
	egagvo6jSGMpJQex1Kj+//ZZ4m19k7wecfNMG37TpK+NDP2hfx6Ma1qLC5FxzMhp
	wP7MXAeMdCGgxb3J20ZUpNhMtgnJiSVNecuTbkdT+bVd8ALIeqXIUITR/s4wh9+T
	eHwoorMwY8GJ898cX1pwofBL8NuAwgSS/8fwXDDLpggdE6xw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt6w5mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 14:08:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SE8pCI001886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 14:08:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 07:08:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 28 Oct 2024 07:08:40 -0700
Subject: [PATCH] wifi: ath12k: mark QMI driver event helpers as noinline
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241028-ath12k_qmi_driver_event_work-v1-1-0d532eb593fa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOeaH2cC/42O0Q6CIBiFX8VxHU2Q1LrqPZpjCH/xzwkJRjXnu
 4c+QZffds53zkIiBIRILsVCAiSM6F0GdiiItso9gKLJTHjJBSv5iarZMj7IaURpAiYIEhK4Wb5
 9GCioc1NWWghlGpIVzwB3/Oz6W5e5VxFoH5TTdpNmFx0Vui1qMc4+fPcjiW2FPzcTo4y2fV3xl
 rO2NuI6vVCj00ftR9Kt6/oDzFJSGeUAAAA=
To: <ath12k-devel-internal@qti.qualcomm.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Arnd Bergmann <arnd@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lCpZeS_j_RfWys6-w64f4zA4uqEA4Ei4
X-Proofpoint-GUID: lCpZeS_j_RfWys6-w64f4zA4uqEA4Ei4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280113

As described in [1], compiling the ath12k driver using clang with
KASAN enabled warns about some functions with excessive stack usage,
with the worst case being:

drivers/net/wireless/ath/ath12k/qmi.c:3546:13: warning: stack frame size (2456) exceeds limit (1024) in 'ath12k_qmi_driver_event_work' [-Wframe-larger-than]

Nathan [2] highlighted work done by Arnd [3] to address similar
issues in other portions of the kernel.

ath12k_qmi_driver_event_work() itself is a pretty lightweight
function, but it dispatches to several other functions which do the
real work:
ath12k_qmi_driver_event_work()
	ath12k_qmi_event_server_arrive()
		ath12k_qmi_host_cap_send()
	ath12k_qmi_event_mem_request()
		ath12k_qmi_respond_fw_mem_request()
	ath12k_qmi_event_load_bdf()
		ath12k_qmi_request_target_cap()
		ath12k_qmi_load_bdf_qmi()
		ath12k_qmi_wlanfw_m3_info_send()

Mark all of those underlying functions as 'noinline_for_stack' to
prevent them from being inlined in ath12k_qmi_driver_event_work(),
thereby eliminating the excessive stack usage.

Link: https://msgid.link/bc214795-1c51-4cb7-922f-67d6ef98bff2@quicinc.com # [1]
Link: https://msgid.link/20241025223321.GA3647469@thelio-3990X # [2]
Link: https://lore.kernel.org/all/?q=f:arnd@kernel.org+Wframe-larger-than # [3]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b93ce9f87f61..d2d9d03c7a28 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2066,7 +2066,9 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_chip_info_valid = 1;
 }
 
-static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_host_cap_req_msg_v01 req = {};
 	struct qmi_wlanfw_host_cap_resp_msg_v01 resp = {};
@@ -2275,7 +2277,9 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 	return ret;
 }
 
-static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_respond_mem_req_msg_v01 *req;
 	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp = {};
@@ -2433,7 +2437,9 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 	return 0;
 }
 
-static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_cap_req_msg_v01 req = {};
 	struct qmi_wlanfw_cap_resp_msg_v01 resp = {};
@@ -2619,8 +2625,10 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	return ret;
 }
 
-static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
-				   enum ath12k_qmi_bdf_type type)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
+			    enum ath12k_qmi_bdf_type type)
 {
 	struct device *dev = ab->dev;
 	char filename[ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE];
@@ -2791,7 +2799,9 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	return ret;
 }
 
-static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 	struct qmi_wlanfw_m3_info_req_msg_v01 req = {};
@@ -3079,7 +3089,9 @@ ath12k_qmi_driver_event_post(struct ath12k_qmi *qmi,
 	return 0;
 }
 
-static int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
 {
 	struct ath12k_base *ab = qmi->ab;
 	int ret;
@@ -3101,7 +3113,9 @@ static int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
 	return ret;
 }
 
-static int ath12k_qmi_event_mem_request(struct ath12k_qmi *qmi)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_event_mem_request(struct ath12k_qmi *qmi)
 {
 	struct ath12k_base *ab = qmi->ab;
 	int ret;
@@ -3115,7 +3129,9 @@ static int ath12k_qmi_event_mem_request(struct ath12k_qmi *qmi)
 	return ret;
 }
 
-static int ath12k_qmi_event_load_bdf(struct ath12k_qmi *qmi)
+/* clang stack usage explodes if this is inlined */
+static noinline_for_stack
+int ath12k_qmi_event_load_bdf(struct ath12k_qmi *qmi)
 {
 	struct ath12k_base *ab = qmi->ab;
 	int ret;

---
base-commit: 8a58dcd8db9c7af1187f0236d71a99cbbe146f6a
change-id: 20241025-ath12k_qmi_driver_event_work-ea9703c44ad7


