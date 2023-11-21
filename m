Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F77F333E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjKUQIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 11:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKUQIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 11:08:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC4BC
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 08:08:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE1mMh010901;
        Tue, 21 Nov 2023 16:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1mdyPrsu67APsNDZfjHYJQPGl02sxbUb5zyREZHDels=;
 b=OBzNaT2D46sjOq73mu4aBCaRB6N5bUt7i+AjxmwzCDIrS2OrwFCN5/TP/LVXYknlFqMT
 vdw8doCk921d+tnxw7J3cjchVVYmBxMpe4dWeezMfgi1RC99YkcZrZxUXJfvHfUkT1aJ
 mt0SuB4jJkGLHcSaefrxRAhk11KutnrkcM7MpF/5PJ/rukmUEyZ2TwRCSgk1lDGu0AgF
 YbqHShl1NcD947CwUwXrSGcFBwFCSZ+jr+7UR0mi3vcXWRQgsT5P9bMWfpRkioEBOCSs
 feau3LisC0DCFR9LuqdERMa1hLVek9k8mymIg4LPOgQQlsaZHpWqV1ns8zG4FkjXA/WZ ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugvt2gkjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:08:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALG8QS5003817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:08:26 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 08:08:25 -0800
Message-ID: <de71ff67-c840-479f-9d06-5a2a7364cc09@quicinc.com>
Date:   Tue, 21 Nov 2023 08:08:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] wifi: ath12k: set IRQ affinity to CPU0 in case of
 one MSI vector
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231121021304.12966-1-quic_kangyang@quicinc.com>
 <20231121021304.12966-8-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231121021304.12966-8-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0W-Wx5wOHjcWBUwhHnFsHnxwsqVO2Sgq
X-Proofpoint-ORIG-GUID: 0W-Wx5wOHjcWBUwhHnFsHnxwsqVO2Sgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 mlxlogscore=920 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/2023 6:13 PM, Kang Yang wrote:
> With VT-d disabled on Intel platform, ath12k gets only one MSI
> vector. In that case, ath12k does not free IRQ when doing suspend,
> hence the kernel has to migrate it to CPU0 (if it was affine to
> other CPUs) and allocates a new MSI vector. However, ath12k has
> no chance to reconfig it to HW srngs during this phase, thus
> ath12k fails to resume.
> 
> This issue can be fixed by setting IRQ affinity to CPU0 before
> request_irq is called. With such affinity, migration will not
> happen and thus the vector keeps unchanged during suspend/resume.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

