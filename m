Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927BD78D99B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjH3Sdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbjH3HG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 03:06:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C51A3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 00:06:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b962c226ceso78978501fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1693379211; x=1693984011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk2BMd3fTU6hSMNRPtb9uGi61yiAwZH0GKVfttifIBA=;
        b=cxp8yejSJY3GVQaZMjyBHazslnIex6CD/flhDYF3aqbC8FYcJvtedJd3VD8CZZDmw9
         L5iHfi39Xhx+mhqqNN7WD9bDILHymi1vUt9RhMhuUDhs9/q5ekKZkHAk1JDhGX2gEzUa
         4bGiJA9UxDTokaeW1Lg9ydqPl8fQcGY5tE6oBLBExvLQOvcWYpci0oUDpHpu/3ZSA86h
         FaLT8+m+mCnaY80B2Y478mXf54DsVwVN2RC+ke8nNqxvnyj9Sic0DkO0AUlKCPSkAGI4
         v0QMYvZPGojiidEopNAA+tB0bXUKQe5NvyEEXj0RpxStgSOAsDknj33mIPPUUx/i9yGL
         qLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379211; x=1693984011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk2BMd3fTU6hSMNRPtb9uGi61yiAwZH0GKVfttifIBA=;
        b=ibITfRF2vZNCHkF6/1WrPwASDyeOBR1efA3UJlUTJydUb+tNSrp9ZOn2pD7zwVBcNg
         nvqmcp3fUrMONK2g41ixwAMCwl4Ln+yfRlot1knDxAf69U819AjpceYERwLTJVgh4vZU
         wdCxsPIfgsL91GVi3agwkBRs+WjwhvsivZOZveOEgQWfISDajcAI8yh5DAWIe7Qx5+oh
         f92MbqLawusZg3NLhF1CXEJwrAKy1ZbuKCnYSEnqNs6I/YeCqPgS09S6sZWFIGJRtdIq
         0ubf4GLScewK9hZRNzw/vIWU2MJc+NElQ8cWxtgyHHmMUpa39aRG6cZoaPvP07pfXU01
         TVqQ==
X-Gm-Message-State: AOJu0YwlB1HZTRLdX3mFDAuvPohlW1BioCadZo5CoOniFEjD6tP/WRtG
        WHuoLTIu5+Vx7b/jxo2VzgNCHLp1yUOHGd9U42FRrA==
X-Google-Smtp-Source: AGHT+IHloPnn/IyA25/qUsFZcwQ6VVkXL0dYQdBKDgje7DiU4LETnRQy3gNFuptCunI8uQVcl3sIGq/f/Pv7qtw65UA=
X-Received: by 2002:a2e:9857:0:b0:2bc:d634:2210 with SMTP id
 e23-20020a2e9857000000b002bcd6342210mr1195920ljj.16.1693379210872; Wed, 30
 Aug 2023 00:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230829201610.cc648236f434.I205a557b06a27f58afe3880f4db43d554210c88d@changeid>
In-Reply-To: <20230829201610.cc648236f434.I205a557b06a27f58afe3880f4db43d554210c88d@changeid>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Date:   Wed, 30 Aug 2023 09:06:40 +0200
Message-ID: <CAPh3n808FmLxYzvp2=iNX5RAfdGKe57O2yGSXS9zKhSz_bPhhw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: fix BA session teardown race
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I'm running OpenWRT on an AP device and noticed following splat when a
fair amount of clients was connected to it (roughly 20)
Do you think this one is affiliated with this patch?

Thanks!


