Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87424468B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHNIlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 04:41:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48139 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgHNIlq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 04:41:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597394505; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MvbjjQ7u//aqilk9HDdb/hCeibT+UpQ7RXFvgnrjOF4=;
 b=ZY8fJhCo+QYsMrMRS0WoNN2wHQyHh+ryMrkl7cxNJRfh21ytynkAsN7x3aVYrtxtnQ5a6UKV
 Kdr62VmrOP5mEf6+ncnIq175w1rGXdrzL5shd/VXGzVAePJTqPQ5kNzkjFZRpGVEmdu72o4M
 uOdM6ZSbCHI/W5O8gDHG4PTNrk0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f364e43ba4c2cd367d2cb85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 08:41:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0A09C43391; Fri, 14 Aug 2020 08:41:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22B14C433C6;
        Fri, 14 Aug 2020 08:41:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Aug 2020 14:11:38 +0530
From:   Karthikeyan periyasamy <periyasa@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V4 4/5] mac80211: add support for BSS coloring
In-Reply-To: <20200811080107.3615705-4-john@phrozen.org>
References: <20200811080107.3615705-1-john@phrozen.org>
 <20200811080107.3615705-4-john@phrozen.org>
Message-ID: <fe02e5697e40cb02aa007acc50fb3a60@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> The CCA (color change announcement) is very similar to how CSA works 
> where
> we have an IE that includes a counter. When the counter hits 0, the new
> color is applied via an updated beacon.
> 
> This patch makes the CSA counter functionality reusable, rather than
> implementing it again. This also allows for future reuse incase support
> for other counter IEs gets added.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/mac80211.h     |  28 +++++
>  net/mac80211/cfg.c         | 227 +++++++++++++++++++++++++++++++++++--
>  net/mac80211/ieee80211_i.h |  12 ++
>  net/mac80211/iface.c       |   3 +
>  net/mac80211/tx.c          |  24 ++--
>  5 files changed, 276 insertions(+), 18 deletions(-)
...
> 
> +static int ieee80211_cca_finalize(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	u32 changed = 0;
> +	int err;
> +
> +	sdata_assert_lock(sdata);
> +	lockdep_assert_held(&local->mtx);
> +
> +	sdata->vif.cca_active = false;
> +
> +	err = ieee80211_set_after_cca_beacon(sdata, &changed);
> +	if (err) {
> +		cfg80211_color_change_aborted_notify(sdata->dev);
> +		return err;
> +	}
> +
> +	sdata->vif.bss_conf.he_bss_color.color = sdata->vif.cca_color;
> +	sdata->vif.bss_conf.he_bss_color.enabled = 1;
> +	changed |= BSS_CHANGED_HE_BSS_COLOR;
> +

Why we are not updating the bss color information in he_oper.params.
IMHO remove the redundant information of bss color in the "struct 
ieee80211_bss_conf" by removing
the he_bss_color since he_oper.params holds more information in u32 
itself.
What do you think?

> +	ieee80211_bss_info_change_notify(sdata, changed);
> +
> +	cfg80211_color_change_notify(sdata->dev);
> +
> +	return 0;
> +}
> +
> +void ieee80211_cca_finalize_work(struct work_struct *work)
> +{
> +	struct ieee80211_sub_if_data *sdata =
> +		container_of(work, struct ieee80211_sub_if_data,
> +			     cca_finalize_work);
> +	struct ieee80211_local *local = sdata->local;
> +
> +	sdata_lock(sdata);
> +	mutex_lock(&local->mtx);
> +
> +	/* AP might have been stopped while waiting for the lock. */
> +	if (!sdata->vif.cca_active)
> +		goto unlock;
> +
> +	if (!ieee80211_sdata_running(sdata))
> +		goto unlock;
> +
> +	ieee80211_cca_finalize(sdata);
> +
> +unlock:
> +	mutex_unlock(&local->mtx);
> +	sdata_unlock(sdata);
> +}
> +
> +void ieee80211_cca_finish(struct ieee80211_vif *vif)
> +{
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +
> +	ieee80211_queue_work(&sdata->local->hw,
> +			     &sdata->cca_finalize_work);
> +}
> +EXPORT_SYMBOL_GPL(ieee80211_cca_finish);
> +
> +void
> +ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
> +				       u64 color_bitmap)
> +{
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +
> +	if (sdata->vif.cca_active || sdata->vif.csa_active)
> +		return;
> +
> +	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap);
> +}
> +EXPORT_SYMBOL_GPL(ieeee80211_obss_color_collision_notify);
> +
> +static int
> +__ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
> +			 struct cfg80211_color_change_settings *params)
> +{
> +	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
> +	struct ieee80211_local *local = sdata->local;
> +	u32 changed = 0;
> +	int err;
> +
> +	sdata_assert_lock(sdata);
> +	lockdep_assert_held(&local->mtx);
> +
> +	/* don't allow another color change if one is already active or if 
> csa
> +	 * is active
> +	 */
> +	if (sdata->vif.cca_active || sdata->vif.csa_active)
> +		return -EBUSY;
> +
> +	err = ieee80211_set_cca_beacon(sdata, params, &changed);
> +	if (err)
> +		return err;
> +
> +	sdata->vif.cca_active = true;
> +	sdata->vif.cca_color = params->color;
> +
> +	cfg80211_color_change_started_notify(sdata->dev, params->count);
> +
> +	if (changed) {
> +		sdata->vif.bss_conf.he_bss_color.enabled = 0;
> +		changed |= BSS_CHANGED_HE_BSS_COLOR;

same here

> +		ieee80211_bss_info_change_notify(sdata, changed);
> +	} else {
> +		/* if the beacon didn't change, we can finalize immediately */
> +		ieee80211_cca_finalize(sdata);
> +	}
> +
> +	return 0;
> +}

Thanks
Karthikeyan P
