Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C417C594E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbjJKQiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjJKQiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 12:38:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264BD8F
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 09:38:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BCNJpp017903;
        Wed, 11 Oct 2023 16:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gu2apgfUR9QVJtxf7s5KraUVpcOv6L4f5sRu4PMzoEo=;
 b=V+ZLAypLAl2+hVF7j88bQ+AleU7rPEuJXXSL/QazlgReJIn9vQwS6divex2ddgMvWT8U
 qk5a7hYbmndeCeIFyGEUTsUhRpMh95xdcJ3hpmCskg3lW+r8yAE/DCZ8szK0YoBNOwQE
 ro3ILnP6gVUd526yky8N2PHJZR/NdnaIZxNOtv0y163cEsJo1bAHr4LK7MHiNc25cWJV
 77kB1e4Q24cSo8vefUYFK9RtM9dXaUOaByQBIGXkUiHdxrg2rcSHKctFZ+ZKGkw/8uAe
 3x0dXTGYdYpMeJ2gOubNiPf9CBGUD7a5YMMzqGgYk4XP7DyC3dPcJEz9I0RoI4KLO9ta MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnstyrxsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 16:38:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGc7xc019816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 16:38:07 GMT
Received: from [10.111.181.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 09:38:06 -0700
Message-ID: <fbc9c0ed-87b9-490b-9992-14625eda9635@quicinc.com>
Date:   Wed, 11 Oct 2023 09:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] wifi: ath12k: add TAS capability for WCN7850
Content-Language: en-US
To:     Lingbo Kong <quic_lingbok@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231011050004.423413-1-quic_lingbok@quicinc.com>
 <20231011050004.423413-2-quic_lingbok@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231011050004.423413-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M39FipRfkYYfimfBIUtnppooHA7poeZa
X-Proofpoint-GUID: M39FipRfkYYfimfBIUtnppooHA7poeZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_11,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=883 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/10/2023 10:00 PM, Lingbo Kong wrote:
> Currently, ath12k does not support Time-Average-SAR(TAS) for WCN7850. In
> order to enable Time-Average-SAR(TAS) for WCN7850, ath12k defines
> ath12k_get_acpi_all_data() function to get TAS configuration and SAR power
> table, then sets pdev_id, param_type_id, and finally sends the TAS
> configuration, SAR power table and WMI_PDEV_SET_BIOS_INTERFACE_CMDID
> command to firmware to implement TAS during the initialization phase.
> Besides, ath12k registers an ACPI event callback so that ACPI can notify
> ath12k to get the updated SAR power table and sends it to firmware when the
> device state is changed.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

