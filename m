Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB517CE3D
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGM5s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 07:57:48 -0500
Received: from mail.w1.fi ([212.71.239.96]:32998 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCGM5s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 07:57:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 3998311758;
        Sat,  7 Mar 2020 12:57:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ru4eCLzhSuyH; Sat,  7 Mar 2020 12:57:45 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sat, 07 Mar 2020 14:57:03 +0200
Date:   Sat, 7 Mar 2020 14:57:03 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>,
        "hostap@lists.infradead.org" <hostap@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wds link and Radius authentication issue
Message-ID: <20200307125703.GA4458@w1.fi>
References: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 03, 2020 at 03:28:47PM +0000, Cedric VONCKEN wrote:
> The origin of the issue is  in VLAN sta feature and  WDS sta feature management.
> These both features are managed with the same code.
> 
> In case of we use a WDS sta and 802.1x authentication that don't work.
> When the AP side receive the null function frame in 4addr format from the sta, hostapd create the sta netdev and call the NL message NL80211_CMD_SET_STATION. In mac80211 the function ieee80211_change_station assign the pointer vlansdata->u.vlan.sta.
> 
> During the 802.1x authentication hostapd send the NL80211_CMD_SET_STATION message for add vlan management. I didn't understand why hostapd require this call, because in the msg no vlan information is given. With this second call, ieee80211_change_station function, set the vlansdata->u.vlan.sta to NULL . After that no frames are sent through the wds sta netdev and all frame are sent with 3 addr.

It is fine to skip that assignment in cases where the RADIUS server does
not assign a specific VLAN for the station.

> I tried to fix this issue, but I'm not sure where I should fix the issue (hostapd or mac80211).

This specific case of WDS with EAP, but without separate VLAN ID
assignment should be fixed in hostapd and this commit takes care of
that:
https://w1.fi/cgit/hostap/commit/?id=43ededa9c74e3762bcf2f78841790eeecfa8ad56

As far as use of WDS and VLAN ID assignment for the same station is
concerned, I'm not sure there is a good solution for that with the
current mac80211 design for the WDS interfaces. Anyway, that is a
separate issue and I guess it is fine to leave that waiting for someone
to come up with a real use case for that before coming up with anything
more complex.

-- 
Jouni Malinen                                            PGP id EFC895FA
