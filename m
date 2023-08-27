Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6478A035
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjH0QnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjH0QnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 12:43:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE26115
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 09:43:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37RGT8Bq015102;
        Sun, 27 Aug 2023 16:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3st+rNsfGu5gft43YbbI/5ToQNlrl0whFBe0ukilmyM=;
 b=DvrkM6Oln5qietL3L0seRVmV+5I5fVVdWgsaDmkEPHbCDFPhZBp1vpydnZAEhQOV49uX
 hBF/g1hPL95veTUvn4Wl7rfu8DgJ3LT6b4zv0Fu3aTDJHnGpkZTB7yurxu6Y6xQmToYf
 9fhDX4Khtqc4pbjZiWhUxpl/a+TsBHUxsmJQBEMvh2iNKbOoj3lbNgN9dNaad+ucJSea
 pXsqfNgbtIcjzCBfrdC82vDgz/2eVnlq7a9nApVSS4vcWZrdovJ69guRQooJJOJBHM+Y
 QqsVAg8lDTSmzETJm2m/ir9cR5wkIP2bwhLMu3x/AuDhns5FgyOHFYwsuAyn0oVGyl76 +A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8qrsw1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 16:43:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37RGhF3A015906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 16:43:15 GMT
Received: from [10.48.245.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 09:43:15 -0700
Message-ID: <82a1c9f6-ab55-4e99-a4cb-c549e558ed15@quicinc.com>
Date:   Sun, 27 Aug 2023 09:43:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] wifi: mac80211: add support for mld in
 ieee80211_chswitch_done
Content-Language: en-US
To:     <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
 <20230827135854.9f3d846ec9ad.Ic2d14e2285aa1646216a56806cfd4a8d0054437c@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230827135854.9f3d846ec9ad.Ic2d14e2285aa1646216a56806cfd4a8d0054437c@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p5kBySnkiLs-ABCzdPKPgrvvHZyGdR75
X-Proofpoint-GUID: p5kBySnkiLs-ABCzdPKPgrvvHZyGdR75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308270157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/2023 4:05 AM, gregory.greenman@intel.com wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> This allows to finalize the CSA per link.
> In case the switch didn't work, tear down the MLD connection.
> Also pass the ieee80211_bss_conf to post_channel_switch to let the
> driver know which link completed the switch.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>   .../net/wireless/intel/iwlegacy/4965-mac.c    |  2 +-
>   drivers/net/wireless/intel/iwlegacy/common.c  |  2 +-
>   .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  6 ++--
>   .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +++---
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
>   .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 +-
>   drivers/net/wireless/ti/wlcore/event.c        |  2 +-
>   drivers/net/wireless/ti/wlcore/main.c         |  6 ++--
>   include/net/mac80211.h                        |  8 +++--
>   net/mac80211/cfg.c                            | 35 ++++++++++---------
>   net/mac80211/driver-ops.h                     |  6 ++--
>   net/mac80211/mlme.c                           | 29 ++++++++++-----
...
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 7c707358d15c..67f54825110f 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -4544,7 +4544,8 @@ struct ieee80211_ops {
>   				  struct ieee80211_channel_switch *ch_switch);
>   
>   	int (*post_channel_switch)(struct ieee80211_hw *hw,
> -				   struct ieee80211_vif *vif);
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_bss_conf *link_conf);
>   	void (*abort_channel_switch)(struct ieee80211_hw *hw,
>   				     struct ieee80211_vif *vif);
>   	void (*channel_switch_rx_beacon)(struct ieee80211_hw *hw,
> @@ -6542,11 +6543,14 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw);
>    * ieee80211_chswitch_done - Complete channel switch process
>    * @vif: &struct ieee80211_vif pointer from the add_interface callback.
>    * @success: make the channel switch successful or not
> + * @link_id: the link_id on which the switch was done. Ignored if success is
> + *	false.

I would not call this being ignored:
+	link = rcu_dereference(sdata->link[link_id]);
+	if (WARN_ON(!link)) {
+		rcu_read_unlock();
+		return;
+	}

>    *
>    * Complete the channel switch post-process: set the new operational channel
>    * and wake up the suspended queues.
>    */
> -void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success);
> +void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
> +			     unsigned int link_id);
>   
>   /**
>    * ieee80211_channel_switch_disconnect - disconnect due to channel switch error
...
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index f93eb38ae0b8..ca6045f56b4b 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -1773,7 +1773,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
>   	 */
>   	link->u.mgd.beacon_crc_valid = false;
>   
> -	ret = drv_post_channel_switch(sdata);
> +	ret = drv_post_channel_switch(link);
>   	if (ret) {
>   		sdata_info(sdata,
>   			   "driver post channel switch failed, disconnecting\n");
> @@ -1785,25 +1785,36 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
>   	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0, 0);
>   }
>   
> -void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
> +void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
> +			     unsigned int link_id)
>   {
> +	struct ieee80211_link_data *link;
>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> -	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
> -
> -	if (WARN_ON(ieee80211_vif_is_mld(&sdata->vif)))
> -		success = false;
> +	struct ieee80211_link_data_managed *ifmgd;
>   
>   	trace_api_chswitch_done(sdata, success);

no value in tracing the link_id?

> +
> +	rcu_read_lock();
> +
> +	link = rcu_dereference(sdata->link[link_id]);
> +	if (WARN_ON(!link)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	ifmgd = &link->u.mgd;
> +
>   	if (!success) {
>   		sdata_info(sdata,
>   			   "driver channel switch failed, disconnecting\n");
>   		wiphy_work_queue(sdata->local->hw.wiphy,
> -				 &ifmgd->csa_connection_drop_work);
> +				 &sdata->u.mgd.csa_connection_drop_work);
>   	} else {
>   		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
> -					 &sdata->deflink.u.mgd.chswitch_work,
> -					 0);
> +					 &ifmgd->chswitch_work, 0);
>   	}
> +
> +	rcu_read_unlock();
>   }
>   EXPORT_SYMBOL(ieee80211_chswitch_done);
>   

