Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF126FAE8
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgIRKsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRKso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:48:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E48C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:48:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDwZ-006CjO-1t; Fri, 18 Sep 2020 12:48:43 +0200
Message-ID: <07751701c06d14e39c956369e5b1dd2a066fd69e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 12/22] mac80211: convert S1G beacon to scan results
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:48:42 +0200
In-Reply-To: <20200831205600.21058-13-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-13-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:

>  
> +	if (!elems->parse_error && elems->s1g_capab)
> +		bss->s1g = true;

It seems odd to set this only if it's in error - why not always set it
if the band is right?

In fact, why set it at all, since you always know the band?

> +		case WLAN_EID_S1G_CAPABILITIES:
> +			if (elen == 15)
> +				elems->s1g_capab = (void *)pos;
> +			else
> +				elem_parse_failed = true;
> +			break;
> +		case WLAN_EID_S1G_OPERATION:
> +			if (elen == 6)
> +				elems->s1g_oper = (void *)pos;
> +			else
> +				elem_parse_failed = true;
> +			break;
> +		case WLAN_EID_S1G_SHORT_BCN_INTERVAL:
> +			if (elen == 2)
> +				elems->s1g_tsbtt = (void *)pos;
> +			else
> +				elem_parse_failed = true;
> +			break;

Seems like you ought to have some structs/sizeof or defines for the
sizes?

johannes

