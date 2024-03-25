Return-Path: <linux-wireless+bounces-5216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531988B17F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 21:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8626CE421E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94B6F079;
	Mon, 25 Mar 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="q6TIEcpq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4956740
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383027; cv=none; b=guaDp8DSHXmp44o2ZffcWlHJDJAwgOmtxj1SwkUG9WfJ8aRohdDqR3t+axlBC1rzU+vh1787Hfx/qP+qyv0utz53DchxpFnrwv0snV2asrF+FZXwb/w3+Nsld+eHin3fa8b4mHIVPf0LqIvrF0c9+9KhAiuM9bnaVUYEhLszQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383027; c=relaxed/simple;
	bh=TNhTO3oEGKdK8/FRCZCOdcHCiK1CA4vK+N6duiFKCpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u9WZv/y7jVzNH3maAgGJmYBeEyT3YVsXel09jSiVCaP+V5AVbJWTHfV/Bql/RzgUYHdmcm48oqTVHoBYj3pFk8EFgDxzldahlDvUqm1McyMofy2wPKCFjGvqqTu5vF9hdiy+M2n0Vx5fJLRIqdLyh7RCIF3RuxHoLVYTGUTwq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=q6TIEcpq; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B3984440066
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:10:16 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 16EB713C2B0
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 09:10:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 16EB713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711383016;
	bh=TNhTO3oEGKdK8/FRCZCOdcHCiK1CA4vK+N6duiFKCpw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=q6TIEcpqcfOTnErYiPBGsQINo8XvL1gZi3cTHvI4gqOAKFkWXNSZfvPQwT07AWNUw
	 mLwwm3KI2pBgCqSOcxO/VHPvx5EkV0TNMJos2HT2Hm4Y+yXmQQ2ATqWFhCTSw1MFDj
	 qoT4GmIOLi5LaGB+mVcuhRKmBl+EsFlpaUcLGH6Q=
Message-ID: <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
Date: Mon, 25 Mar 2024 09:10:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mac80211: Ensure links are cleaned up when driver
 fails.
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <20231111001023.1335122-1-greearb@candelatech.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20231111001023.1335122-1-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711383017-Jtbwyu0HsGEK
X-MDID-O:
 us5;at1;1711383017;Jtbwyu0HsGEK;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

On 11/10/23 16:10, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> On cleanup paths, links need to be deleted even if the driver fails
> to do so.  Add a flag to cause driver errors to be ignored in
> appropriate cases.
> 
> This appears to fix some kernel warnings and crashes.

Hello Johannes,

Any interest in this patch?

Thanks,
Ben

> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   net/mac80211/cfg.c         |  4 ++--
>   net/mac80211/ieee80211_i.h |  7 ++++---
>   net/mac80211/iface.c       |  2 +-
>   net/mac80211/link.c        | 30 +++++++++++++++++++-----------
>   net/mac80211/mlme.c        | 29 +++++++++++++++--------------
>   5 files changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 08c284c4984a..1c2b88429ce4 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -4894,7 +4894,7 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
>   	if (wdev->use_4addr)
>   		return -EOPNOTSUPP;
>   
> -	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
> +	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0, false);
>   }
>   
>   static void ieee80211_del_intf_link(struct wiphy *wiphy,
> @@ -4905,7 +4905,7 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
>   
>   	lockdep_assert_wiphy(sdata->local->hw.wiphy);
>   
> -	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
> +	ieee80211_vif_set_links(sdata, wdev->valid_links, 0, false);
>   }
>   
>   static int sta_add_link_station(struct ieee80211_local *local,
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 9ce7f7d2b573..34412ac5db71 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -2040,10 +2040,11 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
>   			 struct ieee80211_bss_conf *link_conf);
>   void ieee80211_link_stop(struct ieee80211_link_data *link);
>   int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
> -			    u16 new_links, u16 dormant_links);
> -static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
> +			    u16 new_links, u16 dormant_links, bool ignore_driver_failures);
> +static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata,
> +					     bool ignore_driver_failures)
>   {
> -	ieee80211_vif_set_links(sdata, 0, 0);
> +	ieee80211_vif_set_links(sdata, 0, 0, ignore_driver_failures);
>   }
>   
>   /* tx handling */
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 0c7ec6ef9136..c71e6c786b28 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -864,7 +864,7 @@ static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
>   	if (ieee80211_vif_is_mesh(&sdata->vif))
>   		ieee80211_mesh_teardown_sdata(sdata);
>   
> -	ieee80211_vif_clear_links(sdata);
> +	ieee80211_vif_clear_links(sdata, true);
>   	ieee80211_link_stop(&sdata->deflink);
>   }
>   
> diff --git a/net/mac80211/link.c b/net/mac80211/link.c
> index 2dc0f46ee053..19c085a143e4 100644
> --- a/net/mac80211/link.c
> +++ b/net/mac80211/link.c
> @@ -225,7 +225,9 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
>   		if (sdata->vif.active_links)
>   			break;
>   		sdata->vif.active_links = valid_links & ~dormant_links;
> -		WARN_ON(hweight16(sdata->vif.active_links) > 1);
> +		if (WARN_ON(hweight16(sdata->vif.active_links) > 1))
> +			sdata_err(sdata, "ERROR: set-vif-links-bitmaps: too many active-links,  valid_links: 0x%x  dormant_links: 0x%x  active_links: 0x%x\n",
> +				  valid_links, dormant_links, sdata->vif.active_links);
>   		break;
>   	default:
>   		WARN_ON(1);
> @@ -234,7 +236,8 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
>   
>   static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
>   				      struct link_container **to_free,
> -				      u16 new_links, u16 dormant_links)
> +				      u16 new_links, u16 dormant_links,
> +				      bool ignore_driver_failures)
>   {
>   	u16 old_links = sdata->vif.valid_links;
>   	u16 old_active = sdata->vif.active_links;
> @@ -325,13 +328,17 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
>   	}
>   
>   	if (ret) {
> -		/* restore config */
> -		memcpy(sdata->link, old_data, sizeof(old_data));
> -		memcpy(sdata->vif.link_conf, old, sizeof(old));
> -		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
> -		/* and free (only) the newly allocated links */
> -		memset(to_free, 0, sizeof(links));
> -		goto free;
> +		sdata_info(sdata, "driver error applying links: %d  Restoring old configuration, old_links: 0x%x  dormant_links: 0x%x requested new_links: 0x%x ignore-driver-failures: %d\n",
> +			   ret, old_links, dormant_links, new_links, ignore_driver_failures);
> +		if (!ignore_driver_failures) {
> +			/* restore config */
> +			memcpy(sdata->link, old_data, sizeof(old_data));
> +			memcpy(sdata->vif.link_conf, old, sizeof(old));
> +			ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
> +			/* and free (only) the newly allocated links */
> +			memset(to_free, 0, sizeof(links));
> +			goto free;
> +		}
>   	}
>   
>   	/* use deflink/bss_conf again if and only if there are no more links */
> @@ -352,13 +359,14 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
>   }
>   
>   int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
> -			    u16 new_links, u16 dormant_links)
> +			    u16 new_links, u16 dormant_links,
> +			    bool ignore_driver_failures)
>   {
>   	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
>   	int ret;
>   
>   	ret = ieee80211_vif_update_links(sdata, links, new_links,
> -					 dormant_links);
> +					 dormant_links, ignore_driver_failures);
>   	ieee80211_free_links(sdata, links);
>   
>   	return ret;
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index bbb337005766..21ae23531f5f 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -3215,7 +3215,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
>   	memset(&sdata->u.mgd.ttlm_info, 0,
>   	       sizeof(sdata->u.mgd.ttlm_info));
>   	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
> -	ieee80211_vif_set_links(sdata, 0, 0);
> +	ieee80211_vif_set_links(sdata, 0, 0, true);
>   }
>   
>   static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
> @@ -3379,7 +3379,8 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
>   
>   	lockdep_assert_wiphy(sdata->local->hw.wiphy);
>   
> -	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
> +	if (WARN_ONCE(ieee80211_vif_is_mld(&sdata->vif),
> +		      "mgd-probe-ap called for MLD station: %s", sdata->dev->name))
>   		return;
>   
>   	if (!ieee80211_sdata_running(sdata))
> @@ -3654,7 +3655,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
>   		sdata->u.mgd.flags = 0;
>   
>   		ieee80211_link_release_channel(&sdata->deflink);
> -		ieee80211_vif_set_links(sdata, 0, 0);
> +		ieee80211_vif_set_links(sdata, 0, 0, true);
>   	}
>   
>   	cfg80211_put_bss(sdata->local->hw.wiphy, auth_data->bss);
> @@ -3711,7 +3712,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
>   		}
>   
>   		ieee80211_link_release_channel(&sdata->deflink);
> -		ieee80211_vif_set_links(sdata, 0, 0);
> +		ieee80211_vif_set_links(sdata, 0, 0, true);
>   	}
>   
>   	kfree(assoc_data);
> @@ -5268,7 +5269,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
>   			}
>   		}
>   
> -		ieee80211_vif_set_links(sdata, valid_links, dormant_links);
> +		ieee80211_vif_set_links(sdata, valid_links, dormant_links, false);
>   	}
>   
>   	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
> @@ -5348,7 +5349,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
>   	}
>   
>   	/* links might have changed due to rejected ones, set them again */
> -	ieee80211_vif_set_links(sdata, valid_links, dormant_links);
> +	ieee80211_vif_set_links(sdata, valid_links, dormant_links, false);
>   
>   	rate_control_rate_init(sta);
>   
> @@ -5915,7 +5916,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
>   	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
>   
>   	ret = ieee80211_vif_set_links(sdata, new_valid_links,
> -				      new_dormant_links);
> +				      new_dormant_links, false);
>   	if (ret)
>   		sdata_info(sdata, "Failed setting valid links\n");
>   
> @@ -6045,12 +6046,12 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
>   		return;
>   	}
>   
> -	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0);
> +	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0, false);
>   	new_active_links = BIT(ffs(new_active_links) - 1);
>   	ieee80211_set_active_links(&sdata->vif, new_active_links);
>   
>   	ret = ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
> -				      new_dormant_links);
> +				      new_dormant_links, false);
>   
>   	sdata->u.mgd.ttlm_info.active = true;
>   	sdata->u.mgd.ttlm_info.switch_time = 0;
> @@ -6165,7 +6166,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
>   			 */
>   			ret = ieee80211_vif_set_links(sdata,
>   						      sdata->vif.valid_links,
> -						      0);
> +						      0, false);
>   			if (ret) {
>   				sdata_info(sdata, "Failed setting valid/dormant links\n");
>   				return;
> @@ -7229,12 +7230,12 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
>   		mlo = true;
>   		if (WARN_ON(!ap_mld_addr))
>   			return -EINVAL;
> -		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0);
> +		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0, false);
>   	} else {
>   		if (WARN_ON(ap_mld_addr))
>   			return -EINVAL;
>   		ap_mld_addr = cbss->bssid;
> -		err = ieee80211_vif_set_links(sdata, 0, 0);
> +		err = ieee80211_vif_set_links(sdata, 0, 0, false);
>   		link_id = 0;
>   		mlo = false;
>   	}
> @@ -7386,7 +7387,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
>   
>   out_err:
>   	ieee80211_link_release_channel(&sdata->deflink);
> -	ieee80211_vif_set_links(sdata, 0, 0);
> +	ieee80211_vif_set_links(sdata, 0, 0, true);
>   	return err;
>   }
>   
> @@ -8037,7 +8038,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   		}
>   
>   		/* if there was no authentication, set up the link */
> -		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0);
> +		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0, false);
>   		if (err)
>   			goto err_clear;
>   	} else {

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



