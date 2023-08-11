Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3A778992
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjHKJQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjHKJQy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:16:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2930DC
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:16:49 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B4o2BR015432;
        Fri, 11 Aug 2023 09:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Im0HlFF/jFHxyQzHrj8bE9B3ABpF3Osaw1rwortTpBU=;
 b=Nn8ch3v1sjIOLGbicRX7yA3oZiu5pCkZg220rEbAldLTxvJ/a9o+DLZnFQCGrYAMpErS
 jHKVEi4OCNZhdnqha3RpCJnzTnt21tkTJnsQPLvXtNIcuqsaxssLHfiBhPXMyYyDMFer
 CeHsFss4r79q6hH77NtLK3FznBx4jy2BbOaQDImoxgB74drU7aXdDl1cd5FL54iDIXkF
 gPpSUwpuqiAVzpcF0qDypeAZIdrUPGUKv/Nh4VQD2fllIZf+0P6jOVdppEjSCLCZo6Y9
 6D9OwADfR7fi4DyFod9Aseck0BXAyUDNmkVHciEw4ywnVHXiXaqzZ3vTFuT/6wBW8X7k xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yuh74c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:16:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37B9GfUc013605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:16:41 GMT
Received: from [10.201.206.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 11 Aug
 2023 02:16:39 -0700
Message-ID: <fbdfaef1-d680-c58b-f048-306ec8623ced@quicinc.com>
Date:   Fri, 11 Aug 2023 14:46:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 2/2] wifi: ath12k: fix undefined behavior with __fls in dp
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
 <20230809042738.13394-3-quic_hprem@quicinc.com>
 <5cabcc57acd781e90c35fcc9b3c6a8aa8fbaa581.camel@sipsolutions.net>
Content-Language: en-US
From:   Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <5cabcc57acd781e90c35fcc9b3c6a8aa8fbaa581.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hZcBKDM7q0mMY5ZHYbiFtx1eQ6McCa6P
X-Proofpoint-ORIG-GUID: hZcBKDM7q0mMY5ZHYbiFtx1eQ6McCa6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=908 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110084
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 8/9/2023 5:47 PM, Johannes Berg wrote:
> On Wed, 2023-08-09 at 09:57 +0530, Harshitha Prem wrote:
>>
>> During the crash, the fragment id of that packet was 0 and
>> __fls returned a junk value. Hence, it was identified that "__fls"
>> would have an undefined behavior if the argument is passed as "0".
>> Therefore, add changes to handle the same.
> 
> Umm. That makes it sound like you are surprised by this behaviour of
> __fls() and expected something else?! Please go read the documentation,
> and then rewrite the commit message. You really shouldn't be surprised
> by this.
> 
> johannes

Thanks Johannes for reviewing the changes. Sure, I will update the 
commit message in next patch version.

Thanks,
Harshitha
