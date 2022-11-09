Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AD623073
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiKIQtt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 11:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKIQts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 11:49:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA7F5AA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 08:49:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9GeMak021593;
        Wed, 9 Nov 2022 16:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ctzmFSo1PexZ5PgANKy1hX8p9c199fpL7E236yajZmA=;
 b=BXvsOJ+8bCm5rUYlge3rO5HX55qYWnktUVSPRP4WcqEWIZAS+y3LrSUaYMqk96jZUSBR
 EJoKifqDHMmgUDygE3NFAu9AFPpO7gBQAYUarrDiOCRMHcBXr8YYAFy9TS3pcFtL/WsW
 uiQWGUk3c4eDZZkPW0tifna8hqvx1R07QS37Q6qzMg3vq9qXUPTiDjfgMyfOIQhMpUSv
 aRZnmnVtt9bCZTbhChbYqxkd3hSSeloa+Sy8wOaynMp7+5dwFJaS1sNaEuxdLJVMXl0r
 96uDwMHn/MQF5kjj884w6Z1ulxmyl1vY5K3ithWpWI1gwjZkyY9ggcmQOgeX0zsW2t/Y CQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kr6qfsagq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 16:49:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9GnZ2d021294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 16:49:35 GMT
Received: from [10.110.45.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 9 Nov 2022
 08:49:35 -0800
Message-ID: <7c41d634-e602-d5fa-05a2-8661fcd7ad55@quicinc.com>
Date:   Wed, 9 Nov 2022 08:49:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 33/50] wifi: ath12k: add mhi.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-34-kvalo@kernel.org>
 <05841a52-3d2f-8704-b885-4b02e7a439e0@quicinc.com>
 <87h6z9eeb2.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87h6z9eeb2.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IzOBNluWDfOH_Lo3syIfAQWtcb64I8ES
X-Proofpoint-ORIG-GUID: IzOBNluWDfOH_Lo3syIfAQWtcb64I8ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=959
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/2022 6:00 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>> +static struct mhi_event_config ath12k_mhi_events_qcn9274[] = {
>>
>> seems this should be const
>> but for some reason struct mhi_controller_config has:
>> 	struct mhi_event_config *event_cfg;
>>
>> (not const) so this can't be const :(
>>
>> perhaps someone can propose a MHI interface change?
>> especially since internally to MHI in parse_ev_cfg() we have:
>> 	const struct mhi_event_config *event_cfg;
>> 	[...]
>> 	for (i = 0; i < num; i++) {
>> 		event_cfg = &config->event_cfg[i];
>>
>> so it is treated as const
> 
> You submitted a patch for this, thanks for that:
> 
> https://lore.kernel.org/all/20220830171147.24338-1-quic_jjohnson@quicinc.com/
> 
> But oddly I cannot find anywhere in git, I sent a question about that to
> the mhi list.

This was already discussed on the MHI list, but just to follow up here, 
that MHI patch could not be accepted since there is one use case where 
MHI needs to write back into the event_cfg.

