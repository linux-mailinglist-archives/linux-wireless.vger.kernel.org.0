Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4895678D308
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 07:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjH3Fm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjH3FmG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 01:42:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE390FC
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 22:42:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U4U0Y5005151;
        Wed, 30 Aug 2023 05:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fXB+I5cpp1GRCVEYZ9qHgnkX45uwzaaNxWlfwgzVaAU=;
 b=h01hbVR0nQ/dd0FLkUG2Bq9CpIiFuzRz9XV18ZzHuxY6Lf92UF1CuwvWbeZBYwhnCEOK
 g1ooF54cdlhD0MD+YXy3qEcUEI5cHoN6UY7xCMEOsA2GjO5OxVdJ4yfunhe4khD+CpKg
 G6OAHRTb2KDFPcowoMQf3NhpyB+Di7HH+kulkRQIvBTNnKq6QndA/7lxXvEshKiFy+2h
 FZ7BpTXjD835PRXW0NA/tCOETIp/DmnnNnXBxsoMohI+tNsmL81i/hRVQfRDJ/RqAVqu
 N8xXh3B+TjC6yulYbAdEh1gZYgFctryB49mVwtDQnhyDkcvJGHKtcDYnfN+RAtoIEOVw Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv008d15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:39:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U5Yf18021152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:34:41 GMT
Received: from [10.111.178.80] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 22:34:38 -0700
Message-ID: <477607e8-5d56-437c-9c77-c1a46feb01ee@quicinc.com>
Date:   Tue, 29 Aug 2023 22:34:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix possible out-of-bound write in
 ath12k_wmi_ext_hal_reg_caps()
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230830020716.5420-1-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230830020716.5420-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Be1eQmgvm3muuX7ybsbK267uk-rNEzJ4
X-Proofpoint-GUID: Be1eQmgvm3muuX7ybsbK267uk-rNEzJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=822 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/2023 7:07 PM, Baochen Qiang wrote:
> reg_cap.phy_id is extracted from WMI event and could be an unexpected value
> in case some errors happen. As a result out-of-bound write may occur to
> soc->hal_reg_cap. Fix it by validating reg_cap.phy_id before using it.
> 
> This is found during code review.
> 
> Compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index ef0f3cf35cfd..a8a7fa9f71cf 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -3876,6 +3876,10 @@ static int ath12k_wmi_ext_hal_reg_caps(struct ath12k_base *soc,
>   			ath12k_warn(soc, "failed to extract reg cap %d\n", i);
>   			return ret;
>   		}
> +		if (reg_cap.phy_id >= MAX_RADIOS) {
> +			ath12k_warn(soc, "unexpected phy id %u\n", reg_cap.phy_id);
> +			return -EINVAL;
> +		}
>   		soc->hal_reg_cap[reg_cap.phy_id] = reg_cap;
>   	}
>   	return 0;
> 
> base-commit: a62b0aeb556839fb6abb9835874443b08fe95598

