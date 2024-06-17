Return-Path: <linux-wireless+bounces-9137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242F290BD09
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 23:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEECD1F22A0D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104908480;
	Mon, 17 Jun 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iJoD4/BS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C951190693
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718660473; cv=none; b=eSSwpibBh2CLwl9kK4H/8S3YnGcOYnBA8qWxYXqk/jHUo6Zx0YKVVZxBP4aEuin9OSS5CDoecUNYg0O4VX4vUvhwahuaEw7cEQOLzKFQkSITqwEWic7klkkAdpe7dgVOR5e+pDwmYZw03mAeQdXYN+YoFySUglXdLsFWQOKeHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718660473; c=relaxed/simple;
	bh=u6vMC8T5e7qlHqWEP8EBZJ0CKet+4P8/t1Tx3l6F3+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mTt7F7tjVBFUozjXTJnWfTEyeL6bGJgbhZvZD26DAiD+Q7+O9e7odJrxivsiKpi9x+fYrjKGJkZsHPkzcs4LwXKZ9wnBWd/OSQZc+c//S2Q+vphrf0sd6ttUckcO2xMG4zX+HDivERGgrkIGsdye+Duatnh2BHCa0lDUGKLFmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iJoD4/BS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHwINC014938;
	Mon, 17 Jun 2024 21:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+XEv25AeEXOCbpq7xrT/sJI7wsH9BqIwKNpiXTJkYA=; b=iJoD4/BSLWpP3Vl7
	HWJ5qErR43RLUsSmco7NtZKFkiRMFDy7I6QPpZxlegDDXcN9VEqfWDI2lEilqYtn
	2W01zNbt7MSQtRWq4yHz0TQEEjh3apCe0BwlkfP5KOIoD+UnHsUU2AH03gP71i6z
	/0uJIwaq9T9uhQU3m2pbUPy/UOO5+fX/3aQ+sCviC+Mr6BwLtddO5VKwBRAi/JRc
	pOeQgj28doq8qnJh58KvKCY9vBhjiiWDeWJu76INEsKO+Sluv3UD+el0acWoaxrO
	u8/X1eW+mM5fHveVOmkARFEw6YrUQaMOJkaCZnQIMKseTgtPu+iAbmfDwYaBRSl5
	61J/HA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt0trghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:41:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HLf5tw004757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:41:05 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 14:41:05 -0700
Message-ID: <65ec9320-4286-4470-af7a-e00932713475@quicinc.com>
Date: Mon, 17 Jun 2024 14:41:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] wifi: ath12k: Fill pdev id for fw test cmd
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
 <20240617052903.2720292-5-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240617052903.2720292-5-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vaHxfuZzNMLlCEDnR9Pn0ZM9K4lgHlp3
X-Proofpoint-GUID: vaHxfuZzNMLlCEDnR9Pn0ZM9K4lgHlp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170167

On 6/16/2024 10:29 PM, Aaradhana Sahu wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Currently pdev id is not set properly that can cause crash

s/properly that/properly. That/
s/cause crash/cause a crash/

> if pdev id is not equal to the pdev id when firmware test
> command is run during AP bring up or ping.
> 
> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
> issue.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
> index aa9904de296f..f81564a4e6de 100644
> --- a/drivers/net/wireless/ath/ath12k/testmode.c
> +++ b/drivers/net/wireless/ath/ath12k/testmode.c
> @@ -320,9 +320,10 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
>  {
>  	struct ath12k_wmi_pdev *wmi = ar->wmi;
>  	struct sk_buff *skb;
> -	u32 cmd_id, buf_len;
> -	int ret;
> +	struct wmi_pdev_set_param_cmd *cmd;
> +	int ret, tag;
>  	void *buf;
> +	u32 cmd_id, buf_len;
>  
>  	mutex_lock(&ar->conf_mutex);
>  
> @@ -347,6 +348,12 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
>  
>  	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
>  
> +	cmd = buf;
> +	tag = le32_get_bits(cmd->tlv_header, WMI_TLV_TAG);
> +
> +	if (tag == WMI_TAG_PDEV_SET_PARAM_CMD)
> +		cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
> +
>  	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
>  		   "testmode cmd wmi cmd_id %d  buf length %d\n",
>  		   cmd_id, buf_len);


