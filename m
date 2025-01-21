Return-Path: <linux-wireless+bounces-17771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F6A1769A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 05:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD11884E1E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 04:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2B1898F2;
	Tue, 21 Jan 2025 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XRIjjuFN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D983BBE5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434419; cv=none; b=eJWKAGa9FfyaxHPHrBL/e5p9hHPpke9YxcmT+wyT9vDCLAX1jWRHhrgDwX5OTZ3Cc7jHgC1XDPG4TaR+KoeCTuWHzXWyPuBLRY5leQyl1/9DVgQiBtM8yRev7MIKKsiNgNGrcgQJ03icwwLbEsq4GFWVznujEtbu+e2CBbI8ZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434419; c=relaxed/simple;
	bh=jBsflptO+lzsQFEiG4Ykc2dSZYPFyJY+htKPxciWwOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZBgoFRRC7P56JAj5gTR4BURVDr+NoHjcywotaWBoLUmo+Vsu64BluDk/RX2byXgiAYCR7t2K61M4AG4jB+XZxf9AvYjt39syRRKvC8vNLTPQHRedfXft6XSbEjYWn/dl054KuuIwbDPJXZ6Q/SZOTHGpTUl5ENH5rerFybdttCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XRIjjuFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KNGsVE014241;
	Tue, 21 Jan 2025 04:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eLZ66EA0oEnYbbajR85OhvcVgHaE3xcQ3t0bbCkABPw=; b=XRIjjuFNZwfF8ig4
	a+HnoPMHkPzGkyW+/9SInnpIj7zYvJnLaoc5SvXqblpowlDkw7/LiCETiQFlN148
	ff6GkdYHvC5lxT10tEc5M6EFizWG7986mR5RKEA4zH2AemvxyklVgXyFM4/qfZh+
	iUrOol8Boa/G4bfGMZJexIzp9O+/Octg2ANM00pGlXy22I6qbr+14C16479xXv13
	KDlkqBhCQwOxncOPCe00OMLIzPSGNQjfgtTGS8+UYCeQeaKin7Ss86Luzkn+aSg3
	mazKbceOhBSqUZRHEXe3ENavHQl4tsw9Rss6oZiBOYZkW+oqWUj0zk04wCr8Gqqf
	z8wTNA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449xxcgk9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 04:40:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L4eBoW021583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 04:40:11 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 Jan
 2025 20:40:09 -0800
Message-ID: <b38164bf-3ea3-41d4-8387-330623257ad8@quicinc.com>
Date: Tue, 21 Jan 2025 10:10:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: Add WMI control path stats infra
To: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <rajat.soni@oss.qualcomm.com>
References: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250120184447.658660-1-ramya.gnanasekar@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W4p38yunCZkTZwmfCqte6pnyVepkPfTO
X-Proofpoint-GUID: W4p38yunCZkTZwmfCqte6pnyVepkPfTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=735 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210035

On 1/21/25 00:14, Ramya Gnanasekar wrote:
> @@ -559,6 +559,13 @@ struct ath12k_debug {
>   	struct dentry *debugfs_pdev;
>   	struct dentry *debugfs_pdev_symlink;
>   	struct ath12k_dbg_htt_stats htt_stats;
> +	struct ath12k_wmi_ctrl_path_stats_list wmi_ctrl_path_stats;
> +	enum wmi_tlv_tag wmi_ctrl_path_stats_tagid;
> +	struct completion wmi_ctrl_path_stats_rcvd;
> +	u8 wmi_ctrl_path_stats_reqid;
> +	/* To protect wmi_list manipulation */
> +	spinlock_t  wmi_ctrl_path_stats_lock;

nit: extra space between type and name

@@ -92,6 +243,11 @@ void ath12k_debugfs_register(struct ath12k *ar)
>   	}
>   
>   	ath12k_debugfs_htt_stats_register(ar);
> +
> +	if (test_bit(WMI_TLV_SERVICE_CTRL_PATH_STATS_REQUEST,
> +		     ar->ab->wmi_ab.svc_map))
> +		ath12k_debugfs_wmi_ctrl_stats_register(ar);
> +
>   }

drivers/net/wireless/ath/ath12k/debugfs.c:251: Blank lines aren't necessary before a close brace '}'

-- 
Aditya

