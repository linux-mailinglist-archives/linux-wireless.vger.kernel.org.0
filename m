Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F95AD6B7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiIEPkD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIEPkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 11:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E98510FCD
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 08:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE556133D
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 15:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5296C433C1;
        Mon,  5 Sep 2022 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662392400;
        bh=TeFUX4zgahpMMjfFEW8qtMj1TNi6vP6+FKMLxpAoaLY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pvD3/iR3GVQo+4Xkwze0mBv57r7smizgtOBInEoToiryakaCHts2E8yvdyp5urKNj
         y96R/b4QtDNtxrdtR6vbd1sHqyC5MR+t4CzkmoPyo++DFdkcEOpI5Nk5YJsWbWPSPR
         LVIzQ8Umbw/QN98HIbU+w/eKrFISOxrHAiiUpOSLZX+W34tygIP3cgc8NhOBgc5l8K
         OJhI05AIO6SEZcBx09cfodk+5IcqMjfLsWfLEXL2ybBwrVQJ4P2l+YRHB5l+6+ez0q
         C/aqF+5V3w1Fo8HQ+88X2acBWdjbhpX0bqOcKc7Hzl9HXTbM6WpaFqaHMr0HfJk8W/
         kArfofgdbLScA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 04/12] wifi: rndis_wlan: fix array of flexible structures warning
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
        <20220904212910.0e7ce5fdbcfb.I972158734def3f93b93a3858a087cbc2cca6337e@changeid>
Date:   Mon, 05 Sep 2022 18:39:58 +0300
In-Reply-To: <20220904212910.0e7ce5fdbcfb.I972158734def3f93b93a3858a087cbc2cca6337e@changeid>
        (Johannes Berg's message of "Sun, 4 Sep 2022 21:29:04 +0200")
Message-ID: <87tu5lde41.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Use "u8 bssid_data[]" with an appropriate cast. No binary
> changes.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wireless/rndis_wlan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
> index 325933217b41..82a7458e01ae 100644
> --- a/drivers/net/wireless/rndis_wlan.c
> +++ b/drivers/net/wireless/rndis_wlan.c
> @@ -251,7 +251,7 @@ struct ndis_80211_bssid_ex {
>  
>  struct ndis_80211_bssid_list_ex {
>  	__le32 num_items;
> -	struct ndis_80211_bssid_ex bssid[];
> +	u8 bssid_data[];
>  } __packed;
>  
>  struct ndis_80211_fixed_ies {
> @@ -2084,7 +2084,8 @@ static int rndis_check_bssid_list(struct usbnet *usbdev, u8 *match_bssid,
>  	netdev_dbg(usbdev->net, "%s(): buflen: %d\n", __func__, len);
>  
>  	bssid_len = 0;
> -	bssid = next_bssid_list_item(bssid_list->bssid, &bssid_len, buf, len);
> +	bssid = next_bssid_list_item((void *)bssid_list->bssid_data,
> +				     &bssid_len, buf, len);

Same comment as in patch 2, I just feel the code gets worse because of a
compiler warning.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
