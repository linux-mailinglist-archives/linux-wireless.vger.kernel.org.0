Return-Path: <linux-wireless+bounces-568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA480983B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15382823B7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D5A32;
	Fri,  8 Dec 2023 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xaovjfqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208021BFF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:54:15 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B80aq7E007678;
	Fri, 8 Dec 2023 00:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hjrOs9j/VugZGmBVLVIsfa089L7TlJJ1W+3kc4q0ycE=;
 b=XaovjfqytCA93Or7V8qUG54LFDfZu0HrhQc8sTbpDDBgaJ4xO84+QWXgLWcECsyZbDz0
 YZ30U9ocTMbXgCFhs0ZLDLfajvL+hdpbHb40wNzWyLjRCuzx1tov9bIxJUEFRChzcGpE
 Wt5WFWYea8EJEtdtkgK6JsymX2YyO9flUT+8eeKI476lIAzpQUcXdKdkR/UD1tNGYDf8
 KlUDeJ3nC8XcB3SdP/QKUFP63YjNaGE+5t+QpflV/cII9H5Srn8TwokIo6yQjf56bJe/
 KWHd1bJUQmrQMqXiZbMGfHbY6IoF/Stp3CcgCjQFN9cpwK5ayOQJ1gxIi/Ct1I/dt4HC tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2p8b74q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:53:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80rn37019108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:53:49 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:53:48 -0800
Message-ID: <cfad2ad7-213e-454c-9108-a52f56ae2c01@quicinc.com>
Date: Thu, 7 Dec 2023 16:53:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13 v2] wifi: iwlwifi: pcie: add another missing
 bh-disable for rxq->lock
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Brian Norris <briannorris@chromium.org>
References: <20231208183100.e79ad3dae649.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231208183100.e79ad3dae649.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CjRPw2QLv8AUjHGs5q3jU_EvdGSrlpM1
X-Proofpoint-ORIG-GUID: CjRPw2QLv8AUjHGs5q3jU_EvdGSrlpM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=890 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080005

On 12/8/2023 8:32 AM, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Hi,
> I Added the 'wifi' prefix
> 
> Thanks,
> Miri

you don't want the above to be part of the git history

> 
> Evidently I had only looked at all the ones in rx.c, and missed this.
> Add bh-disable to this use of the rxq->lock as well.
> 
> Fixes: 25edc8f259c7 ("iwlwifi: pcie: properly implement NAPI")
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---

instead you should have added the v2 change log here, "after the cut"

>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index f39c436f0b6d..fc64e1e7f5ee 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -3092,7 +3092,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
>  	struct iwl_rxq *rxq = &trans_pcie->rxq[0];
>  	u32 i, r, j, rb_len = 0;
>  
> -	spin_lock(&rxq->lock);
> +	spin_lock_bh(&rxq->lock);
>  
>  	r = iwl_get_closed_rb_stts(trans, rxq);
>  
> @@ -3116,7 +3116,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
>  		*data = iwl_fw_error_next_data(*data);
>  	}
>  
> -	spin_unlock(&rxq->lock);
> +	spin_unlock_bh(&rxq->lock);
>  
>  	return rb_len;
>  }


