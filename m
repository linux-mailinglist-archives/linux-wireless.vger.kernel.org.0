Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D626FAF6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRKvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRKvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:51:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEEEC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:51:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDzX-006CpT-Nu; Fri, 18 Sep 2020 12:51:47 +0200
Message-ID: <05ad5f4f7623e6e072eebf7b87320fa7385fac35.camel@sipsolutions.net>
Subject: Re: [PATCH v2 14/22] mac80211: encode listen interval for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:51:46 +0200
In-Reply-To: <20200831205600.21058-15-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-15-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:

> +static const int listen_int_usf[] = { 1, 10, 1000, 10000 };

That should probably be in some C file?

OTOH ... maybe it's small enough to duplicate everywhere? could make it
u16 at least :)

> +__le16 ieee80211_encode_usf(int listen_interval)
> +{
> +	u16 ui, usf = 0;
> +
> +	/* find greatest USF */
> +	while (usf < IEEE80211_MAX_USF) {
> +		if (listen_interval % listen_int_usf[usf + 1])
> +			break;
> +		usf += 1;
> +	}
> +	ui = listen_interval / listen_int_usf[usf];

But you really only need it here in one place anyway.

johannes

