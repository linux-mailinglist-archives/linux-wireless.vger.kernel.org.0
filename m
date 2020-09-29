Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2189D27C9BB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgI2MNV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgI2MNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 08:13:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9EC0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Sep 2020 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WfwgbMH46N0J3skDcV1QxDSC8kRlXgd+kMVmyE/5acU=; b=bM4IJ5gxEXeAoIq1iabC530Ea7
        seWLa2m7OTMEijBfEti8xRD7mMDEojdDBk5x7pWtAYRF+Oj1SONbfosYw/oZ0KsY/fmgUa9fYJmwM
        kM2rmOtXrBu4nnkLZo0wbY/c9G5N+RinGCbxqxhqCRkRh6VVyf65xAxbEuJS6vsFTDNU=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNEVP-0004fY-65; Tue, 29 Sep 2020 14:13:15 +0200
Subject: Re: [PATCH v3] mac80211: fix regression in sta connection monitor
To:     Georgi Valkov <gvalkov@abv.bg>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
References: <20200927105605.97954-1-nbd@nbd.name>
 <4ED2AADF-092B-424E-A5B5-C2A371C88A92@abv.bg>
 <FC3CA053-0DB9-41B9-AEC6-0AE189AEFE17@abv.bg>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <98daee02-b277-2850-6bc2-16f4d8971fac@nbd.name>
Date:   Tue, 29 Sep 2020 14:13:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <FC3CA053-0DB9-41B9-AEC6-0AE189AEFE17@abv.bg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-09-28 19:09, Georgi Valkov wrote:
> Hi Felix!
> 
> Unfortunately it disconnected again after 21 hours and 44 minutes of uptime, and remained offline for 5 minutes again.
> I will add some code to ieee80211_sta_work() to trace more info when a disconnect occurs.
> Do you have any ideas? Why does it remain offline for exactly 5 minutes every time? Do we need to reset probe_send_count in rx.c? Do we have to send probe requests or nullfunc while there is active communication, e.g. acknowledged ICMP traffic?
> 
> This is the most common event in the trace, it occurs every 30 seconds, we called ieee80211_sta_tx_notify(ack: true), and ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset:
> --- ack  probe_send_count: 1  vif.type 2:2
> 
> These events are rare, I could not find any pattern. probe_send_count is reset inside status.c
> reset connection monitor  probe_send_count: 1  nullfunc: 0
> 
> These events are rare and appear randomly. The first indicates that we called ieee80211_sta_tx_notify(ack: false), and ieee80211_is_any_nullfunc() returned true, so probe_send_count is not reset, while the second always appears 10ms later with ack = true, and ieee80211_is_any_nullfunc() returned true, so probe_send_count is reset.
> probe_send_count: 1  vif.type 2:2
> --- ack  probe_send_count: 2  vif.type 2:2
So far I don't see any strong indication that these disconnects are
related to this patch. The debug messages you added seem normal to me.
More comments on the disconnects below.

> Here are some interesting parts from the trace:
> 
> [STA kernel log]
> [55045.254528] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [55075.971445] wifi: reset connection monitor  probe_send_count: 1  nullfunc: 0
> [55106.699439] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> ...
> [57812.177775] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [57842.894483] wifi: reset connection monitor  probe_send_count: 1  nullfunc: 0
> [57873.610852] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> ...
> [78172.681502] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78203.398703] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78234.118347] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78264.834126] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78282.530133] wifi: deauthenticated from 60:38:e0:xx:xx:xx (Reason: 16=GROUP_KEY_HANDSHAKE_TIMEOUT)
This one is definitely not related to the connection monitor.

> [78282.539463] br-lan: port 3(wifi) entered disabled state
> [78282.544987] br-lan: topology change detected, propagating
> [78283.514078] wifi: authenticate with 60:38:e0:xx:xx:xx
> [78283.533405] wifi: send auth to 60:38:e0:xx:xx:xx (try 1/3)
> [78283.577391] wifi: authenticated
> [78283.583874] wifi: associate with 60:38:e0:xx:xx:xx (try 1/3)
> [78283.610166] wifi: RX AssocResp from 60:38:e0:xx:xx:xx (capab=0x431 status=0 aid=1)
> [78283.618322] wifi: associated
> [78283.628908] br-lan: port 3(wifi) entered blocking state
> [78283.634358] br-lan: port 3(wifi) entered listening state
> [78285.663507] br-lan: port 3(wifi) entered learning state
> [78287.679338] br-lan: port 3(wifi) entered forwarding state
> [78287.684939] br-lan: topology change detected, sending tcn bpdu
> [78313.981348] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78316.028959] br-lan: port 3(wifi) neighbor 7fff.60:38:e0:xx:xx:xy lost
> [78316.035630] br-lan: topology change detected, propagating
> [78346.746657] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78377.464074] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78408.181527] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78438.898977] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78471.664287] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78502.381794] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78533.099298] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78563.816824] wifi: --- ack  probe_send_count: 1  vif.type 2:2
> [78583.518337] wifi: disassociated from 60:38:e0:xx:xx:xx (Reason: 4=DISASSOC_DUE_TO_INACTIVITY)
Are you sure that this one is even related to the connection monitor? It
seems to me that the client may have been kicked from the AP due to
inactivity (might be AP probing, not STA probing).

- Felix
