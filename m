Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B344D605C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348105AbiCKLEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiCKLEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 06:04:31 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812A186B9B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 03:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=A0Vtf0oIcOhC5jNJ0AvM/ZmbPBrz6RKmGRE+jynQMCI=;
        t=1646996608; x=1648206208; b=TM2xZcww73qg21IjhGLmFbFV9ySIYa8CoNQXlQQbyE8ZAXC
        RhvohWj2SHxk+IW95QQXS5eOVsqTQSObAMBWNMXufKVA2hho4js8qL8ARhia9AZR8ug2CPR4YwVNw
        /YEARGJeCw67u4ScORq1Vt48uySuXndphEHfJ3xwqRrlAYFMdq6otiUAHTMXTiRwyOYCOhjGvh7jy
        COahPneoEh1WuVuuNwhjjR/wkesSKFNbKZucxiIotqzaWh0TvrTWZqFgj/0fXgeCWDt+ov3DalCDR
        A9xvVKAtlfTerPdvfG5fF8vcY9d0mq4dHlhCdLy13FFhNSdXvvYfRIbd0c3B4HwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSd3M-00Bsc9-Uz;
        Fri, 11 Mar 2022 12:03:25 +0100
Message-ID: <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Fri, 11 Mar 2022 12:03:24 +0100
In-Reply-To: <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Couple of notes below:

> @@ -704,6 +704,7 @@ struct ieee80211_bss_conf {
>  	struct cfg80211_he_bss_color he_bss_color;
>  	struct ieee80211_fils_discovery fils_discovery;
>  	u32 unsol_bcast_probe_resp_interval;
> +	bool he_6g_nonht_dup_beacon_set;

This is missing documentation.
 
> +	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
> +				     params->tail, params->tail_len);
> +	if (cap && cap->datalen >= sizeof(*he_oper) + 1) {
> +		he_oper = (void *)(cap->data + 1);
> +		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
> +		if (he_6ghz_oper) {
> +			sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = false;
> +			if (u8_get_bits(he_6ghz_oper->control,
> +					IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON)) {
> +				sdata->vif.bss_conf.he_6g_nonht_dup_beacon_set = true;
> +			}

no braces needed there, and no u8_get_bits() either, you can just & ?

> +		}
> +	}

I am wondering though if this should even be detected from the HE
operation element itself, rather than from the beacon rate settings that
are separate in nl80211?

johannes
