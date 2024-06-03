Return-Path: <linux-wireless+bounces-8448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F28FA618
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1C285FE5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA913CABC;
	Mon,  3 Jun 2024 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YYZMFLwx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1349F9E9;
	Mon,  3 Jun 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455468; cv=none; b=euIazc6mpU3veJiGyeRoCiXrO+dmVBr6sH8H8zEHapNooyFNfSDKrfCKlJp9GAuj1iVnzbqFfSePkZ9qcAebICgVkHMQhaXg3brJ6ZQRlseyy/e7MVWBkol6Var75N5o9tVTktbjfp35U9cicJ0TSbHzvBI4/PrHwO2Fh8Dsrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455468; c=relaxed/simple;
	bh=KqPryLWc7zoc2VYG8QXuXcI0TeNlclWzwv+GWOys33s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bZrFOKckARhNwmaanuTcC8PsuhR7TfvCflBC8xQtOErmmteguTTJ9pgGlSXjrO/2dwwqt9t2/HPdjWm1izTIdTdbLJmQOU4biHswpsPasMPRvLh6aO9kiDpy09FEqt/8iL1z0lJV/+85jXnlkrVooGTft9S+TjajVRASBFinXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YYZMFLwx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453Bl8qM017816;
	Mon, 3 Jun 2024 22:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4QY+F1FJbsM/wDJgEBzeFcAgoh0auxhIr9S0zEFsxk=; b=YYZMFLwxjWhT35F6
	YBOKzW3GwNCoPchaIgQN2YgatIGOBj7Y3CFIM/b53d0mzsEQz9Mpw7jdAoAJ1I/F
	IYilULFa9UP9NWGIPE3i3YVt/WYMvx2vjWPyysVvOTkIRB/PmgEQ7SKDypuJ7Cp5
	Zr5dYxXrL3Xo258U2toVn/U8G7MJhlahlEFj9U8UjCVxZ3yf/fplopQPqjLj0lqb
	0uPCYgzj2aD1o95bn3d7B2fdqWj5wtXr5eMbixFMlCJhQMUzLVngvX+snstvWrho
	MZfUgCUEw95C97gqLJJpI0uNPABKiKrFFSwefio/9Q62DJj/5dJxsto907NGBgav
	dCZ1Eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw3r5e1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 22:57:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453MvZjH001996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 22:57:35 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 15:57:28 -0700
Message-ID: <47cc9455-6efb-4b1c-8743-c992e502633d@quicinc.com>
Date: Mon, 3 Jun 2024 15:57:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath11k: use 'time_left' variable with
 wait_event_timeout()
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
 <20240603091541.8367-2-wsa+renesas@sang-engineering.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240603091541.8367-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gFeYGuRClnezr6hNISr4C3GIahKB3ZbI
X-Proofpoint-GUID: gFeYGuRClnezr6hNISr4C3GIahKB3ZbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030186

On 6/3/2024 2:15 AM, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_event_timeout() causing patterns like:
> 
> 	timeout = wait_event_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index d4a243b64f6c..2fe0ef660456 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2859,7 +2859,7 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
>  
>  int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
>  {
> -	int timeout;
> +	long time_left;
>  
>  	if (!ath11k_core_coldboot_cal_support(ab) ||
>  	    ab->hw_params.cbcal_restart_fw == 0)
> @@ -2867,11 +2867,11 @@ int ath11k_qmi_fwreset_from_cold_boot(struct ath11k_base *ab)
>  
>  	ath11k_dbg(ab, ATH11K_DBG_QMI, "wait for cold boot done\n");
>  
> -	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
> -				     (ab->qmi.cal_done == 1),
> -				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
> +	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
> +				       (ab->qmi.cal_done == 1),
> +				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
>  
> -	if (timeout <= 0) {
> +	if (time_left <= 0) {
>  		ath11k_warn(ab, "Coldboot Calibration timed out\n");
>  		return -ETIMEDOUT;
>  	}
> @@ -2886,7 +2886,7 @@ EXPORT_SYMBOL(ath11k_qmi_fwreset_from_cold_boot);
>  
>  static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
>  {
> -	int timeout;
> +	long time_left;
>  	int ret;
>  
>  	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
> @@ -2897,10 +2897,10 @@ static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
>  
>  	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait started\n");
>  
> -	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
> -				     (ab->qmi.cal_done  == 1),
> -				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
> -	if (timeout <= 0) {
> +	time_left = wait_event_timeout(ab->qmi.cold_boot_waitq,
> +				       (ab->qmi.cal_done  == 1),
> +				       ATH11K_COLD_BOOT_FW_RESET_DELAY);
> +	if (time_left <= 0) {
>  		ath11k_warn(ab, "coldboot calibration timed out\n");
>  		return 0;
>  	}

This looks ok to me, but note that changes to ath11k go through the ath tree,
so, unless Kalle has a different opinion, this should be submitted separately
from changes that go through the wireless tree.

