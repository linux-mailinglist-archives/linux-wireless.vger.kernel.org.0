Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9C68224D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 03:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAaClA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 21:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaCk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 21:40:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE812847
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 18:40:58 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2F1kn026025;
        Tue, 31 Jan 2023 02:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZGJCdSbtiiEEWZako4px0NCt4o/4iXCpVDqXTbZ19WM=;
 b=PhJk5qDoiRxdhh/xOX6Qbqo1fwD/lHKczA/7BpIajSKhd4ebUV8xRwsOlGrZ3YQrB8yF
 ZcQthUDHgjRTpPe0SaTuYma4imQKt2x2/htpoJfNRpGNEL+AWw/vg3K6L3tU0ZpAIq+c
 UNqnGNeU1WQ/YpwAWMRZ41OXaJuqKYWN56SK5J/mvBI1K747s2uc/Vf8iyeYrFCOuNOv
 WzSzBKnI+1CFZ4wAf5H5hODe1PJsuukBKYalzbb1LeukirS4GtyrB1vPp3BW/uRXjJYd
 3fh8dTI76l8M6/lQBKBlMnQwaGwBvnYI+zPz066Z6++s0YH6SvYaYIHWvoMVzSPqidBo /w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnyn7b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:40:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V2en77018299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:40:49 GMT
Received: from [10.253.72.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 18:40:48 -0800
Message-ID: <31f9d4b3-6c49-6b49-0240-ad956ce95e34@quicinc.com>
Date:   Tue, 31 Jan 2023 10:40:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/2] wifi: ath11k: reduce the timeout value back for hw
 scan from 10 seconds to 1 second
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221011072408.23731-1-quic_wgong@quicinc.com>
 <20221011072408.23731-3-quic_wgong@quicinc.com> <8735atg335.fsf@kernel.org>
 <cd96eea8-dce0-bcb9-e8ce-05fa0e0f22fb@quicinc.com>
 <e7e34c3d-8b73-f7d5-9ce8-5ed346ca9d28@quicinc.com>
 <7bcd1a12-fb60-98cd-1a29-f55efa8d1499@quicinc.com>
 <73908049-4a69-e65c-665b-97d068f1fef7@quicinc.com>
 <87k01qd426.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87k01qd426.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qe6Q_hEuswDjp7TLlZ8DItIiUXBsVDuj
X-Proofpoint-ORIG-GUID: qe6Q_hEuswDjp7TLlZ8DItIiUXBsVDuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=928 clxscore=1011
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310022
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/13/2023 8:14 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> Should I change commit log with below explanation and send v4?
> Please stop spamming the same question over and over, it's really
> annoying. If I don't have time to look at something, spamming me won't
> help, quite the opposite. It would be a lot better if you would help
> with the other upstream related tasks we have, that way I might have
> more time to look at your patches.
>
> To answer your question I need to look at this patchset in detail and I
> don't know when I'm able to do that. But at this moment I don't trust
> this patchset is the right approach and I'm not willing to take it.

yes.

I will send v4 only for one patch "[v3,1/2] wifi: ath11k: change to set 
11d state instead of start 11d scan while disconnect",

is it ok?

