Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672969DE8B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjBULOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 06:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjBULOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 06:14:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE392330F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 03:14:03 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LBE0t0023035;
        Tue, 21 Feb 2023 11:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jSBIsB1MGHSpt+XQlcKSWmuzGa/OIRJIiDbQir1/xZE=;
 b=EYe2KILjIXP1wOxysKWHZr4M4OftVs+ZGAj8EqjkzfzZDAZugdVhFYLdYlc0Dya51xxL
 cS+h5PUtOFdorlgYpsKnVquOWxD1Lvg9UtRebMJ9+MPsHwM+TBYLfJ8jt/Hwd1qQSGPO
 O0edjuDxD90KEe2PP32u42NAf3dUyInkmiOEqPNnw+UVyhHWQeYwPUI+Dn7ieuAVupL+
 lTL3sX61DrVUabN/HmiIJ9Pb0Y8C37kqg5gjbAGpUwZ9xtYLJ7rl+RBDKIXCJmJ6K0t8
 XifhkAAVoTSfDkEDw01JimB1+PH33ITsCbbaitAEJouauQhGyLqkfdukQ6y86dcJjY1u zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvp4v0xcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:14:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LBDmwQ016720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:13:48 GMT
Received: from [10.110.58.30] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 03:13:47 -0800
Message-ID: <16b0fcce-01ff-3d55-14ca-f088f53c8724@quicinc.com>
Date:   Tue, 21 Feb 2023 16:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] mac80211: support RNR for EMA AP
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20221114230416.20192-1-quic_alokad@quicinc.com>
 <20221114230416.20192-3-quic_alokad@quicinc.com>
 <d9461ebd1a17608f73ef832c60fa7489e358a84e.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <d9461ebd1a17608f73ef832c60fa7489e358a84e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jFPNu4Innu2wZxidkxEuJaFcPOSqst8t
X-Proofpoint-GUID: jFPNu4Innu2wZxidkxEuJaFcPOSqst8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=717
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210097
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/14/2023 8:03 PM, Johannes Berg wrote:
> On Mon, 2022-11-14 at 15:04 -0800, Aloka Dixit wrote:
>>
>>   	if (params->mbssid_ies) {
>>   		mbssid = params->mbssid_ies;
>>   		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
>> -		size += ieee80211_get_mbssid_beacon_len(mbssid, mbssid->cnt);
>> +		if (params->rnr_ies) {
>> +			rnr = params->rnr_ies;
>> +			size += struct_size(new->rnr_ies, elem, rnr->cnt);
>> +		}
> 
> Is this right? The struct_size() is only the size of the struct, but you
> need the size of the elements contained in it here, i.e. the sum of the
> .len fields?
> 
> johannes
> 

Yes, I modified ieee80211_get_mbssid_beacon_len() to include the 'len' 
fields if rnr_ies is present. It is called right after the lines you 
have copied here with the new input parameter.
