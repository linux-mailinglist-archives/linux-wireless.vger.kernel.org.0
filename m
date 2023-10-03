Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384377B6D7C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJCPzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJCPzE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 11:55:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46FDA6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 08:55:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393FdGH2018635;
        Tue, 3 Oct 2023 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HUXyGXoLKhyYQeoVnJGMcDOQp0CNl54U8zFApb+wyvU=;
 b=mOR1T5ec9TwlP5LUINFKJBfiFdSSKg1kEGmBlDkKbvvna2h4INznZxJYkHF8+gtjTTZn
 c8DkvcCJcxEUfBS/dFCJiREVkuvcWMJAjANUMGxtzvhJjzv5r5m2ImJFifBleVee7v+N
 MMCBGQilKPU01VT38z4OWnIan6YzkM2mIlU+f0JExH8EU7dGfIm4Kll4sinGLYSo0JwG
 WLvltnL7SaHFs6n5wpR8A9g9CuzG1wKBbmi33s5hXb3JNENvaAjFsQZsIw7200xTwxlV
 /xQdCxICMAG2JtA+gM7nIe0LzXPSMruXTO3shXUL6bYavCJ657Zo5e4D+qMOm/ePznFw SA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjj9f81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 15:54:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393FstmF002725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 15:54:55 GMT
Received: from [10.111.179.185] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 08:54:55 -0700
Message-ID: <946415fc-f8a6-42ee-b20c-f6a895a2db4f@quicinc.com>
Date:   Tue, 3 Oct 2023 08:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix debug messages
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231003150132.187875-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231003150132.187875-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Og_jjKyYrwNo3ZelrdfklecqSZ3seJVw
X-Proofpoint-ORIG-GUID: Og_jjKyYrwNo3ZelrdfklecqSZ3seJVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=906 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/3/2023 8:01 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In ath12k the debug messages were broken, no matter setting what value to the
> debug_mask module parameter would not get the debug messages printed. The issue
> is that __ath12k_dbg() uses dev_dbg() to print the debug messages which requires either enabling
> CONFIG_DYNAMIC_DEBUG or DEBUG symbol in the driver.
> 
> ath12k is supposed to use debug_mask module to control whether debug messages
> are printed or not. Using both CONFIG_DYNAMIC_DEBUG and debug_mask parameter
> does not make any sense so switch to using dev_printk(), just like ath11k does.
> Now it's enough just to debug_mask module parameter to get the debug messages.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

