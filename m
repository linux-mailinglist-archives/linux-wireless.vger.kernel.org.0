Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE37ADAE4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjIYPF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjIYPF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 11:05:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74D101
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 08:05:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PENWkR008140;
        Mon, 25 Sep 2023 15:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+cqfdTIiPv8R5ERGjFj0EWFXtCpyYL+Dj52qrdHozsQ=;
 b=HeSxho6Q0dQ8gkOuYt9uXumGMusNiIsLKHRLsfH5bsDTY7B/ktUQYw7O/EVtpP2gwmx9
 JxQFamHrnHUS/RXyYVsyjpqmzjL474/zGFKQ9q431t5wFnlUpgVGstfD5lOxrRL2FP2e
 JxpVMNCz94aXY53LT+Q86Eov0F/ljrezn9Aq55uLjp8v/1oW22YeR2XHfstrPX0CgJ3D
 ncDZmh1TR130Bd9GTX/bpCYpDPgpdlSndA5xryk7HiNoWtWgnEta0YYtL79ULRapZsla
 LJQSF2TePYoKTHvBxczQrpNwY07a2QqugpqT8rqxkN5BfXynC/0t+MXn3MLrWZ1jlZDv qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72sgs9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 15:05:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PF5jhQ009444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 15:05:45 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 08:05:45 -0700
Message-ID: <7cb8dae5-81b6-4a01-84d3-cb60484a8bb5@quicinc.com>
Date:   Mon, 25 Sep 2023 08:05:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: add trace log support
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <1636439755-30419-1-git-send-email-quic_vnaralas@quicinc.com>
 <e1594171-6859-6b93-e865-3216975e6135@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e1594171-6859-6b93-e865-3216975e6135@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4qn05n8YQLhSvApi63dphis2xJN_2l2b
X-Proofpoint-ORIG-GUID: 4qn05n8YQLhSvApi63dphis2xJN_2l2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_12,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=844 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/2023 2:24 AM, Wen Gong wrote:
> On 11/9/2021 2:35 PM, Venkateswara Naralasetty wrote:
> [...]
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c 
>> b/drivers/net/wireless/ath/ath11k/wmi.c
>> index 5ae2ef4..80f7760 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>> @@ -249,6 +249,8 @@ static int ath11k_wmi_cmd_send_nowait(struct 
>> ath11k_pdev_wmi *wmi, struct sk_buf
>>       cmd_hdr = (struct wmi_cmd_hdr *)skb->data;
>>       cmd_hdr->cmd_id = cmd;
>> +    trace_ath11k_wmi_cmd(ab, cmd_id, skb->data, skb->len);
>> +
>>       memset(skb_cb, 0, sizeof(*skb_cb));
>>       ret = ath11k_htc_send(&ab->htc, wmi->eid, skb);
> 
> This will trace 3 times because ath11k_wmi_cmd_send()
> 
> calls ath11k_wmi_cmd_send_nowait() 3 times when the credit is not 
> available.
> 
> Any one know how to change it with a good way?

my first thought is to have an iter = 0 variable in 
ath11k_wmi_cmd_send() and to add that as an additional param to 
ath11k_wmi_cmd_send_nowait():
ret = ath11k_wmi_cmd_send_nowait(wmi, skb, cmd_id, iter++);

then the trace logic would change to only trace on the first iteration:
if (!iter)
	trace_ath11k_wmi_cmd(ab, cmd_id, skb->data, skb->len);

