Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452826784E3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjAWS3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAWS3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4332E4E
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 10:29:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NHeqOi001396;
        Mon, 23 Jan 2023 18:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TupMFhSd8ETnc31eiZFpGtqvSKkOhN/wRS1DjV9krh8=;
 b=KT1CwMbLBWcG2FOq65daJAtyndBYtVhf/Oezu39v2ZfCrWP/jQ3iOIlhhtaC3/DsUkOL
 Ypf4Vn8f+GoqQQjJNW12e6Wv4ZYS/3xxedUzjeOhYvdWb++OcW/U+3VIslPpcUcKfbOy
 BE63s3xL+E9vJxodTn9Bwr8HMN5UyqSPLLMLAN39rgtYiK/P+DI1ZQF4LcWu+Lz9czx6
 7ZWCsjquS8A22Ln6NCippcvKhtZZZTeZdpiSDQWChp2vpEL9uCVnUScOBfPuYTBDgKIS
 dGOblNcXVIF+L7oVpv/5lRLFRt//QsjzJb9w8NaYl6Uc0RMC9AcsKVqC1qv2PddAYKUr XA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89gtbhtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 18:28:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NISAtG006081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 18:28:10 GMT
Received: from [10.110.116.68] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 10:28:09 -0800
Message-ID: <6a67f821-759e-aac5-abf3-d2234c3bd6aa@quicinc.com>
Date:   Mon, 23 Jan 2023 10:28:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC 3/4] wifi: nl80211: validate RU puncturing bitmap
To:     Johannes Berg <johannes@sipsolutions.net>,
        Muna Sinada <quic_msinada@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
 <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
 <3df39d4f2e2e64bd3899cfbe7bade547e54330f7.camel@sipsolutions.net>
 <0b77bad5-f55c-73d5-7cd0-dfed57871f25@quicinc.com>
 <1a063de0aba4a6e2bcf5cacaa661ca8b73c1ffad.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <1a063de0aba4a6e2bcf5cacaa661ca8b73c1ffad.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vM02tsQkOLijv1FRDIDs121bN-9gsioC
X-Proofpoint-ORIG-GUID: vM02tsQkOLijv1FRDIDs121bN-9gsioC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=625 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230177
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/20/2023 1:20 AM, Johannes Berg wrote:
> Hi Aloka,
> 
>> Secondly, this RFC uses ieee80211_valid_disable_subchannel_bitmap()
>> defined in following RFC you sent:
>> https://patchwork.kernel.org/project/linux-wireless/patch/20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/
> 
> Yes, I saw that.
> 
>> Is there is any plan for the next version?
> 
> Am I correct that by basing your work here on top of that, you're OK
> with that being included, and we've concluded the discussion about where
> and how the puncturing bitmap should be stored? This patchset was an
> RFC, I'm personally happy with the design, but really also want to hear
> your opinion and perspective on it.
> 
> 
> Anyway if that's the case then I'll go and resubmit the patch - we also
> made some more fixes to it since, I think. I'm not sure I'll get to it
> today, but I'll do it soon.
> 
> johannes

Yes, we are okay with the bitmap being part of the bss_conf/link_conf.
Please send the new version with fixes as soon as you can, I'm still 
looking into your comments regarding the design Muna sent.
