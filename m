Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628401E229A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEZNB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgEZNB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 09:01:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B99C03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 06:01:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdZCu-003Qw9-Vf; Tue, 26 May 2020 15:01:25 +0200
Message-ID: <256d488507006cff8b0a9bc80ab51ef0cee9ff7e.camel@sipsolutions.net>
Subject: Re: [PATCH v4 5/5] nl80211: S1G band and channel definitions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 26 May 2020 15:01:23 +0200
In-Reply-To: <20200430172554.18383-6-thomas@adapt-ip.com> (sfid-20200430_192613_998673_DBD2473D)
References: <20200430172554.18383-1-thomas@adapt-ip.com>
         <20200430172554.18383-6-thomas@adapt-ip.com>
         (sfid-20200430_192613_998673_DBD2473D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Thomas,

This looks mostly good (and I've applied the other 4 patches with some
fixups), but ...

> @@ -911,6 +931,15 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>  	control_freq = chandef->chan->center_freq;
>  
>  	switch (chandef->width) {
> +	case NL80211_CHAN_WIDTH_1:
> +		width = 1;
> +		break;
> +	case NL80211_CHAN_WIDTH_2:
> +		width = 2;
> +		break;
> +	case NL80211_CHAN_WIDTH_4:
> +		width = 4;
> +		break;
>  	case NL80211_CHAN_WIDTH_5:

aren't you missing some bandwidths here? You'd fall through to a
WARN_ON(), which doesn't seem good?

johannes

