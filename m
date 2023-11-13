Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114CA7E9FE2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjKMPXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 10:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjKMPXd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 10:23:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4474D67
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:23:30 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADAWGFN021308;
        Mon, 13 Nov 2023 15:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mQkIctUny5Z7pkWEIrabujEW1CfB+ASyHKeol1dt3rk=;
 b=VK/ogdzmTZ/GNVPyL/6ue9g1MvwuQ+ID6KKhGVEYDRTPCs5cb3J4rmAdzy4onjrQWKBJ
 HdMaGUkFV1UdpjBB6kCLMy+x68vNVTRKmoHxgTDsAsXmUt2pN+NRVvECk4D/r7WyrtYD
 vXpzaveI68p/5P4dQXLM4EnFTCslGTVi7qTjhb2p5YRxwijEpb6rMJmQ6ZpIZoBY4LkE
 6MNGRWtxR4zNIQujbciwKJAp2Zk3gq1Y4qppRnAeh5EtreWkUPJZ8pzmk/8YsHAOgOOK
 ZbpavxWIzlV/zqKBbZwqV2deF1HbfCxtrRU/+J5WNBo+4xNHj7g8f9YoM5Q0nzl6LRPE lA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9yanc73v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 15:23:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ADFNSYB005804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 15:23:28 GMT
Received: from [10.110.49.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 07:23:28 -0800
Message-ID: <13544bcb-9c8b-49cd-9b43-ebe2d2b96778@quicinc.com>
Date:   Mon, 13 Nov 2023 07:23:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: refactor DP Rxdma ring structure
Content-Language: en-US
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231111043934.20485-1-quic_periyasa@quicinc.com>
 <20231111043934.20485-5-quic_periyasa@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231111043934.20485-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A4fYoinMQiryO-GZk9ZmBKgvCeW6YqJR
X-Proofpoint-GUID: A4fYoinMQiryO-GZk9ZmBKgvCeW6YqJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=674 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2023 8:39 PM, Karthikeyan Periyasamy wrote:
> Currently data path Rxdma ring structure store the IDR buffer and lock.
> These IDR handling is needed only for SW cookie conversion and not
> needed for HW cookie conversion. REO Rxdma ring use the HW cookie
> conversion and monitor Rxdma ring use the SW cookie conversion.
> Since idr not needed for REO Rxdma ring, remove the IDR data entity
> from the data path Rxdma ring structure. Introduce the new data path ring
> structure for monitor rxmda rings since it need IDR data entity.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

