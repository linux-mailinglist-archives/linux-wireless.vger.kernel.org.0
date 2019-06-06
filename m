Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2147737C66
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFFSlf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 14:41:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35382 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFSle (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 14:41:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so2957649otq.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dQw0Ep4ybC1oAO5ostHodAu2cXVAC1LcvUfzJVxA2zs=;
        b=WjmL9wVqo09Wey3bgIdc2HnVHMXt+v2NJ2SHfj5J60b+XQftsHBhZOGFo2TcTO2BJd
         X63XZjKofQHrLKCo+3X8efxGSs7uDnK+ffw5SOU/znVlWP3CtlOIdci3SG7EaNE9BkHo
         /hBvAsP34QYBrds0TgDQ9dGYgkNoeC+JYCtfUbTbtpqezoAaVferqCHvuBDwt+oV2M9o
         Jrhhz+YK+Pqezm7/+KjaSdf/3fF1gkNhkN2Dzy1XJ+pbpM5blb7zFhpnwoZKe9q9qByu
         t4p2RYBIzCqfaFK7PLic6SQRjiZdgr/1FD4tMaBod4N3uk9ayQpXhqyunhPqs8OKYsUm
         CAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dQw0Ep4ybC1oAO5ostHodAu2cXVAC1LcvUfzJVxA2zs=;
        b=Jq1HptEldQUBofo7sgD8nO4OOoG8GigDgTx9n5Vbvnbg1HUm5bkiAojPiNbfm0Kq6C
         WOaUcM7fJ8IAIIa6XmS5czMA8nm3lSrc+j3cyeyAMIV/+CyFYwR0z4hLqaHOEZnNDVDM
         8zoLyAxm5NqNjXDVpC8Wjmv24SyiSoq6fDRJTuoBVH3ig62Rx2YMvMn+PAfq3NmN91Jb
         BDGtxdBEzlgBST0SpLITFHg0qA+hK+qeV0C+ZYLfYKK66pzHcMjiEvktY5XJy6o3ujNZ
         /XuwhE+5n65buRxG9tZ9KVscp0R6Dw8ZM+ul2fmy/qRqgtnWuAcKd25y18YDMN/5WWfe
         i/TQ==
X-Gm-Message-State: APjAAAUsgFH7fe4+av9jo334uUvFn2zzmdZpVP8piPm+99WTJqKvcY/X
        aal+Cq3Bi+cGRmXcEt8v9MsFw7rsY1n429MThsSGuQ==
X-Google-Smtp-Source: APXvYqyYN1JENt1ZWlmC3R6x7IIfaXwEZGOpkrollL7qDiXG32SgFIT9QFimyKsK7oL4dUrg6Q0+9BIP8t47NS0Efck=
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr10114169otc.27.1559846493661;
 Thu, 06 Jun 2019 11:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:1346:0:0:0:0 with HTTP; Thu, 6 Jun 2019 11:41:32
 -0700 (PDT)
In-Reply-To: <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
 <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net> <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 6 Jun 2019 20:41:32 +0200
Message-ID: <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31/05/2019, Manikanta Pubbisetty <mpubbise@codeaurora.org> wrote:
>
> On 5/14/2019 2:08 PM, Johannes Berg wrote:
>> On Wed, 2019-05-08 at 14:55 +0530, Manikanta Pubbisetty wrote:
>>> +++ b/net/mac80211/util.c
>>> @@ -3795,7 +3795,9 @@ int ieee80211_check_combinations(struct
>>> ieee80211_sub_if_data *sdata,
>>>   	}
>>>
>>>   	/* Always allow software iftypes */
>>> -	if (local->hw.wiphy->software_iftypes & BIT(iftype)) {
>>> +	if (local->hw.wiphy->software_iftypes & BIT(iftype) ||
>>> +	    (iftype == NL80211_IFTYPE_AP_VLAN &&
>>> +	     local->hw.wiphy->flags & WIPHY_FLAG_4ADDR_AP)) {
>>>   		if (radar_detect)
>>>   			return -EINVAL;
>> Shouldn't this check if 4addr is actually enabled too, like here:
>
>
> Sure Johannes, I'll look into it.
>
>
>>>   	case NETDEV_PRE_UP:
>>> -		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)))
>>> +		if (!(wdev->wiphy->interface_modes & BIT(wdev->iftype)) &&
>>> +		    !(wdev->iftype == NL80211_IFTYPE_AP_VLAN &&
>>> +		      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP &&
>>> +		      wdev->use_4addr))
>>>   			return notifier_from_errno(-EOPNOTSUPP);
>> ?
>> Or is there some reason it doesn't matter?
>>
>>> @@ -3439,6 +3438,11 @@ static int nl80211_new_interface(struct sk_buff
>>> *skb, struct genl_info *info)
>>>   			return err;
>>>   	}
>>>
>>> +	if (!(rdev->wiphy.interface_modes & (1 << type)) &&
>>> +	    !(type == NL80211_IFTYPE_AP_VLAN && params.use_4addr &&
>>> +	      rdev->wiphy.flags & WIPHY_FLAG_4ADDR_AP))
>>> +		return -EOPNOTSUPP;
>>> +
>> I also wonder if we shouldn't go "all in" and actually make the check
>> something like
>>
>>    check_interface_allowed(iftype, 4addr):
>>      if (iftype == AP_VLAN && 4addr)
>>        return wiphy.flags & WIPHY_FLAG_4ADDR_AP;
>>
>>      else return wiphy.interface_modes & BIT(iftype);
>>
>> i.e. make it "you must have WIPHY_FLAG_4ADDR_AP to use 4-addr AP_VLAN
>> interfaces", rather than "also allow it in this case".
>>
>> That would seem like the clearer semantics to me?
>
>
> Yeah, it can be better; I'll check if this is feasible.
>
>
> Thanks,
>
> Manikanta
>
>

