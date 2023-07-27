Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631E764966
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjG0HyM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjG0Hx6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 03:53:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276C3582
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 00:49:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6Kd6P018927;
        Thu, 27 Jul 2023 07:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tu9ZEBqMz2I3FlOfAItugEKHjzez/FyRx9ayHIfrU4A=;
 b=Vhf5fsjduXIQCohc+g+9jUJQsztuDS9nuc4FnVqpBB0JZyjZo5VwWmrh+aXZ+rEmo2KE
 xZFI9cSQNXrVcdrftR4/AX6d2x/GMyFmlR1fdf/PMdG+7wQOAHFQsLpP333fS53gYC7I
 ww+wUtvRIlcRFUQQ0ztfQfMog3I+S3+lLpoKPmM39PBxFYdQbkaaYgRcS7qzeon2Bk0h
 RmeHThOLRSMDdtFHbJ+XnPT2lp0j0QDEC0uXssHB/fDYTkfb6Ny0r+LV/D7AMYafMbim
 rEFuCKEYx4claDaSkgJgWO1tDD+Mc8MFxP+c507iWT7VssTrKetev9EGyEY6kW0EHw8N 4w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u057v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:49:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R7nMZt027223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 07:49:22 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 00:48:47 -0700
Message-ID: <f070a5d3-e013-590b-ca05-43b777e9783d@quicinc.com>
Date:   Thu, 27 Jul 2023 15:48:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support for
 all power modes
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <yahuan@qti.qualcomm.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
 <9d393f3e-4452-47c4-1911-92d817e89a25@quicinc.com>
In-Reply-To: <9d393f3e-4452-47c4-1911-92d817e89a25@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nXxSCtB9XQ9MXZZ3y-a8ATbeB5VpTDMk
X-Proofpoint-ORIG-GUID: nXxSCtB9XQ9MXZZ3y-a8ATbeB5VpTDMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=597
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270067
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Kindly Reminder. Could you give comments for these v3 patches?

On 6/9/2023 1:41 PM, Wen Gong wrote:
> Hi Johannes,
>
> Could you give comments for these v3 patches?
>
> On 3/15/2023 9:28 PM, Aditya Kumar Singh wrote:
> ...
