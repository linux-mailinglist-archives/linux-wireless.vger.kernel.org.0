Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CC7C8D48
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 20:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJMSrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMSri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 14:47:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A49BE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 11:47:35 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEPQm8015187;
        Fri, 13 Oct 2023 18:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iQ2dzGPfFTzrQcqKDqRYY4LkZbGk6fb9XbYLh8vfbME=;
 b=FeUkexyB2Dg0ZtSJzM/HQ2WN92pwQkl57+iMs+Ui62dwTzeIvBzMfNb1xF0wIUeJLjuf
 l5sxLeKFcaL4OFBZKSy3UPtnLXsE6fWI5W4OOqC12Y2YCBiMv5i7aZg8Baups2fIbPYI
 GhGD9DTIllBFFulvX8T3MIzCqTvhWW/S6ze+RvhlPVt3eMdI0+WjLRKfmfQtYJ5Z6LO5
 WRlzxGv5JRvvt5dU9fEdeSb4w12+2U05zkVNKB2tpLaNwFFKpREjnpIi0NbzELhcK4uB
 wqQYl6XNCT5GtyKBGN377EAOjReB+1K5Lu3EJ2Myp/X0pX+tc3xt9ljVxDwUlg4suPR6 eA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1rajcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 18:47:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DIlTbP028020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 18:47:29 GMT
Received: from [10.111.181.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 11:47:29 -0700
Message-ID: <46b945be-44c1-445e-a719-e5c7ed0e400a@quicinc.com>
Date:   Fri, 13 Oct 2023 11:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] wifi: ath12k: add TAS capability for WCN7850
Content-Language: en-US
To:     Lingbo Kong <quic_lingbok@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231013114434.81648-1-quic_lingbok@quicinc.com>
 <20231013114434.81648-2-quic_lingbok@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231013114434.81648-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9GpsAS0pITyivyqevBdzqRY1pN-7Ux0r
X-Proofpoint-ORIG-GUID: 9GpsAS0pITyivyqevBdzqRY1pN-7Ux0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=844 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/13/2023 4:44 AM, Lingbo Kong wrote:
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

Verified ath12k-check

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


