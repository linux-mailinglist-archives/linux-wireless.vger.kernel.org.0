Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F486076B5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJUMLO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJUMLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:11:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25E3AE7B
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:11:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L9Kc4h027794;
        Fri, 21 Oct 2022 12:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rZDX3YmqG6TjDKPKvxf0OLKxWN4Tze7EEAMBsu/bAsU=;
 b=j61zruWlLtP0uE2ZNc225pdn91hEcM+4wDTrP9Efm+dOUlEWIXDVQXqTl4bxjLFwJ16i
 9wOmC7v4MJc+xN16wbBRxGSe1LKfJy12LCn0SqpgNxhkCTn/IPysSlKUm654j0s0AHMZ
 vplrTYmCNQAQAxfEZGNipWPyUU1WLbNtHVZqjwo9kdZp/dCxazV21/zQdHdRD5lfjyrl
 LREaaVxXhtGWMisvogvmvj9lqImUfU7J2D8dtiFFie5hu2ZfJlMH91pmOqc5f+dKX0Fx
 paqbwH9vKN47TJ4HGyWfjOosNxpymyM2donYQFVo1WLfozJ49bWIlDyEHpnq/QBITSJ7 6w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbrq98hux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:11:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LCB8bA029293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:11:08 GMT
Received: from [10.216.6.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 05:11:06 -0700
Message-ID: <5a32c6af-ae18-12dd-7916-cf0ae8d71edf@quicinc.com>
Date:   Fri, 21 Oct 2022 17:41:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC 0/4] wifi: cfg80211/mac80211: capability advertisement infra
 for multi-hw abstraction under one wiphy
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
 <878a0455b6af009b6e751152c714e5f310dba729.camel@sipsolutions.net>
Content-Language: en-US
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <878a0455b6af009b6e751152c714e5f310dba729.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JDJEhiHLa1KGT_uzkoVq84y5SMty7Pts
X-Proofpoint-ORIG-GUID: JDJEhiHLa1KGT_uzkoVq84y5SMty7Pts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=309 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/21/2022 5:27 PM, Johannes Berg wrote:
> Hi,
> 
> Sorry for the delay!

no worries.

> 
>> - Should we make the capability advertisement changes to mac80211_hwsim?
> 
> I don't think we can, unless we teach hwsim and even mac80211 about
> this? IMHO doesn't make much sense.
> 

Sure.

>> - Should we enable some of concurrent operations like allow scan on each physical
>>    hardware concurrently?
> 
> Isn't that up to the driver? If userspace requests scanning all bands in
> a single scan request you can parallelize it using multiple HW
> resources?

Correct, driver should be able to handle the scanning on multiple HW in 
parallel. We saw resource busy error code when tried to bring up 
multiple AP interfaces on different band at the same time due to
an existing scan request still in progress. I agree, it makes sense
to give a single scan request with all the bands and let the ACS in
user space share the results for AP bring up on any band.

Vasanth