[   45.032106] ------------[ cut here ]------------
[   45.032441] WARNING: CPU: 2 PID: 1654 at
backports-6.1.24/net/mac80211/driver-ops.h:611
__ieee80211_flush_queues+0x168/0x16c [mac80211]
[   45.036137] wlan1.sta4: Failed check-sdata-in-driver check, flags: 0x1
[   45.048585] Modules linked in: nft_fib_inet nf_flow_table_ipv6
nf_flow_table_ipv4 nf_flow_table_inet iptable_nat ath10k_pci
ath10k_core ath xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQUERADE
xt_FLOWOFFLOAD wireguard nft_reject_ipv6 nft_reject_ipv4
nft_reject_inet nft_reject nft_redir nft_quota nft_objref nft_numgen
nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload
nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_counter nft_compat
nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mac80211
libchacha20poly1305 iptable_mangle iptable_filter ipt_REJECT ip_tables
curve25519_neon cfg80211 xt_time xt_tcpudp xt_multiport xt_mark xt_mac
xt_limit xt_comment xt_TCPMSS xt_LOG x_tables poly1305_arm nfnetlink
nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6
nf_defrag_ipv4 mbt libcurve25519_generic libcrc32c hwmon compat
chacha_neon ip_gre gre dummy ip6_udp_tunnel udp_tunnel ip_tunnel tun
dns_resolver sha512_arm ghash_arm_ce cmac leds_gpio xhci_plat_hcd
xhci_pci xhci_hcd
[   45.055080]  dwc3 dwc3_qcom gpio_button_hotplug crc32c_generic
[   45.141905] CPU: 2 PID: 1654 Comm: hostapd Not tainted 5.15.127 #0
[   45.147557] Hardware name: Generic DT based system
[   45.153753] [<c030d480>] (unwind_backtrace) from [<c0309848>]
(show_stack+0x10/0x14)
[   45.158523] [<c0309848>] (show_stack) from [<c05dd924>]
(dump_stack_lvl+0x40/0x4c)
[   45.166414] [<c05dd924>] (dump_stack_lvl) from [<c0322540>]
(__warn+0x8c/0x100)
[   45.173792] [<c0322540>] (__warn) from [<c032261c>]
(warn_slowpath_fmt+0x68/0x78)
[   45.180996] [<c032261c>] (warn_slowpath_fmt) from [<bf25b63c>]
(__ieee80211_flush_queues+0x168/0x16c [mac80211])
[   45.188780] [<bf25b63c>] (__ieee80211_flush_queues [mac80211]) from
[<bf228ec8>] (sta_set_sinfo+0xd44/0xe64 [mac80211])
[   45.198951] [<bf228ec8>] (sta_set_sinfo [mac80211]) from
[<bf229230>] (sta_info_destroy_addr_bss+0x44/0x5c [mac80211])
[   45.209456] [<bf229230>] (sta_info_destroy_addr_bss [mac80211])
from [<bf1a5000>] (nl80211_del_station+0xe0/0x2b4 [cfg80211])
[   45.220271] [<bf1a5000>] (nl80211_del_station [cfg80211]) from
[<c080a818>] (genl_rcv_msg+0x154/0x340)
[   45.231538] [<c080a818>] (genl_rcv_msg) from [<c08098e8>]
(netlink_rcv_skb+0xb8/0x11c)
[   45.240718] [<c08098e8>] (netlink_rcv_skb) from [<c0809f24>]
(genl_rcv+0x28/0x34)
[   45.248619] [<c0809f24>] (genl_rcv) from [<c0808fb0>]
(netlink_unicast+0x174/0x26c)
[   45.256170] [<c0808fb0>] (netlink_unicast) from [<c0809284>]
(netlink_sendmsg+0x1dc/0x440)
[   45.263641] [<c0809284>] (netlink_sendmsg) from [<c0782878>]
(____sys_sendmsg+0x1d0/0x224)
[   45.271974] [<c0782878>] (____sys_sendmsg) from [<c0784308>]
(___sys_sendmsg+0xa4/0xdc)
[   45.280220] [<c0784308>] (___sys_sendmsg) from [<c0784470>]
(sys_sendmsg+0x44/0x74)
[   45.288110] [<c0784470>] (sys_sendmsg) from [<c0300040>]
(ret_fast_syscall+0x0/0x48)
[   45.295740] Exception stack(0xc28dffa8 to 0xc28dfff0)
[   45.303794] ffa0:                   00000000 00000000 00000018
beae5c88 00000000 00000000
[   45.308783] ffc0: 00000000 00000000 0133de50 00000128 00000001
00000004 beae5cd0 b6bbb040
[   45.316894] ffe0: beae5c30 beae5c20 b6fbeb9c b6fbe00c
[   45.325425] ---[ end trace 328f4e6808844143 ]---

