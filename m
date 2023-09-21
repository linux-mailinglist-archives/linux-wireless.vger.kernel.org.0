Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FE7A9EA4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjIUUGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjIUUGC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:06:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120122AC6A
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 13:00:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LJlo34016326;
        Thu, 21 Sep 2023 20:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tBOEr4nA3Ih94k8mdYHrasFkDL/5zM6Q9uGMr7GTt8A=;
 b=Ml4OFhHp6KSSebbLpwaqXDCyjSgh/++sQznOcan/b803ApyIx+K5lv2bGqHd972CHdno
 fWLSP4XZhIqPND/AabVDTAXy3qaa2+VeueO0RxvKlOIOOnJILxOnStGCyJon06LPfUn1
 niMPcVJCDDo9AOpVN6ddDlyjXUMf0ZuhC36ddI4ncynB0alL7q0oen5xjdpKUA0xjW85
 dldGHSxNq9M9CHEtCD5jj4hus9KtoNNJ20VyuookMX8BElJOb2h5J5gWJppyGyEdoOrw
 0vgyIIik2rIkDhxoB7He3Uh5CYPxsxwertyNigUSYAxWHRR9jcD4QUW7U7j/3QYIJBHU tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uknr3ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 20:00:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LK0Wv1007630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 20:00:32 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 13:00:31 -0700
Message-ID: <a06adf34-555c-4558-9645-65011d86abe9@quicinc.com>
Date:   Thu, 21 Sep 2023 13:00:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] wifi: ath11k: save power spectral density(psd)
 of regulatory rule
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-7-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230920082349.29111-7-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8FKSsJS6ZWcaX9Lsbp6Dd4DdrmZVGWfp
X-Proofpoint-ORIG-GUID: 8FKSsJS6ZWcaX9Lsbp6Dd4DdrmZVGWfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_17,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=833 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210172
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/2023 1:23 AM, Wen Gong wrote:
> Save the power spectral density(psd) report from firmware to struct
> ieee80211_reg_rule.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


