Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764E35A2B99
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiHZPtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbiHZPsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 11:48:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70831C2E94
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 08:48:25 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QFQQaV024514;
        Fri, 26 Aug 2022 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sO4tHXrJgM6OBGT3QmDwNcSknx/fFFOyijvnOFsEHeY=;
 b=msSiRMY5BFB8oyQK7glPEhWdujVD6XuY7mE4L4nbUWO8YmxU6aN+AKV0IL2yzq9aLh1V
 UGMnYqKaTsedgKCUV77UAWRiS+8uNEwuyTVn9HW2T4FE5G3W3J2oXP9xCJb+pXTZjDII
 uqTgnaXBXE9TmCsjQcKnmv16fsg9j2aUo/sywJqFM3vfBzSkOdX3nVWaUJKZZBZ4gaL9
 FHdYdLUjeVeBJLA3mc/7bh0ZF3G9hJYpph5Pdv2XaCxFlWBkbO5c2+7k3UWaL/UU8ZPC
 lhm0DUO/jgLMdby6JXrQenUmbCxPcCgIEkzMQkk4iHpgIXaQp+HpNbQUp+5f4Fa/n777 nQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j6ns523mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:48:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27QFmHGN008969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:48:17 GMT
Received: from [10.110.120.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 26 Aug
 2022 08:48:17 -0700
Message-ID: <c177e3cc-ae69-b8c8-bb72-be85b2262149@quicinc.com>
Date:   Fri, 26 Aug 2022 08:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
Content-Language: en-US
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <jithu.jance@broadcom.com>
References: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wha94UHeznzcKlRrUt_LkWtKuoB4jsJg
X-Proofpoint-GUID: Wha94UHeznzcKlRrUt_LkWtKuoB4jsJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/26/2022 5:55 AM, Vinayak Yadawad wrote:

if this is a v2 it should have been annotated as such with a change log

> In case of 4way handshake offload, transition disable policy
> updated by the AP during EAPOL 3/4 is not updated to the upper layer.
> This results in mismatch between transition disable policy
> between the upper layer and the driver. This patch addresses this
> issue by updating transition disable policy as part of port
> authorization indiation.

s/indiation/indication/

> 
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 2 +-
>   include/net/cfg80211.h                                    | 3 ++-
>   include/uapi/linux/nl80211.h                              | 3 +++
>   net/wireless/core.h                                       | 4 +++-
>   net/wireless/nl80211.c                                    | 7 ++++++-
>   net/wireless/nl80211.h                                    | 3 ++-
>   net/wireless/sme.c                                        | 8 +++++---
>   net/wireless/util.c                                       | 2 +-
>   8 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index db45da33adfd..6654c4167c36 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -6028,7 +6028,7 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
>   	brcmf_dbg(CONN, "Report roaming result\n");
>   
>   	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X && profile->is_ft) {
> -		cfg80211_port_authorized(ndev, profile->bssid, GFP_KERNEL);
> +		cfg80211_port_authorized(ndev, profile->bssid, -1, GFP_KERNEL);
>   		brcmf_dbg(CONN, "Report port authorized\n");
>   	}
>   
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 908d58393484..2fc173e88d31 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -7659,6 +7659,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>    *
>    * @dev: network device
>    * @bssid: the BSSID of the AP
> + * @td_bitmap: transition disable policy
>    * @gfp: allocation flags
>    *
>    * This function should be called by a driver that supports 4 way handshake
> @@ -7669,7 +7670,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>    * indicate the 802.11 association.
>    */
>   void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
> -			      gfp_t gfp);
> +			      s16 td_bitmap, gfp_t gfp);
>   
>   /**
>    * cfg80211_disconnected - notify cfg80211 that connection was dropped
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index ffb7c573e299..c81cdc6d6c86 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2741,6 +2741,8 @@ enum nl80211_commands {
>    *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
>    *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
>    *	the incoming frame RX timestamp.
> + * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
> + *  (re)associations.
>    * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>    * @NL80211_ATTR_MAX: highest attribute number currently defined
>    * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3268,6 +3270,7 @@ enum nl80211_attrs {
>   
>   	NL80211_ATTR_TX_HW_TIMESTAMP,
>   	NL80211_ATTR_RX_HW_TIMESTAMP,
> +	NL80211_ATTR_TD_BITMAP,
>   
>   	/* add attributes here, update the policy in nl80211.c */

