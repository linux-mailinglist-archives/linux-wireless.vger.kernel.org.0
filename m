Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672437AA018
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjIUUcf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjIUUcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:32:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5C8C61B
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 13:04:27 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIIpCd028747;
        Thu, 21 Sep 2023 20:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U9E1Zf/ACOZ/XWrmzMsS/3gS8ERNfOBV3Kb7Y9oVPHE=;
 b=ipZYEXr6FJ4tOXbtsVZDkm8xahEPyLqU7e2cA5lrbi383Bvx0vuAaP1CaznuEOqM5oU9
 8D+hagDH8+RJlXjnRBlwOXAZ7HR/qepbpjZD8nERcsq/YV3dS/3Q/bVuv0u/JwWUf/7o
 LT9eQ7kvGm7PFibKiNYLJ2ywNxyO1nmDBlHYJe1WxENz2XANhWW9JtTM9tRbfUItwi7y
 9GIF804FyVoPtl0yojpv6kamVDojOvggmF5OPMkiH4XbW31zryaQDt6B9fNPUom9FWP0
 9Jv4Aj2Th2o2Ys/XniB4jOKbBZ8dCp/rquyeXL5BuHrf4VjeZ8iJzeQy0WaAc5nt4MCd Kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0hg6ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 20:04:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LK44nl011039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 20:04:04 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 13:04:03 -0700
Message-ID: <2dd83f9f-2e40-4dce-aef0-be0c4fb55c6e@quicinc.com>
Date:   Thu, 21 Sep 2023 13:04:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] wifi: ath11k: add parse of transmit power
 envelope element
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-8-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230920082349.29111-8-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CoZMXs0l93P5BokFCBhHa_VlMren5LtD
X-Proofpoint-GUID: CoZMXs0l93P5BokFCBhHa_VlMren5LtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_17,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=500 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/2023 1:23 AM, Wen Gong wrote:
> The transmit power envelope element has some fields for power, ath11k
> should parse it according to IEEE Std 802.11ax™‐2021.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

