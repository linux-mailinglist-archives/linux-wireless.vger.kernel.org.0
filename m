Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2D88AC9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 12:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfHJK3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 06:29:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35914 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfHJK3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 06:29:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so17270555lfp.3
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2019 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUImiWlxnfnmpS5myYHjorKlWYB9iUbuWVVXIzh5eG4=;
        b=dpoCwZcqJeDwWS4ANLUvZjry4Xu6//bHvVFIEWRQRo0YHT7X7J/dKQkA1NcsV+0kkJ
         CGrk4G5Cs7k4edCcQ4cpg5NqB/dDDWuDtQ+CF6C18mi8buxRbM7kajQtuFXbXa5TEM5D
         3msBN3HGDbPKJRbOR/tpga12LbQGFC8alTrkNsyuvwskb9MKvyuB3TCHi2UbrB8yWvW7
         XZ/0YN2N8Fk9wCkvMIHU1j8DLq+NIfBU1p9EXj9v8Qb18Nfmsc8/VPKLJL8AMRhuu+Fl
         Sl6Lc0qbxgA2n9UFBgcXXFRD7mLtecMjSQbMGar/cuv06mftFRoxw8uSQ52y+aDUUg4V
         PdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUImiWlxnfnmpS5myYHjorKlWYB9iUbuWVVXIzh5eG4=;
        b=LOlfdHlU5/AX5BFts+KKfPQvj7Bre2PS6clh6Ax21BeJ8PLUmPJD7LmTj41mZfKonp
         3/6Xw779IvTj7R6BizxXFwqGslDcXcPx3s2OSkBBbNuJoRV8nCSw/GkKa4gZww6plfon
         orJc3zV3E0D4vW4bIjRFW9OiLW92fY647glW6PZY5wamifzj8WsifS6CGCaBnGxMunkh
         6QTT5asLMd8H7MhwO+P0ekUPulw1c7BO276oBKdvU8Qwc4x1NfnrKFIRh04+p168ULOQ
         RcJGKKG9a2dtvnk+me5IKbteewcky9O6IxOOnGCD5q2D1D55GgqACwOIzkRpGinPU0A3
         Sr1g==
X-Gm-Message-State: APjAAAXp4HiOgXphN3zTkz+Jg2b8g7eJZ/ypAPikvbGHVm7aZsZ6B2zZ
        2xkiLFsDHjiAfPn5mKwmUxXCE2uR6WfTynBC3ID9jCmc3JI=
X-Google-Smtp-Source: APXvYqxVPWBCvuns4JUbYiqsr2d8e2EflnqEJzeC98h9spR+1K3ieONCpWGO92A9fR6R6nKuy1oXunyK5cNkpkYrmLc=
X-Received: by 2002:a19:4f42:: with SMTP id a2mr14913314lfk.23.1565432947348;
 Sat, 10 Aug 2019 03:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSNYx0k7k8RyRT6siC1xv_0xqf3ggKSwNp7sp9c7y-kOgSeAg@mail.gmail.com>
 <64EA957F-B24A-4B1C-AAC0-B51790F47E9E@sipsolutions.net>
In-Reply-To: <64EA957F-B24A-4B1C-AAC0-B51790F47E9E@sipsolutions.net>
From:   Guo Wei Lim <limguowei@gmail.com>
Date:   Sat, 10 Aug 2019 10:28:55 +0000
Message-ID: <CAJSNYx3Paw7RXpHFbC55zNptT+1AGeYPx08m0=XSr6sSGtC33g@mail.gmail.com>
Subject: Re: Unaligned Memory Access on mesh_*.c files
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Correct me if I am wrong.
The problem is largely in net/mac80211/mesh_hwmp.c
The macros
#define PREQ_IE_ORIG_ADDR(x) (x + 7)
#define PREP_IE_TARGET_ADDR(x) (x + 3)

Almost guarantees the addresses will be odd when it hit the following

