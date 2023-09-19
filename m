Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A77A670E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjISOnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 10:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjISOnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 10:43:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33F135
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 07:43:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JDphdP017577;
        Tue, 19 Sep 2023 14:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FB+Wv0z8e8vpyK7yXtnE9x4fXf6Rr6Oxu6k/fddRaXI=;
 b=WGruaA/zvrV5PfiPz5EfDRnXZux4bASKgTvi1ciFKiaYmH3n1DFoCdKbpdDjtf6NtToh
 cYNqOsbNtgqTlzrxYPlO97xCipX1WaS8k9VFCfnBzu+jDx/q5Lu67K4g1kxm+tFvQli3
 AL7dHWfYlQ4kwkdRndvUSJanPFZnpXu1KQ4IBpidqGxg5FZA5I8GcmuqkgKV4sWVd2FZ
 /t4tDXliOr2agP3jfcy5oFiJpQ7EHQwxMbb3pTi8Oykj+uILY6s4OSnsjxh6zJ7uu9cy
 zH3wrODYIHTyaIJakXiHh2AMSa/qi97Ba3fv7qiLkkrXd1fpLR3+tYRkImyrRFSR8G3d Dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t78upgku8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 14:42:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JEguhB002542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 14:42:56 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 07:42:55 -0700
Message-ID: <812fef01-6b13-4a5f-bbf3-311991f74a71@quicinc.com>
Date:   Tue, 19 Sep 2023 07:42:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: simplify SDIO async handling
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>
References: <20230918143718.78259-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230918143718.78259-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ugwIaHwBT5CbchiRQ71rrYwjT23r5T73
X-Proofpoint-ORIG-GUID: ugwIaHwBT5CbchiRQ71rrYwjT23r5T73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/2023 7:37 AM, Dmitry Antipov wrote:
> This is an initial attempt to fix TODO found in SDIO bus support
> code. As original comment says, an idea is to store SDIO-specific
> 'struct ath10k_sdio_bus_request' data within skb control buffer
> instead of managing (a relatively large, 1024-items for now) free
> list of the aforementioned structures.
> 
> Compile tested only so TESTERS WANTED.

While the maintainers like code to be as clean as possible, there is 
also the "if it isn't broke, don't fix it" mantra. This is especially 
true for older drivers that are in pure maintenance mode.

So unless you can show you are fixing a problem and you can actually 
test your patches (or recruit someone to do so), any patches to ath10k, 
especially to SDIO, won't be accepted.

Your team is doing some nice work, but I suggest you focus on drivers 
that are under active development, and preferably ones where you 
actually have the hardware to test.

/jeff
