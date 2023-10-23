Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376227D437B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 01:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJWXtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 19:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjJWXtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 19:49:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15082B0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 16:49:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NN865q024494;
        Mon, 23 Oct 2023 23:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V9gRI6Em77yWghvXp+LscUW6bO9h3frQ16M9H9cRBeU=;
 b=cqgg9i4xJpJj0nEpXB1B/FdHpfpcGukKb2dZ2oBtERbFznnUUdZqNa7MxtSoIYRYcqNA
 DaQMVaqf3D08qzQOpD3s7u4XJjwnbxfEfVGPe89a+Ouv3rufhfEEqqWdSSy/YKhyuv8I
 nBmYswWTKguFJ7pcGFf/wK30y/YU0NCvcyKk34p1jl6nm+Z4vNZpzmSoc+7pSDs3mtdY
 n2IQguN4JkUwnVlllIYjUOSyVTTxyeZRSAW7FrkmvckKMQavDFOHpEmGtzcqy3ruTEmV
 eaPOYF+wq+oDeuHAKM3GuNSmBw5xOq107nU3Qt+0BLG/UV/cBu8PJuCTIJGpWlMa/OZY zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxw5gd6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:49:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NNnG3Y026115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:49:16 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 16:49:15 -0700
Message-ID: <ad339dd4-25ee-4cab-986f-79cc517e008c@quicinc.com>
Date:   Mon, 23 Oct 2023 16:49:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v6.6-rc6+: ath11k not available after hibernation with trace
Content-Language: en-US
To:     Julian Wollrath <jwollrath@web.de>,
        <linux-wireless@vger.kernel.org>
References: <20231022105807.5a210fe9@mayene>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231022105807.5a210fe9@mayene>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _vPW2TkTFzuDOhfNoS55S4AVqGGbg3Nu
X-Proofpoint-GUID: _vPW2TkTFzuDOhfNoS55S4AVqGGbg3Nu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=864 priorityscore=1501 suspectscore=0 clxscore=1011
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310230208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/22/2023 1:58 AM, Julian Wollrath wrote:
> Dear maintainers,
> 
> on v6.6-rc6+ (git commit 9c5d00cb7b6b) the QCNFA765 (17cb:1103) adapter
> does not work after resuming from hibernation to disk. I see the
> following in the kernel log:
...snipped...

This is a known issue being tracked by:
https://bugzilla.kernel.org/show_bug.cgi?id=214649

A fix for this issue is under development.

/jeff

