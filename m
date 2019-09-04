Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80FA7C9C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfIDHTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 03:19:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43452 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfIDHTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 03:19:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id l22so11035224qtp.10
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qu7o7rztC+MVwy4nICnfoy4ExB5K29trQMEqKQNwYfI=;
        b=jnLukmOcoPntIIuTzGGDx2p+l1tmfA8WTmA9ycL8e5i3/ien+imDhk7ldoYByAvtyC
         Uhl4E8o1eEHjs/0zyIn/I2IqCtreoyIRWNIGsu4pRCRVNcaGXdXJigKdet+rt1Niem7V
         qr93ij3nqG6xLbl+n4oDmXN8QSPOjF7l4l+KZ8lLwmqCLpxiDGNdpsZfiH7lgIR2kPLS
         G1bpV1QkcwmqMfqtsdBQoAcUXB+Z5/kqAaqam6WiIbb5+ot6e5BauvnBuOcpxS5NwPeC
         owQAtdDXcsejE65jw5JzHQOYbDUWLLzJt7IUJL1cAUDSnZdMeGK9Lucxz9IqeaH1LvID
         uveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Qu7o7rztC+MVwy4nICnfoy4ExB5K29trQMEqKQNwYfI=;
        b=tEIlSVXsSq68LN1yXlyLDE3YRxJ2s0mKqBv3u/B1qIYtGjPG4/1mR5Fw4JrycUHejp
         bHixeyKqlCaqetemLMHiKSSYNGChgr10ekNnKihGcy3ybZA8KppK+5iUKDyfXyUSqP40
         ksFt8xTdu6BdzXk29O/q3ynHpGK33y5v5kbDvP+c3bgjJ1zgc2tKJyIkir4CjoVlB+Jc
         1iSnz+El9AK4J+HbeuZd6tg27PQ0pr7wOdy/waHConIW1YqoPLyLlg8O86xhQiOpRK9q
         ZGzcHIOYTulS2P0QltVEgVLRJh6kiZRruwW0LDXPi/9qgVhoWXLQ6YUtkIFZpgCwBdaN
         WGUA==
X-Gm-Message-State: APjAAAUr8lDjG86wE952jRZPLf0Y73nTL6pl4kjSKtpoZb8CXsMUbNDz
        kW5WA0DV6F/v9X3f6it2y+KbO0K2s+WUuJd+eGyeBQ==
X-Google-Smtp-Source: APXvYqxnKxvxjdMW4UFNeQFFlNfeaN17iy10NuPOoILMotVycgGA+OwU7izhjTgd6o+UogTLsUApPdCJQUZy5fFBkgA=
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr37719814qtl.144.1567581562068;
 Wed, 04 Sep 2019 00:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFb4eQksH4B8fO8kShaLSPk+-tNsE3tdUHb7qbXXSneSwjt9QA@mail.gmail.com>
In-Reply-To: <CAFb4eQksH4B8fO8kShaLSPk+-tNsE3tdUHb7qbXXSneSwjt9QA@mail.gmail.com>
From:   Equipe Soft <equipe.soft.isere@gmail.com>
Date:   Wed, 4 Sep 2019 09:19:10 +0200
Message-ID: <CAFb4eQkPjP0vVpknnddY4EeMfzZhaAhmOOu+h8DmaaiFT78iOA@mail.gmail.com>
Subject: Re: Issue with intel wireless-AC 9260 in wifi direct in 5Ghz
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, Did you have any news about the issue?
Regards.

