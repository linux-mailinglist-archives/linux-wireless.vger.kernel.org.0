Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82497EBA83
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 01:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbjKOAM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 19:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKOAM5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 19:12:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC40CF
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 16:12:52 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AENKPAV023546;
        Wed, 15 Nov 2023 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ijccHGA2xXwY8cxN0fLgyW65IjRrkPA+CeTrnE0SRgg=;
 b=asaBifqMnfH1Urbf7Qvye08xF3FYqMta48G60NkKTtEaI2acltYaupqwVdQKHgDzqUni
 SYIPV/btJtX4b2YP4UTTm0wfBmb2O0nYTrE4oLAcdST1QWO/WHckZg8mmztQkdbJTzjQ
 C82+fp9h6fwlATT1c8vlPAWZ4hL6yL0C0EuUiswCz8wMT4KwTU1OFlAr0IF0ORA+L4XV
 2jP14ojDkfx+IZ6RWxx0d81K9tuj8bp5yxauc6Oigwcrs6Jc16vsSC8SXnhfdpkWVdM/
 I5ufoPn9sJPKziAjw0FBqRlEa5VK67G5cl7pyNvmLFyBnv+x23xcfvQ+sBLJjxlewHMQ wg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucanq1bet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 00:12:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF0CiVr022676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 00:12:44 GMT
Received: from [10.110.49.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 16:12:44 -0800
Message-ID: <5f41c0d6-f172-4b36-84bc-cf7ac5d694c6@quicinc.com>
Date:   Tue, 14 Nov 2023 16:12:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add 320 MHz bandwidth enums
Content-Language: en-US
To:     Muna Sinada <quic_msinada@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231114183314.2846274-1-quic_msinada@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231114183314.2846274-1-quic_msinada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ik-DV0bEDuYyFGzI9WJiVhyzTTMw_3qf
X-Proofpoint-ORIG-GUID: ik-DV0bEDuYyFGzI9WJiVhyzTTMw_3qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_23,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=505 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/14/2023 10:33 AM, Muna Sinada wrote:
> Add 320 MHz bandwidth as a new bandwidth enum for ATH12k driver. This
> is extending existing bandwidth related enums to include 320 MHz. This
> is a precursor to supporting 320 MHz in the future.
> 
> Sanity test performed to confirm that there was no impact in existing
> bandwidths.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 3 ++-
>  drivers/net/wireless/ath/ath12k/dp_rx.c  | 3 ++-
>  drivers/net/wireless/ath/ath12k/hal_rx.h | 1 +
>  drivers/net/wireless/ath/ath12k/mac.c    | 8 ++++++++
>  drivers/net/wireless/ath/ath12k/mac.h    | 1 +
>  drivers/net/wireless/ath/ath12k/wmi.h    | 1 +

Can you update hal_rx.h to have a 2023 QuIC copyright and then repost a
v2? I have a pending patch that updates copyrights for all ath12k files
modified by QuIC in 2023, and that patch updates all of the files you
are touching except hal_rx.h. Your change is the first modification of
hal_rx.h this year.

