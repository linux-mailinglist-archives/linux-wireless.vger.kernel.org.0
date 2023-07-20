Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434275A89F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 10:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGTIFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGTIFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 04:05:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9D2111
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 01:05:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7ta7C017927;
        Thu, 20 Jul 2023 08:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0QB3ByfJGl/qT7BhiLMWt45ojkOuxf4dUUPAi9yA7Rk=;
 b=hOY7Wsb2+3s1dJ7+htWH7p5QzZgLYjxKEWaUBnHfX3RtZDlu+ABy9mVgO13yK1cGL5+N
 mrXxazcpQ/ofwZhY5hCSKBHkDq5IzLArJNQon+JDmT5ZGGBFfyVlTSR6HMcWIGh7hvqT
 J4ZPstH4b4N1A9VQIQmZQw8wRncUGnU6GZEENTN7xQKUSogf04m6+0Nm1WmfK3Y3qpdE
 EOGOHGhyiBU1kdpSAwH5Nr4mzR0D6RDBOCqRtZQ5MpHaos3XruTAKDM6OamynVJ15X21
 QsptkzV/9KdC9Q0NklY8QagYSw9dnD6jGZOAVe7lN4/ftuCkaHUS/VOXItBhn70q+RaK kQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxjtjsgec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:05:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K85TbX009825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:05:29 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 01:05:27 -0700
Message-ID: <0f2d0f44-20aa-9be7-bfe4-f09b84636ce9@quicinc.com>
Date:   Thu, 20 Jul 2023 16:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Wen Gong <quic_wgong@quicinc.com>
Subject: Re: [PATCH 06/14] wifi: iwlwifi: mvm: add support for Extra EHT LTF
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
 <20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid>
 <2027bcac-cfd9-3858-3438-9a7297600350@quicinc.com>
Content-Language: en-US
In-Reply-To: <2027bcac-cfd9-3858-3438-9a7297600350@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 10BIa8_7Pi7vSdMNghYQ-M6HshHEn7h9
X-Proofpoint-ORIG-GUID: 10BIa8_7Pi7vSdMNghYQ-M6HshHEn7h9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=761 phishscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200066
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 7/20/2023 12:02 PM, Wen Gong wrote:
> On 6/13/2023 8:57 PM, gregory.greenman@intel.com wrote:
>> From: Gregory Greenman <gregory.greenman@intel.com>
>>
>> Add support for Extra EHT LTF defined in 9.4.2.313
>> EHT Capabilities element.
>>
>> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 ++
>>   .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 ++
>>   drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 +++++++++++++++
>>   include/linux/ieee80211.h                         |  1 +
>>   4 files changed, 20 insertions(+)
>>
> This patch changed both ieee80211.h and iwlwifi, if separate the 
> change of ieee80211.h
> to another patch such as commit 4fdeb8471302(wifi: ieee80211: clean up 
> public action codes),
> then it will be easy for someone to pick the patch if he/she only need 
> the change of ieee80211.h.
>
> Also same for commit 2c9abe653bc5(wifi: ieee80211: correctly mark FTM 
> frames non-bufferable)
> and commit 1a30a6b25f26(wifi: brcmfmac: p2p: Introduce generic 
> flexible array frame member).
>
> Right?😁
Hi Johannes, please correct me if something is not correct.😁
