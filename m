Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4F6BB942
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjCOQOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjCOQOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 12:14:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68F5982B
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 09:13:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALac9020632;
        Wed, 15 Mar 2023 16:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XbyTqVEZoMayy4FBsG765i8DzXTgj5W9IpKJdmRYcKo=;
 b=RNcXhnlNkwRCDWRog0TVR9izCzoE479+T62rGOrIbGorioZlwb7XWR38CJeXcZMdCGuY
 aAFCBaLzkFVNheKjs0oKhmEo5GOaLld6QRcrkUoA5QnS8OOcqV7/HiLldd5GZj+uh1og
 Zdq7vV64jEtDAIbL4WIyYHLMOq7CsBoesaLPQt3L/A7uuerYrfuCWeYoIJwUXbxaAYxE
 ZaBRfYiuVQJGl1q7c+5kPJ+lhlsGQuqoPnDFcvFte0Knj1XY7xclUN3/3007YVNwK4yl
 ysSg63WX4fAAEmGkTblcSYUitWFsX4IO4Hj9IIqiPibt4w9Xvs+Kl0d2eHJBbN/sxhiW /A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c5t6fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 16:13:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FGD3Up006155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 16:13:03 GMT
Received: from [10.110.5.11] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 09:13:02 -0700
Message-ID: <e7425af0-7b40-df42-0942-71016ba47e25@quicinc.com>
Date:   Wed, 15 Mar 2023 09:13:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/2] wifi: ath11k: Fix incorrect update of BCC counters in
 peer stats
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
 <20230308174703.12270-3-quic_pradeepc@quicinc.com>
 <87mt4emhrq.fsf@kernel.org>
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <87mt4emhrq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M-zC7lgBqJbJ7jCm527IVUyB3_BgpSv6
X-Proofpoint-GUID: M-zC7lgBqJbJ7jCm527IVUyB3_BgpSv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 mlxlogscore=969
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150136
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/15/2023 3:27 AM, Kalle Valo wrote:
> Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:
>
>> Fix typos causing incorrect update of BCC counters in 11ax mode.
>>
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> What are BCC counters?
Thanks Kalle and Vasanth for review..will address the comments in next 
revision.
