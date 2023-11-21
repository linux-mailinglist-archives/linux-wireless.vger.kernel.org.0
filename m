Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1157F333C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 17:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKUQIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 11:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKUQIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 11:08:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630C126
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 08:08:09 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE28L1030676;
        Tue, 21 Nov 2023 16:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=e7gXK6mk3uKdEXhwOsDKiEYSQrqFtxJZJyGhIYbeYa8=;
 b=IeGfh6qdQxHAaesorPwhPDCUd+7Hi7+33Cf2L2ExCq8X4yq8GTk5LXmZOjfjgBKb8TIH
 0ryUxzLThDSHgxEuAt7S092oluxz7rfOGAD27aZAsCnsJ+3chT1fYDOFLGaueDSFcW0O
 jknRLnZxp31oDM8ervqgSBIguGRNVTO4kMGVINz4PRWt/z8339VXnNHsq7lEh/f4+VCR
 d5WTJpnJQJoXKCAsKBUc6OlwouP9/U0HP2NwuhzC3x4jhsouC/r0zrplEwy9FE3e1pHO
 36840VIHhfw3xucncINVKJUuusJBgN6LfKvfSXQSRH2t3DF/o4IvdKjlxWmI+fo0MTHc jQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7eabxjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:08:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALG85BE029706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:08:05 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 08:08:05 -0800
Message-ID: <268eb900-3231-4d8d-9a6e-c8bc91583d4a@quicinc.com>
Date:   Tue, 21 Nov 2023 08:08:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] wifi: ath12k: do not restore ASPM in case of
 single MSI vector
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231121021304.12966-1-quic_kangyang@quicinc.com>
 <20231121021304.12966-7-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231121021304.12966-7-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9SaRv9RF2LlGTJx7sKydLWFuN_io3kh6
X-Proofpoint-ORIG-GUID: 9SaRv9RF2LlGTJx7sKydLWFuN_io3kh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=809 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210126
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
> Current code enables ASPM by default, it allows MHI to enter M2 state.
> In case of one MSI vector, system hang is observed if ath12k does MHI
> register reading in this state.
> 
> The workaround here is to prevent MHI from entering M2 state, this can
> be done by disabling ASPM if only one MSI vector is used. When using 32
> vectors ASPM is enabled as before.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

