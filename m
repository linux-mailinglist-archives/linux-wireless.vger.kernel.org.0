Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882F86E227D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDNLoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNLoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 07:44:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A47D81
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 04:44:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EBgYDl022385;
        Fri, 14 Apr 2023 11:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hseGeoWDrV+maYM9edTomm12DRL5c1CT2cwDL6EUD0s=;
 b=Qx6zHdbULbwrHfiLc+Wj5oA+assPMLl8R2F1Z1f4vDNGSFbrFBafDtjPBFAnpXPUY4hc
 LCjSyg2bDDSMxDHGDrawFS18NPVL8oOf7xG3Qx0f6a8SFyRWq5rzLW5t9v1NjI3iKWj7
 zIEthrLE0NsG2kwYe9L39+WlgBwnF29ispcPQRmMn2EZfeKt56wwDNoqPtBNyWyOS9O0
 OYe7fC1rxRRwCo1OJZWNRhl49O4o3XRxBV0mkdpo+EFoIVf+R3OYRoo5isao8An5X1W3
 m2mdeImIStrgCjw3tttIqd+79I+Sw3WOmGkQKsbSn0myAnxSSM6xlqzTXqnzjApQXalr Ww== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxxhkh0y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:43:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EBhsmF011691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:43:54 GMT
Received: from [10.216.60.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 04:43:52 -0700
Message-ID: <66552ea9-5212-1c43-98fa-5c29fcd1457c@quicinc.com>
Date:   Fri, 14 Apr 2023 17:13:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] wifi: ath11k: Add rx histogram stats
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k-bounces@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
References: <20230405132804.226681-1-quic_mkenna@quicinc.com>
 <87zg7ass6r.fsf@kernel.org>
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <87zg7ass6r.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XqZ4SOsuZfH_LlSJvOj1w25c2UH6eatc
X-Proofpoint-GUID: XqZ4SOsuZfH_LlSJvOj1w25c2UH6eatc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=572 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304140106
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/14/2023 3:26 PM, Kalle Valo wrote:
> Maharaja Kennadyrajan <quic_mkenna@quicinc.com> writes:
>
>> Add peer specific debugfs support to store and
>> display peer rx stats info like HE, VHT, HT,
>> legacy and NSS.
>> Also, add a debugfs knob to reset rx stats
>> specific to the peer.
>>
>> This helps  to debug the throughput related
>> issues in the UL traffic(STA to AP) by getting
>> the segregated rx_stats info like HE, VHT, HT etc,.
>>
>> There is no addition of new debugfs_file here to get
>> these segregated stats. The exising rx_stats is enhanced
>> to get these stats.
>>
>> Usage:
> This isn't right:
>
> To:     <ath11k-bounces@lists.infradead.org>
>
> Please use the correct address and resubmit as v2.
Sure Kalle, I will send the v2 patch to correct mailing address.
