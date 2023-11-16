Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CE7EE950
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjKPWcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 17:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKPWcH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 17:32:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41527B9
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 14:32:03 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGLs2ZU001580;
        Thu, 16 Nov 2023 22:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3lnBg0GqK1GXRqDKIQuCedQmoQacV7visCy0LvD1udo=;
 b=OdYdlYiOJ8l+ZiEiEC96potxFicw8pkhq7ZiUJ5oBMwpbJn9+Izj9RuyqYjevWEJfshN
 KVjQU6dTfoi8KqitwgxdlM3m4qH/pUjWoGyea+sFwjJvjEsmfrIJqAzdicfBaoXw2sBQ
 oF8qf5kC99nKhZUbxp9DuBjmVchyyjSKeEHw/4gR516Amzq9rDoq+sU+zXiIAUBHhJec
 ZAcIgtIVvT41COH170hc+QvsV/+LOhCpisUZqodmsLhSSU4hx4CXtQvCfipy4iT80bak
 O/fXp85cGsadfQ17PKGR3hxGae9n1JPHLB3ynhxpmM1BAPIcaYoff6cogHkK0IrZg4kk zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udkkusbbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 22:31:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGMVb8d007563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 22:31:37 GMT
Received: from [10.110.1.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 14:31:36 -0800
Message-ID: <a7ae4efe-08be-4b92-8a0e-4f1e743852f1@quicinc.com>
Date:   Thu, 16 Nov 2023 14:31:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add 320 MHz bandwidth enums
Content-Language: en-US
To:     Muna Sinada <quic_msinada@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231116221839.1303170-1-quic_msinada@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231116221839.1303170-1-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JAveaeJmosKXS2yyZOGbEP_iHURIP-_p
X-Proofpoint-ORIG-GUID: JAveaeJmosKXS2yyZOGbEP_iHURIP-_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=771 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/2023 2:18 PM, Muna Sinada wrote:
> Add 320 MHz bandwidth as a new bandwidth enum for ATH12k driver. This
> is extending existing bandwidth related enums to include 320 MHz. This
> is a precursor to supporting 320 MHz in the future.
> 
> Sanity test performed to confirm that there was no impact in existing
> bandwidths.
> 
> Additionally update QuIC copyright to include 2023 in hal_rx.h.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

