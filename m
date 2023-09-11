Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032779C360
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 04:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjILC4b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 22:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbjILC4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 22:56:19 -0400
Received: from mx0a-0031df01.pphosted.com (unknown [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F63F90E4
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 16:23:22 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJjQK1009182;
        Mon, 11 Sep 2023 20:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OdOliK3ijmeYVY1mgK5ERQFzsbaWLhI1jKj6P3LDLmA=;
 b=YdfjZP2XS226mkmlStTLCaJt2MhqDNhomCGkX9gd8FEpQFjFNRdgXCKe6gmfyM/NriUS
 gXdD8ytQeqaxaXQuOBu+F9OYIfnuJ/DfGb27mnU5ePq2mbeJ9qkL8b1aQmuM7VmFISGY
 H2dWoFDSKyX+8Kn+jR2FuX6iGhCTS1aGegnxtdH0M8JWH7881s1xKrLqFo8h2rsDVJPk
 0cfjwEjzDlUH6aRhwXo9BSQnq10fkNnYKs+SLXTPSRWFnL3X0mhXM7NPch9fh0qvbte7
 +hQmvuccbdgLRAarRBiqWv3gcB5z4jM2aS5ib5Xm3i4rFJK4XLr/rJYpv7AQBqmsolam VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0g5pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 20:53:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BKr6w3031548
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 20:53:06 GMT
Received: from [10.111.183.71] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 13:53:06 -0700
Message-ID: <c71a6524-2d61-44fd-b918-a0215cfc983a@quicinc.com>
Date:   Mon, 11 Sep 2023 13:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add msdu_end structure for WCN7850
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230911093054.74943-1-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230911093054.74943-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 12WRylF4gYbsESMaI_3hdGOY2E1q8XAp
X-Proofpoint-ORIG-GUID: 12WRylF4gYbsESMaI_3hdGOY2E1q8XAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=585
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110192
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/11/2023 2:30 AM, Kang Yang wrote:
> WCN7850 and QCN9274 currently use the same structure rx_msdu_end_qcn9274
> for msdu_end. But content of msdu_end on WCN7850 is different from that of
> QCN9274. Need to update it for WCN7850, otherwise will get the wrong
> values when using it.
> 
> For example, TID is no longer in WCN7850's msdu_end. But
> ath12k_dp_rx_process_err() and ath12k_dp_rx_process_wbm_err() still get
> TID from msdu_end. So an uncertain value will be used in these two
> functions on WCN7850.
> 
> Therefore, add new structure rx_msdu_end_wcn7850 for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

