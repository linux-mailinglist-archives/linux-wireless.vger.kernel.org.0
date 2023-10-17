Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB307CCC66
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 21:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjJQTim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjJQTil (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 15:38:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858D98
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 12:38:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HEpHlK008545;
        Tue, 17 Oct 2023 19:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y/y/0QnvL+eGuC45VSQaLho4UKeRTLlSMFuoL+S2R3s=;
 b=HVhHin25G4RbYNVJgrEr+L/hNAkT915szH9m0jywXvcW/UcZPyeLPoPg4B6xTRtG0YtB
 3PYuzBqtbwRQ2oxORYZvZUN841MSsEnUoV0YUYYl6I8qM4Ry7C7phmoSdeTQDBn3v7LX
 3cc64pnEVcsRMaziLN3C/OSSsFM+fNl+oBvgiVdaf6qUafgO/78HCsrBnfzIWsNMgJy2
 34uLOW9YQ8oRb3sKcwYXIRUyAeY3ZPnCY0r5lFg0MV/r1PYkq/Im3xxLQzPMa7XBtWHU
 zaYbnaSIXBky9LnxyqyfQ03F4CDUMV2ubx/+OtgTKFZL8jlb/WmjsKU3O6zUjrG5U5uD Ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsr7c1a6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 19:38:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HJcWZE011445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 19:38:32 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 12:38:32 -0700
Message-ID: <8a825923-c34d-40b5-812e-e28a25c83eb5@quicinc.com>
Date:   Tue, 17 Oct 2023 12:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix -Wformat-truncation warning
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <87fs2k5l1a.fsf@kernel.org>
 <20231017155342.112032-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231017155342.112032-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vdBeFmwcPG6rSwAw11GbHP1EfrxeTbR1
X-Proofpoint-GUID: vdBeFmwcPG6rSwAw11GbHP1EfrxeTbR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=463
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/17/2023 8:53 AM, Dmitry Antipov wrote:
> Fix the following warning observed with GCC 13.2 and -Wformat-truncation:
> 
> drivers/net/wireless/ath/ath11k/debugfs.c: In function ‘ath11k_debugfs_register’:
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: warning: ‘%d’ directive output
> may be truncated writing between 1 and 3 bytes into a region of size 2 [-Wformat-truncation=]
>   1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
>        |                                                   ^~
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument in the range [0, 255]
>   1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
>        |                                                ^~~~~~
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: ‘snprintf’ output between
> 5 and 7 bytes into a destination of size 5
>   1597 |         snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Simplify the 'snprintf()' statement as well.
> 
> Suggested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

