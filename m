Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0F7DC307
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJ3XQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3XQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 19:16:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1DC1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 16:16:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMqZGc025123;
        Mon, 30 Oct 2023 23:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SanPOEFm1N0PBAWz0gd0Rv+5E6wqxH2fGOUotdYL4gk=;
 b=Kr+L/H+U9teYyyH0aLqLNqIqGH8Ul1Lr59HzO1lcyUzNF9R90Jyp9qKhhGSF5xEmdNKd
 rzn9RITTrU9DgyqOo1adYgU7zhMQMCbF5IAUHR1KOJFMDZpV448rL0YPIRY+feopS4sC
 BM9PWaMLn4ye+lP0pztDExlxvRvTForZ1cltNjoB1gj/4E9fD+bnpPoKTZbMG341a8h9
 HxwSabgwZ0g6YaJsLXwGbamhr/+anj5T7ZvdXOERS6qBwVsqN+ci6zIlQUNaNKu4vW62
 Dh2IhSJY/X8XESEpOuwRqp8SAJB7nFObQ9m5qj8CTwk8mdjXqMx3FLQ1RWxVEtlhlCsO 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u280jt1f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:16:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UNGAGF022002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 23:16:10 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 16:16:09 -0700
Message-ID: <d2c3a0e1-f989-4862-b63f-b869d4af0010@quicinc.com>
Date:   Mon, 30 Oct 2023 16:16:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] wifi: ath12k: add support for peer meta data
 version
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-5-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-5-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sf0G22Fxid3yRMbZbgD7cVB8mVasUPKz
X-Proofpoint-ORIG-GUID: sf0G22Fxid3yRMbZbgD7cVB8mVasUPKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=969
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> From: Harshitha Prem <quic_hprem@quicinc.com>
> 
> Add support to process WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT
> service bit. If this service bit is set by firmware, then it expects
> host to set rx_peer_meta_data_ver in wmi_resource_config's flags2
> with value 3 for QCN9274 to indicate as V1B meta version. If this is
> not set firmware crash is seen during peer addition.
> 
> Hence, if WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT service bit
> is set by firmware, set correct peer metadata version to avoid
> firmware crash.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

