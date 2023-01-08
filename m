Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDE6613D9
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAHHMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 02:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHHME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 02:12:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C1186D3
        for <linux-wireless@vger.kernel.org>; Sat,  7 Jan 2023 23:12:02 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30872RNY010941;
        Sun, 8 Jan 2023 07:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I02dSrlOPBcHiau/bqDwr5pfzLmDz/Z9n5dD99MB3fE=;
 b=EpOez7MTImxt7boVT8nlEuVgYe6mT6DJQRGFZb1uz2B19mlG3Upgmej3ufweHQLcr97z
 jj8uZP1REyFUQzMc37qyeS9yhyBVGSf7OQU4xr6+8xJl0Jw/nAVDeD5WcXzAUv8thkmn
 AbIDPqkFTP4PQ0Ww0Jvp+McJk69ZvdvwqgcBushD4lFaQ5AQeAgXkQNBeN/Z/ARXvELw
 5JiNthyXmnnqv79ZRNYRj3vbgfBHiA0McdMdHYoMspheufQ8/zBP6M9DJU4I39zMw5AU
 fdlHzs2byB87tzLBGcE+7G0zfjTIIeYGdKRgKyS3eKfFCOiiifN6Oz23IOEfphxbm52e vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my14fs788-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Jan 2023 07:11:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3087BiZu000338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Jan 2023 07:11:44 GMT
Received: from [10.216.50.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 7 Jan 2023
 23:11:43 -0800
Message-ID: <042e4ab6-d7ed-717e-6018-d067835e8c2f@quicinc.com>
Date:   Sun, 8 Jan 2023 12:41:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/4] wifi: mac80211: Add support for randomizing auth
 and deauth frames TA
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, Jouni Malinen <j@w1.fi>
References: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
 <20220919121155.3069765-2-quic_vjakkam@quicinc.com>
 <245eac51ecd65be5b31d433eebf0f212d50b8819.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <245eac51ecd65be5b31d433eebf0f212d50b8819.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fec0TDP7I5rK1udKptjZ3aGlVHre5SM9
X-Proofpoint-ORIG-GUID: fec0TDP7I5rK1udKptjZ3aGlVHre5SM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0 mlxlogscore=665
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 12/1/2022 7:02 PM, Johannes Berg wrote:

>
> Anyway, I still think there's a design issue here in how you handle the
> lifetime of this temporary address, and would think that it might make
> more sense to address that within the context of remain-on-channel and
> the response waiting time offchannel period. Remain-on-channel might not
> even be needed for the purpose here since you'd get a response and then
> give up waiting for a response? But it might be needed in some retry
> cases perhaps, I don't know.
>
> johannes


Thanks Johannes for reviewing the patches. The suggested approach to 
keep the allowed random/temporary address till the response waiting time 
off-channel period  looks more cleaner and better. I will send new patch 
series with the suggested changes.


Also, we are considering to drop authentication offload changes patch 
(4th patch) from this series. We think it would be good to align with 
mac80211 and use MLD addresses in the frames during authentication 
offload case also. I will send a separate to patch for supporting 
authentication offload with MLD addressed frames.

--

veeru

