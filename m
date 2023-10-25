Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C77D716A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYQFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJYQFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 12:05:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E0BB
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 09:05:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDQ8Mq007059;
        Wed, 25 Oct 2023 16:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nuXU23vfd4Lu85a/qHZDenzYnHTJSAVOQbEDXuDjRx8=;
 b=XzqyAlJMoh2d0mfjs1+JOAA5BZZoX3PwsVEv3na5hX+zoMnyEPJJvjv5L0B0/rOM9CKH
 t/mE/t+jmEbiPdB2cxTqLH0pxsJCwh2VbQX0pSQbjTqC2exajf8ClZNPEVd6mZ6yPHLE
 bF8zgD9CWHPDCncek5onwfeBxRw8NVzQpmeLfZVJeTGg28b7S1Tc8kxfYXcW0TzoQGbd
 2sLW6WSWfBucGBYYX2nExHIoWn1lTZ0B5zLrimKzDcBg59QOyIWpN+Zou8jxKqeL8yCd
 FLY+iC4ioNVOcwMnyAR96ENETAqbBkhAdH+0VnNHDSd6PwJ7+ThPo+HCHDf3Btoqdm9K qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txpj5hu05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 16:04:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PG4n1U011037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 16:04:49 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 09:04:49 -0700
Message-ID: <97bfc661-132c-48c1-a6c0-c662c1b37db1@quicinc.com>
Date:   Wed, 25 Oct 2023 09:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
Content-Language: en-US
To:     Jiazi Li <jqqlijiazi@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Jiazi Li <jiazi.li@transsion.com>, <linux-wireless@vger.kernel.org>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231025103304.22082-1-jiazi.li@transsion.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vyxid88Tn-d9C3ewm8DgbJGCdKK1qtA4
X-Proofpoint-GUID: Vyxid88Tn-d9C3ewm8DgbJGCdKK1qtA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=665 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/25/2023 3:33 AM, Jiazi Li wrote:
> If cfg80211_update_assoc_bss_entry call rb_insert_bss re-insert bss
> failed because cmp_bss return 0, this bss->rbn will continue to hold
> expired data, such as __rd_parent_color.
> And this bss still in rdev->bss_list, maybe double erase in
> __cfg80211_bss_expire later.
> Double erase a rbtree node(with expired parent and color data) maybe
> corrupt rbtree, so add a in_rbtree flag to fix this issue.
> 
> Signed-off-by: Jiazi Li <jiazi.li@transsion.com>

Note your Signed-off-by doesn't match your e-mail address in your e-mail 
header. From the actual e-mail source it seems Google is trashing your 
headers:
From: Jiazi Li <jqqlijiazi@gmail.com>
X-Google-Original-From: Jiazi Li <jiazi.li@transsion.com>

That needs to be resolved