Le mer. 28 ao=C3=BBt 2019 =C3=A0 19:21, Equipe Soft
<equipe.soft.isere@gmail.com> a =C3=A9crit :
>
> Hello,
> I'm trying to set up a wifi direct group between my AC9260 wifi board
> and a android tablet supporting WifiDirect.
>
> I tried several configurations and I faced some issues.
> Here follow the testing sequence. All the following command are sent
> through wpa_cli:
>
> > p2p_find
> P2P-DEVICE-FOUND f2:ee:10:c2:ce:68 p2p_dev_addr=3Df2:ee:10:c2:ce:68
> pri_dev_type=3D10-0050F204-5 name=3D'[Tablet] Galaxy Tab S3'
> config_methods=3D0x188 dev_capab=3D0x25 group_capab=3D0x0 vendor_elems=3D=
1
> new=3D1
>
> >p2p_connect f2:ee:10:c2:ce:68 pin 1234 go_intent=3D1
> 74493685
>
> PIN is set on the tablet then, on my terminal I see:
>
> P2P-GO-NEG-SUCCESS role=3DGO freq=3D5785 ht40=3D0 peer_dev=3Df2:ee:10:c2:=
ce:68
> peer_iface=3Df2:ee:10:c2:4e:68 wps_method=3DDisplay
> P2P-GROUP-FORMATION-FAILURE
> P2P-GROUP-REMOVED p2p-wlan0-0 GO reason=3DFORMATION_FAILED
>
> dmesg :
>
> [ 1875.593069] IPv6: ADDRCONF(NETDEV_UP): p2p-wlan0-0: link is not ready
> [ 1875.659199] iwlwifi 0000:01:00.0: Microcode SW error detected.
> Restarting 0x2000000.
> [ 1875.667246] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> [ 1875.672851] iwlwifi 0000:01:00.0: Status: 0x00000100, count: 6
> [ 1875.678718] iwlwifi 0000:01:00.0: Loaded firmware version: 38.755cfdd8=
.0
> [ 1875.685466] iwlwifi 0000:01:00.0: 0x000014FC | ADVANCED_SYSASSERT
> [ 1875.692498] iwlwifi 0000:01:00.0: 0x00A0A200 | trm_hw_status0
> [ 1875.698270] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> [ 1875.704048] iwlwifi 0000:01:00.0: 0x00454EF6 | branchlink2
> [ 1875.709561] iwlwifi 0000:01:00.0: 0x0045E90E | interruptlink1
> [ 1875.715330] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
> [ 1875.721096] iwlwifi 0000:01:00.0: 0x00009D00 | data1
> [ 1875.726084] iwlwifi 0000:01:00.0: 0x00000741 | data2
> [ 1875.731070] iwlwifi 0000:01:00.0: 0x00090010 | data3
> [ 1875.736076] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> [ 1875.741589] iwlwifi 0000:01:00.0: 0x6F091C80 | tsf low
> [ 1875.746757] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> [ 1875.751833] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> [ 1875.757081] iwlwifi 0000:01:00.0: 0x6F091C81 | time gp2
> [ 1875.762325] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> [ 1875.768529] iwlwifi 0000:01:00.0: 0x00000026 | uCode version major
> [ 1875.774731] iwlwifi 0000:01:00.0: 0x755CFDD8 | uCode version minor
> [ 1875.780934] iwlwifi 0000:01:00.0: 0x00000321 | hw version
> [ 1875.786352] iwlwifi 0000:01:00.0: 0x00C89004 | board version
> [ 1875.792044] iwlwifi 0000:01:00.0: 0x801BF402 | hcmd
> [ 1875.796951] iwlwifi 0000:01:00.0: 0x24022000 | isr0
> [ 1875.801853] iwlwifi 0000:01:00.0: 0x01000000 | isr1
> [ 1875.806751] iwlwifi 0000:01:00.0: 0x08301802 | isr2
> [ 1875.811653] iwlwifi 0000:01:00.0: 0x00415CC0 | isr3
> [ 1875.816559] iwlwifi 0000:01:00.0: 0x00000000 | isr4
> [ 1875.821462] iwlwifi 0000:01:00.0: 0x000501D1 | last cmd Id
> [ 1875.826975] iwlwifi 0000:01:00.0: 0x00000000 | wait_event
> [ 1875.832399] iwlwifi 0000:01:00.0: 0x000000D0 | l2p_control
> [ 1875.837928] iwlwifi 0000:01:00.0: 0x00018014 | l2p_duration
> [ 1875.843527] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
> [ 1875.849040] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> [ 1875.854811] iwlwifi 0000:01:00.0: 0x0000000D | lmpm_pmg_sel
> [ 1875.860412] iwlwifi 0000:01:00.0: 0x04071046 | timestamp
> [ 1875.865758] iwlwifi 0000:01:00.0: 0x0000C0E4 | flow_handler
> [ 1875.871405] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> [ 1875.877037] iwlwifi 0000:01:00.0: Status: 0x00000100, count: 7
> [ 1875.882889] iwlwifi 0000:01:00.0: 0x00000070 | ADVANCED_SYSASSERT
> [ 1875.889020] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> [ 1875.894959] iwlwifi 0000:01:00.0: 0xC0087CB8 | umac branchlink2
> [ 1875.900904] iwlwifi 0000:01:00.0: 0xC0084264 | umac interruptlink1
> [ 1875.907134] iwlwifi 0000:01:00.0: 0xC00847C8 | umac interruptlink2
> [ 1875.913344] iwlwifi 0000:01:00.0: 0x00000800 | umac data1
> [ 1875.918764] iwlwifi 0000:01:00.0: 0xC00847C8 | umac data2
> [ 1875.924184] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
> [ 1875.929606] iwlwifi 0000:01:00.0: 0x00000026 | umac major
> [ 1875.935026] iwlwifi 0000:01:00.0: 0x755CFDD8 | umac minor
> [ 1875.940448] iwlwifi 0000:01:00.0: 0xC0887F30 | frame pointer
> [ 1875.946128] iwlwifi 0000:01:00.0: 0xC0887F30 | stack pointer
> [ 1875.951810] iwlwifi 0000:01:00.0: 0x0006012B | last host cmd
> [ 1875.957488] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
> [ 1875.963268] ieee80211 phy0: Hardware restart was requested
> [ 1875.968932] iwlwifi 0000:01:00.0: iwlwifi transaction failed,
> dumping registers
> [ 1875.976275] iwlwifi 0000:01:00.0: iwlwifi device config registers:
> [ 1875.983647] iwlwifi 0000:01:00.0: 00000000: 25268086 00100406
> 02800029 00000000 e0000004 00000000 00000000 00000000
> [ 1875.994312] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000
> 00000000 00148086 00000000 000000c8 00000000 0000012b
> [ 1876.004835] iwlwifi 0000:01:00.0: iwlwifi device memory mapped registe=
rs:
> [ 1876.011780] iwlwifi 0000:01:00.0: 00000000: 00c89004 00000040
> 00000000 ba00008b 00000000 00000000 00027e1f 00000000
> [ 1876.022251] iwlwifi 0000:01:00.0: 00000020: 00000000 0c040005
> 00000321 d55555d5 d55555d5 d55555d5 80008040 041f0044
> [ 1876.032714] iwlwifi 0000:01:00.0: iwlwifi device AER capability struct=
ure:
> [ 1876.039694] iwlwifi 0000:01:00.0: 00000000: 14c10001 00000000
> 00000000 00462031 00000000 00002000 00000000 00000000
> [ 1876.050219] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
> [ 1876.056838] iwlwifi 0000:01:00.0: iwlwifi parent port
> (0000:00:00.0) config registers:
> [ 1876.064933] iwlwifi 0000:00:00.0: 00000000: d02110ee 00100006
> 06040000 00010000 00000000 00000000 000c0100 00000000
> [ 1876.075399] iwlwifi 0000:00:00.0: 00000020: e000e000 0001fff1
> 00000000 00000000 00000000 00000040 00000000 0000012b
> [ 1876.085869] iwlwifi 0000:01:00.0: FW error in SYNC CMD BINDING_CONTEXT=
_CMD
> [ 1876.092773] CPU: 1 PID: 498 Comm: wpa_supplicant Not tainted
> 4.18.31-yocto-standard #1
> [ 1876.100680] Hardware name: ********
> [ 1876.105290] Call trace:
> [ 1876.107744]  dump_backtrace+0x0/0x158
> [ 1876.111403]  show_stack+0x24/0x30
> [ 1876.114723]  dump_stack+0x80/0xa4
> [ 1876.118064]  iwl_trans_pcie_send_hcmd+0x5d0/0x5e8 [iwlwifi]
> [ 1876.123649]  iwl_trans_send_cmd+0x68/0x108 [iwlwifi]
> [ 1876.128644]  iwl_mvm_send_cmd_status+0x44/0xe0 [iwlmvm]
> [ 1876.133889]  iwl_mvm_send_cmd_pdu_status+0x6c/0x98 [iwlmvm]
> [ 1876.139480]  iwl_mvm_binding_update+0x148/0x230 [iwlmvm]
> [ 1876.144809]  iwl_mvm_binding_add_vif+0x5c/0x80 [iwlmvm]
> [ 1876.150048]  iwl_mvm_start_ap_ibss+0xe0/0x238 [iwlmvm]
> [ 1876.155268]  ieee80211_start_ap+0x218/0x488 [mac80211]
> [ 1876.160473]  nl80211_start_ap+0x3f4/0x6a8 [cfg80211]
> [ 1876.165446]  genl_family_rcv_msg+0x1cc/0x338
> [ 1876.169718]  genl_rcv_msg+0xa0/0xd8
> [ 1876.173207]  netlink_rcv_skb+0x60/0x120
> [ 1876.177043]  genl_rcv+0x3c/0x50
> [ 1876.180186]  netlink_unicast+0x194/0x210
> [ 1876.184109]  netlink_sendmsg+0x1a0/0x348
> [ 1876.188036]  sock_sendmsg+0x34/0x50
> [ 1876.191523]  ___sys_sendmsg+0x288/0x2c8
> [ 1876.195357]  __sys_sendmsg+0x7c/0xd0
> [ 1876.198933]  sys_sendmsg+0x38/0x48
> [ 1876.202330]  el0_svc_naked+0x30/0x34
> [ 1876.206366] iwlwifi 0000:01:00.0: Failed to send binding (action:1): -=
5
> [ 1876.213092] iwlwifi 0000:01:00.0: Failed to remove MAC context: -5
> [ 1876.219353] iwlwifi 0000:01:00.0: PHY ctxt cmd error. ret=3D-5
>
> It looks like the module firmware got an error when trying to set the
> module in AP in 5GHz. I know there could be some regulatory limitation
> for IBSS in 5Ghz, but why this does not work for wifi direct.
> Thanks for your time.
> @team.
