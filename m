Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA214792E60
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIETKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbjIETKK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 15:10:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA110F8
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 12:09:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385FbrD9028994;
        Tue, 5 Sep 2023 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VdYWOsg7YcRWRMM47bFyqzxarQ3BYLzoLAnShCegydM=;
 b=PW0L8k2Gw+4A1F9aAY+iwTXuzZ0/ZeZdHFdeLqSTgWmTSneH7ZKwoShXyLwPLBzWT70V
 sgqtKgO8dspnNVPx86kosf+LCVqsj0EFQ9/knQ1RlLE86OaQNA0KQ6VSzX8Iq1vK6whq
 CcqZeTdYPBiNtGuHkld21dMZdgdQPA+E9evz8BkmXqrHjlnt38IP4DYixkpW6tXFsj2z
 8zfC7SFJoHfVLSn2Q34AxSO0HFf0yC1i8dtg2pLEizrdUEjiWoltZhI/6lb+xe1vAZLp
 3h849ybx6zZgZwyZtfG6BONy3FzOGFxmzhFQp0NH+Bf2y/UHeujWsKJmCqby0fiwrxgK xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swpr6j1qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:04:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385H4w3B020172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 17:04:58 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 10:04:57 -0700
Message-ID: <cc57c0fd-e6e0-49df-910b-2ce1204d3d41@quicinc.com>
Date:   Tue, 5 Sep 2023 10:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: indicate to mac80211 scan complete with
 aborted flag for ATH12K_SCAN_STARTING state
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230905105947.10369-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230905105947.10369-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NMnIKxJ5Ka7JMz-HB-NoiTkOuM0yqYv3
X-Proofpoint-GUID: NMnIKxJ5Ka7JMz-HB-NoiTkOuM0yqYv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/5/2023 3:59 AM, Wen Gong wrote:
> Scan failure can not be recovered from when running a loop of the
> following steps:
> 1. run scan: "iw wlan scan".
> 2. run command: echo assert > /sys/kernel/debug/ath12k/wcn7850\ hw2.0/simulate_fw_crash
>     immediately after step 1.
> 
> result:
> scan failed and can not recover even when wlan recovery succeeds:
> command failed: Device or resource busy (-16)
> 
> reason:
> When scan arrives, WMI_START_SCAN_CMDID is sent to the firmware and
> function ath12k_mac_op_hw_scan() returns, then simulate_fw_crash arrives
> and the scan started event does not arrive, and then it starts to do
> recovery of wlan. __ath12k_mac_scan_finish() which is called from
> ath12k_core_halt() is one step of recovery, it will not call
> ieee80211_scan_completed() by logic currently because the scan state is
> ATH12K_SCAN_STARTING. Thus it leads the scan not being completed in
> mac80211, and leads all consecutive scans failing with -EBUSY in
> nl80211_trigger_scan even after wlan recovery success.
> 
> Indicate scan complete with aborted flag to mac80211 for
> ATH12K_SCAN_STARTING to allow recovery from scan failed with "Device or
> resource busy (-16)" after wlan recovery.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0f2af2f14ef7..a99324dbe7ad 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2780,18 +2780,21 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
>   		break;
>   	case ATH12K_SCAN_RUNNING:
>   	case ATH12K_SCAN_ABORTING:
> +		if (ar->scan.is_roc && ar->scan.roc_notify)
> +			ieee80211_remain_on_channel_expired(ar->hw);
> +		fallthrough;
> +	case ATH12K_SCAN_STARTING:
>   		if (!ar->scan.is_roc) {
>   			struct cfg80211_scan_info info = {
> -				.aborted = (ar->scan.state ==
> -					    ATH12K_SCAN_ABORTING),
> +				.aborted = ((ar->scan.state ==
> +					    ATH12K_SCAN_ABORTING) ||
> +					    (ar->scan.state ==
> +					    ATH12K_SCAN_STARTING)),
>   			};
>   
>   			ieee80211_scan_completed(ar->hw, &info);
> -		} else if (ar->scan.roc_notify) {
> -			ieee80211_remain_on_channel_expired(ar->hw);
>   		}
> -		fallthrough;
> -	case ATH12K_SCAN_STARTING:
> +
>   		ar->scan.state = ATH12K_SCAN_IDLE;
>   		ar->scan_channel = NULL;
>   		ar->scan.roc_freq = 0;
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