On Tue, Aug 29, 2023 at 8:17=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> As previously reported by Alexander, whose commit 69403bad97aa
> ("wifi: mac80211: sdata can be NULL during AMPDU start") I'm
> reverting as part of this commit, there's a race between station
> destruction and aggregation setup, where the aggregation setup
> can happen while the station is being removed and queue the work
> after ieee80211_sta_tear_down_BA_sessions() has already run in
> __sta_info_destroy_part1(), and thus the worker will run with a
> now freed station. In his case, this manifested in a NULL sdata
> pointer, but really there's no guarantee whatsoever.
>
> The real issue seems to be that it's possible at all to have a
> situation where this occurs - we want to stop the BA sessions
> when doing _part1, but we cannot be sure, and WLAN_STA_BLOCK_BA
> isn't necessarily effective since we don't know that the setup
> isn't concurrently running and already got past the check.
>
> Simply call ieee80211_sta_tear_down_BA_sessions() again in the
> second part of station destruction, since at that point really
> nothing else can hold a reference to the station any more.
>
> Also revert the sdata checks since those are just misleading at
> this point.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/agg-tx.c     |  6 +-----
>  net/mac80211/driver-ops.c |  3 ---
>  net/mac80211/sta_info.c   | 14 ++++++++++++++
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
> index 0627abb09f0e..b8a278355e18 100644
> --- a/net/mac80211/agg-tx.c
> +++ b/net/mac80211/agg-tx.c
> @@ -497,7 +497,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_=
info *sta, int tid)
>  {
>         struct tid_ampdu_tx *tid_tx;
>         struct ieee80211_local *local =3D sta->local;
> -       struct ieee80211_sub_if_data *sdata;
> +       struct ieee80211_sub_if_data *sdata =3D sta->sdata;
>         struct ieee80211_ampdu_params params =3D {
>                 .sta =3D &sta->sta,
>                 .action =3D IEEE80211_AMPDU_TX_START,
> @@ -525,7 +525,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_=
info *sta, int tid)
>          */
>         synchronize_net();
>
> -       sdata =3D sta->sdata;
>         params.ssn =3D sta->tid_seq[tid] >> 4;
>         ret =3D drv_ampdu_action(local, sdata, &params);
>         tid_tx->ssn =3D params.ssn;
> @@ -539,9 +538,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_=
info *sta, int tid)
>                  */
>                 set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
>         } else if (ret) {
> -               if (!sdata)
> -                       return;
> -
>                 ht_dbg(sdata,
>                        "BA request denied - HW unavailable for %pM tid %d=
\n",
>                        sta->sta.addr, tid);
> diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
> index 919300750527..169dbbca54b6 100644
> --- a/net/mac80211/driver-ops.c
> +++ b/net/mac80211/driver-ops.c
> @@ -409,9 +409,6 @@ int drv_ampdu_action(struct ieee80211_local *local,
>         might_sleep();
>         lockdep_assert_wiphy(local->hw.wiphy);
>
> -       if (!sdata)
> -               return -EIO;
> -
>         sdata =3D get_bss_sdata(sdata);
>         if (!check_sdata_in_driver(sdata))
>                 return -EIO;
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index abcc280acd38..2a61269a4b54 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -1385,6 +1385,20 @@ static void __sta_info_destroy_part2(struct sta_in=
fo *sta, bool recalc)
>          *       after _part1 and before _part2!
>          */
>
> +       /*
> +        * There's a potential race in _part1 where we set WLAN_STA_BLOCK=
_BA
> +        * but someone might have just gotten past a check, and not yet i=
nto
> +        * queuing the work/creating the data/etc.
> +        *
> +        * Do another round of destruction so that the worker is certainl=
y
> +        * canceled before we later free the station.
> +        *
> +        * Since this is after synchronize_rcu()/synchronize_net() we're =
now
> +        * certain that nobody can actually hold a reference to the STA a=
nd
> +        * be calling e.g. ieee80211_start_tx_ba_session().
> +        */
> +       ieee80211_sta_tear_down_BA_sessions(sta, AGG_STOP_DESTROY_STA);
> +
>         might_sleep();
>         lockdep_assert_wiphy(local->hw.wiphy);
>
> --
> 2.41.0
>