Hi

Applying this patch instead of v1 broke WDS operation between two
Litebeam AC Gen2 devices:

Thu Jun  6 19:38:43 2019 kern.info kernel: [  625.840896] device
wlan0.sta1 left promiscuous mode
Thu Jun  6 19:38:43 2019 kern.info kernel: [  625.846146] br-lan: port
3(wlan0.sta1) entered disabled state
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.854349]
------------[ cut here ]------------
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.859253] WARNING:
CPU: 0 PID: 1417 at backports-4.19.32-1/net/mac80211/key.c:907
ieee80211_free_keys+0x170/0x228 [mac80211]
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.870871] Modules
linked in: ath9k ath9k_common pppoe ppp_async ath9k_hw ath10k_pci
ath10k_core ath pppox ppp_generic mac80211 iptable_nat iptable_mangle
iptable_filter ipt_REJECT ipt_MASQUERADE ip_tables cfg80211 xt_time
xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit
xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD
x_tables thermal_sys slhc nf_reject_ipv4 nf_nat_redirect
nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat
nf_log_ipv4 nf_log_common nf_flow_table_hw nf_flow_table
nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack hwmon crc_ccitt
compat ehci_platform ehci_hcd gpio_button_hotplug usbcore nls_base
usb_common
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.930674] CPU: 0 PID:
1417 Comm: hostapd Not tainted 4.14.118 #0
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.936958] Stack :
804d0000 80489150 00000000 00000000 80460fc0 82e79a9c 82e9d35c
804b1307
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.945494]
8045d190 00000589 80603670 0000038b 804838a0 00000001 82e79a50
688195c4
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.954197]
00000000 00000000 80600000 00003dd0 00000000 00000000 00000008
00000000
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.962745]
000000c8 d9e4e916 000000c7 00000000 80000000 00000000 83266130
83234cfc
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.971247]
00000009 0000038b 804838a0 00000100 00000001 8026bd44 00000000
80600000
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.979754]         ...
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.982249] Call Trace:
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.984764] [<8006a9ec>]
show_stack+0x58/0x100
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.989305] [<80085080>]
__warn+0xe4/0x118
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.993492] [<80085144>]
warn_slowpath_null+0x1c/0x28
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  625.998793] [<83234cfc>]
ieee80211_free_keys+0x170/0x228 [mac80211]
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  626.005308] [<8321611c>]
ieee80211_ibss_leave+0xa70/0x1940 [mac80211]
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  626.011970] [<802f4998>]
rollback_registered_many+0x2dc/0x414
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  626.017813] [<802f60b0>]
unregister_netdevice_queue+0x94/0xec
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  626.023762] [<8321fd8c>]
ieee80211_nan_func_match+0x2894/0x29a0 [mac80211]
Thu Jun  6 19:38:43 2019 kern.warn kernel: [  626.030795] ---[ end
trace 5309fee2cf0ee39d ]---
Thu Jun  6 19:38:43 2019 daemon.notice hostapd: wlan0:
WDS-STA-INTERFACE-REMOVED ifname=wlan0.sta1 sta_addr=18:e8:29:30:9b:2c
Thu Jun  6 19:38:48 2019 daemon.info hostapd: wlan0: STA
18:e8:29:30:9b:2c IEEE 802.11: authenticated
Thu Jun  6 19:38:48 2019 daemon.info hostapd: wlan0: STA
18:e8:29:30:9b:2c IEEE 802.11: associated (aid 1)
Thu Jun  6 19:38:48 2019 kern.info kernel: [  631.114522] br-lan: port
3(wlan0.sta1) entered blocking state
Thu Jun  6 19:38:48 2019 kern.info kernel: [  631.120364] br-lan: port
3(wlan0.sta1) entered disabled state
Thu Jun  6 19:38:48 2019 kern.info kernel: [  631.126603] device
wlan0.sta1 entered promiscuous mode
Thu Jun  6 19:38:48 2019 daemon.notice hostapd: wlan0:
WDS-STA-INTERFACE-ADDED ifname=wlan0.sta1 sta_addr=18:e8:29:30:9b:2c
Thu Jun  6 19:38:48 2019 daemon.err hostapd: Could not set interface
wlan0.sta1 flags (UP): Invalid argument
Thu Jun  6 19:38:48 2019 daemon.err hostapd: nl80211: Failed to set
WDS STA interface wlan0.sta1 up
Thu Jun  6 19:38:48 2019 daemon.err hostapd: nl80211:
NL80211_ATTR_STA_VLAN (addr=18:e8:29:30:9b:2c ifname=wlan0.sta1
vlan_id=0) failed: -127 (Network is down)
Thu Jun  6 19:38:48 2019 daemon.notice hostapd: wlan0:
AP-STA-CONNECTED 18:e8:29:30:9b:2c
Thu Jun  6 19:38:48 2019 daemon.info hostapd: wlan0: STA
18:e8:29:30:9b:2c WPA: pairwise key handshake completed (RSN)

Reverting v1 of the patch restored connection.

Regards, Tom
