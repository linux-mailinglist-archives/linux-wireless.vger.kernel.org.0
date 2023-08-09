Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70B7766FE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHISL3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 14:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHISL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 14:11:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8A10F5
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 11:11:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379HkfZo019808;
        Wed, 9 Aug 2023 18:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KICgTAJeFWfXDSRWXBQf28sWnVUJTLNR4TtYP4eudYs=;
 b=Av6MipalIVxC2/KZ2i9JQq1iaDN5DXMMcqGgYl2zAj5z00upai7SpxLb5NcpPZQKBPWG
 w4F9gQvQd7/UA/aZCM+qJJ1ZWg1vZ7fY/S2caK4WL79C57V+AYBoSeMR6UFfjJYFCENn
 b2nZ3pRb6SU6XcFz6uPilWBwFlsSvWmwV6O+EW9uTMkzdM1DXdMHdTJOgqMWuYUbFBvs
 ngNmJjDu4AYvUEIMdUxhkndH+pxVB779GjjiWPfMYtuD+jw9W6+b7e/xyHgFPq5MB5KI
 Whk0db49raYwTBONbE1p9IdnGaRyOGk6RqbXAjV4in+9ExdjW+GJP8N6xJ7QOYquJtlg dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny1ym6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 18:11:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379IBPHS021765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 18:11:25 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 11:11:24 -0700
Message-ID: <00af8b1a-40d4-469c-8646-d542db77b937@quicinc.com>
Date:   Wed, 9 Aug 2023 11:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Ignore fragments from uninitialized
 peer in dp
Content-Language: en-US
To:     Harshitha Prem <quic_hprem@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
 <20230809042738.13394-2-quic_hprem@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230809042738.13394-2-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hG_xNb4oFhvNAYQIGM6AuzcH56iOev9a
X-Proofpoint-ORIG-GUID: hG_xNb4oFhvNAYQIGM6AuzcH56iOev9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_16,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=856 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090159
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/8/2023 9:27 PM, Harshitha Prem wrote:
> When max virtual ap interfaces are configured in all the bands
> with ACS and hostapd restart is done every 60s,
> a crash is observed at random times.

nit: please fill the paragraph to 70+ columns

> 
> In the above scenario, a fragmented packet is received for self peer,
> for which rx_tid and rx_frags are not initialized in datapath.
> While handling this fragment, crash is observed as the rx_frag list
> is uninitialised and when we walk in ath12k_dp_rx_h_sort_frags,

nit: s/uninitialised /uninitialized/

> skb null leads to exception.
> 
> To address this, before processing received fragments we check
> dp_setup_done flag is set to ensure that peer has completed its
> dp peer setup for fragment queue, else ignore processing the
> fragments.
> 
> Call trace:
>      PC points to "ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]"
>      LR points to "ath12k_dp_process_rx_err+0x480/0xfcc [ath12k]".
>      The Backtrace obtained is as follows:
>      ath12k_dp_process_rx_err+0x4e8/0xfcc [ath12k]
>      ath12k_dp_service_srng+0x78/0x260 [ath12k]
>      ath12k_pci_write32+0x990/0xb0c [ath12k]
>      __napi_poll+0x30/0xa4
>      net_rx_action+0x118/0x270
>      __do_softirq+0x10c/0x244
>      irq_exit+0x64/0xb4
>      __handle_domain_irq+0x88/0xac
>      gic_handle_irq+0x74/0xbc
>      el1_irq+0xf0/0x1c0
>      arch_cpu_idle+0x10/0x18
>      do_idle+0x104/0x248
>      cpu_startup_entry+0x20/0x64
>      rest_init+0xd0/0xdc
>      arch_call_rest_init+0xc/0x14
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> ---

actual code patch LGTM

