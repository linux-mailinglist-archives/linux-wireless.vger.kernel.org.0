Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5387A8B3B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjITSJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjITSJh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30375189
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:09:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHKL1n026261;
        Wed, 20 Sep 2023 18:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nt4Ss+85durL6GZWDe0NgGhFyFK13LTwhwqza+lJ2MA=;
 b=lCX3q+woF/QCnE8IISQ78ytTxhzchplvZS6eyYssR/8iR7IBw4zpVeLP8P09syUZvdyO
 2Ns1Du03xbDeK+ffwM2nlWd28rWHhR0Goo9jVS1YCXuzrFcKHrOWqEQHIYz2d6RcznwX
 lkC1f+0XY8ii3xQZcUB1k1fS1hTpyWBwa1M5RXrhA+X0+w9TBXl3maWUQvvOaaRTnNd+
 Z6MGzzKw+WoiojI4wd6CxC8P4osNNtbhoTC4EdCS2tstBMo1aafNyV2CDQSt65fKijxD
 piYJdyaJsA4JnXEY6aMHAfrSiIYnqZgig+ihdeanj5VtNrNS05Vjoo78YlDo9m+4AFP8 1w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7sh3su2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:09:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KI9Ivl006444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 18:09:18 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 11:09:18 -0700
Message-ID: <4c9423bf-1667-45dd-ab06-e5183875a21d@quicinc.com>
Date:   Wed, 20 Sep 2023 11:09:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] wifi: ath12k: add support to select 6 GHz Regulatory
 type
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>,
        Aishwarya R <quic_aisr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-2-quic_aisr@quicinc.com>
 <4282f92a-3543-4863-bc00-478ae03759e0@quicinc.com>
 <46b69fe7-d007-18b0-baae-e59ffb035e42@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <46b69fe7-d007-18b0-baae-e59ffb035e42@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HxVbA9xIIBzmy26n1itSot4yXLtWZqbT
X-Proofpoint-GUID: HxVbA9xIIBzmy26n1itSot4yXLtWZqbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=618
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2023 7:10 PM, Wen Gong wrote:
> On 9/20/2023 1:47 AM, Jeff Johnson wrote:
>> On 9/19/2023 12:17 AM, Aishwarya R wrote:
>>> There are 3 types of regulatory rules for AP mode and 6 types for
>>> STATION mode. This is to add wmi_vdev_type and ieee80211_ap_reg_power
>>> to select the exact reg rules.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Wen,
>> Can you provide a "Tested-on: WCN7850" tag for this series?
>>
> Jeff, it is this tag below.
> 
> I have not tested this serials on WCN7850.
> 
> Should I test this serials on WCN7850?

For a large, non-trivial patchset such as this I'd like to be sure that 
both AP-focused and STA-focused products are tested before merge.

/jeff

