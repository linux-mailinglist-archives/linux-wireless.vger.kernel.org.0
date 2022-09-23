Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41745E71ED
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 04:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIWChG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 22:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIWChF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 22:37:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013CF1176C0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 19:37:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N1oqwe029985;
        Fri, 23 Sep 2022 02:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=miMAe3rC2PYLPdw5GZAzlGYiscSKTdhuRQwxsQjpBzI=;
 b=FBMGyQjT2rd6KbqhLaDR2x/TpkJiOx0FSbFzl8PBRQx+MLsDQiMwR/MtsxLeSAUuDMEl
 KdDEXsvoAI3uKo8pMuL/y4hCxTCpPTYnGmwg+p/L7TpzXn9UJoXbbxMFgs86JnTkyote
 XCjA4BE6OeSYP0mMlAeqlXoDsFS2lklyrHb2QqusYw38qK8XdD7r7yXbJRlGXy5VFNX8
 uVYoPj+jbV8xbGDr7XzoyxesfOrF/KVQJVDdN0HWYlSN+NVYnOR5txUYaspuvrczBoH9
 K8+5tlnQolRU3EsNDLB7p3dJXth9yJSxct7VPM4blZjBjBFq7haNP/czEMcnBafDNjax dg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrutp97y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 02:36:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N2anxD023379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 02:36:49 GMT
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 19:36:48 -0700
Message-ID: <23f64039-6f6a-7912-8e92-b45c86b4875b@quicinc.com>
Date:   Fri, 23 Sep 2022 10:36:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] wifi: ath11k: reduce the timeout value back for hw scan
 from 10 seconds to 1 second
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220919024121.24820-1-quic_wgong@quicinc.com>
 <166383445202.9473.8707216192194973891.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <166383445202.9473.8707216192194973891.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fF6e17EMG7frIDK5PNXLcuc-hGnyQTzz
X-Proofpoint-ORIG-GUID: fF6e17EMG7frIDK5PNXLcuc-hGnyQTzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=579
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230013
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2022 4:14 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
...
> With this patch I started seeing new errors:
>
> [ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>
> This seems to happen after my suspend tests, but didn't have time to
> investigate further.

Thanks Kalle.

I guess it is caused by 11d scan is running at that moment, I will 
provide v2 for it to avoid the "failed to start hw scan: -110".

