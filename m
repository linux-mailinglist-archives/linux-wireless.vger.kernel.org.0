Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285B233279
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG3M5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3M5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:57:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB59C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 05:57:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k187y-00DX45-Gx; Thu, 30 Jul 2020 14:57:42 +0200
Message-ID: <0a6461103e5b32503e38b5f0d34a4d2c7f4a990d.camel@sipsolutions.net>
Subject: Re: [PATCH V2 01/10] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 14:57:41 +0200
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 13:52 +0200, John Crispin wrote:

>  /**
> @@ -5109,6 +5111,9 @@ struct cfg80211_cqm_config;
>   * @pmsr_free_wk: (private) peer measurements cleanup work
>   * @unprot_beacon_reported: (private) timestamp of last
>   *	unprotected beacon report
> + * @multi_bssid_mode: Is this a legacy, transmitted or non-transmitted bssid
> + * @multi_bssid_parent: a non-transmitted bssid has a transmitted parent
> + * @multi_bssid_list: linked list for tracking parent - child relations.
>   */
>  struct wireless_dev {
>  	struct wiphy *wiphy;
> @@ -5188,6 +5193,10 @@ struct wireless_dev {
>  	struct work_struct pmsr_free_wk;
>  
>  	unsigned long unprot_beacon_reported;
> +
> +	enum nl80211_multi_bssid_mode multi_bssid_mode;
> +	struct wireless_dev *multi_bssid_parent;
> +	struct list_head multi_bssid_list;

Ah, I forgot - this was where I thought it'd be better to change ...
after reading the later patches.

Or let me just ask: why is that here? You're passing it down in the
params (code I removed above), and then you're effectively making it the
driver's (mac80211's) responsibility to track it.

So why should it be here? cfg80211 isn't really using this much. I saw
there's a small validation thing here, but that could also be pushed
down, and then this can live in mac80211?

Or do you have any future plans for using this in cfg80211?

johannes