switch (action) {
case MPATH_PREQ:
orig_addr = PREQ_IE_ORIG_ADDR(hwmp_ie);
orig_sn = PREQ_IE_ORIG_SN(hwmp_ie);
orig_lifetime = PREQ_IE_LIFETIME(hwmp_ie);
orig_metric = PREQ_IE_METRIC(hwmp_ie);
hopcount = PREQ_IE_HOPCOUNT(hwmp_ie) + 1;
break;
case MPATH_PREP:
/* Originator here refers to the MP that was the target in the
* Path Request. We divert from the nomenclature in the draft
* so that we can easily use a single function to gather path
* information from both PREQ and PREP frames.
*/
orig_addr = PREP_IE_TARGET_ADDR(hwmp_ie);
orig_sn = PREP_IE_TARGET_SN(hwmp_ie);
orig_lifetime = PREP_IE_LIFETIME(hwmp_ie);
orig_metric = PREP_IE_METRIC(hwmp_ie);
hopcount = PREP_IE_HOPCOUNT(hwmp_ie) + 1;
break;
default:
rcu_read_unlock();
return 0;
}

So following that many functions like

if (ether_addr_equal(orig_addr, sdata->vif.addr)) {

Results in unaligned memory access
I traced and caught all the following functions creating unaligned memory access
This is just one example

[  344.065508] Call Trace:
[  344.068111] [<870d9b7c>] mesh_rx_plink_frame+0xed0/0x139c [mac80211]
[  344.074626] Code: 96c40002  9646000c  00451026 <96c30004> 9645000e
00862026  00441025  00651826  00431025
[  344.084628]
[  344.086166] CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.14.123 #0
[  344.092833] Workqueue: phy1 ieee80211_ibss_leave [mac80211]
[  344.098609] task: 87c25600 task.stack: 87c3a000
[  344.103319] $ 0   : 00000000 00000001 00000000 00000000
[  344.108656] $ 4   : 00000000 0000c46e 000067a5 00000000
[  344.114057] $ 8   : 86e25464 00000001 00000004 873811e8
[  344.119433] $12   : ffffffff 00000000 00b00000 00000000
[  344.124806] $16   : 804f0000 8773f078 87315460 8773f082
[  344.130155] $20   : 8773f094 8773f0a9 000000b3 870e89e8
[  344.135485] $24   : 804ef040 870de528
[  344.140915] $28   : 87c3a000 87c3bcb8 870e8a14 870da454
[  344.146279] Hi    : 0004e2ca
[  344.149300] Lo    : b0250b0d
[  344.152383] epc   : 870da988 mesh_rx_path_sel_frame+0x658/0xb08 [mac80211]
[  344.159527] ra    : 870da454 mesh_rx_path_sel_frame+0x124/0xb08 [mac80211]
[  344.166543] Status: 1100dc03 KERNEL EXL IE
[  344.170825] Cause : 00800010 (ExcCode 04)
[  344.174894] BadVA : 8773f0a9
[  344.177829] PrId  : 0001974c (MIPS 74Kc)
[  344.181881] Modules linked in: ath9k ath9k_common pppoe ppp_async
l2tp_ppp ath9k_hw ath qmi_wwan pptp pppox ppp_mppe ppp_generic
nf_conntrack_ipv6 mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE
cfg80211 xt_time xt_tcpudp xt_tcpmss xt_statistic xt_state xt_recent
xt_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_helper
xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlimit xt_connbytes
xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_DSCP xt_CT
xt_CLASSIFY wireguard usbnet slhc nf_reject_ipv4 nf_nat_redirect
nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat
nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache
nf_conntrack_netlink iptable_raw iptable_mangle iptable_filter ipt_ECN
ip_tables crc_ccitt compat cdc_wdm sch_cake nf_conntrack sch_tbf
sch_ingress sch_htb sch_hfsc
[  344.254146]  em_u32 cls_u32 cls_tcindex cls_route cls_matchall
cls_fw cls_flow cls_basic act_skbedit act_mirred ledtrig_usbport
cryptodev xt_set ip_set_list_set ip_set_hash_netportnet
ip_set_hash_netport ip_set_hash_netnet ip_set_hash_netiface
ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet
ip_set_hash_ipportip ip_set_hash_ipport ip_set_hash_ipmark
ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip
ip_set nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle
ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip_gre
gre ifb l2tp_netlink l2tp_core udp_tunnel ip6_udp_tunnel ip_tunnel tun
shortcut_fe_ipv6 shortcut_fe algif_skcipher algif_hash af_alg
sha1_generic ecb authenc ehci_platform ehci_hcd gpio_button_hotplug
usbcore nls_base usb_common mii aead cryptomgr crypto_null
[  344.326861]  crypto_hash
[  344.329502] Process kworker/u2:0 (pid: 5, threadinfo=87c3a000,
task=87c25600, tls=00000000)
[  344.338022] Stack : 0000002f 870ac7f0 00000000 20000009 00000000
00000000 00000000 00000041
[  344.346622]         8717a780 804f0000 87315460 00000041 87380bc0
870b2d30 8717a780 8717a780
[  344.355242]         000000a0 00000000 00000000 802d09dc 8773f092
00000021 00000000 00000000
[  344.363839]         00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  344.372380]         00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  344.380888]         ...
[  344.383382] Call Trace:
[  344.386011] [<870da988>] mesh_rx_path_sel_frame+0x658/0xb08 [mac80211]
[  344.392801] [<870d5bb4>] ieee80211_mesh_rx_queued_mgmt+0x15c/0x164 [mac80211]
[  344.400279] [<87097164>] ieee80211_ibss_leave+0x80c/0x1888 [mac80211]
[  344.406922] [<870d5cd0>] ieee80211_mesh_work+0x114/0x2cc [mac80211]
[  344.413498] [<8009d280>] process_one_work+0x1f8/0x428
[  344.418706] [<8009d630>] worker_thread+0x180/0x548
[  344.423692] [<800a3a04>] kthread+0x134/0x13c
[  344.428075] [<80066db8>] ret_from_kernel_thread+0x14/0x1c
[  344.433622] Code: 26950015  2695001b  964508a0 <96a20000> 96a40002
964608a2  00451026  96a30004  964508a4

   orig_addr = PREP_IE_ORIG_ADDR(prep_elem);
   5bb7c:    92620000     lbu    v0,0(s3)
   5bb80:    30420040     andi    v0,v0,0x40
   5bb84:    14400002     bnez    v0,5bb90 <mesh_rx_path_sel_frame+0x510>
   5bb88:    2674001b     addiu    s4,s3,27
   5bb8c:    26740015     addiu    s4,s3,21
    return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2])) == 0;
   5bb90:    962508b8     lhu    a1,2232(s1)
   5bb94:    96820000     lhu    v0,0(s4)
   5bb98:    96840002     lhu    a0,2(s4)
   5bb9c:    962608ba     lhu    a2,2234(s1)
   5bba0:    00451026     xor    v0,v0,a1
   5bba4:    96830004     lhu    v1,4(s4)
   5bba8:    962508bc     lhu    a1,2236(s1)
   5bbac:    00862026     xor    a0,a0,a2
   5bbb0:    00441025     or    v0,v0,a0
   5bbb4:    00651826     xor    v1,v1,a1
    if (ether_addr_equal(orig_addr, sdata->vif.addr))

I have tested that replacing ether_addr_equal with
ether_addr_equal_unaligned fixes the issue but this happens in many
places as well as other functions like is_multicast_ether_addr(),
is_broadcast_ether_addr() so it isn't the correct fix.

On Sat, Aug 10, 2019 at 8:50 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
>
>
> On August 10, 2019 6:07:15 AM GMT+02:00, Guo Wei Lim <limguowei@gmail.com> wrote:
> >I have traced a large number of unaligned memory access on mips cpu
> >due to ether_addr_equal(), is_multicast_ether_addr(),
> >is_broadcast_ether_addr() being called on odd addresses.
> >
> >Even though the values are u8, the inlines in etherdevice.h converts
> >them to u16 causing the issue.
> >
> >I can replace ether_addr_equal() with ether_addr_equal_unaligned() but
> >it doesn't seem like a proper fix. Anyone has better ideas?
>
> Can you say which places cause this,and which driver you're using? Also, I guess the type of frame and what address format it has would be good to know.
>
> If you aren't also hitting the warning in rx.c about alignment though, it might be that we do in fact need to use code not expecting alignment.
>
> johannes
> --
> Sent from my phone.
