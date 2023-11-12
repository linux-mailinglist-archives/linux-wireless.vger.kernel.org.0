Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2F7E8E58
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 05:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKLEZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 23:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLEY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 23:24:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7A30D1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 20:24:56 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC4OivZ000997;
        Sun, 12 Nov 2023 04:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MHyF5XFWxTDTGEuQZvCCBwCqoNyzxAZnfW1V2Z2coto=;
 b=AGBy4oEVe3DNXMq+nG6m1Ix/DcOtZE6GLSthQAbbbyAWm1KxIZ203+SVwfnVNw0y6NEp
 XIPoIddnns3ZdLNaHgymPFnfZ/k44Crmvw/iV0EUWLmhKlJsYlz2M1FlOIvogmvclHL/
 r9BMA6HJv7G3XPDVOIlwEhw+6rtsgT9KrdvIdEum6+9Y9GChqO2ME1wQz6zt7In/0nHS
 8HqRahePxwiaAU4rrI04UT0WIBmCl/LnbecFNXwlwlEBsSV4/WABBQwcrUOJrhfJmFyc
 K+yqvedvuunuyT4O7tkWz6YKPYJdhYP3E8ZjjHWPs0d2lzRYJQHIPbM5iEc1Db75tn4B Qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw1b7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 04:24:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AC4OhuZ005337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 04:24:43 GMT
Received: from [10.253.35.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 20:24:41 -0800
Message-ID: <e2ad1380-d55f-42bd-9f40-ef8aa6e0f105@quicinc.com>
Date:   Sun, 12 Nov 2023 12:24:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] wifi: ath11k: remove MHI LOOPBACK channels
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-5-kvalo@kernel.org>
 <f56bce13-bba8-40d2-1dfc-210478ff63d6@quicinc.com>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f56bce13-bba8-40d2-1dfc-210478ff63d6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E3MZTNXumas3qj3-t4tOf1c-3D0HHu1Z
X-Proofpoint-GUID: E3MZTNXumas3qj3-t4tOf1c-3D0HHu1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=515 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11/11/2023 12:54 AM, Jeffrey Hugo wrote:
> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>
>> There is no driver to match these two channels, so
>> remove them. This fixes warnings from MHI subsystem during suspend:
>>
>> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
>> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
>
> This feels like just masking a real issue.
>
> If LOOPBACK is not being consumed, then the channel should never go 
> into the start state.  Why would we be trying to transition to the 
> reset state then?
>
> -Jeff
That is because, with patch 'bus: mhi: host: add new interfaces to 
handle MHI channels directly' in this patch set, ath11k is able to call 
mhi_unprepare_all_from_transfer(), which will reset all channels.
