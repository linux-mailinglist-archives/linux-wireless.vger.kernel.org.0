Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B57A0B5E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbjINRQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbjINRQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 13:16:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86E1FE8
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 10:16:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHEvai017723;
        Thu, 14 Sep 2023 17:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MlF4PsJT99WtnXe2+XCFt3aD5e82g18NBfytNY2kHAE=;
 b=EyeuD0c5sG2W4RnkNhtlu31mXS+QLN201FRVllCyIpxfTBN8+YQJ9xO1++wMga89E0V9
 0sAplcQ4qujWiZw/9zJwwiv+yka25KZwyAeftnWqKCW9cBqjXfCj3uiMEa2gnthpnDzW
 eIc06byTWELCwZ1wbOgzGSGHk5oW+sQg/rTl3jynuefFd09YT1JTd5K/kJjVA8lw84JE
 XG07LiCQizie+0AdZCBFwJX1zhge1edd/KjUf0bD66Ap5FEahrhTLcmOg+KZxQt77Rt8
 fTqXHsWahi/+X0dJVt30Oy1YTHu0UZuJPB2GlW1SuiR2tIdvG9MGXeLEQ2L72hgyCupV 8w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3v4ha1ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:16:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EHGUtb023959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:16:30 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 10:16:30 -0700
Message-ID: <a86e4484-3b03-443c-8c62-c76c2e439790@quicinc.com>
Date:   Thu, 14 Sep 2023 10:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: add 11d scan offload support
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230914090746.23560-1-quic_wgong@quicinc.com>
 <20230914090746.23560-3-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230914090746.23560-3-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sne_JxEK8WSWvp1oAnF_eqgrPISOu8kW
X-Proofpoint-GUID: Sne_JxEK8WSWvp1oAnF_eqgrPISOu8kW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=726 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140150
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/2023 2:07 AM, Wen Gong wrote:
> Add handler for WMI_11D_NEW_COUNTRY_EVENTID, WMI_11D_SCAN_START_CMDID,
> WMI_11D_SCAN_STOP_CMDID.
> 
> The priority of 11d scan WMI_SCAN_PRIORITY_MEDIUM in firmware, the
> priority of hw scan is WMI_SCAN_PRIORITY_LOW, then the 11d scan will
> cancel the hw scan which is running. To avoid this, change the priority
> of the 1st hw scan to WMI_SCAN_PRIORITY_MEDIUM. Add wait_for_completion_timeout
> for ar->scan.completed in ath12k_reg_update_chan_list(), plus the existing
> wait in ath12k_scan_stop(), then ath12k have 2 place to wait the
> ar->scan.completed, they run in different thread, thus it is possible to
> happen that the two threads both enter wait status. To handle this scenario,
> ath12k should change the complete() to complete_all() for the ar->scan.completed,
> this also work well when it is only one thread wait for ar->scan.completed.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

