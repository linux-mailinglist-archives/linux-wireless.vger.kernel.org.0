Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA407B8B05
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244575AbjJDSpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbjJDSpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 14:45:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B6C6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 11:45:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394IdVbr012575;
        Wed, 4 Oct 2023 18:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=13wkz53jc/Vr3MPbZdp9C2xXm7HBK++7QkZVMb7s9TU=;
 b=Nf8K0KnYT/y/GBQ59flddmKeLbH7tyZg2igQHenkOEKm1yDjX1wd+9kiU+MR3I+xuysy
 vLjOwexG11BVxm8T2Xs2PEHCUBqlrm/1RzPAF9iuklXSdXSvgQg3Dygbom5dth5vx+w5
 thl9IfzLwQifqxVJ4uq18M8d906JLNsRIZ2zo40lCkl1wt04cQMOugUVF8UhBddcwzFs
 IZgyRdQzysuaJNhIeFWm3HZC6U0FmmcbYyvWMFR5SI9V5pIr/CcEU+pSo41ISqC8wyLq
 szNTbVcr1nvYCTvSjje/TYgQARf9uJTNoBfHLIIDwmrxZElnrY1viD7v8rvYnoim2MP3 9w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mjt0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 18:45:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394Ij4bx004068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 18:45:04 GMT
Received: from [10.111.179.185] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 11:45:03 -0700
Message-ID: <be9ca925-4ae5-424f-a9cb-6a0ef57ad2d0@quicinc.com>
Date:   Wed, 4 Oct 2023 11:45:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: add parsing of phy bitmap for reg rules
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231004092655.25020-1-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231004092655.25020-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rtyCuZkrvgHC7txkb6FigFK1mRAKpCRQ
X-Proofpoint-ORIG-GUID: rtyCuZkrvgHC7txkb6FigFK1mRAKpCRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/4/2023 2:26 AM, Aditya Kumar Singh wrote:
> Certain regulatory domains could put restrictions on phy mode operation.
> For example, in a few countries HE Operation is not allowed. For such
> countries, firmware indicates this via phy bitmap in each reg rule.
> 
> Currently, there is no logic to parse this info and then pass it on to the
> cfg80211/regulatory.
> 
> Add parsing of this phy bitmap from the regulatory channel change event and
> then accordingly map it to cfg80211/regulatory flags and pass it on to it.
> 
> While at it, correct typo in debug print s/dsf/dfs.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

