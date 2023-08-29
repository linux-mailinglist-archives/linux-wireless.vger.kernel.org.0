Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B778C9B8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjH2Qe0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbjH2QeL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 12:34:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820CA6
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 09:34:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TEtmpu017337;
        Tue, 29 Aug 2023 16:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OP7dzRttNOotf5WAsYPhCwIDPNx4eW6fztZX/8LyXEQ=;
 b=ZvabagHtZT7ChDpDsuv8wa83TimjMDnp1Vj6sa39ukSdTLGw2Qpx7+aOkoeXLtr8S46N
 8YDBeitJ3TlhscQUD1oXOVDNbKuvV3OFNfSWQtHblwnNE45uNOUY14r70lRldANsRxiQ
 /F93YrTkbGPtULcm0bEVGBDp7BH+pyIEw9aPsu/BFIiyhTWR9Ccxjf/tpNyqJhonoAfa
 quhnwZMjju4R1GcroTyTyHn+Jz9zTQkjusYmdcrTo5+O+/lNbGvzPrMMzlKVp3a6O1Yi
 79AMxQ0+REOgI0+w3sCyN0J5ixFohgW67o60tL+8TNPjKf27F42OgfYcAj4VncK7FaUf dA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssjvb08d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 16:34:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TGY5Eu009471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 16:34:05 GMT
Received: from [10.48.245.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 09:34:05 -0700
Message-ID: <256e3c4b-672f-4687-a3b9-4176dbcce3c2@quicinc.com>
Date:   Tue, 29 Aug 2023 09:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: cfg80211: remove scan_width support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Xinyue Ling <quic_xinyling@quicinc.com>
References: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
 <5b809506-7fea-4598-b6ae-39ea94cc2849@quicinc.com>
 <50d2dd83079d01e1c260590cd5470e3a534b4a66.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <50d2dd83079d01e1c260590cd5470e3a534b4a66.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dY56uLqMOF9B3-GUB6YmLsa7H52JuP8d
X-Proofpoint-GUID: dY56uLqMOF9B3-GUB6YmLsa7H52JuP8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=683 priorityscore=1501 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/2023 9:24 AM, Johannes Berg wrote:
> If we even decide to go that route, because honestly, I'm getting pretty
> upset about the whole Qualcomm adding various APIs that we never see any
> users for, then not maintaining it, _and_ complaining that we don't fix
> things upstream quickly enough.

Part of my new role within Qualcomm is to address this.

