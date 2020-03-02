Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1B17583D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 11:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBKWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 05:22:01 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:39047 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBKWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 05:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=eJJnMgKzTKTuQ0iHt8vATte6TCkcL/MNJArqXUFoEKg=;
        b=YYFWlhYXSkcXV6LwTZuTuPMZm9dOJhyRbV7dtfmqTZWpbuvpkx50cH9wElj8gGdSESMVDTyuXP2a00JvXRO7U9XliBtJeEloHmydl2h3BHslMo3l7XtopmkKwambC9uhbZu5l/ktx4A0N+40tLt8UtvtW6wgAf5JZPaK7ni1MV0=;
Subject: Re: [mac80211]: wds link and Radius authentication issue
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
 <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
 <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <9a1cdd80-aca3-256f-1355-5762fb340a06@dd-wrt.com>
Date:   Mon, 2 Mar 2020 11:21:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:a100:7cfe:1070:e1b2:ff3c]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1j8iAJ-00063V-TJ; Mon, 02 Mar 2020 11:19:11 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

its likelly not hostapd. i do use wds sta and wds ap modes with latest 
hostapd.
i have a different idea. hostapd is creating a ap vlan type interface 
for each wds station associating and there was a issue i had with a 
patch in mac80211 a while ago
since something was changed regarding vlan ap handling in mac80211

take a look on the following patches

the second one broke wds sta operation for me completelly. i never 
checked the second one. my advise. revert them both and try it again and 
report if its working then. i was originally complaining already on this 
mailinglist about the breakage, but it seems that my comment was ignored 
at the end


https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=33d915d9e8ce811d8958915ccd18d71a66c7c495

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=db3bdcb9c3ffc628c5284d7ed03a704295ba1214


Am 02.03.2020 um 09:28 schrieb Cedric VONCKEN:
> Yes I'm running mac80211 on both side.
>
> I progress in understanding to this issue. After checked, the issue is different with different mac80211 version. With the backport 5.4-rc8-1, the driver level seem worked correctly. The hostapd (in AP side) didn't include the sta in the bridge when the security policy is WPA-PSK or WPA-EAP. With none policy the sta is correctly included.
>
> Now I'm searching in hostpad.
>
> -----Message d'origine-----
> De : Johannes Berg <johannes@sipsolutions.net>
> Envoyé : vendredi 28 février 2020 10:37
> À : Steve deRosier <derosier@gmail.com>; Cedric VONCKEN <cedric.voncken@acksys.fr>
> Cc : linux-wireless@vger.kernel.org
> Objet : Re: [mac80211]: wds link and Radius authentication issue
>
> On Thu, 2020-02-27 at 17:26 -0800, Steve deRosier wrote:
>> On Thu, Feb 27, 2020 at 9:37 AM Cedric VONCKEN <cedric.voncken@acksys.fr> wrote:
>>> Where can I found some information on how the wds system should
>>> work? I looked in 802.11-2012 standard and I didn't found any
>>> informations.
>>>
>> I think Wikipedia says it best:
>> "WDS may be incompatible between different products (even occasionally
>> from the same vendor) since the IEEE 802.11-1999 standard does not
>> define how to construct any such implementations or how stations
>> interact to arrange for exchanging frames of this format. The IEEE
>> 802.11-1999 standard merely defines the 4-address frame format that
>> makes it possible."
> I think really what Cedric is asking is how this is/should be done with mac80211's 4-addr client/AP mode(s)?
>
> Cedric, are you running mac80211 on both sides of the link, the AP and the (4-addr) client?
>
> johannes
>
