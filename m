Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8C7A8CAC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjITTU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjITTUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 15:20:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65263AF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 12:20:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIIXR1032639;
        Wed, 20 Sep 2023 19:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eV9KmdTPjXbPKwDk+kKZIb1OxrwZjFE6wiw0HEgkmJM=;
 b=FtjLR2uqG/eX4peyxzj1j1Lkz/M/AnwJMhZPWvvydyfp1M96enqFGqiiAvMjMDewNyaw
 r7M9/A3I4rA9aBZLB2+C9h5+EsjAgJeKv8A9nkYvlKVoGDfhW5sPsnJm0Uk10EnMPdYt
 16sTJwqSufFvJj0pX9N+HnagbGQvrTuXzIa55na1vQtgatSJBa7dVYU+Aa+qfWfqTEcl
 pTjaCSAGYtKzHcFZDSfOw9kREvvkXq7qYgZvo9IWc9YiTHzufpH/Lu1nfePKwVg63T13
 /xXRSHaD2Qh5yiAAcB7Xlbowz1m5yVZEdb3IOquisTTI/dfJ/lTr5qO/jbDZTe83z4P5 AA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7r8w221d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:20:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KJK96d020707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:20:09 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 12:20:09 -0700
Message-ID: <97f2ecdc-ad94-4a0e-81ae-83f61dbf0377@quicinc.com>
Date:   Wed, 20 Sep 2023 12:20:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] wifi: ath10k: consistently use kstrtoX_from_user()
 functions
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <202309202242.GlXozks6-lkp@intel.com>
 <20230920154018.48314-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230920154018.48314-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: umaSxl239mRyTXRDGmZmrsagXI8kez03
X-Proofpoint-ORIG-GUID: umaSxl239mRyTXRDGmZmrsagXI8kez03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=348 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/20/2023 8:39 AM, Dmitry Antipov wrote:
> Use 'kstrtoul_from_user()', 'kstrtobool_from_user()' and
> 'kstrtoint_from_user()' where appropriate and thus avoid
> some code duplication.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

...

> +	ssize_t ret;

curious why you changed this, especially given that you were bitten by 
the format change required. I would have left this as int and just let 
it promote to size_t or ssize_t as needed.

That said:
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

P.S.:
 > Hopefully this doesn't violate "if it isn't broke, don't fix
 > it" rule (the same thing was recently accepted for ath9k).

Patches that are very self-contained are more likely to be reviewed and 
accepted. But the maintainers don't have infinite bandwidth...

/jeff
