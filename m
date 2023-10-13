Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD387C87DF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJMObB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMObA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 10:31:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D895
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 07:30:59 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDojZj005405;
        Fri, 13 Oct 2023 14:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=byyPySpuEzs+k9GORQd9rQy1JwT/b/pZRBAjY44ovu8=;
 b=klI6eWPFPTZNlw0HbQvUWqLoUx8cPEi7yXoRrW2cF4o9ZT2+mA8YwhkR/STZvbL7QnkH
 rtCOgpzeQFQf8IdSWGaLlgvAxhfnQkjJPK2NOo8lUdG8XbNirEt1sXllZjqjMQ/YvFTC
 vSOkjjUfzfx3cIhyeM14pvxHP+OSf64VzOeBibpB4JEDpMPOVOgRZkXeySKEUuowGJG3
 Y+rfym6HdwHhtkOtJOXFiTHKFJ18AzfGe1Y6YWhgEasn8p0KukXZeApybjHyiyEmQOSD
 iR+9lw7NuJa6W6zO3gcWZpf7/BiE+oaxSBMsLeQwY7IqtRE6IQDUN4dRG4D0TE2tKlhp zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1k1wab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:30:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DEUs6O031999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 14:30:54 GMT
Received: from [10.111.181.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 07:30:54 -0700
Message-ID: <a661a608-e077-4b1c-ae9c-c0d1711bc1b0@quicinc.com>
Date:   Fri, 13 Oct 2023 07:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Enable Mesh support for QCN9274
Content-Language: en-US
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231013070007.25597-1-quic_rgnanase@quicinc.com>
 <20231013070007.25597-2-quic_rgnanase@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231013070007.25597-2-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0CIFalHJkoriwyE-u3fptpIAbnY45BF8
X-Proofpoint-GUID: 0CIFalHJkoriwyE-u3fptpIAbnY45BF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=665 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/13/2023 12:00 AM, Ramya Gnanasekar wrote:
> Currently QCN9274 supports only AP and station interface modes.
> 
> Add interface type mesh to ath12k_hw_params for
> QCN9274 to provide support for mesh mode as well.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


