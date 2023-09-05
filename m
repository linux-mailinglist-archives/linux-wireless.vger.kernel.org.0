Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212D792C88
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjIERhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjIERhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 13:37:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B467807C
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 10:07:16 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ds9tv023231;
        Tue, 5 Sep 2023 17:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9DwOYdzyCmrvCcBYnB48qZv4FwVwBCfPHgm3VjQekZs=;
 b=V77YIYkdQLbF0g6ZDK/gs0QcPLGmRYxx91jXdCjLO7h+Ux34wrZIpwQXeHAQtajJuY3l
 mfYr1UUAowSjsSrJqMohvhPwdB6wN4SYIDd2CeAPlRQoLizfqfjtcoykV7LNZq3mbmU2
 swKGSGLuWIOBryxXx9mwcAXDGG5z1Sn6R0QNOAX93r9EpTxQvhYrlAlSB4KnkX5FgGWX
 RmLlR55r286fCE4Wv7n9lgmOwZ+tIqafuzfYKd0Sd/2eA6f3tpz+QHsmW/uDNf+ziWHT
 uvCOsg/09Ef1slGIAKHz2uSKEEFXy+RJImVniBLbEqrgTIzhC83za5UA1lWmUFTUOhw6 JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swsp59tsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:05:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385H5rHr012051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 17:05:53 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 10:05:52 -0700
Message-ID: <a1e4f4fd-7558-412f-8011-02740b8cf4a9@quicinc.com>
Date:   Tue, 5 Sep 2023 10:05:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix recovery fail while firmware crash when
 doing channel switch
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230905105229.10090-1-quic_wgong@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230905105229.10090-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gTOB22NbLKiwrQj06szoJQDC5dvqROGQ
X-Proofpoint-GUID: gTOB22NbLKiwrQj06szoJQDC5dvqROGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/5/2023 3:52 AM, Wen Gong wrote:
> When firmware crashed while channel switch running, recovery starts in
> ath12k. Then ieee80211_sta_connection_lost() will be called by function
> ieee80211_restart_work() in mac80211. And then many WMI command timeout
> because firmware is crashed. Each WMI command cost 3 seconds, then the
> total time will be large and leads recovery fail.
> 
> Hence change to set value ATH12K_FLAG_CRASH_FLUSH early and then
> ath12k_wmi_cmd_send() will not wait 3 seconds, then recovery will be
> started quickly and success.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 3df8059d5512..56be7298ac86 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -685,6 +685,9 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>   	ab->stats.fw_crash_counter++;
>   	spin_unlock_bh(&ab->base_lock);
>   
> +	if (ab->is_reset)
> +		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
> +
>   	for (i = 0; i < ab->num_radios; i++) {
>   		pdev = &ab->pdevs[i];
>   		ar = pdev->ar;
> 
> base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e

