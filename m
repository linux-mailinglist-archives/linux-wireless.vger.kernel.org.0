Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7770B771B4A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Aug 2023 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHGHOt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjHGHOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 03:14:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA5A10D4
        for <linux-wireless@vger.kernel.org>; Mon,  7 Aug 2023 00:14:47 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3775mgqT010133;
        Mon, 7 Aug 2023 07:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E3tSv98mYAdS1mIT54aLgPgNkcYTeVrG0rWUbo4rGNU=;
 b=dQYj7bvc1Ib/ypaZOb9jHYgl3srzwIYYfhKoQx17Fjf1f5LE+tuIyg3/eUkmvLvNwGcb
 Sz67lsC86dxV2by0G+paydOL52v7LCdBKLoXRpekmVh+0iWzkCvHASwnkgpMOk4k9Dky
 O40JzQOaCXTOp0BfHR4rk1WpvitN8Drd9dZ0sHS0T91oA50vCUWmYFWxqOp47x3b3zkW
 c7tcfSG26ICVlOB/kvxAK4Eiv2A8dCQN9jF8B7IvLVhzwTrpFbyt5a+3ei/Z62Lpvlvq
 +jWDT/X1+8MhU/GM9t1wtZItgmoF5kKK8HNjPr9tJlY8eWYy+CDflS6oGyW9k64WH4Jj Hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9fqfar32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 07:14:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3777EgHs004104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 07:14:42 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 00:14:41 -0700
Message-ID: <545cc8e8-481d-85b2-5692-43580936b48d@quicinc.com>
Date:   Mon, 7 Aug 2023 15:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
To:     Kalle Valo <kvalo@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
 <87fs70hlel.fsf@kernel.org>
Content-Language: en-US
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87fs70hlel.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m4Z4a1wmi_x-_RDHgKveXV79Gh-TWe9y
X-Proofpoint-ORIG-GUID: m4Z4a1wmi_x-_RDHgKveXV79Gh-TWe9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070067
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 6/9/2023 8:26 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
>> PCI common code") breaks with one MSI vector because it moves
>> affinity setting after IRQ request, see below log:
>>
>> [ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control response completion, polling..
>> [ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
>> [ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
>> [ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110
>>
>> The detail is, if do affinity request after IRQ activated,
>> which is done in request_irq(), kernel caches that request and
>> returns success directly. Later when a subsequent MHI interrupt is
>> fired, kernel will do the real affinity setting work, as a result,
>> changs the MSI vector. However at that time host has configured
>> old vector to hardware, so host never receives CE or DP interrupts.
>>
>> Fix it by setting affinity before registering MHI controller
>> where host is, for the first time, doing IRQ request.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI common code")
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> I'm worried if this breaks WCN6750 support. Manikanta, would able to
> test this patch on WCN6750 and let us know if breaks anything?
Hi Manikanta, could you help test this patch on WCN6750?
