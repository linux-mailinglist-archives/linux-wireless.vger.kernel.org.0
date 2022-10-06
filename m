Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60D5F69D5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiJFOlH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiJFOlG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 10:41:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3BEAA36E
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 07:41:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296DomuM015125;
        Thu, 6 Oct 2022 14:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Db5btVJDe/SatuCrAfZGfI7N+UArjJmMzaBDzfTo+xM=;
 b=ajKfgCvmFLnHwg4ENP8g+p3PuRQYe5Ven7QgmzxTXR6PrVv0hA2V9YRIWy3i5UD4vhdi
 IsynlmRSUUSgz6/gJROj20R5zQTzCYh2nVTec3+XU39Var2ItfuYC1MT9rzTDqgpcRt+
 jekV7Ra4P+m6UcCpKbliwJvzCHTq+asDDid6cmIZyl3RtsBJSpZk/WbPpVln3lrSLgRD
 lKSfVStGXB6ZknZE8PUwdxEzKppT+xkqYnwkjduw/PGW0lIM3h9VPNlv17ufIodVq3Xy
 +KmGYli6hem2YWsejYKPMMLyY/5yfVJmrak1f//LiU/XcS049za/l6fatXSJOFCli4KA Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1qyksdhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:41:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296Ef1PA018388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 14:41:01 GMT
Received: from [10.216.43.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 07:40:59 -0700
Message-ID: <d837e231-7704-bdb0-4cc5-89a214d21d3c@quicinc.com>
Date:   Thu, 6 Oct 2022 20:10:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 05/28] wifi: cfg80211: support reporting failed links
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
 <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
 <0fd2932c29adcc6be5fe5528d297b7deb0e0617b.camel@sipsolutions.net>
 <13b44ce9-e000-cdcf-c057-b176edb6d31f@quicinc.com>
 <6d0333ef30624ef285c01dc2dd27da76450d613e.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <6d0333ef30624ef285c01dc2dd27da76450d613e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wyP0MSa59xFSYxem4_5hUQX7uwNRJY7x
X-Proofpoint-GUID: wyP0MSa59xFSYxem4_5hUQX7uwNRJY7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_03,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=562 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060085
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10/6/2022 4:41 PM, Johannes Berg wrote:
> Right, but is there a fundamental difference between
>   "hey I roamed to this AP MLD with links 1, 2 and 5"
>   (with the right BSSIDs for the links etc.)
>
> and
>
>   "hey I roamed to this AP MLD and I tried links 1, 2, 3, 4, 5 but only
> 1, 2 and 5 were established"
>
> ?

supplicant must validate MLO Link KDEs(includes RSNE and RSNXE) for all 
the negotiated links but MLO GTK/IGTK/BIGTK only for accepted links 
while processing 3/4 msg.

So, during roaming if EAPOL 4HS is offload to supplicant it should know 
the requested and accepted links information.

non-AP MLD needs to select common AKM across all the links. The MLO Link 
KDEs validation helps to avoid downgrade attacks.

- veeru


