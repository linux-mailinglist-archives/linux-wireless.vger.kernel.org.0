Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAE77F8A7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351796AbjHQOUx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351805AbjHQOUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 10:20:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6C2D76
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 07:20:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HD1r3V031507;
        Thu, 17 Aug 2023 14:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wjg2YyzZjKdxmmAoe487S4k7NU1zRvT9a3rX4sZd+a4=;
 b=D5uBt+E0y7i1TXtXvBsxjJdolprtt5qQWzf8rsXoV3HXGLoYV2yGkBXF8MALhdIGbSIU
 0RGl+9WEiSCmP78Mqhtk/gqK+/obhtO2JFtuODwv80FAWd1r1pGmDOgwVaOohoLBYGZd
 gq4a7ZV8RFvYRC9N9Ph++RL2tvGyMu1+A5TdAn9O57dHU4hD/YwZCJPzw9K0zQn//Ndh
 SXQda+f7VUcKS9n+3AsvTQa1Fmj4Y+TlAo3vo/mCLZrYdqjtwwfdECTyCs/tjXY0wtuI
 xTcWTzEaSmPiDOOyzohprlOlD6NjAmMTz3+yIg8w7f4CoQNnNi1/VxkgaHjOTiGd+hrE gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sh0upamxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:20:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37HEKapQ029942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:20:36 GMT
Received: from [10.48.241.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 07:20:35 -0700
Message-ID: <1868f377-be15-49f3-8bdd-e5e72858f15d@quicinc.com>
Date:   Thu, 17 Aug 2023 07:20:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix WARN_ON during
 ath12k_mac_update_vif_chan
To:     Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
 <20230802085852.19821-2-quic_mdharane@quicinc.com>
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230802085852.19821-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gkki4-fntb40-7j5ub9ltYGHutD8WDzZ
X-Proofpoint-GUID: Gkki4-fntb40-7j5ub9ltYGHutD8WDzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_07,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=605
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/2023 1:58 AM, Manish Dharanenthiran wrote:
> Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
> Since change_chanctx can be called even before vdev_up.
> 
> Do vdev stop followed by a vdev start in case of vdev is down.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

