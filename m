Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BE2A92C8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKFJbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFJbu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:31:50 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3146C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:31:50 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kay61-002CSH-13; Fri, 06 Nov 2020 10:31:49 +0100
Message-ID: <020eb33ec1ed5cd5eb076eee7cc39a09a62bfdff.camel@sipsolutions.net>
Subject: Re: [PATCH V5 3/4] mac80211: add multiple bssid/EMA support to
 beacon handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Date:   Fri, 06 Nov 2020 10:31:47 +0100
In-Reply-To: <20201103091743.1924854-4-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
         <20201103091743.1924854-4-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-11-03 at 10:17 +0100, John Crispin wrote:

> +/**
> + * enum ieee80211_bcn_tmpl_ema - EMA beacon generation type
> + * @IEEE80211_BCN_EMA_NONE: don't generate an EMA beacon.
> + * @IEEE80211_BCN_EMA_NEXT: generate the next periodicity beacon.
> + * @IEEE80211_BCN_EMA_INDEX: generate beacon by periodicity index
> + *	if the value is >= this enum value.
> + */
> +enum ieee80211_bcn_tmpl_ema {
> +	IEEE80211_BCN_EMA_NONE	= -2,
> +	IEEE80211_BCN_EMA_NEXT	= -1,
> +	IEEE80211_BCN_EMA_INDEX	= 0,
> +};

I don't see this used in the new API below?

> +/** struct ieee80211_ema_bcn_list - list entry of an EMA beacon

missing newline

> + * Return: The nuber of entries in the list or 0 on error.
> + */
> +
> +int
> +ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,

could remove that newline and put the int on the same line, I guess?

> +				       struct ieee80211_vif *vif,
> +				       struct list_head *head);
> +
> +/**
> + * ieee80211_beacon_free_ema_list - free an EMA beacon template list
> + * @head: linked list head containing &struct ieee80211_ema_bcn_list pointers.
> + *
> + * This function will free a list previously acquired by calling
> + * ieee80211_beacon_get_template_ema_list()
> + */
> +
> +void
> +ieee80211_beacon_free_ema_list(struct list_head *head);

certainly here void fits on the line.

johannes

