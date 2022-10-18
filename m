Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF3602791
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJRIwl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJRIwk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 04:52:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1E2A723
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 01:52:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I76EQu007649;
        Tue, 18 Oct 2022 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hv72E3Mp+YNAxZFYnLe18FsIzWld8ZfDBm2ltOu9irM=;
 b=GoxkqCVo6SLPgTDJ5fBibuRTGolpRMMmbDf2SNk8+HBixtOL1vI9zB8Ulpxe3rFxc7cb
 X+sJ1vMcyuABMhuKzxgRGkTAwvmz5cJzuUBSetHTxqKz+eQUBCz7xEOfjNC8mWtTEgPi
 eYB3Kj8npxzSGcY9PcLzVdg6KTjvY2Xd3Ukos/iPyy8sB/gSb+jHUNZ/R5Q7fBbP34BN
 pQTlL7vVEHRyMcT5/jwFptNplbyLlSzHtaHxNFHnXQpkDClH0CtUgpDTPyrgtznurOaj
 AwPfSq2GQUzzbmBfh5SBHvE/5DUfoGGsiLzLgJPzDbyXSkSPbs6C6HpVowH6IQB6taU8 QQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9ktr8n5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:52:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I8qShi017484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:52:28 GMT
Received: from [10.253.75.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 01:52:27 -0700
Message-ID: <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
Date:   Tue, 18 Oct 2022 16:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
 <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
 <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9EFchPsPzYst-vC_U_2ekMTg-GT5RR60
X-Proofpoint-ORIG-GUID: 9EFchPsPzYst-vC_U_2ekMTg-GT5RR60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=642 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/2022 4:50 PM, Johannes Berg wrote:
> On Tue, 2022-10-18 at 16:47 +0800, Wen Gong wrote:
>>> +	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
>>> +		/* FIXME: should be for each link */
>>> +		trace_drv_link_info_changed(local, sdata, 0, changed);
>>> +		if (local->ops->link_info_changed)
>>> +			local->ops->link_info_changed(&local->hw, &sdata->vif,
>>> +						      0, changed);
>> I think you/someone will change here later for the "/* FIXME: should be
>> for each link */", right?
> Maybe. I'm not actually sure it's really needed, it depends how we use
> this in the future.
>
>> It lead error/kernel crash as below while reconfig single MLO link which
>> link id is 2.
>> When test with single MLO link which link id is 0, not found
>> error/kernel crash.
> I'm not surprised, I just worked on fixing reconfig in the last few
> days, will post it after some more review/testing.
Thanks.
> So I think that might not need changes *here*, but rather a proper FW
> restart. Which I haven't tested in AP mode though -- was the crash in AP
> mode?
It is crash in station mode.
> johannes
