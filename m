Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88117989EB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbjIHPYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbjIHPYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 11:24:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284EF1FE0
        for <linux-wireless@vger.kernel.org>; Fri,  8 Sep 2023 08:23:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Dm1Jg002285;
        Fri, 8 Sep 2023 15:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TGrx0UZqY5EHDi4H8hAQ0tBKWZWssi6Gm787gaTq7Qg=;
 b=hsrsUsENcfeHWltaUgiat9BGZoCiPTwBifZfrmWIYr2u0IzcArcEobI6mR6hGhYvd005
 U2FUKj/0W+q4GpmY0IWYuKCZTSYzNfQWcF9BfJbxLvOvVcx1m8bepeheMpC9f2LBqft7
 AGacv8PXxcSm0tSDmPeJMm0llcPtNhU783gIqW1qfT9VT/Hou1mvOq8C9m67EFbIY3b/
 zp1ggRGfya29ouhVBi31AGLGJP1wlkbz9/zrh8PqwgV3/YEk8U37Rmp4h23v+G6DEuHX
 tNVUtXDXrryiq/1zZa0GkdIEtVpWn3DLsR8e6v7yL6PVAqyiXwJySi4XhwzWNaqYXXiA rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3synyq9yr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 15:23:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388FNnT3021676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 15:23:49 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 08:23:49 -0700
Message-ID: <232a1b91-f7b4-44da-8c91-b65bb661f22c@quicinc.com>
Date:   Fri, 8 Sep 2023 08:23:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: indicate scan complete for scan canceled
 when scan running
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230906085746.18968-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230906085746.18968-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m-vXzvQo77ttaqdzIxTNMPKLncHAPejb
X-Proofpoint-GUID: m-vXzvQo77ttaqdzIxTNMPKLncHAPejb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2023 1:57 AM, Wen Gong wrote:
> ath12k prints "Received scan event for unknown vdev" when doing the
> following test:
> 1. trigger scan
> 2. wait 0.2 second
> 3. iw reg set is issued or 11d scan complete event is sent from firmware
> 
> Reason is:
> When iw reg set is issues or the 11d scan complete event is received, the
> new country code will be set to the firmware, and the new regdomain info
> indicated to ath12k, then the new channel list will be sent to the firmware.
> The firmware will cancel the current scan after receiving WMI_SCAN_CHAN_LIST_CMDID
> which is used for the new channel list, and the state of ath12k is
> ATH12K_SCAN_RUNNING, then ath12k_get_ar_on_scan_abort() returns NULL and
> ath12k_scan_event() returns at this point and does not indicate scan
> completion to mac80211.
> 
> Indicate scan completion to mac80211 and get rid of the "Received scan
> event for unknown vdev" print for the above case.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 9ed33e2d6da0..d30de487f43f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5862,8 +5862,9 @@ static void ath12k_mgmt_tx_compl_event(struct ath12k_base *ab, struct sk_buff *s
>   	rcu_read_unlock();
>   }
>   
> -static struct ath12k *ath12k_get_ar_on_scan_abort(struct ath12k_base *ab,
> -						  u32 vdev_id)
> +static struct ath12k *ath12k_get_ar_on_scan_state(struct ath12k_base *ab,
> +						  u32 vdev_id,
> +						  enum ath12k_scan_state state)
>   {
>   	int i;
>   	struct ath12k_pdev *pdev;
> @@ -5875,7 +5876,7 @@ static struct ath12k *ath12k_get_ar_on_scan_abort(struct ath12k_base *ab,
>   			ar = pdev->ar;
>   
>   			spin_lock_bh(&ar->data_lock);
> -			if (ar->scan.state == ATH12K_SCAN_ABORTING &&
> +			if (ar->scan.state == state &&
>   			    ar->scan.vdev_id == vdev_id) {
>   				spin_unlock_bh(&ar->data_lock);
>   				return ar;
> @@ -5905,10 +5906,15 @@ static void ath12k_scan_event(struct ath12k_base *ab, struct sk_buff *skb)
>   	 * aborting scan's vdev id matches this event info.
>   	 */
>   	if (le32_to_cpu(scan_ev.event_type) == WMI_SCAN_EVENT_COMPLETED &&
> -	    le32_to_cpu(scan_ev.reason) == WMI_SCAN_REASON_CANCELLED)
> -		ar = ath12k_get_ar_on_scan_abort(ab, le32_to_cpu(scan_ev.vdev_id));
> -	else
> +	    le32_to_cpu(scan_ev.reason) == WMI_SCAN_REASON_CANCELLED) {
> +		ar = ath12k_get_ar_on_scan_state(ab, le32_to_cpu(scan_ev.vdev_id),
> +						 ATH12K_SCAN_ABORTING);
> +		if (!ar)
> +			ar = ath12k_get_ar_on_scan_state(ab, le32_to_cpu(scan_ev.vdev_id),
> +							 ATH12K_SCAN_RUNNING);
> +	} else {
>   		ar = ath12k_mac_get_ar_by_vdev_id(ab, le32_to_cpu(scan_ev.vdev_id));
> +	}
>   
>   	if (!ar) {
>   		ath12k_warn(ab, "Received scan event for unknown vdev");
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

