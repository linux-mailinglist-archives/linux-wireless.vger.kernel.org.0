Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F355FD53A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJMGup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJMGuk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:50:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA11463A9
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:50:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D6GGxM010972;
        Thu, 13 Oct 2022 06:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6OIDCA1oxq6p7/yOMy8f8At7MzGN42WTJEdOinTHcQM=;
 b=hA+ExTeuAJt0UKXHtF05jL7oSDiG4hIB3CWpEnyTE7TDEDI41KA37wtUUISNRR2EuDWo
 ygofLqggKhB55id8M5W8wugJMV0ejTDAHvpCuECpzR/6dyIc89ow15uRZHmZF8w2GSIk
 eRKL3W2Ys1Wa3mRKi2bv2/GrKYyfmpJ5tb8W8N5WXjg/kPy1zZrJjiXspeG54zEkEQjB
 JalxebA2xu6fX9rKAPvge7gU8fjpYW6YwCwn/XMVeBhpUUSR4XHjZey6t4DJ1dbosdpK
 umqi0pyiL+CdtFHaGCZR1kfzfQSTgRokHqwgFwddL8wBcRTYNZHE/MP5NNksX9hO7/B8 uA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k643h1naf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 06:50:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29D6oS3W015380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 06:50:28 GMT
Received: from [10.110.65.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 23:50:26 -0700
Message-ID: <0e4a896d-1d57-166b-9cef-fd551d22464b@quicinc.com>
Date:   Wed, 12 Oct 2022 23:50:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Content-Language: en-US
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
 <SN6PR02MB433498DC221CF70BE3B6CE63F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <SN6PR02MB433498DC221CF70BE3B6CE63F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZfZfgKTE4KW6dIJtnrv5LdK_bOkNHupZ
X-Proofpoint-ORIG-GUID: ZfZfgKTE4KW6dIJtnrv5LdK_bOkNHupZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=569 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130041
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/2022 4:39 PM, Sriram R (QUIC) wrote:
>>> +     elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
>>> +     if (!elem)
>>> +             goto free_desc;
>>> +
>>> +     elem->ts = jiffies;
>>> +     memcpy(&elem->data, rx_tid, sizeof(*rx_tid));
>>> +
>>> +     spin_lock_bh(&dp->reo_cmd_lock);
>>> +     list_add_tail(&elem->list, &dp->reo_cmd_cache_flush_list);
>>> +     dp->reo_cmd_cache_flush_count++;
>>> +
>>> +     /* Flush and invalidate aged REO desc from HW cache */
>>> +     list_for_each_entry_safe(elem, tmp, &dp->reo_cmd_cache_flush_list,
>>> +                              list) {
>>> +             if (dp->reo_cmd_cache_flush_count >
>> ATH12K_DP_RX_REO_DESC_FREE_THRES ||
>>> +                 time_after(jiffies, elem->ts +
>>> +
>> msecs_to_jiffies(ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS))) {
>>> +                     list_del(&elem->list);
>>> +                     dp->reo_cmd_cache_flush_count--;
>>> +                     spin_unlock_bh(&dp->reo_cmd_lock);
>>> +
>>> +                     ath12k_dp_reo_cache_flush(ab, &elem->data);
>>> +                     kfree(elem);
>>> +                     spin_lock_bh(&dp->reo_cmd_lock);
>>
>> is this really a safe iteration if you unlock & lock in the middle?
>> what prevents the tmp node from being deleted during this window?
> The reo_cmd_cache_flush_list is used in only two contexts, one is this
> Function called from napi and the other in ath12k_dp_free during
> core destroy. Before dp_free, the irqs would be disabled and would wait
> synchronize. Hence there wouldn’t be any race against add or delete
> to this list. Please let me know if that’s fine.

please add that as a code comment since unlock/do something/lock is a 
"code smell" so you should justify the smell

