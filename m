Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399FB172BC2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2020 23:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgB0Wu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Feb 2020 17:50:56 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:45424 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgB0Wu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Feb 2020 17:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=YAFaEpdIFwEdbrfQfsb4F7xWUap0dm6PLaw1TNMeifE=;
        b=W0L5SMXZT1+RHKOqaB3QOvf137lGrgUmHJIf6PJvewVJ7GhAi4ju42X0EdYmlZAe3rheLteAjK1ymEiLfgw8njoLaWD0ixO6C7IFGZCRmKK9LAob3vemhM3DniXgkwmLEij6cc2HuI9fI1aniClAoUzJWMAjWWsHNjyuhJgvFZE=;
Subject: Re: [mac80211]: wds link and Radius authentication issue
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <833575e6-340e-5b8e-118f-23c3ca02f0fd@dd-wrt.com>
Date:   Thu, 27 Feb 2020 23:50:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2003:c9:3f27:e500:a0c2:d3ef:721:d06]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1j7Rww-00074B-Q1; Thu, 27 Feb 2020 23:48:10 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wds is no specified standard.

Am 27.02.2020 um 18:37 schrieb Cedric VONCKEN:
> Where can I found some information on how the wds system should work? I looked in 802.11-2012 standard and I didn't found any informations.
>
> -----Message d'origine-----
> De : linux-wireless-owner@vger.kernel.org <linux-wireless-owner@vger.kernel.org> De la part de Cedric VONCKEN
> Envoyé : jeudi 27 février 2020 18:24
> À : linux-wireless@vger.kernel.org
> Objet : RE: [mac80211]: wds link and Radius authentication issue
>
> 	Please find in attachment 2 wireshark capture
>
> 	The file broadcast_V5.4-rc8-1 contain a broadcast frame capture with the latest backport used in my system.
> 	The file broadcast_V2015-07-21 contain a broadcast frame capture with an old backport (backport 2015-07-21).
>
> 	With the old backport I be able to ping my sta from the AP.
>
> 	If we compare the frame
> 		- In the old backport the bit TODS and FROMDS are set to 1, In latest version only the bit FROMDS is set to 1.
> 		- In old backport the addr1 is set to the mac address of my sta, in latest backport the addr1 is set to broadcast addr (ff:ff:ff:ff:ff:ff)
>
> 	In old version the same test doesn't drop the broadcast frame, but I think the AP should send one broadcast per wds sta.
>
> 	All comment will be appreciated.
>
> -----Message d'origine-----
> De : Cedric VONCKEN <cedric.voncken@acksys.fr> Envoyé : jeudi 27 février 2020 17:21 À : Cedric VONCKEN <cedric.voncken@acksys.fr>; linux-wireless@vger.kernel.org Objet : [mac80211]: wds link and Radius authentication issue
>
> 	 Hi,
>
> 	Now I identified the origin of the issue but  I need some help to fix.
>
> 	For memo the condition to have this issue:
> 		My sta is still connected to my AP. The sta use the 4addr (wds) system and the sta if device (wlan0) is bridged with my eth0 interface.
> 		In this condition I'm not able to ping the sta from the AP.
>
> 	The origin of the issue is in rx.c from driver/net/mac80211. In function __ieee80211_data_to_8023
> 	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
> 	     !!sdata->u.mgd.use_4addr != !!ieee80211_has_a4(hdr->frame_control)) {
> 		if (!sdata->u.mgd.use_4addr)
> 			return -1;
> 		else if (!ether_addr_equal(hdr->addr1, sdata->vif.addr)){   ------> this test is the origin of my issue
> 			check_port_control = true;
>      	}
>
> 	The ARP frame are sent in broadcast. The broadcast are sent without addr4 (the flag TODS and FROMDS are not set) and addr1 == ff:ff:ff:ff:ff:ff.
> 	In this case check_port_control is set to true and several line below in the same function the packet is dropped.
>
> 	I can add a test with  is_broadcast_ether_addr in "else if (!ether_addr_equal(hdr->addr1, sdata->vif.addr)){", but I'm not sure that is the best solution.
>
> 	What are your comments?
>
> 	Regards.
> -----Message d'origine-----
> De : linux-wireless-owner@vger.kernel.org <linux-wireless-owner@vger.kernel.org> De la part de Cedric VONCKEN Envoyé : mercredi 26 février 2020 11:29 À : linux-wireless@vger.kernel.org Objet : wds link and Radius authentication issue
>
> 	Dear mailing list,
>
> 	I'm facing an issue when my equipement are configured with WDS and radius authentication.
>
> 	My both product (the AP and the sta) are using the same hostapd/wpa_supplicant and wifi driver version.
> 	The wifi driver version is openwrt backport-5.4-rc8-1 package.
>
> 	My AP is configured to accept the WDS sta. In the AP side the ifname wlan0.sta1 are created and added in the bridge.
> 	My sta is configured to use the WDS addresses.
>
> 	If the security policy is configured to WPA-PSK and in the client side the client if is added to the bridge, the communication work (I can ping my AP from my sta).
> 	If the security policy is configured to WPA-EAP (I tested PEAP-MSCHAPV2 and EAP-TLS) and the client if is in a bridge, the communication doesn't work.
>
> 	I did a Wireshark capture on other WIFI interface, the packet seem sent by the AP and by the sta (I can see a broadcast frame sent, and the packet type is data. I think it is the arp request). But these frames are not received (I make a wireshar capture on the sta and AP if, no arp frame are received).
>
> 	I don't know where I need to search to fix this issue. Could you give me some pointer/help to fix it.
>
> 	Thanks for your help.
>
>
>
>
>
>
>
>
>
