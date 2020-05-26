Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2046B1E22B4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgEZNH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgEZNH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 09:07:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2516C03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 06:07:28 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdZIk-003R5Z-2N; Tue, 26 May 2020 15:07:26 +0200
Message-ID: <e4009ab74aaf037148932eccf41a6d7739bef59c.camel@sipsolutions.net>
Subject: Re: [PATCH V4 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
Date:   Tue, 26 May 2020 15:07:25 +0200
In-Reply-To: <20200504102051.6438-1-john@phrozen.org> (sfid-20200504_122104_674755_5B1A7EF6)
References: <20200504102051.6438-1-john@phrozen.org>
         (sfid-20200504_122104_674755_5B1A7EF6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-04 at 12:20 +0200, John Crispin wrote:
> 
> * properly make use the iftype_data array

questionable? ;)
 
> +/**
> + * ieee80211_get_he_cap - return the first he_cap that we find for a sband
> + * @sband: the sband that we want to check for HE support
> + *
> + * Return: return a valid he_cap or NULL
> + */
> +static inline const struct ieee80211_sta_he_cap *
> +ieee80211_get_he_cap(const struct ieee80211_supported_band *sband)

So this returns an ... arbitrary one basically.

> +static bool he_set_mcs_mask(struct genl_info *info,
> +			    struct ieee80211_supported_band *sband,
> +			    struct nl80211_txrate_he *txrate,
> +			    u16 mcs[NL80211_HE_NSS_MAX])
> +{
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
> +	u16 tx_mcs_map = 0;
> +	u8 i;
> +
> +	he_cap = ieee80211_get_he_cap(sband);

and here you use it

But! In all the cases where you actually get here, you should have a
netdev. So you also know the correct type, and don't have to pick an
arbitrary one.

johannes


