Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5878698FD9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 10:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBPJdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 04:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBPJdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 04:33:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AD24CA5
        for <linux-wireless@vger.kernel.org>; Thu, 16 Feb 2023 01:33:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8bglb005365;
        Thu, 16 Feb 2023 09:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tatITD6pR5mHo3kNoTIVtjuIS7iLVCPFJaD9VwR/fe4=;
 b=XwqGN3c6O38d7QDOncYS9sL4k58pQ/BKzJD99holp2yYtnKD6fM5723K4vxoWYQAw4qk
 SVaXIN84qXWQlyycfUOOuWrlAFrhfeUKI3KJArfw77r+mJ7c+U704k0Fp5ffeeZY8Zr7
 DZnYUOUAD+N4Urqh9jWd/AV6adlu73U2Ze1+pO8TiAnyufBZvcwQU0Nm1qt8W5EEdNnG
 hvUMHtFBkRzTuzk3dA7TGIGalgWfNtq/TyZWO/bP5yNFok8cyJpHAAEK6Pls2CiEos3B
 bk3b9elfCd2iADH++eKzeLT3Bgcc2UjfqiMUc66V0N1mut1HYp4jP9lrvHgv5kD7YJdx 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nse3d0k9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:33:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31G9X8to020202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:33:08 GMT
Received: from [10.242.242.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 01:33:07 -0800
Message-ID: <b895583b-7637-9025-d028-efbbc663e139@quicinc.com>
Date:   Thu, 16 Feb 2023 15:03:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6/7] cfg80211: rework nl80211_parse_chandef for 6 GHz
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
 <20220704102341.5692-7-quic_adisi@quicinc.com>
 <0ed850ac7d13fc5d40545aff1d59d710374bfcf4.camel@sipsolutions.net>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <0ed850ac7d13fc5d40545aff1d59d710374bfcf4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoYg9LxaGnm5GOxeIgiueAL1mgSZE0w3
X-Proofpoint-ORIG-GUID: HoYg9LxaGnm5GOxeIgiueAL1mgSZE0w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160079
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/18/2023 16:33, Johannes Berg wrote:
> On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>>
>> +	/* For APs, 6 GHz power mode is taken from the user configured
>> +	 * value. However, for clients, power mode is also dependent
>> +	 * upon the APs power mode to which this client has associated.
>> +	 * Hence for client, need to take power mode of asscoiated AP,
> 
> 
> typo - associated
Sure will rectify. Thanks for pointing it out.

> 
> But anyway, were you going to resubmit this with comments from the first
> patches addressed?
Yes! Working on addressing the review comments. Will send next version.

> Honestly I'd also like to see a bit more discussion (in the cover letter
> I guess) about the solution with "multiple channel spaces" and all that.
> And ideally about alternatives considered - why not for example keep a
> single space with flags indicating support for the power mode, etc.
Sure will include these in the cover letter.

> 
> johannes

