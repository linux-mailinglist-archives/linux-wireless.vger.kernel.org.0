Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD4CBA85
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfJDMen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:34:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39270 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJDMen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:34:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iGMnB-000819-Sd; Fri, 04 Oct 2019 14:34:42 +0200
Message-ID: <0dbf438d7e176c85164b8568a98f0d6e98292152.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org
Date:   Fri, 04 Oct 2019 14:34:41 +0200
In-Reply-To: <20191004062151.131405-2-kyan@google.com> (sfid-20191004_082219_852781_215A08B7)
References: <20191004062151.131405-1-kyan@google.com>
         <20191004062151.131405-2-kyan@google.com>
         (sfid-20191004_082219_852781_215A08B7)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-03 at 23:21 -0700, Kan Yan wrote:
> 
> +/* The firmware's transmit queue size limit in airtime */
> +#define IEEE80211_DEFAULT_AQL_INTERFACE_LIMIT	24000

I'm not sure I understand this completely, but IMHO rewording it to be
like a "NIC limit" would be better.

However, I'm not sure it *shouldn't* actually be per interface (i.e.
moving from
	local->aql_total_pending_airtime
to
	sdata->aql_total_pending_airtime

because you could have multiple channels etc. involved and then using a
single airtime limit across two interfaces that are actually on two
different channels (e.g. 2.4 and 5 GHz) doesn't make that much sense.

Actually, it does make some sense as long as the NIC is actually
channel-hopping ... but that's in the process of changing now, there's
going to be hardware really soon (or perhaps already exists) that has
real dual-band capabilities...

Maybe we can live with this now, but we'd probably expect to change this
really soon.

johannes

