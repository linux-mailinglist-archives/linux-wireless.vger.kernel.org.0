Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5E7E9198
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 17:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjKLQP4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 11:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLQPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 11:15:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800D2702
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 08:15:51 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACG0vWm019096;
        Sun, 12 Nov 2023 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EjZRLRapeJGE9nRtCrvzmZ0/G6eqt6q1wxe/ljCM6cc=;
 b=EVAtDCsXQHuGjN3+jHm8y3aKF8Xi6WXTQcbbrLl3ZliPc2wR05xifs5ht0D5gZaI3xDI
 ENwXmlPxMcE0TMpo2dEDqdgVcKdUeIWloBXUSabFmjobu3+BNdLdoEk8c97U+5bLzGSE
 wsDvGbU2mBZXk5th+kfUozBhxlCjp2ENPLMG4OSfJno3IK0v8FpQXLrZMVg4VI6axOsh
 FKLMWsur4ZAiDXlrN6jBGvX8b1YhednlQLFnRyj4cBMaSU8R3TKvSkFUT6YJ5wlzgkU+
 6DKNSltqO7Devgqj+RQ9FWu2Ubm/DihdTio+yz/W0paOiPHbOIic+r9od0vdfFP2ozz3 lw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw1x54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 16:15:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ACGFfkX017085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 16:15:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 12 Nov
 2023 08:15:41 -0800
Message-ID: <818fddb9-b59e-7a6f-6605-2ba016d0db60@quicinc.com>
Date:   Sun, 12 Nov 2023 09:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH RFC 4/8] wifi: ath11k: remove MHI LOOPBACK channels
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-5-kvalo@kernel.org>
 <f56bce13-bba8-40d2-1dfc-210478ff63d6@quicinc.com>
 <e2ad1380-d55f-42bd-9f40-ef8aa6e0f105@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <e2ad1380-d55f-42bd-9f40-ef8aa6e0f105@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ch8vXW29ui1GbesnmnHfPW209WaOpGuh
X-Proofpoint-GUID: ch8vXW29ui1GbesnmnHfPW209WaOpGuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=628 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120142
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/11/2023 9:24 PM, Baochen Qiang wrote:
> 
> On 11/11/2023 12:54 AM, Jeffrey Hugo wrote:
>> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>
>>> There is no driver to match these two channels, so
>>> remove them. This fixes warnings from MHI subsystem during suspend:
>>>
>>> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
>>> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
>>
>> This feels like just masking a real issue.
>>
>> If LOOPBACK is not being consumed, then the channel should never go 
>> into the start state.  Why would we be trying to transition to the 
>> reset state then?
>>
>> -Jeff
> That is because, with patch 'bus: mhi: host: add new interfaces to 
> handle MHI channels directly' in this patch set, ath11k is able to call 
> mhi_unprepare_all_from_transfer(), which will reset all channels.

that implementation is flawed if it is causing this.  Looks like you 
never check to see if the channel was prepared in the first place.

If you go fix that, then it looks like this change is not needed.
