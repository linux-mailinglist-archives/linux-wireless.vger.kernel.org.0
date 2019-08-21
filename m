Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C96973A3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHUHdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:33:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56702 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHUHdf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:33:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0L7d-0004bI-Cj; Wed, 21 Aug 2019 09:33:33 +0200
Message-ID: <d98fc06c44dd5d708afb9cae134d32df8d09204c.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: VLAN offload support for set_key and
 set_sta_vlan
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
Date:   Wed, 21 Aug 2019 09:33:32 +0200
In-Reply-To: <20190820205046.GA9860@jouni.qca.qualcomm.com>
References: <20190815133825.8131-1-jouni@codeaurora.org>
         <3a8edc6691a03ed3c253d95811d5fd6cae453a03.camel@sipsolutions.net>
         <20190820205046.GA9860@jouni.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 23:50 +0300, Jouni Malinen wrote:

> > Without really looking at the specifics, it might be relatively simple
> > to support this in mac80211?
> 
> Yes, that is something that I was thinking about when going through
> this.. I don't remember why exactly mac80211 ended up with its current
> design for per-AP_VLAN netdevs without tags, but it could indeed be
> quite convenient to have this alternative approach available. 

Even just for testing it :-)

> I guess
> both of them have some benefits, so this would likely be left with two
> different mechanisms left to maintain, 

Yes, unless we find a way to attach nl80211 to 802.1q interfaces so we
can pretend to do the netdevs ... not really worth it.

We could encapsulate the backward compatibility on top of this feature,
theoretically, by always asking the drivers to use this feature and then
implementing the AP_VLAN interfaces in cfg80211 entirely, but again,
probably not worth it since it's only mac80211, not a bunch of drivers.

> but the needed implementation in
> mac80211 for this would seem to be pretty minimal (also without looking
> at the exact details..).

Yeah, on RX the station lookup would just have to find the VLAN ID and
use __vlan_hwaccel_put_tag(); on TX ... not sure, probably
skb_vlan_tag_present()?

johannes

