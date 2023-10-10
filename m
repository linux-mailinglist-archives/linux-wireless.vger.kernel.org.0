Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEA7C0050
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJJPYB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjJJPYA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 11:24:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0726793
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 08:23:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEKaUa023884;
        Tue, 10 Oct 2023 15:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jIEk7bY1igBLvz7sWdZaDhWClh1IdiHKmn4/UZenYjo=;
 b=QCwkFm1ek6k5619ED+B98Vlf0irH0m4mmsSOb3xRkhe1+QlWuJCkaNktTm9gc7Wrp5Ds
 KcJ3hyEYcSj08UXm9+QSwSy5Ehn81Ac+ByUF8emq3NVFSRnmJ7QcGCGDaRYQ80zvUZwB
 9tFwUQQFdG2QHgwHKmOBJPyZLvVl4mokVVGmsl0ky+C62u4uYGt3r9blmEsd+ZSU8N9Q
 3nHziLs5atA4jKDo83YM9+3CbniJCfhCnznjXCF/oS0HsrLv2LoYCGSVHkUGIFObWgt5
 sCZDsd0KWX6na1VdP6H+9aOq0oziJvauJei8VCdC2FtCujLkyTQ+uHO6kJY1lz4+j0xL 5A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmyma95pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:23:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AFNeZV027254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 15:23:41 GMT
Received: from [10.111.180.41] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 10 Oct
 2023 08:23:17 -0700
Message-ID: <2c08791e-44b7-444e-9fb6-a828d849a67b@quicinc.com>
Date:   Tue, 10 Oct 2023 08:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: ath11k_debugfs_register(): fix
 format-truncation warning
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231010062250.2580951-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231010062250.2580951-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 634K_kZdhPhQ8BOY2QMrwvFiQHeRgQqQ
X-Proofpoint-GUID: 634K_kZdhPhQ8BOY2QMrwvFiQHeRgQqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=750
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/9/2023 11:22 PM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In v6.6-rc4 with GCC 13.2 I see a new warning:
> 
> drivers/net/wireless/ath/ath11k/debugfs.c: In function 'ath11k_debugfs_register':
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: error: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size 2 [-Werror=format-truncation=]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: 'snprintf' output between 5 and 7 bytes into a destination of size 5
> 
> Increase the size of pdev_name to 10 bytes to make sure there's enough room for
> the string. Also change the format to '%u' as ar->pdev_idx is u8.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

