Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031077F4C6C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjKVQcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKVQcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 11:32:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA71B9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 08:31:46 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMFMg9p028197;
        Wed, 22 Nov 2023 16:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3qKGTKEG3vpRSY/X+OWKlV9k9tcTOuDpGev3LADmhKg=;
 b=UNbOb4dnHc7EtW5VaQOr/maPeDZo+gwCTpiQId1rEyNXlALfuk9Rrvl0qBg0rmc3eJax
 PBmlds9XYAqVPsJaKECV9JJGjoRtis9skivm93KH6Ws4WadgOhp4PxgHwXnVAmO5GDsu
 X0FfGigIfTyF2Ch8+FFqEMLE+52L8ZnA2EG3kHtaqcGc57TskMZ8dXtsMQR49kfbAP6T
 cpgnUVmNllr829dU6Vu+Ol8897N6qBQeQNf7A0kh5jlrZBs6uLG+IyT2d/xk1I+2Eo9+
 eBFkGxNgppwc6TgEhK/AMH+1HIZpFCLh/8h/q78SU1bKGLx8njnROEZwYWYp9kCxvYpo 1Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugvt2ktvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:31:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMGVdxS012725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 16:31:39 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 08:31:39 -0800
Message-ID: <318854e2-fae5-49a1-a71a-0005fe270573@quicinc.com>
Date:   Wed, 22 Nov 2023 08:31:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: Remove unsupported tx monitor handling
Content-Language: en-US
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231122063932.10321-1-quic_tamizhr@quicinc.com>
 <20231122063932.10321-3-quic_tamizhr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231122063932.10321-3-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ouzWQoZQfhAmab7zCaF9jKa1jPosH3FC
X-Proofpoint-ORIG-GUID: ouzWQoZQfhAmab7zCaF9jKa1jPosH3FC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 mlxlogscore=867 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311220119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/21/2023 10:39 PM, Tamizh Chelvam Raja wrote:
> Currently tx monitor is not supported in driver. So remove
> the tx monitor ring configuration, allocation and handling.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

