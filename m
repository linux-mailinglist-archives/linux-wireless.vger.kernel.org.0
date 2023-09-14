Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA579F8B3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 05:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjINDPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjINDPw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 23:15:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FB1BD4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 20:15:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E39Sc9021071;
        Thu, 14 Sep 2023 03:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Oum9B+ZueXk07z0wEEOFPseDq75McWYB77ymeZAJQ4k=;
 b=kst2bIB0XgGl6vyLEH2CrI2Sm2AZJRZph/9HG3H78sxjfBy8BOc1xwpG6FJC+2cSlO+c
 kgFbHeVxxAJYDyViQ+rDbOykT6aB4Bb24hzQF/mGbDU/oB1m60lzGvthLlTgQUTDmSi6
 NrCrVvjoFMJo5IlKs3qsy1uSgczEplG+iqcZLRuwCJ3JGbesXakV5/ouqOKkXo0Le+P5
 CpR+DsRb8jSfmRBlRX3HX+mizO9I/25APQyG0AaO+2s314rcSPhdbE5KXDdkwR+C59jO
 HxnOSAPnJiQR63WpyQMGVV132E9PhbLRGcQVvtkRdRF4Ugbrmv1C/TrOwvYIZyd9dImU CA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7qbjat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:15:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E3Ffms018935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 03:15:41 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 20:15:41 -0700
Message-ID: <46343a69-5f27-4ffa-bbd8-5b5e7616dbbf@quicinc.com>
Date:   Wed, 13 Sep 2023 20:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density (PSD)
 of the regulatory rule
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        <wireless-regdb@lists.infradead.org>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <20230315132904.31779-3-quic_adisi@quicinc.com>
 <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7AZgyV0GJTio5_tpQSp6PdPtAz26FKab
X-Proofpoint-ORIG-GUID: 7AZgyV0GJTio5_tpQSp6PdPtAz26FKab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501
 mlxlogscore=681 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140027
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/13/2023 7:58 AM, Johannes Berg wrote:
> So I'd say we shouldn't touch any of the code under #ifdef
> CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
> developed with any updates here.

On a related note, what will happen to ongoing wireless-regdb support 
now that Seth has stepped down as maintainer? Have enough vendors moved 
to self-managed such that regdb is obsolete?
