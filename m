Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634EB177268
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 10:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCCJbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 04:31:03 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:51318 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgCCJbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 04:31:03 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j93tE-00CJUn-AU; Tue, 03 Mar 2020 10:31:00 +0100
Message-ID: <a6da58cf50e1f6f8f2f45f8c2eb9fa69ba0b78ed.camel@sipsolutions.net>
Subject: Re: [mac80211]: wds link and Radius authentication issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        Steve deRosier <derosier@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 03 Mar 2020 10:30:59 +0100
In-Reply-To: <DB8PR01MB5529C93C4FA5B570DC57F88F90E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
         (sfid-20200228_022737_077710_BB93474D) <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
         <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55292C768759D14699CC5BAE90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55298F5D3E6D1A111EB5AE6C90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <ad70a65c0c113f86ee7d5f12b8483ab2bfa32257.camel@sipsolutions.net>
         <DB8PR01MB5529C93C4FA5B570DC57F88F90E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Cedric,

Umm, that was hard to read. You should quote my writing, not your own :)


> > The wlan0.sta1 net dev was created by hostapd to manage the wds sta.
> > This netdev type is AP VLAN. The function ieee80211_lookup_ra_sta
> > return
> > -ENOLINK because the pointer sdata->u.vlan.sta was not defined.

Right.

> > In mac80211, where this rcu pointer is allocated? Which NL message the user space use ?

Look at ieee80211_change_station(), called from nl80211_set_station()
with 

	params.vlan = get_vlan(info, rdev);

johannes

