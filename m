Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2B7C5952
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbjJKQiW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjJKQiV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 12:38:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6178BA
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 09:38:18 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BFo6VQ029351;
        Wed, 11 Oct 2023 16:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WTMK5I/IGJa2bZV6ExlFk1oE7BpJTm/uw6d45CpXAb0=;
 b=AhDrE4rh4ANvOJ8pfLA6GrNbXxDs9PS+IFMSvpkjLyFwzknzwh+K3vZsYUYrsZ/4pbp3
 vyHbYt1GjzEdZrj9lrW4dRFqnnaOeECWpeYY4TcosUC3630ief8Lm21u0et6AyWVv3H8
 71Inc+1WHQKI1AXueh4WF+lz8MWHUjCa9pYPF8jNGDo7QQOg4AwjurTjmhkkTt1irYK6
 mbiXJHU6iFog2LILzufnbfFGmE40bvC1lcyfgWlF0dC2mvIkMMbX9en2aoQrYwA8ofVq
 bdYq9Xkdt0ffmGS8gNr9zF6yEpt9icVOCnWTFvOVaUmeMZO5EDgJ1ZINKS7WyPKMNyQv Xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn3s1bsmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 16:38:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BGcCT3019881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 16:38:12 GMT
Received: from [10.111.181.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 09:38:11 -0700
Message-ID: <bb7be5ca-acdd-49c5-b925-c04808566427@quicinc.com>
Date:   Wed, 11 Oct 2023 09:38:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] wifi: ath12k: add BIOS SAR capability for WCN7850
Content-Language: en-US
To:     Lingbo Kong <quic_lingbok@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231011050004.423413-1-quic_lingbok@quicinc.com>
 <20231011050004.423413-3-quic_lingbok@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231011050004.423413-3-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ccEphC6IeTwdhij9Q_g2UZ4_MX0OLF3P
X-Proofpoint-GUID: ccEphC6IeTwdhij9Q_g2UZ4_MX0OLF3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_11,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=771 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Currently, ath12k does not support BIOS SAR for WCN7850. In order to enable
> BIOS SAR for WCN7850, ath12k gets BIOS SAR table and GEO offset table in
> ath12k_acpi_dsm_get_data() function, then sets pdev_id, length of data, and
> finally sends these data and WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID and
> WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID to firmware to implement BIOS SAR during
> the initialization phase. Besides, ath12k registers an ACPI event callback
> so that ACPI can notify ath12k to get the updated BIOS SAR table and sends
> it to firmware when the device state is changed.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

