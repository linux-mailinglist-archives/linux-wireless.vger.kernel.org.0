Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7097B7EB808
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 21:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKNU6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNU6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 15:58:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D67FB
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 12:58:04 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEKiCIk010790;
        Tue, 14 Nov 2023 20:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hs0BOTXKHzvyNHZe8Eva96+xTY2w6kP6MRFrZE78bUA=;
 b=lu9IIeCfnhWuawqysvevEtWo8X5dLZFwsB5zOHItHW7wfXK08R3Zb+qhAt+HfW6274ui
 NSMDIJIf2CD8bzwLjPF6DRzx47ofFPB6KZywvnH+mGBIBh3rEmIJqP0iurLZgEFHH8PN
 YWUwcHxQaNXE5ajZdRGFamES/LcWbcZ9ToxNTtpvgWznukq/DAGt54ZBbfbHCSbiB+gh
 UGRXvZ1BGtqGlHTgCigc9rwizHzJrThIKIOSDGXXzGlU02XjpIqQkTjTc+S6UPScUnVW
 ksxbYOrcl9VlFB/YYvM/KjbH/JFJpcGxr/rWZM0YzUYL7SUFfoQJrPiZFqay6Up5oMyh XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqfdkfaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 20:57:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEKvu6X004721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 20:57:56 GMT
Received: from [10.110.49.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 12:57:56 -0800
Message-ID: <88287ab2-923d-400d-b101-6de2466891ac@quicinc.com>
Date:   Tue, 14 Nov 2023 12:57:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ath10k: reduce invalid ht params rate message noise
Content-Language: en-US
To:     James Prestwood <prestwoj@gmail.com>, <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <skhan@linuxfoundation.org>,
        Wen Gong <quic_wgong@quicinc.com>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org>
 <5c31f6dadbcc3dcb19239ad2b6106773@codeaurora.org>
 <87h7mktjgi.fsf@codeaurora.org>
 <db4cd172-6121-a0b7-6c3f-f95baae1c1ed@linuxfoundation.org>
 <87wnvesv8t.fsf@codeaurora.org>
 <82e3e0a2-d95b-cffb-4fa7-2eaa4513dd48@linuxfoundation.org>
 <4a02dd43-c629-4c7c-83fe-256e6d444d60@locusrobotics.com>
 <859fac21-9b1a-452e-91bb-c6d097d451b6@quicinc.com>
 <7c3874b1-2d0f-49a0-9542-18b5350ae99a@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <7c3874b1-2d0f-49a0-9542-18b5350ae99a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: efNut4dUIHpcgJ6nEBwPiUM9Hfq0n7ly
X-Proofpoint-ORIG-GUID: efNut4dUIHpcgJ6nEBwPiUM9Hfq0n7ly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_21,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 mlxlogscore=628 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/14/2023 11:31 AM, James Prestwood wrote:
> I hate to keep bringing this up, and if its a "won't fix" type of issue 
> you don't have to tell me twice and I can deal with it out of tree. Any 
> answer would be greatly appreciated so I know how to proceed, and if its 
> something I can wait for on upstream or handle on my own. Since its 
> apparently a firmware bug its not something I can fix, or I would try to 
> myself.

I've asked the development team for an update.

/jeff