Johannes, do you want the policy updated even thought this is 
driver->userspace and hence the policy is never applied to it?

>   
> diff --git a/net/wireless/core.h b/net/wireless/core.h
> index 775e16cb99ed..d36d4b775284 100644
> --- a/net/wireless/core.h
> +++ b/net/wireless/core.h
> @@ -271,6 +271,7 @@ struct cfg80211_event {
>   		} ij;
>   		struct {
>   			u8 bssid[ETH_ALEN];
> +			s16 td_bitmap;

I know you are using -1 as an indication that the bitmap is not used, 
but using signed with a bitmap seems strange since bitops can be 
affected by sign extension. Just something that set off my Spider-Sense.

>   		} pa;
>   	};
>   };
> @@ -409,7 +410,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
>   			bool wextev);
>   void __cfg80211_roamed(struct wireless_dev *wdev,
>   		       struct cfg80211_roam_info *info);
> -void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid);
> +void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
> +				s16 td_bitmap);
>   int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
>   			      struct wireless_dev *wdev);
>   void cfg80211_autodisconnect_wk(struct work_struct *work);
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 2705e3ee8fc4..176aa7b3bc6c 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -17841,7 +17841,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
>   }
>   
>   void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
> -				  struct net_device *netdev, const u8 *bssid)
> +				  struct net_device *netdev, const u8 *bssid,
> +				  s16 td_bitmap)
>   {
>   	struct sk_buff *msg;
>   	void *hdr;
> @@ -17861,6 +17862,10 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
>   	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
>   		goto nla_put_failure;
>   
> +	if (td_bitmap >= 0)
> +		if (nla_put_s16(msg, NL80211_ATTR_TD_BITMAP, td_bitmap))
> +			goto nla_put_failure;
> +
>   	genlmsg_end(msg, hdr);
>   
>   	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
> diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
> index 855d540ddfb9..17abb0a46d8c 100644
> --- a/net/wireless/nl80211.h
> +++ b/net/wireless/nl80211.h
> @@ -83,7 +83,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
>   			 struct net_device *netdev,
>   			 struct cfg80211_roam_info *info, gfp_t gfp);
>   void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
> -				  struct net_device *netdev, const u8 *bssid);
> +				  struct net_device *netdev, const u8 *bssid,
> +				  s16 td_bitmap);
>   void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
>   			       struct net_device *netdev, u16 reason,
>   			       const u8 *ie, size_t ie_len, bool from_ap);
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index 27fb2a0c4052..e3150b9edb88 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -1234,7 +1234,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
>   }
>   EXPORT_SYMBOL(cfg80211_roamed);
>   
> -void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
> +void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
> +					s16 td_bitmap)
>   {
>   	ASSERT_WDEV_LOCK(wdev);
>   
> @@ -1247,11 +1248,11 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
>   		return;
>   
>   	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
> -				     bssid);
> +				     bssid, td_bitmap);
>   }
>   
>   void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
> -			      gfp_t gfp)
> +			      s16 td_bitmap, gfp_t gfp)
>   {
>   	struct wireless_dev *wdev = dev->ieee80211_ptr;
>   	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
> @@ -1267,6 +1268,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
>   
>   	ev->type = EVENT_PORT_AUTHORIZED;
>   	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
> +	ev->pa.td_bitmap = td_bitmap;
>   
>   	/*
>   	 * Use the wdev event list so that if there are pending
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 2c127951764a..6a1d82c43766 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -988,7 +988,7 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
>   			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
>   			break;
>   		case EVENT_PORT_AUTHORIZED:
> -			__cfg80211_port_authorized(wdev, ev->pa.bssid);
> +			__cfg80211_port_authorized(wdev, ev->pa.bssid, ev->pa.td_bitmap);
>   			break;
>   		}
>   		wdev_unlock(wdev);

