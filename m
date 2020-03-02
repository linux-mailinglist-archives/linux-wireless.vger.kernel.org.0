Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001A8176492
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCBUDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 15:03:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:36000 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBUDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 15:03:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j8rI5-00AguX-Ty; Mon, 02 Mar 2020 21:03:50 +0100
Message-ID: <ad70a65c0c113f86ee7d5f12b8483ab2bfa32257.camel@sipsolutions.net>
Subject: Re: [mac80211]: wds link and Radius authentication issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        Steve deRosier <derosier@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 02 Mar 2020 21:03:48 +0100
In-Reply-To: <DB8PR01MB55298F5D3E6D1A111EB5AE6C90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
         (sfid-20200228_022737_077710_BB93474D) <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
         <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55292C768759D14699CC5BAE90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55298F5D3E6D1A111EB5AE6C90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-03-02 at 17:44 +0000, Cedric VONCKEN wrote:
> I continue my investigation, and I think I found an interesting point.
> 
> 	My AP have 3 bssid, the wlan0 is set in WPA-EAP, the wlan0_1 is
> set in WPA-PSK and the latest wlan0_2 is without security. It is
> useful for my test, I only need to change the sta configuration.
> 
> 	I added some debug in  net/mac80211/tx.c
> 
> 	When I use the BSSID set in WPA-PSK (this case works), the
> broadcast frames are sent through the netdev wlan0_1.sta1.
> 	When I use the BSSID set in WPA-EAP (this case doesn't work) the
> broadcast frames are sent through the netdev wlan0 (use fast_xmit
> path). But the wlan0.sta1 netdev is created in the system, added to
> the bridge, and received the frame from the bridge. But in this case
> the function ieee80211_lookup_ra_sta  return ENOLINK for wlan0.sta1
> and the frame is dropped.
> 
> 	So I think the issue is in transmit side, I don't why, but with
> WPA-EAP the mac80211 state seem different and the WDS doesn't work.
> 
> 	Do you have any explanation or idea to locate the origin ?

Not really. The code there is just

        switch (sdata->vif.type) {
        case NL80211_IFTYPE_AP_VLAN:
                sta = rcu_dereference(sdata->u.vlan.sta);
                if (sta) {
                        *sta_out = sta;
                        return 0;
                } else if (sdata->wdev.use_4addr) {
                        return -ENOLINK;
                }

as far as I can tell, right?

So if you got into the -ENOLINK case, then it means that userspace
didn't add the right station to the 4-addr VLAN interface, which I guess
was "wlan0.sta1"? Not sure how that'd happen.

johannes

