Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2943A7BC2DD
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Oct 2023 01:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjJFXSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 19:18:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C89C
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 16:18:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396MqusY005175;
        Fri, 6 Oct 2023 23:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=euWaSMyt8It5PxHkXPawoFxCBnm3NLhxrR2oYVc0HhQ=;
 b=S/4drtzCQDfJ8Gce8Ukiz6hOdBa/SANHvso+pgiGc2RxV02rqVatCzZFest5ExAHFae7
 1QN3pAnKU/+zD3TPSi5AAB6D++1QH5/W2WwAqY1pI0mZGN6XMHhvwSnTkrM/i3ifKZuL
 EPYSJa2FEss5ySrtY1Ruh0riikQdEsuFf8bqbcUtY6Tz4fRyV56GvVCCpoyaA+3TQH4X
 ca/V5pg9T/Rgg5NxXdNcU+RA/YBW0FR1MMlnY977bY73iEHL3YwDQpSk0sv8nFhU5aDJ
 tMHs3lsTIFVF7tkBE+lSdX13lHOMWSuxJTb7IwSFCwEPeuea43Wm6Y21/w69qqnp3U1g MQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjnddgtsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 23:15:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 396NFmqp002377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 23:15:48 GMT
Received: from [10.111.180.104] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 6 Oct
 2023 16:15:47 -0700
Message-ID: <90fcfe15-de1b-4371-a316-574ac7a03eda@quicinc.com>
Date:   Fri, 6 Oct 2023 16:15:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: removing OCB/WAVE/802.11p
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Rostislav Lisovy <lisovy@gmail.com>,
        Bertold Van den Bergh <bertold.vandenbergh@esat.kuleuven.be>,
        <chrisshen@skku.edu>, <bienaime@skku.edu>, <pauljeong@skku.edu>,
        <carloaugusto.grazia@unimore.it>
References: <ec69aa2722b07bffd6184d687861cc7e5ae9c1ef.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ec69aa2722b07bffd6184d687861cc7e5ae9c1ef.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TxsuON2LU3lcoQ25Yj4nn2c73SvmRo0E
X-Proofpoint-GUID: TxsuON2LU3lcoQ25Yj4nn2c73SvmRo0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=493 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/2023 8:38 AM, Johannes Berg wrote:
> Hi,
> 
> CC'ing lots of people who touched or used this in the past in hopes of
> triggering some reaction somewhere ...
> 
> I'm trying to do some cleanup in IBSS and following that some other
> cleanups wrt. station allocation etc., but OCB pretty much copied the
> IBSS code in this area, and I don't know how to use it, how to test it,
> who's using it, if anyone is actually maintaining it, etc.
> 
> Also, it only ever got implemented for ath9k, so I'm guessing it's not
> getting any traction in new products/devices.
> 
> So I'm probably going to remove it.
> 
> Any takers to help maintain it instead?

Do you have an estimate on the footprint of this logic? Do you have a 
proposed patch?

In addition to ath9k I know there is out-of-tree usage of this 
functionality, and I'm trying to see if I can find someone to maintain 
this. But how would that actually work?

/jeff

