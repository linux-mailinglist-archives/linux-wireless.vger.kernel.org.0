Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7006077F8A9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351806AbjHQOVZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbjHQOVE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 10:21:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201E2D76
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 07:21:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HDtuHM015246;
        Thu, 17 Aug 2023 14:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7HMbfla+JqqCMpc+15tgoMJPcNcMhQqN1xJKlXDGeGE=;
 b=lEgxfinms5umirBy0J8GBY7oR9U4sWMrDSXA5/narfBtxbRdKt/L+nlJFvFldAAM2j1O
 3h+ffyZUTju1F5LLeui3ARmkb7CM/UdZzU5pddBRVEcAk5GICf7RtlTa4JE/c7j7g24S
 y2CP3xylWjFPniz7DdReShobn9YHfchRpYeZcfavnOW3/WmARlfqMks9l+iAAmEOKfgA
 gpprUPmko+eCpK9ROurO+XDugJqEJyEFPQv7HiTHKOI9EU4VZB+DSV9EtJnxrYdp0Vtb
 DD4UcCxsmuTW8zY6DhOfYEsjG0ADmBg1zc0ruJzcU06Rv5efrf8CqaJsw0O/0geu2nJe sw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3shbc0sarg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:20:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37HEKwnm000735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:20:58 GMT
Received: from [10.48.241.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 07:20:58 -0700
Message-ID: <9c082dcd-e26c-4f5b-ae85-8be96763c0c8@quicinc.com>
Date:   Thu, 17 Aug 2023 07:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: fix radar detection in 160 MHz
Content-Language: en-US
To:     Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
 <20230802085852.19821-3-quic_mdharane@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230802085852.19821-3-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7f-ckXnG2cfx16VnNqnUJHp-smiuCdbC
X-Proofpoint-GUID: 7f-ckXnG2cfx16VnNqnUJHp-smiuCdbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_07,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/2023 1:58 AM, Manish Dharanenthiran wrote:
> Radar detection fails in the secondary 80 MHz when the
> the AP's primary 80 MHz is in non-DFS region in 160 MHz.
> 
> This is due to WMI channel flag WMI_CHAN_INFO_DFS_FREQ2 is not set
> properly in case of the primary 80 MHz is in non-DFS region.
> HALPHY detects the radar pulses in the secondary 80 MHz only when
> WMI_CHAN_INFO_DFS_FREQ2 is set.
> 
> Fix this issue by setting WMI channel flag WMI_CHAN_INFO_DFS_FREQ2
> based on the radar_enabled flag from the channel context.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

