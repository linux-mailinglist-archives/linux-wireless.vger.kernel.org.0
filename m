Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B3785B26
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjHWOx3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjHWOx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:53:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA53E6C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 07:53:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEU9tw029046;
        Wed, 23 Aug 2023 14:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h/E8x5sBASp2FmrUQGLxCw/KpSIC6IIIdz3EuQY/sFs=;
 b=CRzyhmkI3yIWKoCvxWmKWxUv61wGIbUYy2e/G8YSq8zKKbVHglfeQNuXARulHLczjLIn
 5aGngeVAL4ujwNskcVZ0haKBG8IBkYPYav816xK2PA3eWNkiMzpUAUkddA9tRE/8pHmY
 0iBgWWCBLKeiCxWdDFqQxEWRKvRtsCQu1hRSzc9nx/NrJbihqtuIM6zw2kGT08KXFQCQ
 pi5lf8tB40v7rsIPvjktArCDqUTqhIri4OVMGWxqpvi/4jRyQKGPTOzEuZWTtVDN2V9s
 CdB712y+6xyqxWEXSzQW3V27yXOX7kGrK+FuUBuU9L/d3PLAk0DTKlP9fxMfZMlvwi5H fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2cm272c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:53:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NErC4Y008295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:53:12 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 07:53:12 -0700
Message-ID: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
Date:   Wed, 23 Aug 2023 07:53:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] wifi: ath10k: cleanup CE initialization
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <20230823095008.50515-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230823095008.50515-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RH6QwBnxHt4Q-U2cDnzyzmeB4IWbAlAr
X-Proofpoint-GUID: RH6QwBnxHt4Q-U2cDnzyzmeB4IWbAlAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=737 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 2:50 AM, Dmitry Antipov wrote:
> Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
> changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
> so these functions can't return -ENOMEM but always returns 0. This way
> both of the above may be converted to 'void' and related code may be
> simplified as well.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

IMO you are doing too many changes in a single patch which makes it 
difficult to quickly review. Please keep it simple. Suggest you change a 
single function signature per patch. Any related code simplification 
should be in a separate patch.

/jeff
