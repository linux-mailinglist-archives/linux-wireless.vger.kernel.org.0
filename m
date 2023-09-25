Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446DF7AD477
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjIYJZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIYJZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 05:25:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB74FC0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 02:25:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P91X20009677;
        Mon, 25 Sep 2023 09:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uK7WjOd5sVmT1QP1QKi8Lj9Fx/VPr9j+ll9X55PnXTY=;
 b=hGGZZ1ZYg91ZSEed7d9FjLZKlPo/nJ5uTm/nv+6QZcJ11vNQItAE2fufnG6yMY3kE5dz
 YvGSJXHBcGmUKF7PIaL48njJkHbbYVoXBZlmEh7TOsw3sliNhDdfvFtbXvyzER0K6aTo
 vR7sMAzk53TXjNx94Y3PswCSfVCi+hO4+3kVAxXRN0wRNmnc5BhCUzHZ6i5pUpEcKOxW
 Kd9AJVBo9NqwUNQwdey/61apRGjQTSwcoXgxGCKXYsqPDzVA50QH5YgUv2hIn1vlyN6Z
 ILyH/wPSD24wZmU/t7JYcULBqfzGNeMjnJ4FxUKdoSlJecHIJun+8IsiQ4V1GT2Sn7E6 kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72sg1p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 09:24:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P9OwgC029493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 09:24:58 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 02:24:57 -0700
Message-ID: <e1594171-6859-6b93-e865-3216975e6135@quicinc.com>
Date:   Mon, 25 Sep 2023 17:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ath11k: add trace log support
Content-Language: en-US
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hhz7owki1JFB3dmWvCZvgVB3GKamHIR5
X-Proofpoint-ORIG-GUID: Hhz7owki1JFB3dmWvCZvgVB3GKamHIR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=717 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250067
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/9/2021 2:35 PM, Venkateswara Naralasetty wrote:
[...]
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 5ae2ef4..80f7760 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -249,6 +249,8 @@ static int ath11k_wmi_cmd_send_nowait(struct ath11k_pdev_wmi *wmi, struct sk_buf
>   	cmd_hdr = (struct wmi_cmd_hdr *)skb->data;
>   	cmd_hdr->cmd_id = cmd;
>   
> +	trace_ath11k_wmi_cmd(ab, cmd_id, skb->data, skb->len);
> +
>   	memset(skb_cb, 0, sizeof(*skb_cb));
>   	ret = ath11k_htc_send(&ab->htc, wmi->eid, skb);
>   

This will trace 3 times because ath11k_wmi_cmd_send()

calls ath11k_wmi_cmd_send_nowait() 3 times when the credit is not 
available.

Any one know how to change it with a good way?

[...]

>   
