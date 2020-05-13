Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AF1D168E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgEMN4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 09:56:16 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:33372 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMN4P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 09:56:15 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6D4E813C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 06:56:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6D4E813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1589378171;
        bh=Cw1oCS/Wi+n+QER5LZxmE/bDfFfuMGYT2du/XkuyEXA=;
        h=To:From:Subject:Date:From;
        b=G5WXP4lqyhk/pIB2iDABTUbprHhyS7qWQeguMGRHmYxowcITdVCjOTgJhasxwf2iP
         SmWepyNR9Rtd0KrA76w8r0V/WkZN7T+ydTECyV8Cdzt3GW8d/gbYQCrT2HGsoJsC+W
         58+mvR7VNjgno6wZYTKTBJJ5v0yAGYnIn6t9NBX0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: mac80211 spam and deadlock on OpenWrt
Message-ID: <e5caffb7-b387-9010-8445-54992ccf6e4c@candelatech.com>
Date:   Wed, 13 May 2020 06:56:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I've been running some stress tests against OpenWrt APs.  My AP partially died yesterday
during a test and did not recover.  It looks like firmware became non responsive,
but then it could not recover due to what I think is bugs I fixed long ago in
the kernel that I normally use.  The OpenWrt image is using my ath10k-ct driver and firmware,
but stock OpenWrt kernel/mac80211 as far as I know.

I think there are several issues:

1)  The WARN-ON about check-sdata-in-driver should be a warn-on-once.  Spamming serial
   console logs like this is both very slow and also useless for debugging.

I posted a patch with this title some time back to mitigate this problem:
"mac80211: Don't spam kernel with sdata-in-driver failures."

2)  I suspect that the ensuing lockup may be fixed by this patch I posted
back in 12/1/2016:
"mac80211:  do not iterate active interfaces when in re-configure"

I have been running both of those patches since posting them to the list, so they have good
soak time in some strenuous wifi usage cases.

At the least, it would be nice to have the sdata spam gone, since it would then be
easier to find the useful information in the console output.

Full logs here (but somewhat subject to change, I am likely to re-run some tests and copy over this
sometime soon):

http://www.candelatech.com/examples/cicd/ferndale-basic-01/basic/ea8300-2020-04-24-41f8bf6/wifi_capacity_dl/logs/dut_console_log.txt

The console logs are below.

[  935.041056] ath10k_pci 0000:01:00.0: wmi command 36967 timeout, restarting hardware
[  935.281046] ath10k_ahb a000000.wifi: bss channel survey timed out
��[  938.081053] ath10k_pci 0000:01:00.0: wmi command 36967 timeout, restarting hardware
[  938.321058] ath10k_ahb a000000.wifi: wmi command 36892 timeout, restarting hardware
[  938.321105] ath10k_ahb a000000.wifi: failed to recalculate rts/cts prot for vdev 0: -11
[  941.121058] ath10k_pci 0000:01:00.0: wmi command 40859 timeout, restarting hardware
[  941.121099] ath10k_pci 0000:01:00.0: failed to send wmi nop: -11
���[  941.129102] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42b800 vdev: 0 addr: 04:f0:21:6d:aa:25
��[  941.135051] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42ba00 vdev: 0 addr: 04:f0:21:85:e2:25
��[  941.146164] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42ae00 vdev: 0 addr: 04:f0:21:50:8b:25
��[  941.157282] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42a000 vdev: 0 addr: 04:f0:21:20:e5:25
��[  941.168400] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42aa00 vdev: 0 addr: 04:f0:21:cc:1f:25
��[  941.179520] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42b600 vdev: 0 addr: 04:f0:21:46:6b:25
��[  941.190640] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42bc00 vdev: 0 addr: 04:f0:21:a5:59:25
��[  941.201767] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42b200 vdev: 0 addr: 04:f0:21:af:b5:25
��[  941.212878] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cc42a800 vdev: 0 addr: 04:f0:21:04:b8:25
��[  941.224000] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce375200 vdev: 0 addr: 04:f0:21:fe:cd:25
��[  941.235132] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca59e800 vdev: 0 addr: 04:f0:21:c5:72:25
��[  941.246245] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61a400 vdev: 0 addr: 04:f0:21:b0:3c:25
��[  941.257361] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61b600 vdev: 0 addr: 04:f0:21:3e:98:25
��[  941.268480] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61ae00 vdev: 0 addr: 04:f0:21:e5:22:25
��[  941.279607] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61b800 vdev: 0 addr: 04:f0:21:d8:6d:25
��[  941.290725] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61a200 vdev: 0 addr: 04:f0:21:7d:3e:25
��[  941.301851] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61ba00 vdev: 0 addr: 04:f0:21:91:f5:25
��[  941.312961] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61a800 vdev: 0 addr: 04:f0:21:6a:9f:25
��[  941.324084] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61ac00 vdev: 0 addr: 04:f0:21:18:31:25
��[  941.335204] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ca61bc00 vdev: 0 addr: 04:f0:21:d7:b4:25
��[  941.346323] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce851000 vdev: 0 addr: 04:f0:21:a6:f5:25
��[  941.357443] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce850400 vdev: 0 addr: 04:f0:21:a9:90:25
��[  941.361064] ath10k_ahb a000000.wifi: wmi command 36892 timeout, restarting hardware
[  941.368562] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce851e00 vdev: 0 addr: 04:f0:21:48:f9:25
��[  941.379686] ath10k_ahb a000000.wifi: failed to set cts protection for vdev 0: -11
��[  941.387322] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce851400 vdev: 0 addr: 04:f0:21:b9:9e:25
��[  941.387336] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce850200 vdev: 0 addr: 04:f0:21:1d:c6:25
��[  941.417212] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cf226e00 vdev: 0 addr: 04:f0:21:fc:66:25
��[  941.428341] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cf226400 vdev: 0 addr: 04:f0:21:b2:8e:25
��[  941.439464] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cded9a00 vdev: 0 addr: 04:f0:21:48:d0:25
��[  941.450581] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cbb6a200 vdev: 0 addr: 4c:1d:96:02:68:ce
��[  941.461707] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cbb6ba00 vdev: 0 addr: 84:c5:a6:fa:80:44
��[  941.472821] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer cbb6a400 vdev: 0 addr: 04:f0:21:ef:a7:25
��[  941.483941] ath10k_pci 0000:01:00.0: removing peer, cleanup-all, deleting: peer ce51c600 vdev: 0 addr: 26:f5:a2:08:21:6e
��[  941.507152] ath10k_pci 0000:01:00.0: failed to read hi_board_data address: -16
�[  941.597831] ieee80211 phy0: Hardware restart was requested
�[  944.241069] ath10k_ahb a800000.wifi: wmi command 40859 timeout, restarting hardware
[  944.241119] ath10k_ahb a800000.wifi: failed to send wmi nop: -11
���[  944.248982] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cee76e00 vdev: 0 addr: 04:f0:21:50:f5:a2
��[  944.255065] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cbb6a800 vdev: 0 addr: 04:f0:21:99:68:a2
��[  944.266183] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ceb45e00 vdev: 0 addr: 04:f0:21:a9:c4:a2
��[  944.277296] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cba89c00 vdev: 0 addr: 04:f0:21:9d:5f:a2
��[  944.288414] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce9ef200 vdev: 0 addr: 04:f0:21:77:04:a2
��[  944.299533] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce51ce00 vdev: 0 addr: 04:f0:21:5e:8e:a2
��[  944.310655] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce51c400 vdev: 0 addr: 04:f0:21:48:34:a2
��[  944.321802] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce51da00 vdev: 0 addr: 04:f0:21:a9:78:a2
��[  944.332900] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce51c000 vdev: 0 addr: 04:f0:21:d0:7d:a2
��[  944.344016] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce9efc00 vdev: 0 addr: 04:f0:21:11:5d:a2
��[  944.355136] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61b000 vdev: 0 addr: 04:f0:21:89:e4:a2
��[  944.366261] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61a000 vdev: 0 addr: 04:f0:21:6d:8b:a2
��[  944.377378] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61a600 vdev: 0 addr: 04:f0:21:73:47:a2
��[  944.388498] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61b200 vdev: 0 addr: 04:f0:21:6d:4b:a2
��[  944.399618] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61be00 vdev: 0 addr: 04:f0:21:e4:67:a2
��[  944.410741] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61b400 vdev: 0 addr: 04:f0:21:fa:40:a2
��[  944.411055] ath10k_ahb a000000.wifi: wmi command 36892 timeout, restarting hardware
[  944.421876] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ca61aa00 vdev: 0 addr: 04:f0:21:27:b0:a2
��[  944.432964] ath10k_ahb a000000.wifi: failed to set erp slot for vdev 0: -11
[  944.451745] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cb03f200 vdev: 0 addr: 04:f0:21:e7:a5:a2
��[  944.458676] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cb03ee00 vdev: 0 addr: 04:f0:21:a5:0f:a2
��[  944.469827] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cb03ec00 vdev: 0 addr: 04:f0:21:46:43:a2
��[  944.480947] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce850000 vdev: 0 addr: 04:f0:21:97:d1:a2
��[  944.492070] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce850e00 vdev: 0 addr: 04:f0:21:27:51:a2
��[  944.503187] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce824800 vdev: 0 addr: 04:f0:21:5c:40:a2
��[  944.514304] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cef1c600 vdev: 0 addr: 04:f0:21:6c:3b:a2
��[  944.525426] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cef1de00 vdev: 0 addr: 04:f0:21:ee:44:a2
��[  944.536546] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cded9600 vdev: 0 addr: 04:f0:21:17:c8:a2
��[  944.547667] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cded9000 vdev: 0 addr: 04:f0:21:d9:21:a2
��[  944.558783] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cbb6b200 vdev: 0 addr: 04:f0:21:66:0c:a2
��[  944.569905] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cbb6b600 vdev: 0 addr: 04:ed:33:10:9d:30
��[  944.581028] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cbb6be00 vdev: 0 addr: 5c:80:b6:58:24:03
��[  944.592161] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer cbb6bc00 vdev: 0 addr: 04:f0:21:6c:2d:a2
��[  944.603272] ath10k_ahb a800000.wifi: removing peer, cleanup-all, deleting: peer ce51d200 vdev: 0 addr: 24:f5:a2:08:21:6d
��[  944.626475] ath10k_ahb a800000.wifi: failed to read hi_board_data address: -16
�[  944.633590] ieee80211 phy2: Hardware restart was requested
�[  947.441060] ath10k_ahb a000000.wifi: wmi command 36892 timeout, restarting hardware
[  947.441102] ath10k_ahb a000000.wifi: failed to set preamble for vdev 0: -11
[  950.481070] ath10k_ahb a000000.wifi: wmi command 36892 timeout, restarting hardware
[  950.481117] ath10k_ahb a000000.wifi: failed to set mgmt tx rate -11
[  950.573316] ath10k_pci 0000:01:00.0: Failed to get pcie state addr: -16
[  950.573354] ath10k_pci 0000:01:00.0: failed to setup init config: -16
��[  950.580127] ath10k_pci 0000:01:00.0: Could not init hif: -16
���[  950.586607] ------------[ cut here ]------------
���[  950.592508] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/util.c:2040 0xbf260c44 [mac80211@bf230000+0x62000]
�[  950.597351] Hardware became unavailable during restart.
[  950.608483] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  950.661815]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  950.685271] CPU: 2 PID: 64 Comm: kworker/2:1 Not tainted 4.14.171 #0
���[  950.697034] Hardware name: Generic DT based system
�[  950.703654] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  950.708521] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  950.715812] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  950.721725] Function entered at [<c073fe14>] from [<c031dd34>]
�[  950.727635] Function entered at [<c031dd34>] from [<c031dd88>]
�[  950.733546] Function entered at [<c031dd88>] from [<bf260c44>]
�[  950.739495] Function entered at [<bf260c44>] from [<bf2307f0>]
�[  950.745372] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  950.751283] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  950.757194] Function entered at [<c0333bb0>] from [<c0339070>]
�[  950.763106] Function entered at [<c0339070>] from [<c03074a8>]
�[  950.769074] ---[ end trace df518fc833e2536a ]---
���[  950.774986] ------------[ cut here ]------------
���[  950.779809] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  950.784724] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  950.796159] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  950.850551]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  950.873985] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  950.885750] Hardware name: Generic DT based system
�[  950.893408] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  950.898277] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  950.905568] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  950.911481] Function entered at [<c073fe14>] from [<c031dd34>]
�[  950.917391] Function entered at [<c031dd34>] from [<c031dd88>]
�[  950.923303] Function entered at [<c031dd88>] from [<bf233718>]
�[  950.929218] Function entered at [<bf233718>] from [<bf23edf4>]
�[  950.935128] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  950.941041] Function entered at [<bf23d384>] from [<bf234a90>]
�[  950.946952] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  950.952864] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  950.958776] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  950.964714] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  950.970601] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  950.976511] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  950.982423] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  950.988334] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  950.994247] Function entered at [<c0634a90>] from [<c0634b74>]
�[  951.000157] Function entered at [<c0634b74>] from [<c0636b80>]
�[  951.006070] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  951.011984] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  951.017896] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  951.023806] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  951.029717] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  951.035628] Function entered at [<c0333bb0>] from [<c0339070>]
�[  951.041543] Function entered at [<c0339070>] from [<c03074a8>]
�[  951.047576] ---[ end trace df518fc833e2536b ]---
���[  951.053390] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:ef:a7:25 tid 0
[  951.058259] ------------[ cut here ]------------
���[  951.066265] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  951.071133] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  951.082585] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  951.136964]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  951.160410] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  951.172179] Hardware name: Generic DT based system
�[  951.179835] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  951.184704] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  951.191996] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  951.197907] Function entered at [<c073fe14>] from [<c031dd34>]
�[  951.203818] Function entered at [<c031dd34>] from [<c031dd88>]
�[  951.209729] Function entered at [<c031dd88>] from [<bf234d74>]
�[  951.215643] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  951.221554] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  951.227464] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  951.233377] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  951.239288] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  951.245199] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  951.251110] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  951.257020] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  951.262931] Function entered at [<c0634a90>] from [<c0634b74>]
�[  951.268843] Function entered at [<c0634b74>] from [<c0636b80>]
�[  951.274755] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  951.280669] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  951.286581] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  951.292493] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  951.298405] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  951.304317] Function entered at [<c0333bb0>] from [<c0339070>]
�[  951.310228] Function entered at [<c0339070>] from [<c03074a8>]
�[  951.316226] ---[ end trace df518fc833e2536c ]---
���[  951.322069] ------------[ cut here ]------------
���[  951.326930] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  951.331827] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  951.343280] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  951.397659]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  951.421107] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  951.432874] Hardware name: Generic DT based system
�[  951.440530] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  951.445399] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  951.452692] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  951.458603] Function entered at [<c073fe14>] from [<c031dd34>]
�[  951.464514] Function entered at [<c031dd34>] from [<c031dd88>]
�[  951.470427] Function entered at [<c031dd88>] from [<bf233718>]
�[  951.476341] Function entered at [<bf233718>] from [<bf23edf4>]
�[  951.482252] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  951.488163] Function entered at [<bf23d384>] from [<bf234a90>]
�[  951.494076] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  951.499987] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  951.505899] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  951.511812] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  951.517723] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  951.523635] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  951.529546] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  951.535458] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  951.541372] Function entered at [<c0634a90>] from [<c0634b74>]
�[  951.547281] Function entered at [<c0634b74>] from [<c0636b80>]
�[  951.553193] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  951.559107] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  951.565019] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  951.570929] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  951.576840] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  951.582752] Function entered at [<c0333bb0>] from [<c0339070>]
�[  951.588666] Function entered at [<c0339070>] from [<c03074a8>]
�[  951.594685] ---[ end trace df518fc833e2536d ]---
���[  951.600491] wlan0: HW problem - can not stop rx aggregation for 84:c5:a6:fa:80:44 tid 0
[  951.605408] ------------[ cut here ]------------
���[  951.613386] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  951.618232] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  951.629712] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  951.684095]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  951.707538] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  951.719306] Hardware name: Generic DT based system
�[  951.726963] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  951.731831] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  951.739125] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  951.745036] Function entered at [<c073fe14>] from [<c031dd34>]
�[  951.750948] Function entered at [<c031dd34>] from [<c031dd88>]
�[  951.756861] Function entered at [<c031dd88>] from [<bf234d74>]
�[  951.762774] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  951.768685] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  951.774596] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  951.780509] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  951.786419] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  951.792332] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  951.798243] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  951.804155] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  951.810068] Function entered at [<c0634a90>] from [<c0634b74>]
�[  951.815980] Function entered at [<c0634b74>] from [<c0636b80>]
�[  951.821893] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  951.827806] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  951.833719] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  951.839629] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  951.845540] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  951.851453] Function entered at [<c0333bb0>] from [<c0339070>]
�[  951.857364] Function entered at [<c0339070>] from [<c03074a8>]
�[  951.863363] ---[ end trace df518fc833e2536e ]---
���[  951.869188] ------------[ cut here ]------------
���[  951.874094] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  951.878940] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  951.890418] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  951.944798]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  951.968240] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  951.980008] Hardware name: Generic DT based system
�[  951.987665] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  951.992531] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  951.999826] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  952.005739] Function entered at [<c073fe14>] from [<c031dd34>]
�[  952.011650] Function entered at [<c031dd34>] from [<c031dd88>]
�[  952.017562] Function entered at [<c031dd88>] from [<bf233718>]
�[  952.023477] Function entered at [<bf233718>] from [<bf23edf4>]
�[  952.029388] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  952.035299] Function entered at [<bf23d384>] from [<bf234a90>]
�[  952.041211] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  952.047123] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  952.053035] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  952.058948] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  952.064858] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  952.070769] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  952.076681] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  952.082592] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  952.088504] Function entered at [<c0634a90>] from [<c0634b74>]
�[  952.094416] Function entered at [<c0634b74>] from [<c0636b80>]
�[  952.100328] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  952.106242] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  952.112152] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  952.118064] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  952.123976] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  952.129888] Function entered at [<c0333bb0>] from [<c0339070>]
�[  952.135801] Function entered at [<c0339070>] from [<c03074a8>]
�[  952.141830] ---[ end trace df518fc833e2536f ]---
���[  952.147632] wlan0: HW problem - can not stop rx aggregation for 4c:1d:96:02:68:ce tid 0
[  952.152562] ------------[ cut here ]------------
���[  952.160501] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  952.165417] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  952.176879] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  952.177743] ------------[ cut here ]------------
���[  952.231236]  mpls_router
���[  952.254654] WARNING: CPU: 3 PID: 1471 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
���[  952.254663] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  952.259495]  mpls_gso
��[  952.262318] Modules linked in:
�[  952.274109]  leds_gpio xhci_plat_hcd
���[  952.280355]  pppoe
�[  952.282801]  xhci_pci xhci_hcd
�[  952.285931]  ppp_async
�[  952.289756]  dwc3
��[  952.291861]  ath10k_pci
[  952.294984]  dwc3_of_simple
[  952.297422]  ath10k_core
���[  952.299515]  gpio_button_hotplug
���[  952.301971]  ath
���[  952.304742]  crc32c_generic
[  952.307530]  pppox
�[  952.313103]  ppp_generic mac80211
��[  952.315893] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  952.315899] Hardware name: Generic DT based system
�[  952.317983]  iptable_nat
���[  952.321482] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  952.329116]  ipt_REJECT
[  952.333988] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  952.333998] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  952.336777]  ipt_MASQUERADE
[  952.344070] Function entered at [<c073fe14>] from [<c031dd34>]
�[  952.344075] Function entered at [<c031dd34>] from [<c031dd88>]
�[  952.344083] Function entered at [<c031dd88>] from [<bf234d74>]
�[  952.346517]  cfg80211
��[  952.352429] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  952.352435] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  952.352443] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  952.358334]  xt_time
���[  952.361127] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  952.361133] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  952.361139] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  952.361144] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  952.361153] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  952.367038]  xt_tcpudp
�[  952.372949] Function entered at [<c0634a90>] from [<c0634b74>]
�[  952.372954] Function entered at [<c0634b74>] from [<c0636b80>]
�[  952.372959] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  952.372967] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  952.378855]  xt_state
��[  952.381299] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  952.381305] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  952.381313] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  952.387212]  xt_nat
[  952.393123] Function entered at [<c0333bb0>] from [<c0339070>]
�[  952.393129] Function entered at [<c0339070>] from [<c03074a8>]
�[  952.393178] ---[ end trace df518fc833e25370 ]---
���[  952.399031]  xt_multiport
��[  952.401490] ------------[ cut here ]------------
���[  952.407389]  xt_mark
���[  952.413323] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  952.419213]  xt_mac
[  952.425137] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  952.431031]  xt_limit xt_conntrack xt_comment xt_TCPMSS
[  952.433476] Modules linked in:
�[  952.439388]  xt_REDIRECT
���[  952.445311]  pppoe
�[  952.451225]  xt_LOG
[  952.457119]  ppp_async
�[  952.459562]  xt_FLOWOFFLOAD
[  952.465489]  ath10k_pci
[  952.471390]  xt_CT slhc
[  952.477292]  ath10k_core
���[  952.479390]  openvswitch
���[  952.485317]  ath
���[  952.491218]  nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6
[  952.496081]  pppox
�[  952.498869]  nf_nat_ipv6
���[  952.503750]  ppp_generic
���[  952.506190]  nf_conntrack_ipv4
�[  952.517654]  mac80211
��[  952.519741]  nf_nat_ipv4
���[  952.526013]  iptable_nat
���[  952.531218]  nf_nat nf_log_ipv4 nf_flow_table_hw
���[  952.534346]  ipt_REJECT
[  952.537131]  nf_flow_table
�[  952.539223]  ipt_MASQUERADE
[  952.541327]  nf_defrag_ipv6 nf_defrag_ipv4
�[  952.543757]  cfg80211
��[  952.546540]  nf_conntrack_rtcache
��[  952.548982]  xt_time
���[  952.551435]  nf_conntrack
��[  952.554208]  xt_tcpudp
�[  952.556993]  libcrc32c
�[  952.559098]  xt_state
��[  952.568827]  iptable_mangle iptable_filter
�[  952.570911]  xt_nat
[  952.573712]  ip_tables
�[  952.576485]  xt_multiport
��[  952.579616]  hwmon
�[  952.582070]  xt_mark
���[  952.584845]  crc_ccitt
�[  952.587635]  xt_mac
[  952.592511]  compat ledtrig_usbport
[  952.594941]  xt_limit
��[  952.597727]  nf_log_ipv6
���[  952.600515]  xt_conntrack
��[  952.604704]  nf_log_common
�[  952.607130]  xt_comment
[  952.610610]  ip6table_mangle
���[  952.613067]  xt_TCPMSS
�[  952.615839]  ip6table_filter
���[  952.618277]  xt_REDIRECT
���[  952.620718]  ip6_tables
[  952.623174]  xt_LOG
[  952.627332]  ip6t_REJECT
���[  952.629424]  xt_FLOWOFFLOAD
[  952.631875]  x_tables nf_reject_ipv6
���[  952.634651]  xt_CT
�[  952.636744]  ip6_gre
���[  952.639183]  slhc
��[  952.641633]  ip_gre gre
[  952.643718]  openvswitch
���[  952.647197]  ip6_tunnel
[  952.649636]  nf_reject_ipv4
[  952.652438]  tunnel6
���[  952.655209]  nf_nat_redirect
���[  952.657994]  ip_tunnel
�[  952.660436]  nf_nat_masquerade_ipv6
[  952.663580]  mpls_iptunnel mpls_router
�[  952.666011]  nf_nat_masquerade_ipv4
[  952.669141]  mpls_gso
��[  952.671944]  nf_conntrack_ipv6
�[  952.674368]  leds_gpio
�[  952.676463]  nf_nat_ipv6
���[  952.679250]  xhci_plat_hcd
�[  952.682053]  nf_conntrack_ipv4
�[  952.685864]  xhci_pci
��[  952.687957]  nf_nat_ipv4
���[  952.690398]  xhci_hcd
��[  952.692506]  nf_nat
[  952.694932]  dwc3
��[  952.697718]  nf_log_ipv4
���[  952.700158]  dwc3_of_simple
[  952.702958]  nf_flow_table_hw
��[  952.705388]  gpio_button_hotplug
���[  952.708519]  nf_flow_table
�[  952.710960]  crc32c_generic
[  952.714456]  nf_defrag_ipv6
[  952.721762]  nf_defrag_ipv4
[  952.724196] CPU: 3 PID: 1471 Comm: dnsmasq Tainted: G        W       4.14.171 #0
���[  952.727322]  nf_conntrack_rtcache
��[  952.729762] Hardware name: Generic DT based system
�[  952.732559]  nf_conntrack
��[  952.735341] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  952.738467]  libcrc32c
�[  952.740909] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  952.743701]  iptable_mangle
[  952.746135] Function entered at [<c073fe14>] from [<c031dd34>]
�[  952.748226]  iptable_filter
[  952.750322] Function entered at [<c031dd34>] from [<c031dd88>]
�[  952.753120]  ip_tables
�[  952.755898] Function entered at [<c031dd88>] from [<bf257584>]
�[  952.759030]  hwmon
�[  952.762514] Function entered at [<bf257584>] from [<bf25a558>]
�[  952.762524] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  952.765297]  crc_ccitt
�[  952.768087] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  952.770873]  compat
[  952.773668] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  952.773674] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  952.773684] Function entered at [<c063b268>] from [<c063b9d4>]
�[  952.781317]  ledtrig_usbport
���[  952.784795] Function entered at [<c063b9d4>] from [<c0720580>]
�[  952.789659]  nf_log_ipv6
���[  952.792451] Function entered at [<c0720580>] from [<c0720614>]
�[  952.792456] Function entered at [<c0720614>] from [<c0720744>]
�[  952.792461] Function entered at [<c0720744>] from [<c0720798>]
�[  952.792468] Function entered at [<c0720798>] from [<c072097c>]
�[  952.798358]  nf_log_common
�[  952.800804] Function entered at [<c072097c>] from [<c071dfb8>]
�[  952.806721]  ip6table_mangle
���[  952.809504] Function entered at [<c071dfb8>] from [<c063b268>]
�[  952.815415]  ip6table_filter
���[  952.818203] Function entered at [<c063b268>] from [<c063b9d4>]
�[  952.824112]  ip6_tables
[  952.826555] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  952.832463]  ip6t_REJECT
���[  952.834560] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  952.840468]  x_tables
��[  952.846374] Function entered at [<c06a9920>] from [<c064645c>]
�[  952.846379] Function entered at [<c064645c>] from [<c0649504>]
�[  952.846386] Function entered at [<c0649504>] from [<c06495fc>]
�[  952.848820]  nf_reject_ipv6
[  952.854725] Function entered at [<c06495fc>] from [<c067c5f8>]
�[  952.854730] Function entered at [<c067c5f8>] from [<c067d11c>]
�[  952.854735] Function entered at [<c067d11c>] from [<c067d8c4>]
�[  952.854743] Function entered at [<c067d8c4>] from [<c06a3e94>]
�[  952.856825]  ip6_gre
���[  952.862737] Function entered at [<c06a3e94>] from [<c06a5da8>]
�[  952.862742] Function entered at [<c06a5da8>] from [<c061f1e4>]
�[  952.862747] Function entered at [<c061f1e4>] from [<c03073c0>]
�[  952.862810] ---[ end trace df518fc833e25371 ]---
���[  952.868647]  ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
���[  953.025580] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  953.042220] Hardware name: Generic DT based system
�[  953.049877] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  953.054746] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  953.062038] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  953.067952] Function entered at [<c073fe14>] from [<c031dd34>]
�[  953.073864] Function entered at [<c031dd34>] from [<c031dd88>]
�[  953.079775] Function entered at [<c031dd88>] from [<bf233718>]
�[  953.085690] Function entered at [<bf233718>] from [<bf23edf4>]
�[  953.091602] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  953.097513] Function entered at [<bf23d384>] from [<bf234a90>]
�[  953.103424] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  953.109338] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  953.115250] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  953.121163] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  953.127074] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  953.132985] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  953.138898] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  953.144808] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  953.150721] Function entered at [<c0634a90>] from [<c0634b74>]
�[  953.156632] Function entered at [<c0634b74>] from [<c0636b80>]
�[  953.162544] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  953.168457] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  953.174370] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  953.180279] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  953.186191] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  953.192103] Function entered at [<c0333bb0>] from [<c0339070>]
�[  953.198016] Function entered at [<c0339070>] from [<c03074a8>]
�[  953.201089] ------------[ cut here ]------------
���[  953.204015] ---[ end trace df518fc833e25372 ]---
���[  953.209852] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  953.214725] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:48:d0:25 tid 0
[  953.214752] ------------[ cut here ]------------
���[  953.219596] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  953.231084] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  953.239046] Modules linked in:
�[  953.243934] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  953.250186]  pppoe
�[  953.261656] Modules linked in:
�[  953.264780]  ppp_async
�[  953.271056]  pppoe
�[  953.273126]  ath10k_pci
[  953.276259]  ppp_async
�[  953.278697]  ath10k_core
���[  953.280790]  ath10k_pci
[  953.283237]  ath pppox ppp_generic
�[  953.285671]  ath10k_core
���[  953.288456]  mac80211
��[  953.290898]  ath
���[  953.294386]  iptable_nat ipt_REJECT ipt_MASQUERADE
�[  953.297166]  pppox
�[  953.299605]  cfg80211
��[  953.301714]  ppp_generic
���[  953.306568]  xt_time
���[  953.308660]  mac80211
��[  953.311109]  xt_tcpudp xt_state xt_nat
�[  953.313888]  iptable_nat
���[  953.316326]  xt_multiport
��[  953.318769]  ipt_REJECT
[  953.322604]  xt_mark xt_mac
[  953.325383]  ipt_MASQUERADE
[  953.328169]  xt_limit
��[  953.330610]  cfg80211
��[  953.333406]  xt_conntrack xt_comment
���[  953.336184]  xt_time
���[  953.338622]  xt_TCPMSS
�[  953.341076]  xt_tcpudp
�[  953.344892]  xt_REDIRECT
���[  953.347330]  xt_state
��[  953.349769]  xt_LOG
[  953.352222]  xt_nat
[  953.354998]  xt_FLOWOFFLOAD
[  953.357436]  xt_multiport
��[  953.359528]  xt_CT
�[  953.361634]  xt_mark
���[  953.364409]  slhc
��[  953.367194]  xt_mac
[  953.369287]  openvswitch
���[  953.371739]  xt_limit
��[  953.373817]  nf_reject_ipv4
[  953.375912]  xt_conntrack
��[  953.378698]  nf_nat_redirect
���[  953.381151]  xt_comment
[  953.383926]  nf_nat_masquerade_ipv6
[  953.386712]  xt_TCPMSS
�[  953.389846]  nf_nat_masquerade_ipv4
[  953.392300]  xt_REDIRECT
���[  953.395767]  nf_conntrack_ipv6
�[  953.398207]  xt_LOG
[  953.401696]  nf_nat_ipv6 nf_conntrack_ipv4
�[  953.404476]  xt_FLOWOFFLOAD
[  953.407607]  nf_nat_ipv4
���[  953.409703]  xt_CT
�[  953.413886]  nf_nat nf_log_ipv4
[  953.416664]  slhc
��[  953.419448]  nf_flow_table_hw
��[  953.421554]  openvswitch
���[  953.424676]  nf_flow_table
�[  953.426769]  nf_reject_ipv4
[  953.429902]  nf_defrag_ipv6
[  953.432716]  nf_nat_redirect
���[  953.435478]  nf_defrag_ipv4
[  953.438264]  nf_nat_masquerade_ipv6
[  953.441062]  nf_conntrack_rtcache nf_conntrack libcrc32c
���[  953.444186]  nf_nat_masquerade_ipv4
[  953.446976]  iptable_mangle
[  953.450460]  nf_conntrack_ipv6
�[  953.456031]  iptable_filter ip_tables
��[  953.459503]  nf_nat_ipv6
���[  953.462300]  hwmon crc_ccitt
���[  953.465424]  nf_conntrack_ipv4
�[  953.469250]  compat
[  953.472050]  nf_nat_ipv4
���[  953.475170]  ledtrig_usbport
���[  953.478303]  nf_nat
[  953.480396]  nf_log_ipv6
���[  953.483198]  nf_log_ipv4
���[  953.486318]  nf_log_common
�[  953.488411]  nf_flow_table_hw
��[  953.491205]  ip6table_mangle ip6table_filter ip6_tables
[  953.493983]  nf_flow_table
�[  953.496771]  ip6t_REJECT
���[  953.499907]  nf_defrag_ipv6
[  953.505130]  x_tables nf_reject_ipv6
���[  953.507908]  nf_defrag_ipv4
[  953.510696]  ip6_gre
���[  953.513496]  nf_conntrack_rtcache
��[  953.517312]  ip_gre
[  953.520097]  nf_conntrack
��[  953.522545]  gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router
[  953.522734] ath10k_ahb a000000.wifi: wmi command 40859 timeout, restarting hardware
[  953.522743] ath10k_ahb a000000.wifi: failed to send wmi nop: -11
���[  953.526019]  libcrc32c
�[  953.528113]  mpls_gso
��[  953.530905]  iptable_mangle
[  953.537521]  leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple
�[  953.545170]  iptable_filter
[  953.551414]  gpio_button_hotplug crc32c_generic
[  953.551431] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.14.171 #0
[  953.553851]  ip_tables
�[  953.556293] Hardware name: Generic DT based system
�[  953.559085]  hwmon
�[  953.566039] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  953.566049] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  953.568822]  crc_ccitt
�[  953.573349] Function entered at [<c073fe14>] from [<c031dd34>]
�[  953.573354] Function entered at [<c031dd34>] from [<c031dd88>]
�[  953.573360] Function entered at [<c031dd88>] from [<bf257584>]
�[  953.573371] Function entered at [<bf257584>] from [<bf25a558>]
�[  953.580643]  compat
[  953.583088] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  953.583093] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  953.583103] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  953.587952]  ledtrig_usbport
���[  953.590054] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  953.595974]  nf_log_ipv6
���[  953.601870] Function entered at [<c063b268>] from [<c063b9d4>]
�[  953.601875] Function entered at [<c063b9d4>] from [<c0720580>]
�[  953.601883] Function entered at [<c0720580>] from [<c0720614>]
�[  953.604312]  nf_log_common
�[  953.610228] Function entered at [<c0720614>] from [<c0720744>]
�[  953.616152]  ip6table_mangle
���[  953.622050] Function entered at [<c0720744>] from [<c0720798>]
�[  953.622054] Function entered at [<c0720798>] from [<c072097c>]
�[  953.622062] Function entered at [<c072097c>] from [<c071dfb8>]
�[  953.627958]  ip6table_filter
���[  953.630059] Function entered at [<c071dfb8>] from [<c063b268>]
�[  953.635980]  ip6_tables
[  953.641880] Function entered at [<c063b268>] from [<c063b9d4>]
�[  953.641885] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  953.641892] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  953.647787]  ip6t_REJECT
���[  953.650927] Function entered at [<c06a9920>] from [<c064645c>]
�[  953.656843]  x_tables
��[  953.659626] Function entered at [<c064645c>] from [<c0649910>]
�[  953.665541]  nf_reject_ipv6
[  953.671446] Function entered at [<c0649910>] from [<c036bdf0>]
�[  953.671452] Function entered at [<c036bdf0>] from [<c036c138>]
�[  953.671460] Function entered at [<c036c138>] from [<c0301520>]
�[  953.677353]  ip6_gre
���[  953.680146] Function entered at [<c0301520>] from [<c0321e38>]
�[  953.686063]  ip_gre
[  953.689192] Function entered at [<c0321e38>] from [<c035b318>]
�[  953.695107]  gre
���[  953.701012] Function entered at [<c035b318>] from [<c030140c>]
�[  953.701017] Function entered at [<c030140c>] from [<c030b30c>]
�[  953.701026] Exception stack(0xcf85df80 to 0xcf85dfc8)
��[  953.706922]  ip6_tunnel
[  953.710066] df80: 00000001 00000000 00000000 c0313960 ffffe000 c0a03cb8 c0a03c6c 00000000
��[  953.715976]  tunnel6
���[  953.718416] dfa0: 00000000 410fc075 00000000 00000000 cf85dfc8 cf85dfd0 c0307d88 c0307d8c
��[  953.724327]  ip_tunnel
�[  953.730235] dfc0: 60000013 ffffffff
[  953.736146]  mpls_iptunnel
�[  953.738934] Function entered at [<c030b30c>] from [<c0307d8c>]
�[  953.744843]  mpls_router
���[  953.747286] Function entered at [<c0307d8c>] from [<c0352068>]
�[  953.753196]  mpls_gso
��[  953.755985] Function entered at [<c0352068>] from [<c0352388>]
�[  953.761900]  leds_gpio
�[  953.767808] Function entered at [<c0352388>] from [<8030170c>]
�[  953.773716]  xhci_plat_hcd
�[  953.776230] ---[ end trace df518fc833e25373 ]---
���[  953.782070]  xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
��[  953.878456] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  953.886442] Hardware name: Generic DT based system
�[  953.894100] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  953.898968] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  953.906263] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  953.912174] Function entered at [<c073fe14>] from [<c031dd34>]
�[  953.918084] Function entered at [<c031dd34>] from [<c031dd88>]
�[  953.923997] Function entered at [<c031dd88>] from [<bf234d74>]
�[  953.929912] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  953.935823] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  953.941736] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  953.947648] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  953.953560] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  953.959471] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  953.965383] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  953.971294] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  953.977206] Function entered at [<c0634a90>] from [<c0634b74>]
�[  953.983117] Function entered at [<c0634b74>] from [<c0636b80>]
�[  953.989030] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  953.994941] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  954.000855] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  954.006764] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  954.012677] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  954.018588] Function entered at [<c0333bb0>] from [<c0339070>]
�[  954.024502] Function entered at [<c0339070>] from [<c03074a8>]
�[  954.030490] ---[ end trace df518fc833e25374 ]---
���[  954.036335] ------------[ cut here ]------------
���[  954.041218] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  954.046074] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  954.057555] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  954.111917]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  954.135367] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  954.147147] Hardware name: Generic DT based system
�[  954.154801] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  954.159669] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  954.166964] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  954.172875] Function entered at [<c073fe14>] from [<c031dd34>]
�[  954.178788] Function entered at [<c031dd34>] from [<c031dd88>]
�[  954.184699] Function entered at [<c031dd88>] from [<bf233718>]
�[  954.190612] Function entered at [<bf233718>] from [<bf23edf4>]
�[  954.196523] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  954.202435] Function entered at [<bf23d384>] from [<bf234a90>]
�[  954.208345] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  954.214256] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  954.220168] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  954.226081] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  954.231992] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  954.237904] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  954.241083] ------------[ cut here ]------------
���[  954.243822] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  954.249737] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  954.254600] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  954.254605] Function entered at [<c0634a90>] from [<c0634b74>]
�[  954.254609] Function entered at [<c0634b74>] from [<c0636b80>]
�[  954.254614] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  954.254622] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  954.260524] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  954.271979] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  954.271985] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  954.271990] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  954.271998] Function entered at [<c0333bb0>] from [<c0339070>]
�[  954.277891] Modules linked in:
�[  954.283802] Function entered at [<c0339070>] from [<c03074a8>]
�[  954.283876] ---[ end trace df518fc833e25375 ]---
���[  954.289715]  pppoe
�[  954.295642] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:b2:8e:25 tid 0
[  954.301541]  ppp_async ath10k_pci ath10k_core ath pppox
[  954.307811] ------------[ cut here ]------------
���[  954.313713]  ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state
[  954.319633] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  954.325535]  xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack
��[  954.331452] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  954.334581]  xt_comment
[  954.340489] Modules linked in:
�[  954.345358]  xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT
�[  954.347460]  pppoe
�[  954.355452]  slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6
[  954.360668]  ppp_async
�[  954.365548]  nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4
[  954.375287]  ath10k_pci
[  954.386742]  nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw
���[  954.393350]  ath10k_core
���[  954.399599]  nf_flow_table
�[  954.402051]  ath
���[  954.405179]  nf_defrag_ipv6
[  954.411095]  pppox
�[  954.413188]  nf_defrag_ipv4
[  954.420826]  ppp_generic
���[  954.423283]  nf_conntrack_rtcache nf_conntrack
�[  954.430913]  mac80211
��[  954.433366]  libcrc32c iptable_mangle iptable_filter
���[  954.439266]  iptable_nat
���[  954.442055]  ip_tables hwmon crc_ccitt compat
��[  954.444838]  ipt_REJECT
[  954.446931]  ledtrig_usbport
���[  954.449717]  ipt_MASQUERADE
[  954.451814]  nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
�[  954.454600]  cfg80211
��[  954.457388]  ip6_tables
[  954.461921]  xt_time
���[  954.464354]  ip6t_REJECT
���[  954.469565]  xt_tcpudp
�[  954.472361]  x_tables nf_reject_ipv6 ip6_gre
���[  954.476875]  xt_state
��[  954.479316]  ip_gre
[  954.482461]  xt_nat
[  954.485242]  gre
���[  954.491853]  xt_multiport
��[  954.494281]  ip6_tunnel
[  954.496719]  xt_mark
���[  954.499159]  tunnel6
���[  954.501959]  xt_mac
[  954.504391]  ip_tunnel
�[  954.508909]  xt_limit
��[  954.511356]  mpls_iptunnel mpls_router mpls_gso
[  954.513440]  xt_conntrack
��[  954.515533]  leds_gpio
�[  954.517627]  xt_comment
[  954.520412]  xhci_plat_hcd
�[  954.522865]  xt_TCPMSS
�[  954.525293]  xhci_pci
��[  954.527731]  xt_REDIRECT
���[  954.529824]  xhci_hcd
��[  954.532274]  xt_LOG
[  954.534706]  dwc3
��[  954.539226]  xt_FLOWOFFLOAD
[  954.542021]  dwc3_of_simple gpio_button_hotplug
[  954.544450]  xt_CT
�[  954.546891]  crc32c_generic
[  954.549677]  slhc
��[  954.552136] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.14.171 #0
[  954.554557]  openvswitch
���[  954.557344] Hardware name: Generic DT based system
�[  954.559781]  nf_reject_ipv4
[  954.561879] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  954.561885] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  954.561893] Function entered at [<c073fe14>] from [<c031dd34>]
�[  954.563968]  nf_nat_redirect
���[  954.566758] Function entered at [<c031dd34>] from [<c031dd88>]
�[  954.571293]  nf_nat_masquerade_ipv6
[  954.573371] Function entered at [<c031dd88>] from [<bf257584>]
�[  954.576154]  nf_nat_masquerade_ipv4
[  954.578258] Function entered at [<bf257584>] from [<bf25a558>]
�[  954.585556]  nf_conntrack_ipv6
�[  954.588342] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  954.593212]  nf_nat_ipv6
���[  954.596002] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  954.601917]  nf_conntrack_ipv4
�[  954.607825] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  954.613735]  nf_nat_ipv4
���[  954.616871] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  954.622784]  nf_nat
[  954.626267] Function entered at [<c063b268>] from [<c063b9d4>]
�[  954.632178]  nf_log_ipv4
���[  954.635658] Function entered at [<c063b9d4>] from [<c0720580>]
�[  954.641570]  nf_flow_table_hw
��[  954.644706] Function entered at [<c0720580>] from [<c0720614>]
�[  954.650610]  nf_flow_table
�[  954.653400] Function entered at [<c0720614>] from [<c0720744>]
�[  954.653405] Function entered at [<c0720744>] from [<c0720798>]
�[  954.653413] Function entered at [<c0720798>] from [<c072097c>]
�[  954.659308]  nf_defrag_ipv6
[  954.662446] Function entered at [<c072097c>] from [<c071dfb8>]
�[  954.662451] Function entered at [<c071dfb8>] from [<c063b268>]
�[  954.662456] Function entered at [<c063b268>] from [<c063b9d4>]
�[  954.662464] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  954.668350]  nf_defrag_ipv4
[  954.671143] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  954.671148] Function entered at [<c06a9920>] from [<c064645c>]
�[  954.671153] Function entered at [<c064645c>] from [<c0649910>]
�[  954.671161] Function entered at [<c0649910>] from [<c036bdf0>]
�[  954.677048]  nf_conntrack_rtcache
��[  954.679151] Function entered at [<c036bdf0>] from [<c036c138>]
�[  954.685067]  nf_conntrack
��[  954.687850] Function entered at [<c036c138>] from [<c0301520>]
�[  954.693760]  libcrc32c
�[  954.696896] Function entered at [<c0301520>] from [<c0321e38>]
�[  954.702806]  iptable_mangle
[  954.705596] Function entered at [<c0321e38>] from [<c035b318>]
�[  954.711510]  iptable_filter
[  954.717420] Function entered at [<c035b318>] from [<c030140c>]
�[  954.723329]  ip_tables
�[  954.726117] Function entered at [<c030140c>] from [<c030b30c>]
�[  954.732031]  hwmon
�[  954.737941] Exception stack(0xcf85df80 to 0xcf85dfc8)
��[  954.743856]  crc_ccitt
�[  954.749764] df80: 00000001 00000000 00000000 c0313960 ffffe000 c0a03cb8 c0a03c6c 00000000
��[  954.752554]  compat
[  954.758467] dfa0: 00000000 410fc075 00000000 00000000 cf85dfc8 cf85dfd0 c0307d88 c0307d8c
��[  954.764378]  ledtrig_usbport
���[  954.770286] dfc0: 60000013 ffffffff
[  954.776197]  nf_log_ipv6
���[  954.779679] Function entered at [<c030b30c>] from [<c0307d8c>]
�[  954.785589]  nf_log_common
�[  954.788378] Function entered at [<c0307d8c>] from [<c0352068>]
�[  954.794287]  ip6table_mangle
���[  954.796730] Function entered at [<c0352068>] from [<c0352388>]
�[  954.802639]  ip6table_filter
���[  954.805427] Function entered at [<c0352388>] from [<8030170c>]
�[  954.811337]  ip6_tables
[  954.814218] ---[ end trace df518fc833e25376 ]---
���[  954.820030]  ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
���[  954.906363] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  954.926828] Hardware name: Generic DT based system
�[  954.934485] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  954.939353] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  954.946647] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  954.952560] Function entered at [<c073fe14>] from [<c031dd34>]
�[  954.958471] Function entered at [<c031dd34>] from [<c031dd88>]
�[  954.964383] Function entered at [<c031dd88>] from [<bf234d74>]
�[  954.970298] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  954.976208] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  954.982120] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  954.988032] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  954.993942] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  954.999853] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  955.005765] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  955.011677] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  955.017589] Function entered at [<c0634a90>] from [<c0634b74>]
�[  955.023500] Function entered at [<c0634b74>] from [<c0636b80>]
�[  955.029412] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  955.035325] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  955.041240] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  955.047148] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  955.053062] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  955.058973] Function entered at [<c0333bb0>] from [<c0339070>]
�[  955.064887] Function entered at [<c0339070>] from [<c03074a8>]
�[  955.070882] ---[ end trace df518fc833e25377 ]---
���[  955.076724] ------------[ cut here ]------------
���[  955.081607] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  955.086461] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  955.097943] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  955.152306]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  955.175752] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  955.187533] Hardware name: Generic DT based system
�[  955.195189] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  955.200058] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  955.207352] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  955.213265] Function entered at [<c073fe14>] from [<c031dd34>]
�[  955.219177] Function entered at [<c031dd34>] from [<c031dd88>]
�[  955.225088] Function entered at [<c031dd88>] from [<bf233718>]
�[  955.231002] Function entered at [<bf233718>] from [<bf23edf4>]
�[  955.236914] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  955.242827] Function entered at [<bf23d384>] from [<bf234a90>]
�[  955.248737] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  955.254650] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  955.260563] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  955.266475] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  955.272386] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  955.278296] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  955.284210] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  955.290120] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  955.296034] Function entered at [<c0634a90>] from [<c0634b74>]
�[  955.301945] Function entered at [<c0634b74>] from [<c0636b80>]
�[  955.307856] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  955.313769] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  955.319681] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  955.325593] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  955.331505] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  955.337417] Function entered at [<c0333bb0>] from [<c0339070>]
�[  955.343330] Function entered at [<c0339070>] from [<c03074a8>]
�[  955.349324] ---[ end trace df518fc833e25378 ]---
���[  955.355174] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:fc:66:25 tid 0
[  955.360042] ------------[ cut here ]------------
���[  955.368047] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  955.372913] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  955.384370] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  955.438737]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  955.462192] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  955.473971] Hardware name: Generic DT based system
�[  955.481625] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  955.486494] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  955.493787] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  955.499701] Function entered at [<c073fe14>] from [<c031dd34>]
�[  955.505612] Function entered at [<c031dd34>] from [<c031dd88>]
�[  955.511526] Function entered at [<c031dd88>] from [<bf234d74>]
�[  955.517439] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  955.523351] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  955.529262] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  955.535174] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  955.541083] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  955.546996] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  955.552908] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  955.558820] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  955.564730] Function entered at [<c0634a90>] from [<c0634b74>]
�[  955.570642] Function entered at [<c0634b74>] from [<c0636b80>]
�[  955.576553] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  955.582465] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  955.588378] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  955.594289] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  955.600202] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  955.606112] Function entered at [<c0333bb0>] from [<c0339070>]
�[  955.612024] Function entered at [<c0339070>] from [<c03074a8>]
�[  955.618027] ---[ end trace df518fc833e25379 ]---
���[  955.623859] ------------[ cut here ]------------
���[  955.628725] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  955.633619] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  955.645072] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  955.699442]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  955.722896] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  955.734672] Hardware name: Generic DT based system
�[  955.742325] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  955.747196] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  955.754489] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  955.760402] Function entered at [<c073fe14>] from [<c031dd34>]
�[  955.766314] Function entered at [<c031dd34>] from [<c031dd88>]
�[  955.772224] Function entered at [<c031dd88>] from [<bf233718>]
�[  955.778137] Function entered at [<bf233718>] from [<bf23edf4>]
�[  955.784048] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  955.789960] Function entered at [<bf23d384>] from [<bf234a90>]
�[  955.795871] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  955.801784] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  955.807695] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  955.813607] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  955.819517] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  955.825429] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  955.831341] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  955.837251] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  955.843163] Function entered at [<c0634a90>] from [<c0634b74>]
�[  955.849075] Function entered at [<c0634b74>] from [<c0636b80>]
�[  955.854987] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  955.860900] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  955.866814] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  955.872724] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  955.878637] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  955.884549] Function entered at [<c0333bb0>] from [<c0339070>]
�[  955.890461] Function entered at [<c0339070>] from [<c03074a8>]
�[  955.896462] ---[ end trace df518fc833e2537a ]---
���[  955.902300] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:1d:c6:25 tid 0
[  955.907175] ------------[ cut here ]------------
���[  955.915179] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  955.920030] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  955.931511] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  955.985878]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  956.009340] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  956.021105] Hardware name: Generic DT based system
�[  956.028761] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  956.033630] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  956.040924] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  956.046836] Function entered at [<c073fe14>] from [<c031dd34>]
�[  956.052748] Function entered at [<c031dd34>] from [<c031dd88>]
�[  956.058660] Function entered at [<c031dd88>] from [<bf234d74>]
�[  956.064573] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  956.070482] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  956.076394] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  956.082308] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  956.088219] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  956.094130] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  956.100042] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  956.105953] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  956.111864] Function entered at [<c0634a90>] from [<c0634b74>]
�[  956.117776] Function entered at [<c0634b74>] from [<c0636b80>]
�[  956.123688] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  956.129600] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  956.135515] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  956.141424] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  956.147337] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  956.153248] Function entered at [<c0333bb0>] from [<c0339070>]
�[  956.159161] Function entered at [<c0339070>] from [<c03074a8>]
�[  956.165156] ---[ end trace df518fc833e2537b ]---
���[  956.170986] ------------[ cut here ]------------
���[  956.175884] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  956.180735] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  956.192212] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  956.246578]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  956.270027] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  956.281806] Hardware name: Generic DT based system
�[  956.289462] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  956.294331] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  956.301626] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  956.307538] Function entered at [<c073fe14>] from [<c031dd34>]
�[  956.313449] Function entered at [<c031dd34>] from [<c031dd88>]
�[  956.319359] Function entered at [<c031dd88>] from [<bf233718>]
�[  956.325272] Function entered at [<bf233718>] from [<bf23edf4>]
�[  956.331184] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  956.337098] Function entered at [<bf23d384>] from [<bf234a90>]
�[  956.343008] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  956.348920] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  956.354832] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  956.360745] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  956.366657] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  956.372569] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  956.378480] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  956.384391] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  956.390304] Function entered at [<c0634a90>] from [<c0634b74>]
�[  956.396214] Function entered at [<c0634b74>] from [<c0636b80>]
�[  956.402126] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  956.408039] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  956.413952] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  956.419863] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  956.425774] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  956.431688] Function entered at [<c0333bb0>] from [<c0339070>]
�[  956.437601] Function entered at [<c0339070>] from [<c03074a8>]
�[  956.443600] ---[ end trace df518fc833e2537c ]---
���[  956.449424] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:b9:9e:25 tid 0
[  956.454333] ------------[ cut here ]------------
���[  956.462314] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  956.467169] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  956.478642] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  956.533017]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  956.556459] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  956.568242] Hardware name: Generic DT based system
�[  956.575897] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  956.580765] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  956.588060] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  956.593972] Function entered at [<c073fe14>] from [<c031dd34>]
�[  956.599884] Function entered at [<c031dd34>] from [<c031dd88>]
�[  956.605795] Function entered at [<c031dd88>] from [<bf234d74>]
�[  956.611708] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  956.617618] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  956.623531] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  956.629445] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  956.635356] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  956.641268] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  956.647182] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  956.653091] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  956.659003] Function entered at [<c0634a90>] from [<c0634b74>]
�[  956.664915] Function entered at [<c0634b74>] from [<c0636b80>]
�[  956.670827] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  956.676741] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  956.682653] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  956.688565] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  956.694475] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  956.700387] Function entered at [<c0333bb0>] from [<c0339070>]
�[  956.706300] Function entered at [<c0339070>] from [<c03074a8>]
�[  956.712296] ---[ end trace df518fc833e2537d ]---
���[  956.718123] ------------[ cut here ]------------
���[  956.723021] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  956.727872] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  956.739346] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  956.793715]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  956.817164] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  956.828943] Hardware name: Generic DT based system
�[  956.836598] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  956.841465] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  956.848760] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  956.854670] Function entered at [<c073fe14>] from [<c031dd34>]
�[  956.860582] Function entered at [<c031dd34>] from [<c031dd88>]
�[  956.866496] Function entered at [<c031dd88>] from [<bf233718>]
�[  956.872409] Function entered at [<bf233718>] from [<bf23edf4>]
�[  956.878319] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  956.884232] Function entered at [<bf23d384>] from [<bf234a90>]
�[  956.890142] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  956.896054] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  956.901967] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  956.907880] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  956.913789] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  956.919702] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  956.925615] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  956.931525] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  956.937437] Function entered at [<c0634a90>] from [<c0634b74>]
�[  956.943348] Function entered at [<c0634b74>] from [<c0636b80>]
�[  956.949259] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  956.955172] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  956.961084] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  956.966996] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  956.972907] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  956.978819] Function entered at [<c0333bb0>] from [<c0339070>]
�[  956.984732] Function entered at [<c0339070>] from [<c03074a8>]
�[  956.990734] ---[ end trace df518fc833e2537e ]---
���[  956.996569] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:48:f9:25 tid 0
[  957.001461] ------------[ cut here ]------------
���[  957.009430] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  957.014324] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  957.025779] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  957.080148]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  957.103604] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  957.115379] Hardware name: Generic DT based system
�[  957.123035] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  957.127902] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  957.135197] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  957.141108] Function entered at [<c073fe14>] from [<c031dd34>]
�[  957.147021] Function entered at [<c031dd34>] from [<c031dd88>]
�[  957.152932] Function entered at [<c031dd88>] from [<bf234d74>]
�[  957.158846] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  957.164757] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  957.170670] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  957.176583] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  957.182494] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  957.188405] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  957.194319] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  957.200229] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  957.206141] Function entered at [<c0634a90>] from [<c0634b74>]
�[  957.212053] Function entered at [<c0634b74>] from [<c0636b80>]
�[  957.217965] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  957.223877] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  957.229790] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  957.235701] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  957.241612] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  957.247524] Function entered at [<c0333bb0>] from [<c0339070>]
�[  957.253438] Function entered at [<c0339070>] from [<c03074a8>]
�[  957.259427] ---[ end trace df518fc833e2537f ]---
���[  957.265270] ------------[ cut here ]------------
���[  957.270138] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  957.275027] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  957.286483] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  957.338121] ------------[ cut here ]------------
���[  957.340868]  mpls_router mpls_gso
��[  957.364306] WARNING: CPU: 3 PID: 1471 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
���[  957.364314] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  957.369133]  leds_gpio
�[  957.372644] Modules linked in:
�[  957.384440]  xhci_plat_hcd xhci_pci xhci_hcd
���[  957.390687]  pppoe
�[  957.393133]  dwc3 dwc3_of_simple
���[  957.396263]  ppp_async
�[  957.400781]  gpio_button_hotplug
���[  957.402887]  ath10k_pci
[  957.406356]  crc32c_generic
[  957.408797]  ath10k_core
���[  957.414718]  ath pppox
�[  957.417509] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  957.417515] Hardware name: Generic DT based system
�[  957.420290]  ppp_generic
���[  957.422748] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  957.430381]  mac80211
��[  957.435253] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  957.435264] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  957.438043]  iptable_nat
���[  957.445336] Function entered at [<c073fe14>] from [<c031dd34>]
�[  957.445342] Function entered at [<c031dd34>] from [<c031dd88>]
�[  957.445349] Function entered at [<c031dd88>] from [<bf233718>]
�[  957.447780]  ipt_REJECT
[  957.453693] Function entered at [<bf233718>] from [<bf23edf4>]
�[  957.453699] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  957.453707] Function entered at [<bf23d384>] from [<bf234a90>]
�[  957.459599]  ipt_MASQUERADE
[  957.462391] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  957.462397] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  957.462405] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  957.468302]  cfg80211
��[  957.474215] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  957.474221] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  957.474229] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  957.480120]  xt_time
���[  957.482565] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  957.482570] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  957.482579] Function entered at [<c0634a90>] from [<c0634b74>]
�[  957.488477]  xt_tcpudp
�[  957.494388] Function entered at [<c0634b74>] from [<c0636b80>]
�[  957.494394] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  957.494402] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  957.500295]  xt_state
��[  957.503088] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  957.503094] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  957.503102] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  957.508998]  xt_nat
[  957.514910] Function entered at [<c0333bb0>] from [<c0339070>]
�[  957.514916] Function entered at [<c0339070>] from [<c03074a8>]
�[  957.514980] ---[ end trace df518fc833e25380 ]---
���[  957.520818]  xt_multiport
��[  957.523279] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:a9:90:25 tid 0
[  957.529175]  xt_mark
���[  957.535117] ------------[ cut here ]------------
���[  957.540993]  xt_mac
[  957.543461] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  957.549351]  xt_limit
��[  957.555277] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  957.561173]  xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT
�[  957.563615] Modules linked in:
�[  957.569527]  xt_LOG
[  957.575450]  pppoe
�[  957.581349]  xt_FLOWOFFLOAD xt_CT slhc
�[  957.583791]  ppp_async
�[  957.589702]  openvswitch
���[  957.595626]  ath10k_pci
[  957.601523]  nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6
�[  957.603618]  ath10k_core
���[  957.609529]  nf_nat_masquerade_ipv4
[  957.615454]  ath
���[  957.620307]  nf_conntrack_ipv6
�[  957.623114]  pppox
�[  957.631090]  nf_nat_ipv6 nf_conntrack_ipv4
�[  957.633531]  ppp_generic
���[  957.638397]  nf_nat_ipv4
���[  957.640505]  mac80211
��[  957.651975]  nf_nat nf_log_ipv4
[  957.654404]  iptable_nat
���[  957.660660]  nf_flow_table_hw
��[  957.666235]  ipt_REJECT
[  957.669353]  nf_flow_table
�[  957.671461]  ipt_MASQUERADE
[  957.673544]  nf_defrag_ipv6
[  957.677368]  cfg80211
��[  957.679809]  nf_defrag_ipv4
[  957.682610]  xt_time
���[  957.685043]  nf_conntrack_rtcache
��[  957.691310]  xt_tcpudp
�[  957.694084]  nf_conntrack
��[  957.697562]  xt_state
��[  957.699656]  libcrc32c
�[  957.702804]  xt_nat
[  957.704886]  iptable_mangle
[  957.709059]  xt_multiport
��[  957.711862]  iptable_filter
[  957.714631]  xt_mark
���[  957.717073]  ip_tables
�[  957.720205]  xt_mac
[  957.723002]  hwmon crc_ccitt
���[  957.726125]  xt_limit
��[  957.728564]  compat
[  957.731369]  xt_conntrack
��[  957.734141]  ledtrig_usbport
���[  957.736926]  xt_comment
[  957.739366]  nf_log_ipv6
���[  957.742165]  xt_TCPMSS
�[  957.744593]  nf_log_common
�[  957.748074]  xt_REDIRECT
���[  957.750513]  ip6table_mangle
���[  957.753312]  xt_LOG
[  957.755740]  ip6table_filter
���[  957.758177]  xt_FLOWOFFLOAD
[  957.760270]  ip6_tables
[  957.763074]  xt_CT
�[  957.765845]  ip6t_REJECT
���[  957.768629]  slhc
��[  957.771077]  x_tables nf_reject_ipv6 ip6_gre ip_gre
[  957.773509]  openvswitch
���[  957.775602]  gre
���[  957.778736]  nf_reject_ipv4
[  957.781185]  ip6_tunnel tunnel6
[  957.783268]  nf_nat_redirect
���[  957.786056]  ip_tunnel
�[  957.789189]  nf_nat_masquerade_ipv6
[  957.791645]  mpls_iptunnel
�[  957.794415]  nf_nat_masquerade_ipv4
[  957.796857]  mpls_router
���[  957.799644]  nf_conntrack_ipv6
�[  957.802442]  mpls_gso leds_gpio
[  957.805564]  nf_nat_ipv6
���[  957.807657]  xhci_plat_hcd
�[  957.810792]  nf_conntrack_ipv4
�[  957.813594]  xhci_pci
��[  957.816017]  nf_nat_ipv4
���[  957.818110]  xhci_hcd
��[  957.820895]  nf_nat
[  957.823002]  dwc3 dwc3_of_simple
���[  957.827860]  nf_log_ipv4
���[  957.830645]  gpio_button_hotplug
���[  957.832754]  nf_flow_table_hw
��[  957.835527]  crc32c_generic
[  957.838660]  nf_flow_table
�[  957.841814] CPU: 3 PID: 1471 Comm: dnsmasq Tainted: G        W       4.14.171 #0
���[  957.844234]  nf_defrag_ipv6
[  957.847715] Hardware name: Generic DT based system
�[  957.850502]  nf_defrag_ipv4
[  957.853990] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  957.854000] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  957.856770]  nf_conntrack_rtcache
��[  957.859906] Function entered at [<c073fe14>] from [<c031dd34>]
�[  957.863048]  nf_conntrack
��[  957.865826] Function entered at [<c031dd34>] from [<c031dd88>]
�[  957.868611]  libcrc32c
�[  957.871745] Function entered at [<c031dd88>] from [<bf257584>]
�[  957.871756] Function entered at [<bf257584>] from [<bf25a558>]
�[  957.874185]  iptable_mangle
[  957.876975] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  957.879410]  iptable_filter
[  957.881506] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  957.881511] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  957.881521] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  957.884984]  ip_tables
�[  957.887776] Function entered at [<c063b268>] from [<c063b9d4>]
�[  957.891266]  hwmon
�[  957.894391] Function entered at [<c063b9d4>] from [<c0720580>]
�[  957.897175]  crc_ccitt
�[  957.899972] Function entered at [<c0720580>] from [<c0720614>]
�[  957.907617]  compat
[  957.910404] Function entered at [<c0720614>] from [<c0720744>]
�[  957.915273]  ledtrig_usbport
���[  957.918062] Function entered at [<c0720744>] from [<c0720798>]
�[  957.923977]  nf_log_ipv6
���[  957.929881] Function entered at [<c0720798>] from [<c072097c>]
�[  957.933369]  nf_log_common
�[  957.939275] Function entered at [<c072097c>] from [<c071dfb8>]
�[  957.942069]  ip6table_mangle
���[  957.947972] Function entered at [<c071dfb8>] from [<c063b268>]
�[  957.950415]  ip6table_filter
���[  957.956327] Function entered at [<c063b268>] from [<c063b9d4>]
�[  957.956332] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  957.956339] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  957.962238]  ip6_tables
[  957.965027] Function entered at [<c06a9920>] from [<c064645c>]
�[  957.970931]  ip6t_REJECT
���[  957.973723] Function entered at [<c064645c>] from [<c0649504>]
�[  957.973728] Function entered at [<c0649504>] from [<c06495fc>]
�[  957.973733] Function entered at [<c06495fc>] from [<c067c5f8>]
�[  957.973741] Function entered at [<c067c5f8>] from [<c067d11c>]
�[  957.979634]  x_tables
��[  957.985545] Function entered at [<c067d11c>] from [<c067d8c4>]
�[  957.985550] Function entered at [<c067d8c4>] from [<c06a3e94>]
�[  957.985555] Function entered at [<c06a3e94>] from [<c06a5da8>]
�[  957.985563] Function entered at [<c06a5da8>] from [<c061f1e4>]
�[  957.991456]  nf_reject_ipv6
[  957.993900] Function entered at [<c061f1e4>] from [<c03073c0>]
�[  957.999801]  ip6_gre
���[  958.001970] ---[ end trace df518fc833e25381 ]---
���[  958.007807]  ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
���[  958.157432] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  958.174084] Hardware name: Generic DT based system
�[  958.181743] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  958.186609] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  958.193904] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  958.199816] Function entered at [<c073fe14>] from [<c031dd34>]
�[  958.205726] Function entered at [<c031dd34>] from [<c031dd88>]
�[  958.211637] Function entered at [<c031dd88>] from [<bf234d74>]
�[  958.217552] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  958.223461] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  958.229374] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  958.235286] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  958.241196] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  958.247107] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  958.253019] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  958.258930] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  958.264843] Function entered at [<c0634a90>] from [<c0634b74>]
�[  958.270754] Function entered at [<c0634b74>] from [<c0636b80>]
�[  958.276667] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  958.282578] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  958.288491] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  958.294401] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  958.300312] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  958.306224] Function entered at [<c0333bb0>] from [<c0339070>]
�[  958.312136] Function entered at [<c0339070>] from [<c03074a8>]
�[  958.318134] ---[ end trace df518fc833e25382 ]---
���[  958.323972] ------------[ cut here ]------------
���[  958.328835] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  958.333726] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  958.345183] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  958.399554]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  958.411098] ------------[ cut here ]------------
���[  958.423007] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  958.434797] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  958.439657] Hardware name: Generic DT based system
�[  958.447322] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  958.458777] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  958.458791] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  958.463644] Modules linked in:
�[  958.469903] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  958.477211]  pppoe
�[  958.483109] Function entered at [<c073fe14>] from [<c031dd34>]
�[  958.483116] Function entered at [<c031dd34>] from [<c031dd88>]
�[  958.486246]  ppp_async
�[  958.492151] Function entered at [<c031dd88>] from [<bf233718>]
�[  958.492158] Function entered at [<bf233718>] from [<bf23edf4>]
�[  958.492166] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  958.494250]  ath10k_pci
[  958.500163] Function entered at [<bf23d384>] from [<bf234a90>]
�[  958.506074]  ath10k_core
���[  958.508516] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  958.514428]  ath
���[  958.520339] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  958.526245]  pppox
�[  958.528689] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  958.534596]  ppp_generic
���[  958.537387] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  958.543292]  mac80211
��[  958.545391] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  958.551296]  iptable_nat
���[  958.553395] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  958.559298]  ipt_REJECT
[  958.562089] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  958.562096] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  958.567997]  ipt_MASQUERADE
[  958.570444] Function entered at [<c0634a90>] from [<c0634b74>]
�[  958.576355]  cfg80211
��[  958.579141] Function entered at [<c0634b74>] from [<c0636b80>]
�[  958.585049]  xt_time
���[  958.587494] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  958.593406]  xt_tcpudp
�[  958.599312] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  958.602104]  xt_state
��[  958.608010] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  958.610452]  xt_nat
[  958.616359] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  958.616367] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  958.618804]  xt_multiport
��[  958.624709] Function entered at [<c0333bb0>] from [<c0339070>]
�[  958.624715] Function entered at [<c0339070>] from [<c03074a8>]
�[  958.624815] ---[ end trace df518fc833e25383 ]---
���[  958.627155]  xt_mark
���[  958.633078] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:a6:f5:25 tid 0
[  958.635505]  xt_mac
[  958.641444] ------------[ cut here ]------------
���[  958.643514]  xt_limit
��[  958.649435] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  958.655333]  xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD
���[  958.658126] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  958.664039]  xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6
��[  958.669946] Modules linked in:
�[  958.674815]  nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4
[  958.677261]  pppoe
�[  958.685249]  nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table
�[  958.687344]  ppp_async
�[  958.692212]  nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack
���[  958.694664]  ath10k_pci
[  958.706127]  libcrc32c iptable_mangle iptable_filter ip_tables
�[  958.713774]  ath10k_core
���[  958.720031]  hwmon
�[  958.728375]  ath
���[  958.731508]  crc_ccitt compat ledtrig_usbport nf_log_ipv6
��[  958.739145]  pppox
�[  958.741251]  nf_log_common ip6table_mangle
�[  958.748192]  ppp_generic
���[  958.750639]  ip6table_filter
���[  958.757942]  mac80211
��[  958.760377]  ip6_tables
[  958.766295]  iptable_nat
���[  958.769068]  ip6t_REJECT
���[  958.771173]  ipt_REJECT
[  958.773260]  x_tables
��[  958.778818]  ipt_MASQUERADE
[  958.780913]  nf_reject_ipv6
[  958.785099]  cfg80211
��[  958.787875]  ip6_gre
���[  958.791018]  xt_time
���[  958.793445]  ip_gre
[  958.795888]  xt_tcpudp
�[  958.798675]  gre
���[  958.801474]  xt_state
��[  958.803902]  ip6_tunnel
[  958.806341]  xt_nat
[  958.809128]  tunnel6
���[  958.811927]  xt_multiport
��[  958.814354]  ip_tunnel
�[  958.816795]  xt_mark
���[  958.819235]  mpls_iptunnel
�[  958.821345]  xt_mac
[  958.823769]  mpls_router
���[  958.825860]  xt_limit
��[  958.828300]  mpls_gso
��[  958.830739]  xt_conntrack
��[  958.832846]  leds_gpio xhci_plat_hcd
���[  958.835273]  xt_comment
[  958.838058]  xhci_pci
��[  958.840498]  xt_TCPMSS
�[  958.842948]  xhci_hcd dwc3
�[  958.845726]  xt_REDIRECT
���[  958.847819]  dwc3_of_simple
[  958.850605]  xt_LOG
[  958.853056]  gpio_button_hotplug crc32c_generic
[  958.855486]  xt_FLOWOFFLOAD
[  958.862111]  xt_CT
�[  958.864545] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.14.171 #0
[  958.866977]  slhc
��[  958.869418] Hardware name: Generic DT based system
�[  958.872214]  openvswitch
���[  958.874998] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  958.877777]  nf_reject_ipv4
[  958.879875] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  958.884408]  nf_nat_redirect
���[  958.887183] Function entered at [<c073fe14>] from [<c031dd34>]
�[  958.889281]  nf_nat_masquerade_ipv6
[  958.896573] Function entered at [<c031dd34>] from [<c031dd88>]
�[  958.896579] Function entered at [<c031dd88>] from [<bf257584>]
�[  958.896588] Function entered at [<bf257584>] from [<bf25a558>]
�[  958.898671]  nf_nat_masquerade_ipv4
[  958.903538] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  958.903544] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  958.903554] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  958.906330]  nf_conntrack_ipv6
�[  958.912237] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  958.912243] Function entered at [<c063b268>] from [<c063b9d4>]
�[  958.912248] Function entered at [<c063b9d4>] from [<c0720580>]
�[  958.912256] Function entered at [<c0720580>] from [<c0720614>]
�[  958.915029]  nf_nat_ipv6
���[  958.920938] Function entered at [<c0720614>] from [<c0720744>]
�[  958.924086]  nf_conntrack_ipv4
�[  958.929984] Function entered at [<c0720744>] from [<c0720798>]
�[  958.933475]  nf_nat_ipv4
���[  958.939383] Function entered at [<c0720798>] from [<c072097c>]
�[  958.945297]  nf_nat
[  958.951201] Function entered at [<c072097c>] from [<c071dfb8>]
�[  958.951206] Function entered at [<c071dfb8>] from [<c063b268>]
�[  958.951214] Function entered at [<c063b268>] from [<c063b9d4>]
�[  958.954686]  nf_log_ipv4
���[  958.960601] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  958.966530]  nf_flow_table_hw
��[  958.972416] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  958.972421] Function entered at [<c06a9920>] from [<c064645c>]
�[  958.972429] Function entered at [<c064645c>] from [<c0649910>]
�[  958.975555]  nf_flow_table
�[  958.981467] Function entered at [<c0649910>] from [<c036bdf0>]
�[  958.981473] Function entered at [<c036bdf0>] from [<c036c138>]
�[  958.981478] Function entered at [<c036c138>] from [<c0301520>]
�[  958.981486] Function entered at [<c0301520>] from [<c0321e38>]
�[  958.987380]  nf_defrag_ipv6
[  958.993290] Function entered at [<c0321e38>] from [<c035b318>]
�[  958.993296] Function entered at [<c035b318>] from [<c030140c>]
�[  958.993301] Function entered at [<c030140c>] from [<c030b30c>]
�[  958.993311] Exception stack(0xcf85df80 to 0xcf85dfc8)
��[  958.999199]  nf_defrag_ipv4
[  959.001998] df80: 00000001 00000000 00000000 c0313960 ffffe000 c0a03cb8 c0a03c6c 00000000
��[  959.002009] dfa0: 00000000 410fc075 00000000 00000000 cf85dfc8 cf85dfd0 c0307d88 c0307d8c
��[  959.007897]  nf_conntrack_rtcache
��[  959.011034] dfc0: 60000013 ffffffff
[  959.011040] Function entered at [<c030b30c>] from [<c0307d8c>]
�[  959.011049] Function entered at [<c0307d8c>] from [<c0352068>]
�[  959.016942]  nf_conntrack
��[  959.019735] Function entered at [<c0352068>] from [<c0352388>]
�[  959.025649]  libcrc32c
�[  959.027741] Function entered at [<c0352388>] from [<8030170c>]
�[  959.033656]  iptable_mangle
[  959.039619] ---[ end trace df518fc833e25384 ]---
���[  959.045474]  iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
��[  959.198701] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  959.222138] Hardware name: Generic DT based system
�[  959.229796] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  959.234661] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  959.241958] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  959.247870] Function entered at [<c073fe14>] from [<c031dd34>]
�[  959.253784] Function entered at [<c031dd34>] from [<c031dd88>]
�[  959.259695] Function entered at [<c031dd88>] from [<bf234d74>]
�[  959.265610] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  959.271519] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  959.277432] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  959.283345] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  959.289255] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  959.295167] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  959.301077] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  959.306989] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  959.312902] Function entered at [<c0634a90>] from [<c0634b74>]
�[  959.318813] Function entered at [<c0634b74>] from [<c0636b80>]
�[  959.324726] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  959.330637] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  959.336552] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  959.342461] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  959.348374] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  959.354284] Function entered at [<c0333bb0>] from [<c0339070>]
�[  959.360198] Function entered at [<c0339070>] from [<c03074a8>]
�[  959.366189] ---[ end trace df518fc833e25385 ]---
���[  959.372031] ------------[ cut here ]------------
���[  959.376897] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  959.381789] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  959.393242] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  959.441082] ------------[ cut here ]------------
���[  959.447620]  mpls_router
���[  959.471051] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  959.471060] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  959.475894]  mpls_gso
��[  959.478694] Modules linked in:
�[  959.490165]  leds_gpio
�[  959.496408]  pppoe ppp_async
���[  959.498847]  xhci_plat_hcd
�[  959.501988]  ath10k_pci ath10k_core ath
[  959.504422]  xhci_pci
��[  959.507554]  pppox
�[  959.510341]  xhci_hcd
��[  959.514170]  ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE
[  959.516607]  dwc3
��[  959.518700]  cfg80211
��[  959.521160]  dwc3_of_simple
[  959.527747]  xt_time
���[  959.529838]  gpio_button_hotplug
���[  959.532288]  xt_tcpudp xt_state
[  959.535066]  crc32c_generic
[  959.537507]  xt_nat
[  959.544129]  xt_multiport xt_mark xt_mac xt_limit
��[  959.546912] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  959.546919] Hardware name: Generic DT based system
�[  959.549004]  xt_conntrack
��[  959.553887] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  959.561525]  xt_comment
[  959.566393] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  959.569183]  xt_TCPMSS
�[  959.576475] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  959.576480] Function entered at [<c073fe14>] from [<c031dd34>]
�[  959.576488] Function entered at [<c031dd34>] from [<c031dd88>]
�[  959.578920]  xt_REDIRECT
���[  959.584829] Function entered at [<c031dd88>] from [<bf233718>]
�[  959.584836] Function entered at [<bf233718>] from [<bf23edf4>]
�[  959.584843] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  959.587273]  xt_LOG
[  959.593187] Function entered at [<bf23d384>] from [<bf234a90>]
�[  959.593192] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  959.593200] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  959.599098]  xt_FLOWOFFLOAD
[  959.605005] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  959.605011] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  959.605019] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  959.607796]  xt_CT
�[  959.613708] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  959.613714] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  959.613721] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  959.619618]  slhc
��[  959.625525] Function entered at [<c0634a90>] from [<c0634b74>]
�[  959.625530] Function entered at [<c0634b74>] from [<c0636b80>]
�[  959.625537] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  959.627624]  openvswitch
���[  959.633537] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  959.633543] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  959.633551] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  959.639448]  nf_reject_ipv4
[  959.645354] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  959.645359] Function entered at [<c0333bb0>] from [<c0339070>]
�[  959.645367] Function entered at [<c0339070>] from [<c03074a8>]
�[  959.648147]  nf_nat_redirect
���[  959.654114] ---[ end trace df518fc833e25386 ]---
���[  959.659973]  nf_nat_masquerade_ipv6
[  959.665891] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:d7:b4:25 tid 0
[  959.667979]  nf_nat_masquerade_ipv4
[  959.673931] ------------[ cut here ]------------
���[  959.679804]  nf_conntrack_ipv6
�[  959.685736] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  959.687808]  nf_nat_ipv6
���[  959.693736] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  959.699631]  nf_conntrack_ipv4
�[  959.705557] Modules linked in:
�[  959.708333]  nf_nat_ipv4
���[  959.714257]  pppoe
�[  959.720156]  nf_nat
[  959.726076]  ppp_async
�[  959.728856]  nf_log_ipv4
���[  959.734779]  ath10k_pci
[  959.740680]  nf_flow_table_hw
��[  959.746599]  ath10k_core
���[  959.749724]  nf_flow_table
�[  959.754602]  ath
���[  959.758077]  nf_defrag_ipv6
[  959.766079]  pppox
�[  959.769550]  nf_defrag_ipv4
[  959.774431]  ppp_generic
���[  959.777564]  nf_conntrack_rtcache
��[  959.789029]  mac80211
��[  959.791814]  nf_conntrack libcrc32c iptable_mangle iptable_filter
��[  959.798066]  iptable_nat
���[  959.801206]  ip_tables hwmon
���[  959.804333]  ipt_REJECT
[  959.807117]  crc_ccitt
�[  959.809210]  ipt_MASQUERADE
[  959.811307]  compat ledtrig_usbport nf_log_ipv6 nf_log_common
��[  959.813745]  cfg80211
��[  959.816531]  ip6table_mangle
���[  959.818972]  xt_time
���[  959.822113]  ip6table_filter ip6_tables
[  959.824892]  xt_tcpudp
�[  959.827677]  ip6t_REJECT
���[  959.829770]  xt_state
��[  959.832566]  x_tables nf_reject_ipv6
���[  959.834650]  xt_nat
[  959.837436]  ip6_gre
���[  959.840224]  xt_multiport
��[  959.843719]  ip_gre
[  959.846149]  xt_mark
���[  959.852411]  gre ip6_tunnel tunnel6
[  959.855190]  xt_mac
[  959.858321]  ip_tunnel
�[  959.860761]  xt_limit
��[  959.863208]  mpls_iptunnel mpls_router
�[  959.865993]  xt_conntrack
��[  959.871905]  mpls_gso leds_gpio xhci_plat_hcd
��[  959.874340]  xt_comment
[  959.877472]  xhci_pci
��[  959.879914]  xt_TCPMSS
�[  959.883743]  xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
���[  959.886180]  xt_REDIRECT
���[  959.891420]  xt_LOG
[  959.895240] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.14.171 #0
[  959.897327]  xt_FLOWOFFLOAD
[  959.899770] Hardware name: Generic DT based system
�[  959.902566]  xt_CT
�[  959.904653] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  959.907089]  slhc
��[  959.910571] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  959.912667]  openvswitch
���[  959.915103] Function entered at [<c073fe14>] from [<c031dd34>]
�[  959.917541]  nf_reject_ipv4
[  959.921368] Function entered at [<c031dd34>] from [<c031dd88>]
�[  959.921374] Function entered at [<c031dd88>] from [<bf257584>]
�[  959.921382] Function entered at [<bf257584>] from [<bf25a558>]
�[  959.924157]  nf_nat_redirect
���[  959.928678] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  959.931127]  nf_nat_masquerade_ipv6
[  959.933557] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  959.936003]  nf_nat_masquerade_ipv4
[  959.943297] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  959.943303] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  959.943310] Function entered at [<c063b268>] from [<c063b9d4>]
�[  959.946082]  nf_conntrack_ipv6
�[  959.948186] Function entered at [<c063b9d4>] from [<c0720580>]
�[  959.955488]  nf_nat_ipv6
���[  959.958271] Function entered at [<c0720580>] from [<c0720614>]
�[  959.963147]  nf_conntrack_ipv4
�[  959.965236] Function entered at [<c0720614>] from [<c0720744>]
�[  959.971145]  nf_nat_ipv4
���[  959.973240] Function entered at [<c0720744>] from [<c0720798>]
�[  959.979144]  nf_nat
[  959.981935] Function entered at [<c0720798>] from [<c072097c>]
�[  959.981940] Function entered at [<c072097c>] from [<c071dfb8>]
�[  959.981947] Function entered at [<c071dfb8>] from [<c063b268>]
�[  959.987842]  nf_log_ipv4
���[  959.990636] Function entered at [<c063b268>] from [<c063b9d4>]
�[  959.996558]  nf_flow_table_hw
��[  960.002457] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  960.002463] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  960.002467] Function entered at [<c06a9920>] from [<c064645c>]
�[  960.002475] Function entered at [<c064645c>] from [<c0649910>]
�[  960.008365]  nf_flow_table
�[  960.011502] Function entered at [<c0649910>] from [<c036bdf0>]
�[  960.011508] Function entered at [<c036bdf0>] from [<c036c138>]
�[  960.011513] Function entered at [<c036c138>] from [<c0301520>]
�[  960.011521] Function entered at [<c0301520>] from [<c0321e38>]
�[  960.017408]  nf_defrag_ipv6
[  960.020897] Function entered at [<c0321e38>] from [<c035b318>]
�[  960.026814]  nf_defrag_ipv4
[  960.030291] Function entered at [<c035b318>] from [<c030140c>]
�[  960.036207]  nf_conntrack_rtcache
��[  960.042111] Function entered at [<c030140c>] from [<c030b30c>]
�[  960.042116] Exception stack(0xcf85df80 to 0xcf85dfc8)
��[  960.042129] df80: 00000001 00000000 00000000 c0313960 ffffe000 c0a03cb8 c0a03c6c 00000000
��[  960.048019]  nf_conntrack
��[  960.051163] dfa0: 00000000 410fc075 00000000 00000000 cf85dfc8 cf85dfd0 c0307d88 c0307d8c
��[  960.051173] dfc0: 60000013 ffffffff
[  960.057064]  libcrc32c
�[  960.059858] Function entered at [<c030b30c>] from [<c0307d8c>]
�[  960.065774]  iptable_mangle
[  960.068905] Function entered at [<c0307d8c>] from [<c0352068>]
�[  960.074815]  iptable_filter
[  960.077603] Function entered at [<c0352068>] from [<c0352388>]
�[  960.083511]  ip_tables
�[  960.085608] Function entered at [<c0352388>] from [<8030170c>]
�[  960.091523]  hwmon
�[  960.097496] ---[ end trace df518fc833e25387 ]---
���[  960.103340]  crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  960.267020] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  960.290453] Hardware name: Generic DT based system
�[  960.298113] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  960.302980] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  960.310273] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  960.316184] Function entered at [<c073fe14>] from [<c031dd34>]
�[  960.322098] Function entered at [<c031dd34>] from [<c031dd88>]
�[  960.328009] Function entered at [<c031dd88>] from [<bf234d74>]
�[  960.333925] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  960.339833] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  960.345747] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  960.351659] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  960.357569] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  960.363481] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  960.369394] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  960.375304] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  960.381218] Function entered at [<c0634a90>] from [<c0634b74>]
�[  960.387129] Function entered at [<c0634b74>] from [<c0636b80>]
�[  960.393043] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  960.398953] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  960.404868] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  960.410780] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  960.416691] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  960.422602] Function entered at [<c0333bb0>] from [<c0339070>]
�[  960.428515] Function entered at [<c0339070>] from [<c03074a8>]
�[  960.434508] ---[ end trace df518fc833e25388 ]---
���[  960.440337] ------------[ cut here ]------------
���[  960.445236] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  960.450086] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  960.461565] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  960.515944]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  960.539383] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  960.551160] Hardware name: Generic DT based system
�[  960.558816] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  960.563685] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  960.570979] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  960.576893] Function entered at [<c073fe14>] from [<c031dd34>]
�[  960.582803] Function entered at [<c031dd34>] from [<c031dd88>]
�[  960.588717] Function entered at [<c031dd88>] from [<bf233718>]
�[  960.594629] Function entered at [<bf233718>] from [<bf23edf4>]
�[  960.600543] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  960.606454] Function entered at [<bf23d384>] from [<bf234a90>]
�[  960.612364] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  960.618277] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  960.624189] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  960.630102] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  960.636012] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  960.641924] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  960.647835] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  960.653745] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  960.659657] Function entered at [<c0634a90>] from [<c0634b74>]
�[  960.665569] Function entered at [<c0634b74>] from [<c0636b80>]
�[  960.671481] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  960.677393] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  960.683306] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  960.689217] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  960.695127] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  960.701038] Function entered at [<c0333bb0>] from [<c0339070>]
�[  960.706952] Function entered at [<c0339070>] from [<c03074a8>]
�[  960.712945] ---[ end trace df518fc833e25389 ]---
���[  960.718778] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:18:31:25 tid 0
[  960.723687] ------------[ cut here ]------------
���[  960.731669] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  960.736523] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  960.747996] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  960.802369]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  960.825814] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  960.837591] Hardware name: Generic DT based system
�[  960.845248] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  960.850116] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  960.857411] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  960.863324] Function entered at [<c073fe14>] from [<c031dd34>]
�[  960.869236] Function entered at [<c031dd34>] from [<c031dd88>]
�[  960.875147] Function entered at [<c031dd88>] from [<bf234d74>]
�[  960.881059] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  960.886969] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  960.892883] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  960.898795] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  960.904704] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  960.910616] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  960.916528] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  960.922438] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  960.928351] Function entered at [<c0634a90>] from [<c0634b74>]
�[  960.934262] Function entered at [<c0634b74>] from [<c0636b80>]
�[  960.940172] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  960.946085] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  960.951996] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  960.957908] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  960.963821] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  960.969735] Function entered at [<c0333bb0>] from [<c0339070>]
�[  960.975647] Function entered at [<c0339070>] from [<c03074a8>]
�[  960.981652] ---[ end trace df518fc833e2538a ]---
���[  960.987472] ------------[ cut here ]------------
���[  960.992372] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  960.997221] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  961.008697] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  961.063069]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  961.086516] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  961.098295] Hardware name: Generic DT based system
�[  961.105950] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  961.110819] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  961.118114] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  961.124023] Function entered at [<c073fe14>] from [<c031dd34>]
�[  961.129936] Function entered at [<c031dd34>] from [<c031dd88>]
�[  961.135847] Function entered at [<c031dd88>] from [<bf233718>]
�[  961.141759] Function entered at [<bf233718>] from [<bf23edf4>]
�[  961.147672] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  961.153584] Function entered at [<bf23d384>] from [<bf234a90>]
�[  961.159495] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  961.165407] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  961.171319] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  961.177232] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  961.183144] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  961.189055] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  961.194967] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  961.200877] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  961.206790] Function entered at [<c0634a90>] from [<c0634b74>]
�[  961.212700] Function entered at [<c0634b74>] from [<c0636b80>]
�[  961.218612] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  961.224525] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  961.230438] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  961.236348] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  961.242260] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  961.248172] Function entered at [<c0333bb0>] from [<c0339070>]
�[  961.254085] Function entered at [<c0339070>] from [<c03074a8>]
�[  961.260087] ---[ end trace df518fc833e2538b ]---
���[  961.265928] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:6a:9f:25 tid 0
[  961.270800] ------------[ cut here ]------------
���[  961.278803] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  961.283671] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  961.295125] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  961.349497]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  961.372950] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  961.384725] Hardware name: Generic DT based system
�[  961.392382] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  961.397251] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  961.404546] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  961.410458] Function entered at [<c073fe14>] from [<c031dd34>]
�[  961.416369] Function entered at [<c031dd34>] from [<c031dd88>]
�[  961.422281] Function entered at [<c031dd88>] from [<bf234d74>]
�[  961.428193] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  961.434103] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  961.440017] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  961.445928] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  961.451838] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  961.457752] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  961.463664] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  961.469575] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  961.475485] Function entered at [<c0634a90>] from [<c0634b74>]
�[  961.481397] Function entered at [<c0634b74>] from [<c0636b80>]
�[  961.487308] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  961.493221] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  961.499135] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  961.505045] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  961.510956] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  961.516870] Function entered at [<c0333bb0>] from [<c0339070>]
�[  961.522783] Function entered at [<c0339070>] from [<c03074a8>]
�[  961.528765] ---[ end trace df518fc833e2538c ]---
���[  961.534616] ------------[ cut here ]------------
���[  961.539483] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  961.544373] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  961.555828] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  961.610199]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  961.633648] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  961.645425] Hardware name: Generic DT based system
�[  961.653080] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  961.657950] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  961.665246] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  961.671157] Function entered at [<c073fe14>] from [<c031dd34>]
�[  961.677068] Function entered at [<c031dd34>] from [<c031dd88>]
�[  961.682982] Function entered at [<c031dd88>] from [<bf233718>]
�[  961.688896] Function entered at [<bf233718>] from [<bf23edf4>]
�[  961.694808] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  961.700721] Function entered at [<bf23d384>] from [<bf234a90>]
�[  961.706633] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  961.712546] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  961.718458] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  961.724368] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  961.730281] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  961.736194] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  961.742106] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  961.748016] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  961.753929] Function entered at [<c0634a90>] from [<c0634b74>]
�[  961.759841] Function entered at [<c0634b74>] from [<c0636b80>]
�[  961.765752] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  961.771663] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  961.777576] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  961.783487] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  961.789399] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  961.795309] Function entered at [<c0333bb0>] from [<c0339070>]
�[  961.801223] Function entered at [<c0339070>] from [<c03074a8>]
�[  961.807214] ---[ end trace df518fc833e2538d ]---
���[  961.813061] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:91:f5:25 tid 0
[  961.817935] ------------[ cut here ]------------
���[  961.825938] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  961.830792] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  961.842271] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  961.896640]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  961.920087] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  961.931867] Hardware name: Generic DT based system
�[  961.939522] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  961.944392] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  961.951685] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  961.957599] Function entered at [<c073fe14>] from [<c031dd34>]
�[  961.963509] Function entered at [<c031dd34>] from [<c031dd88>]
�[  961.969421] Function entered at [<c031dd88>] from [<bf234d74>]
�[  961.975335] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  961.981246] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  961.987160] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  961.993071] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  961.998984] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  962.004894] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  962.010807] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  962.016718] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  962.022631] Function entered at [<c0634a90>] from [<c0634b74>]
�[  962.028543] Function entered at [<c0634b74>] from [<c0636b80>]
�[  962.034452] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  962.040365] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  962.046278] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  962.052189] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  962.058101] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  962.064013] Function entered at [<c0333bb0>] from [<c0339070>]
�[  962.069925] Function entered at [<c0339070>] from [<c03074a8>]
�[  962.075918] ---[ end trace df518fc833e2538e ]---
���[  962.081758] ------------[ cut here ]------------
���[  962.086625] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  962.091516] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  962.102970] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  962.157342]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  962.180790] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  962.192570] Hardware name: Generic DT based system
�[  962.200225] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  962.205094] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  962.212388] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  962.218302] Function entered at [<c073fe14>] from [<c031dd34>]
�[  962.224213] Function entered at [<c031dd34>] from [<c031dd88>]
�[  962.230125] Function entered at [<c031dd88>] from [<bf233718>]
�[  962.236037] Function entered at [<bf233718>] from [<bf23edf4>]
�[  962.241948] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  962.247860] Function entered at [<bf23d384>] from [<bf234a90>]
�[  962.253773] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  962.259685] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  962.265598] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  962.271511] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  962.277421] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  962.283334] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  962.289246] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  962.295156] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  962.301067] Function entered at [<c0634a90>] from [<c0634b74>]
�[  962.306979] Function entered at [<c0634b74>] from [<c0636b80>]
�[  962.312891] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  962.318804] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  962.324716] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  962.330627] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  962.336539] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  962.342451] Function entered at [<c0333bb0>] from [<c0339070>]
�[  962.348365] Function entered at [<c0339070>] from [<c03074a8>]
�[  962.354357] ---[ end trace df518fc833e2538f ]---
���[  962.360189] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:7d:3e:25 tid 0
[  962.365097] ------------[ cut here ]------------
���[  962.373078] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  962.377934] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  962.389407] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  962.443784]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  962.467229] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  962.479008] Hardware name: Generic DT based system
�[  962.486662] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  962.491531] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  962.498826] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  962.504738] Function entered at [<c073fe14>] from [<c031dd34>]
�[  962.510650] Function entered at [<c031dd34>] from [<c031dd88>]
�[  962.516561] Function entered at [<c031dd88>] from [<bf234d74>]
�[  962.522473] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  962.528384] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  962.534298] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  962.540211] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  962.546121] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  962.552034] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  962.557947] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  962.563858] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  962.569770] Function entered at [<c0634a90>] from [<c0634b74>]
�[  962.575681] Function entered at [<c0634b74>] from [<c0636b80>]
�[  962.581593] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  962.587505] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  962.593419] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  962.599330] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  962.605242] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  962.611151] Function entered at [<c0333bb0>] from [<c0339070>]
�[  962.617064] Function entered at [<c0339070>] from [<c03074a8>]
�[  962.623077] ---[ end trace df518fc833e25390 ]---
���[  962.627778] ------------[ cut here ]------------
���[  962.628894] ------------[ cut here ]------------
���[  962.633799] WARNING: CPU: 3 PID: 1471 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
���[  962.638641] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  962.643533] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  962.655334] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  962.655341] Modules linked in:
�[  962.666790] Modules linked in: pppoe ppp_async
�[  962.673051]  pppoe ppp_async
���[  962.679299]  ath10k_pci
[  962.682450]  ath10k_pci
[  962.686957]  ath10k_core
���[  962.690088]  ath10k_core
���[  962.692540]  ath pppox
�[  962.694970]  ath
���[  962.697754]  ppp_generic
���[  962.700542]  pppox
�[  962.702995]  mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE
[  962.705075]  ppp_generic
���[  962.707862]  cfg80211
��[  962.709960]  mac80211
��[  962.715531]  xt_time xt_tcpudp
�[  962.718305]  iptable_nat
���[  962.720746]  xt_state
��[  962.723203]  ipt_REJECT
[  962.726322]  xt_nat
[  962.729107]  ipt_MASQUERADE
[  962.731561]  xt_multiport
��[  962.733986]  cfg80211
��[  962.736080]  xt_mark
���[  962.738867]  xt_time
���[  962.741664]  xt_mac xt_limit
���[  962.744094]  xt_tcpudp
�[  962.746534]  xt_conntrack
��[  962.748975]  xt_state
��[  962.752124]  xt_comment
[  962.754549]  xt_nat
[  962.757335]  xt_TCPMSS
�[  962.759775]  xt_multiport
��[  962.762224]  xt_REDIRECT xt_LOG
[  962.764307]  xt_mark
���[  962.766747]  xt_FLOWOFFLOAD
[  962.769535]  xt_mac
[  962.772684]  xt_CT
�[  962.775110]  xt_limit
��[  962.777895]  slhc
��[  962.779988]  xt_conntrack
��[  962.782096]  openvswitch
���[  962.784520]  xt_comment
[  962.786614]  nf_reject_ipv4
[  962.789400]  xt_TCPMSS
�[  962.792197]  nf_nat_redirect nf_nat_masquerade_ipv6
[  962.794627]  xt_REDIRECT
���[  962.797412]  nf_nat_masquerade_ipv4
[  962.799855]  xt_LOG
[  962.804737]  nf_conntrack_ipv6
�[  962.807510]  xt_FLOWOFFLOAD
[  962.810987]  nf_nat_ipv6
���[  962.813095]  xt_CT
�[  962.816215]  nf_conntrack_ipv4
�[  962.819002]  slhc
��[  962.821803]  nf_nat_ipv4
���[  962.823882]  openvswitch
���[  962.827014]  nf_nat
[  962.829108]  nf_reject_ipv4
[  962.831905]  nf_log_ipv4 nf_flow_table_hw
��[  962.834680]  nf_nat_redirect
���[  962.836772]  nf_flow_table
�[  962.839561]  nf_nat_masquerade_ipv6
[  962.843751]  nf_defrag_ipv6
[  962.846870]  nf_nat_masquerade_ipv4
[  962.849657]  nf_defrag_ipv4
[  962.853150]  nf_conntrack_ipv6
�[  962.855926]  nf_conntrack_rtcache
��[  962.859405]  nf_nat_ipv6
���[  962.862209]  nf_conntrack
��[  962.865328]  nf_conntrack_ipv4
�[  962.868808]  libcrc32c
�[  962.871609]  nf_nat_ipv4
���[  962.874383]  iptable_mangle
[  962.877515]  nf_nat
[  962.879955]  iptable_filter
[  962.882756]  nf_log_ipv4
���[  962.885529]  ip_tables
�[  962.887622]  nf_flow_table_hw
��[  962.890409]  hwmon
�[  962.893209]  nf_flow_table
�[  962.895636]  crc_ccitt
�[  962.898767]  nf_defrag_ipv6
[  962.900860]  compat
[  962.903658]  nf_defrag_ipv4
[  962.906087]  ledtrig_usbport
���[  962.908871]  nf_conntrack_rtcache
��[  962.910965]  nf_log_ipv6
���[  962.913767]  nf_conntrack
��[  962.916888]  nf_log_common
�[  962.920367]  libcrc32c
�[  962.923164]  ip6table_mangle ip6table_filter
���[  962.925940]  iptable_mangle
[  962.928727]  ip6_tables
[  962.931186]  iptable_filter
[  962.935692]  ip6t_REJECT
���[  962.938477]  ip_tables
�[  962.940917]  x_tables
��[  962.943718]  hwmon
�[  962.946493]  nf_reject_ipv6
[  962.948931]  crc_ccitt
�[  962.951381]  ip6_gre ip_gre
[  962.953466]  compat
[  962.956250]  gre
���[  962.958689]  ledtrig_usbport
���[  962.961486]  ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso
���[  962.963567]  nf_log_ipv6
���[  962.965661]  leds_gpio
�[  962.968802]  nf_log_common
�[  962.976105]  xhci_plat_hcd xhci_pci
[  962.978882]  ip6table_mangle
���[  962.981339]  xhci_hcd
��[  962.984111]  ip6table_filter
���[  962.987591]  dwc3
��[  962.990724]  ip6_tables
[  962.993176]  dwc3_of_simple gpio_button_hotplug
[  962.996296]  ip6t_REJECT
���[  962.998390]  crc32c_generic
[  963.000834]  x_tables
��[  963.008140]  nf_reject_ipv6 ip6_gre
[  963.010934] CPU: 3 PID: 1471 Comm: dnsmasq Tainted: G        W       4.14.171 #0
���[  963.010939]  ip_gre
[  963.013367] Hardware name: Generic DT based system
�[  963.013380] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  963.013389] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  963.016855]  gre
���[  963.024495] Function entered at [<c073fe14>] from [<c031dd34>]
�[  963.024500] Function entered at [<c031dd34>] from [<c031dd88>]
�[  963.024506] Function entered at [<c031dd88>] from [<bf257584>]
�[  963.024515] Function entered at [<bf257584>] from [<bf25a558>]
�[  963.026593]  ip6_tunnel
[  963.031466] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  963.031472] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  963.031482] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  963.037375]  tunnel6
���[  963.043283] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  963.043289] Function entered at [<c063b268>] from [<c063b9d4>]
�[  963.043298] Function entered at [<c063b9d4>] from [<c0720580>]
�[  963.045384]  ip_tunnel
�[  963.051295] Function entered at [<c0720580>] from [<c0720614>]
�[  963.051300] Function entered at [<c0720614>] from [<c0720744>]
�[  963.051305] Function entered at [<c0720744>] from [<c0720798>]
�[  963.051313] Function entered at [<c0720798>] from [<c072097c>]
�[  963.057206]  mpls_iptunnel
�[  963.063119] Function entered at [<c072097c>] from [<c071dfb8>]
�[  963.063124] Function entered at [<c071dfb8>] from [<c063b268>]
�[  963.063129] Function entered at [<c063b268>] from [<c063b9d4>]
�[  963.063136] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  963.069023]  mpls_router
���[  963.071471] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  963.071476] Function entered at [<c06a9920>] from [<c064645c>]
�[  963.071482] Function entered at [<c064645c>] from [<c0649504>]
�[  963.071490] Function entered at [<c0649504>] from [<c06495fc>]
�[  963.077383]  mpls_gso
��[  963.083292] Function entered at [<c06495fc>] from [<c067c5f8>]
�[  963.083298] Function entered at [<c067c5f8>] from [<c067d11c>]
�[  963.083303] Function entered at [<c067d11c>] from [<c067d8c4>]
�[  963.083311] Function entered at [<c067d8c4>] from [<c06a3e94>]
�[  963.089200]  leds_gpio
�[  963.091645] Function entered at [<c06a3e94>] from [<c06a5da8>]
�[  963.091650] Function entered at [<c06a5da8>] from [<c061f1e4>]
�[  963.091656] Function entered at [<c061f1e4>] from [<c03073c0>]
�[  963.091703] ---[ end trace df518fc833e25391 ]---
���[  963.097557]  xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
[  963.239478] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  963.248503] Hardware name: Generic DT based system
�[  963.256161] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  963.261029] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  963.268323] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  963.274236] Function entered at [<c073fe14>] from [<c031dd34>]
�[  963.280148] Function entered at [<c031dd34>] from [<c031dd88>]
�[  963.286059] Function entered at [<c031dd88>] from [<bf233718>]
�[  963.291975] Function entered at [<bf233718>] from [<bf23edf4>]
�[  963.297884] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  963.303795] Function entered at [<bf23d384>] from [<bf234a90>]
�[  963.309706] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  963.315618] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  963.321530] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  963.327444] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  963.333379] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  963.339287] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  963.345203] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  963.351112] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  963.357022] Function entered at [<c0634a90>] from [<c0634b74>]
�[  963.362934] Function entered at [<c0634b74>] from [<c0636b80>]
�[  963.368846] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  963.374761] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  963.380680] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  963.386583] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  963.392500] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  963.398402] Function entered at [<c0333bb0>] from [<c0339070>]
�[  963.404324] Function entered at [<c0339070>] from [<c03074a8>]
�[  963.410375] ---[ end trace df518fc833e25392 ]---
���[  963.416162] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:d8:6d:25 tid 0
[  963.421054] ------------[ cut here ]------------
���[  963.429001] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  963.433907] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  963.445365] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  963.499794]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  963.523220] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  963.534954] Hardware name: Generic DT based system
�[  963.542599] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  963.547465] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  963.554758] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  963.560670] Function entered at [<c073fe14>] from [<c031dd34>]
�[  963.566582] Function entered at [<c031dd34>] from [<c031dd88>]
�[  963.572516] Function entered at [<c031dd88>] from [<bf234d74>]
�[  963.578428] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  963.584341] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  963.590252] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  963.596177] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  963.602080] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  963.607992] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  963.613912] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  963.619816] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  963.625735] Function entered at [<c0634a90>] from [<c0634b74>]
�[  963.631656] Function entered at [<c0634b74>] from [<c0636b80>]
�[  963.637557] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  963.643466] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  963.649358] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  963.655269] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  963.661181] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  963.667092] Function entered at [<c0333bb0>] from [<c0339070>]
�[  963.673005] Function entered at [<c0339070>] from [<c03074a8>]
�[  963.679035] ---[ end trace df518fc833e25393 ]---
���[  963.681129] ------------[ cut here ]------------
���[  963.684844] ------------[ cut here ]------------
���[  963.689716] WARNING: CPU: 3 PID: 2271 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
���[  963.694611] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  963.699461] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  963.711298] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  963.722729] Modules linked in: pppoe ppp_async
�[  963.728983] Modules linked in:
�[  963.728990]  ath10k_pci
[  963.735256]  pppoe
�[  963.739763]  ath10k_core
���[  963.742911]  ppp_async
�[  963.745335]  ath
���[  963.747427]  ath10k_pci
[  963.750213]  pppox
�[  963.752682]  ath10k_core
���[  963.754747]  ppp_generic
���[  963.757185]  ath
���[  963.759278]  mac80211
��[  963.762082]  pppox
�[  963.764854]  iptable_nat
���[  963.766945]  ppp_generic
���[  963.769384]  ipt_REJECT
[  963.771492]  mac80211
��[  963.774265]  ipt_MASQUERADE
[  963.777050]  iptable_nat
���[  963.779488]  cfg80211
��[  963.781944]  ipt_REJECT
[  963.784717]  xt_time
���[  963.787501]  ipt_MASQUERADE
[  963.789940]  xt_tcpudp
�[  963.792393]  cfg80211
��[  963.794822]  xt_state
��[  963.797607]  xt_time
���[  963.800046]  xt_nat
[  963.802502]  xt_tcpudp
�[  963.804927]  xt_multiport
��[  963.807365]  xt_state
��[  963.809456]  xt_mark
���[  963.811910]  xt_nat
[  963.814684]  xt_mac
[  963.817123]  xt_multiport
��[  963.819562]  xt_limit
��[  963.821670]  xt_mark
���[  963.823749]  xt_conntrack
��[  963.826534]  xt_mac
[  963.828974]  xt_comment
[  963.831429]  xt_limit
��[  963.834202]  xt_TCPMSS
�[  963.836295]  xt_conntrack
��[  963.838735]  xt_REDIRECT
���[  963.841190]  xt_comment
[  963.843617]  xt_LOG
[  963.846403]  xt_TCPMSS
�[  963.849190]  xt_FLOWOFFLOAD
[  963.851643]  xt_REDIRECT
���[  963.853723]  xt_CT
�[  963.856162]  xt_LOG
[  963.858947]  slhc
��[  963.861749]  xt_FLOWOFFLOAD
[  963.863828]  openvswitch
���[  963.865920]  xt_CT
�[  963.868013]  nf_reject_ipv4
[  963.870800]  slhc
��[  963.873597]  nf_nat_redirect nf_nat_masquerade_ipv6
[  963.875682]  openvswitch
���[  963.878466]  nf_nat_masquerade_ipv4
[  963.880563]  nf_reject_ipv4
[  963.885442]  nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4
���[  963.888219]  nf_nat_redirect
���[  963.891708]  nf_nat nf_log_ipv4
[  963.894491]  nf_nat_masquerade_ipv6
[  963.901446]  nf_flow_table_hw nf_flow_table nf_defrag_ipv6
�[  963.904575]  nf_nat_masquerade_ipv4
[  963.907708]  nf_defrag_ipv4
[  963.911205]  nf_conntrack_ipv6
�[  963.916753]  nf_conntrack_rtcache
��[  963.920235]  nf_nat_ipv6
���[  963.923032]  nf_conntrack libcrc32c
[  963.926156]  nf_conntrack_ipv4
�[  963.929635]  iptable_mangle
[  963.932440]  nf_nat_ipv4
���[  963.935903]  iptable_filter
[  963.939037]  nf_nat
[  963.941835]  ip_tables hwmon
���[  963.944611]  nf_log_ipv4
���[  963.947396]  crc_ccitt
�[  963.949491]  nf_flow_table_hw
��[  963.952636]  compat ledtrig_usbport
[  963.955412]  nf_flow_table
�[  963.957851]  nf_log_ipv6
���[  963.960988]  nf_defrag_ipv6
[  963.964483]  nf_log_common
�[  963.967254]  nf_defrag_ipv4
[  963.970041]  ip6table_mangle
���[  963.972843]  nf_conntrack_rtcache
��[  963.975616]  ip6table_filter
���[  963.978402]  nf_conntrack
��[  963.981548]  ip6_tables ip6t_REJECT
[  963.985019]  libcrc32c
�[  963.988151]  x_tables
��[  963.990940]  iptable_mangle
[  963.994434]  nf_reject_ipv6
[  963.996859]  iptable_filter
[  963.999299]  ip6_gre
���[  964.002107]  ip_tables
�[  964.004874]  ip_gre
[  964.007658]  hwmon
�[  964.010098]  gre
���[  964.012557]  crc_ccitt
�[  964.014631]  ip6_tunnel
[  964.016723]  compat
[  964.018816]  tunnel6
���[  964.021267]  ledtrig_usbport
���[  964.023696]  ip_tunnel
�[  964.025787]  nf_log_ipv6
���[  964.028229]  mpls_iptunnel
�[  964.031378]  nf_log_common
�[  964.033803]  mpls_router
���[  964.036590]  ip6table_mangle
���[  964.039376]  mpls_gso
��[  964.042178]  ip6table_filter
���[  964.044952]  leds_gpio
�[  964.048084]  ip6_tables
[  964.050524]  xhci_plat_hcd
�[  964.053671]  ip6t_REJECT
���[  964.056099]  xhci_pci
��[  964.058538]  x_tables
��[  964.061341]  xhci_hcd
��[  964.064113]  nf_reject_ipv6
[  964.066552]  dwc3
��[  964.068992]  ip6_gre
���[  964.071442]  dwc3_of_simple gpio_button_hotplug
[  964.074218]  ip_gre
[  964.076311]  crc32c_generic
[  964.078754]  gre
���[  964.085367]  ip6_tunnel tunnel6
[  964.088157] CPU: 3 PID: 2271 Comm: ovsdb-server Tainted: G        W       4.14.171 #0
��[  964.088163]  ip_tunnel
�[  964.090248] Hardware name: Generic DT based system
�[  964.093400]  mpls_iptunnel
�[  964.101381] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  964.101389] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  964.103816]  mpls_router
���[  964.108687] Function entered at [<c073fe14>] from [<c031dd34>]
�[  964.111486]  mpls_gso
��[  964.117389] Function entered at [<c031dd34>] from [<c031dd88>]
�[  964.123300]  leds_gpio
�[  964.126087] Function entered at [<c031dd88>] from [<bf257584>]
�[  964.131997]  xhci_plat_hcd
�[  964.134441] Function entered at [<bf257584>] from [<bf25a558>]
�[  964.140343]  xhci_pci
��[  964.142790] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  964.142795] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  964.142801] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  964.142809] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  964.148695]  xhci_hcd
��[  964.151488] Function entered at [<c063b268>] from [<c063b9d4>]
�[  964.151493] Function entered at [<c063b9d4>] from [<c0720580>]
�[  964.151499] Function entered at [<c0720580>] from [<c0720614>]
�[  964.151507] Function entered at [<c0720614>] from [<c0720744>]
�[  964.157393]  dwc3
��[  964.159841] Function entered at [<c0720744>] from [<c0720798>]
�[  964.165763]  dwc3_of_simple
[  964.171662] Function entered at [<c0720798>] from [<c072097c>]
�[  964.171667] Function entered at [<c072097c>] from [<c071dfb8>]
�[  964.171675] Function entered at [<c071dfb8>] from [<c063b268>]
�[  964.177574]  gpio_button_hotplug
���[  964.183480] Function entered at [<c063b268>] from [<c063b9d4>]
�[  964.183485] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  964.183491] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  964.183499] Function entered at [<c06a9920>] from [<c064645c>]
�[  964.185926]  crc32c_generic
[  964.191838] Function entered at [<c064645c>] from [<c0649910>]
�[  964.191843] Function entered at [<c0649910>] from [<c036bdf0>]
�[  964.191853] Function entered at [<c036bdf0>] from [<c036c138>]
�[  964.203659] Function entered at [<c036c138>] from [<c0301520>]
�[  964.203665] Function entered at [<c0301520>] from [<c0321e38>]
�[  964.203670] Function entered at [<c0321e38>] from [<c035b318>]
�[  964.203677] Function entered at [<c035b318>] from [<c030140c>]
�[  964.303483] Function entered at [<c030140c>] from [<c030b6b0>]
�[  964.309394] Exception stack(0xce3cdfb0 to 0xce3cdff8)
��[  964.315308] dfa0:                                     01659f50 00000000 b6fc42e0 00000002
��[  964.320532] dfc0: 01659f50 00000000 01659110 b6fc6b70 d38c2a41 00000000 00000000 00000000
��[  964.328873] dfe0: b6eedcdc be85da88 b6e254e0 b6e25464 60000010 ffffffff
[  964.337216] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  964.337319] ---[ end trace df518fc833e25394 ]---
���[  964.343816] Hardware name: Generic DT based system
�[  964.343836] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  964.361216] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  964.368507] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  964.374419] Function entered at [<c073fe14>] from [<c031dd34>]
�[  964.380330] Function entered at [<c031dd34>] from [<c031dd88>]
�[  964.386243] Function entered at [<c031dd88>] from [<bf233718>]
�[  964.392159] Function entered at [<bf233718>] from [<bf23edf4>]
�[  964.398069] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  964.403981] Function entered at [<bf23d384>] from [<bf234a90>]
�[  964.409890] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  964.415801] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  964.421715] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  964.427627] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  964.433538] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  964.439448] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  964.445361] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  964.451272] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  964.457185] Function entered at [<c0634a90>] from [<c0634b74>]
�[  964.463094] Function entered at [<c0634b74>] from [<c0636b80>]
�[  964.469008] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  964.474918] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  964.480832] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  964.486741] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  964.492654] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  964.498567] Function entered at [<c0333bb0>] from [<c0339070>]
�[  964.504480] Function entered at [<c0339070>] from [<c03074a8>]
�[  964.510488] ---[ end trace df518fc833e25395 ]---
���[  964.516320] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:e5:22:25 tid 0
[  964.521214] ------------[ cut here ]------------
���[  964.529175] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  964.534067] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  964.545523] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  964.599891]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  964.623343] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  964.635119] Hardware name: Generic DT based system
�[  964.642774] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  964.647644] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  964.654938] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  964.660848] Function entered at [<c073fe14>] from [<c031dd34>]
�[  964.666760] Function entered at [<c031dd34>] from [<c031dd88>]
�[  964.672672] Function entered at [<c031dd88>] from [<bf234d74>]
�[  964.678584] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  964.684495] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  964.690409] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  964.696320] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  964.702230] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  964.708145] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  964.714057] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  964.719967] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  964.721109] ------------[ cut here ]------------
���[  964.725886] Function entered at [<c0634a90>] from [<c0634b74>]
�[  964.731813] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  964.736668] Function entered at [<c0634b74>] from [<c0636b80>]
�[  964.742601] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  964.754044] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  964.754051] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  964.754059] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  964.759956] Modules linked in:
�[  964.766216] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  964.766222] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  964.766229] Function entered at [<c0333bb0>] from [<c0339070>]
�[  964.772131]  pppoe
�[  964.778044] Function entered at [<c0339070>] from [<c03074a8>]
�[  964.783955]  ppp_async
�[  964.787170] ---[ end trace df518fc833e25396 ]---
���[  964.793001]  ath10k_pci ath10k_core ath
[  964.798912] ------------[ cut here ]------------
���[  964.804819]  pppox ppp_generic mac80211 iptable_nat ipt_REJECT
�[  964.806927] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  964.812824]  ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state
[  964.815268] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  964.820134]  xt_nat
[  964.823977] Modules linked in:
�[  964.828839]  xt_multiport
��[  964.834770]  pppoe
�[  964.846219]  xt_mark xt_mac xt_limit xt_conntrack
��[  964.852138]  ppp_async
�[  964.858382]  xt_comment
[  964.860475]  ath10k_pci
[  964.863612]  xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD
���[  964.866393]  ath10k_core
���[  964.868490]  xt_CT
�[  964.873369]  ath
���[  964.875797]  slhc
��[  964.878235]  pppox
�[  964.880680]  openvswitch
���[  964.886254]  ppp_generic
���[  964.889026]  nf_reject_ipv4
[  964.891133]  mac80211
��[  964.893212]  nf_nat_redirect
���[  964.895303]  iptable_nat
���[  964.897396]  nf_nat_masquerade_ipv6
[  964.900183]  ipt_REJECT
[  964.902979]  nf_nat_masquerade_ipv4 nf_conntrack_ipv6
��[  964.905759]  ipt_MASQUERADE
[  964.908198]  nf_nat_ipv6
���[  964.911346]  cfg80211
��[  964.914121]  nf_conntrack_ipv4
�[  964.917600]  xt_time
���[  964.920044]  nf_nat_ipv4
���[  964.925270]  xt_tcpudp
�[  964.928044]  nf_nat
[  964.930829]  xt_state
��[  964.933278]  nf_log_ipv4 nf_flow_table_hw
��[  964.936404]  xt_nat
[  964.938842]  nf_flow_table
�[  964.941643]  xt_multiport
��[  964.944071]  nf_defrag_ipv6
[  964.946164]  xt_mark
���[  964.948605]  nf_defrag_ipv4
[  964.952791]  xt_mac
[  964.954873]  nf_conntrack_rtcache
��[  964.957659]  xt_limit
��[  964.960446]  nf_conntrack
��[  964.963252]  xt_conntrack
��[  964.965673]  libcrc32c
�[  964.968458]  xt_comment
[  964.970552]  iptable_mangle
[  964.974046]  xt_TCPMSS
�[  964.976474]  iptable_filter
[  964.979259]  xt_REDIRECT
���[  964.982053]  ip_tables hwmon
���[  964.984486]  xt_LOG
[  964.986925]  crc_ccitt
�[  964.989711]  xt_FLOWOFFLOAD
[  964.992160]  compat ledtrig_usbport
[  964.994940]  xt_CT
�[  964.997727]  nf_log_ipv6
���[  965.000859]  slhc
��[  965.002961]  nf_log_common ip6table_mangle
�[  965.005393]  openvswitch
���[  965.008180]  ip6table_filter
���[  965.011671]  nf_reject_ipv4
[  965.013752]  ip6_tables
[  965.016537]  nf_nat_redirect
���[  965.018632]  ip6t_REJECT
���[  965.022818]  nf_nat_masquerade_ipv6
[  965.025594]  x_tables
��[  965.028725]  nf_nat_masquerade_ipv4
[  965.031522]  nf_reject_ipv6 ip6_gre
[  965.033954]  nf_conntrack_ipv6
�[  965.037085]  ip_gre
[  965.039873]  nf_nat_ipv6
���[  965.043361]  gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router
[  965.045796]  nf_conntrack_ipv4
�[  965.049276]  mpls_gso
��[  965.052770]  nf_nat_ipv4
���[  965.055890]  leds_gpio
�[  965.057983]  nf_nat
[  965.060776]  xhci_plat_hcd
�[  965.067389]  nf_log_ipv4
���[  965.070509]  xhci_pci
��[  965.072961]  nf_flow_table_hw
��[  965.075735]  xhci_hcd
��[  965.078173]  nf_flow_table
�[  965.080266]  dwc3
��[  965.083065]  nf_defrag_ipv6
[  965.085839]  dwc3_of_simple
[  965.088279]  nf_defrag_ipv4
[  965.091419]  gpio_button_hotplug crc32c_generic
[  965.093853]  nf_conntrack_rtcache
��[  965.098732]  nf_conntrack
��[  965.101540] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.14.171 #0
[  965.104304]  libcrc32c
�[  965.107096] Hardware name: Generic DT based system
�[  965.111622]  iptable_mangle
[  965.115102] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  965.117890]  iptable_filter
[  965.125183] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  965.125189] Function entered at [<c073fe14>] from [<c031dd34>]
�[  965.125197] Function entered at [<c031dd34>] from [<c031dd88>]
�[  965.127625]  ip_tables
�[  965.132493] Function entered at [<c031dd88>] from [<bf257584>]
�[  965.132501] Function entered at [<bf257584>] from [<bf25a558>]
�[  965.132507] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  965.132519] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  965.135285]  hwmon
�[  965.141194] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  965.141200] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  965.141206] Function entered at [<c063b268>] from [<c063b9d4>]
�[  965.141215] Function entered at [<c063b9d4>] from [<c0720580>]
�[  965.143986]  crc_ccitt
�[  965.149899] Function entered at [<c0720580>] from [<c0720614>]
�[  965.155820]  compat
[  965.161714] Function entered at [<c0720614>] from [<c0720744>]
�[  965.161719] Function entered at [<c0720744>] from [<c0720798>]
�[  965.161727] Function entered at [<c0720798>] from [<c072097c>]
�[  965.164161]  ledtrig_usbport
���[  965.170074] Function entered at [<c072097c>] from [<c071dfb8>]
�[  965.175995]  nf_log_ipv6
���[  965.181894] Function entered at [<c071dfb8>] from [<c063b268>]
�[  965.181899] Function entered at [<c063b268>] from [<c063b9d4>]
�[  965.181907] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  965.187801]  nf_log_common
�[  965.189902] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  965.195824]  ip6table_mangle
���[  965.201723] Function entered at [<c06a9920>] from [<c064645c>]
�[  965.201729] Function entered at [<c064645c>] from [<c0649910>]
�[  965.201737] Function entered at [<c0649910>] from [<c036bdf0>]
�[  965.207633]  ip6table_filter
���[  965.213542] Function entered at [<c036bdf0>] from [<c036c138>]
�[  965.213547] Function entered at [<c036c138>] from [<c0301520>]
�[  965.213553] Function entered at [<c0301520>] from [<c0321e38>]
�[  965.213561] Function entered at [<c0321e38>] from [<c035b318>]
�[  965.215985]  ip6_tables
[  965.221894] Function entered at [<c035b318>] from [<c030140c>]
�[  965.221898] Function entered at [<c030140c>] from [<c030b30c>]
�[  965.221904] Exception stack(0xcf85df80 to 0xcf85dfc8)
��[  965.221916] df80: 00000001 00000000 00000000 c0313960 ffffe000 c0a03cb8 c0a03c6c 00000000
��[  965.223992]  ip6t_REJECT
���[  965.229909] dfa0: 00000000 410fc075 00000000 00000000 cf85dfc8 cf85dfd0 c0307d88 c0307d8c
��[  965.235827]  x_tables
��[  965.241721] dfc0: 60000013 ffffffff
[  965.241727] Function entered at [<c030b30c>] from [<c0307d8c>]
�[  965.241735] Function entered at [<c0307d8c>] from [<c0352068>]
�[  965.244861]  nf_reject_ipv6
[  965.250770] Function entered at [<c0352068>] from [<c0352388>]
�[  965.253571]  ip6_gre
���[  965.259474] Function entered at [<c0352388>] from [<8030170c>]
�[  965.265389]  ip_gre
[  965.271356] ---[ end trace df518fc833e25397 ]---
���[  965.274083]  gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
��[  965.408374] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  965.424333] Hardware name: Generic DT based system
�[  965.431992] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  965.436858] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  965.444151] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  965.450064] Function entered at [<c073fe14>] from [<c031dd34>]
�[  965.455976] Function entered at [<c031dd34>] from [<c031dd88>]
�[  965.461887] Function entered at [<c031dd88>] from [<bf233718>]
�[  965.467802] Function entered at [<bf233718>] from [<bf23edf4>]
�[  965.473712] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  965.479625] Function entered at [<bf23d384>] from [<bf234a90>]
�[  965.485537] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  965.491446] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  965.497361] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  965.503274] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  965.509184] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  965.515096] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  965.521008] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  965.526920] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  965.532832] Function entered at [<c0634a90>] from [<c0634b74>]
�[  965.538744] Function entered at [<c0634b74>] from [<c0636b80>]
�[  965.544657] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  965.550567] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  965.556482] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  965.562393] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  965.568306] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  965.574216] Function entered at [<c0333bb0>] from [<c0339070>]
�[  965.580130] Function entered at [<c0339070>] from [<c03074a8>]
�[  965.586129] ---[ end trace df518fc833e25398 ]---
���[  965.591969] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:3e:98:25 tid 0
[  965.596843] ------------[ cut here ]------------
���[  965.604848] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  965.609699] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  965.621177] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  965.675543]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  965.698992] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  965.710772] Hardware name: Generic DT based system
�[  965.718426] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  965.723296] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  965.730590] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  965.736504] Function entered at [<c073fe14>] from [<c031dd34>]
�[  965.742414] Function entered at [<c031dd34>] from [<c031dd88>]
�[  965.748327] Function entered at [<c031dd88>] from [<bf234d74>]
�[  965.754242] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  965.760151] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  965.766064] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  965.771976] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  965.777886] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  965.783799] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  965.789709] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  965.795619] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  965.801532] Function entered at [<c0634a90>] from [<c0634b74>]
�[  965.807443] Function entered at [<c0634b74>] from [<c0636b80>]
�[  965.813356] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  965.819269] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  965.825181] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  965.831090] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  965.837002] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  965.842914] Function entered at [<c0333bb0>] from [<c0339070>]
�[  965.848827] Function entered at [<c0339070>] from [<c03074a8>]
�[  965.854838] ---[ end trace df518fc833e25399 ]---
���[  965.860651] ------------[ cut here ]------------
���[  965.865552] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  965.870400] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  965.881878] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  965.936245]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  965.959693] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  965.971473] Hardware name: Generic DT based system
�[  965.979129] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  965.984000] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  965.991292] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  965.997205] Function entered at [<c073fe14>] from [<c031dd34>]
�[  966.003117] Function entered at [<c031dd34>] from [<c031dd88>]
�[  966.009028] Function entered at [<c031dd88>] from [<bf233718>]
�[  966.014943] Function entered at [<bf233718>] from [<bf23edf4>]
�[  966.020854] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  966.026766] Function entered at [<bf23d384>] from [<bf234a90>]
�[  966.032677] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  966.038590] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  966.044502] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  966.050416] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  966.056325] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  966.062236] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  966.068149] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  966.074060] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  966.079972] Function entered at [<c0634a90>] from [<c0634b74>]
�[  966.085882] Function entered at [<c0634b74>] from [<c0636b80>]
�[  966.091794] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  966.097708] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  966.103620] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  966.109528] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  966.115442] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  966.121352] Function entered at [<c0333bb0>] from [<c0339070>]
�[  966.127266] Function entered at [<c0339070>] from [<c03074a8>]
�[  966.133281] ---[ end trace df518fc833e2539a ]---
���[  966.139092] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:b0:3c:25 tid 0
[  966.144003] ------------[ cut here ]------------
���[  966.151981] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  966.156836] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  966.168308] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  966.222676]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  966.246128] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  966.257908] Hardware name: Generic DT based system
�[  966.265563] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  966.270431] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  966.277725] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  966.283638] Function entered at [<c073fe14>] from [<c031dd34>]
�[  966.289549] Function entered at [<c031dd34>] from [<c031dd88>]
�[  966.295462] Function entered at [<c031dd88>] from [<bf234d74>]
�[  966.301375] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  966.307287] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  966.313196] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  966.319110] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  966.325023] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  966.330934] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  966.336846] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  966.342757] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  966.348669] Function entered at [<c0634a90>] from [<c0634b74>]
�[  966.354579] Function entered at [<c0634b74>] from [<c0636b80>]
�[  966.360494] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  966.366405] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  966.372317] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  966.378227] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  966.384139] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  966.390050] Function entered at [<c0333bb0>] from [<c0339070>]
�[  966.395964] Function entered at [<c0339070>] from [<c03074a8>]
�[  966.401958] ---[ end trace df518fc833e2539b ]---
���[  966.407785] ------------[ cut here ]------------
���[  966.412681] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  966.417536] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  966.429010] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  966.483380]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  966.506829] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  966.518609] Hardware name: Generic DT based system
�[  966.526264] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  966.531133] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  966.538428] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  966.544341] Function entered at [<c073fe14>] from [<c031dd34>]
�[  966.550253] Function entered at [<c031dd34>] from [<c031dd88>]
�[  966.556165] Function entered at [<c031dd88>] from [<bf233718>]
�[  966.562078] Function entered at [<bf233718>] from [<bf23edf4>]
�[  966.567987] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  966.573900] Function entered at [<bf23d384>] from [<bf234a90>]
�[  966.579812] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  966.585724] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  966.591637] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  966.597551] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  966.603461] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  966.609374] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  966.615287] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  966.621198] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  966.627111] Function entered at [<c0634a90>] from [<c0634b74>]
�[  966.633021] Function entered at [<c0634b74>] from [<c0636b80>]
�[  966.638933] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  966.644846] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  966.650758] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  966.656669] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  966.662581] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  966.668492] Function entered at [<c0333bb0>] from [<c0339070>]
�[  966.674405] Function entered at [<c0339070>] from [<c03074a8>]
�[  966.680400] ---[ end trace df518fc833e2539c ]---
���[  966.686241] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:c5:72:25 tid 0
[  966.691136] ------------[ cut here ]------------
���[  966.699098] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  966.703988] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  966.715442] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  966.769822]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  966.793267] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  966.805042] Hardware name: Generic DT based system
�[  966.812698] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  966.817567] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  966.824860] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  966.830773] Function entered at [<c073fe14>] from [<c031dd34>]
�[  966.836685] Function entered at [<c031dd34>] from [<c031dd88>]
�[  966.842599] Function entered at [<c031dd88>] from [<bf234d74>]
�[  966.848514] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  966.854427] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  966.860339] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  966.866250] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  966.872161] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  966.878074] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  966.883984] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  966.889897] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  966.895809] Function entered at [<c0634a90>] from [<c0634b74>]
�[  966.901719] Function entered at [<c0634b74>] from [<c0636b80>]
�[  966.907631] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  966.913542] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  966.919456] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  966.925367] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  966.931279] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  966.937189] Function entered at [<c0333bb0>] from [<c0339070>]
�[  966.943102] Function entered at [<c0339070>] from [<c03074a8>]
�[  966.949103] ---[ end trace df518fc833e2539d ]---
���[  966.954938] ------------[ cut here ]------------
���[  966.959803] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  966.964703] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  966.976148] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  967.030521]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  967.053974] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  967.065748] Hardware name: Generic DT based system
�[  967.073405] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  967.078274] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  967.085568] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  967.091480] Function entered at [<c073fe14>] from [<c031dd34>]
�[  967.097392] Function entered at [<c031dd34>] from [<c031dd88>]
�[  967.103302] Function entered at [<c031dd88>] from [<bf233718>]
�[  967.109217] Function entered at [<bf233718>] from [<bf23edf4>]
�[  967.115127] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  967.121039] Function entered at [<bf23d384>] from [<bf234a90>]
�[  967.126952] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  967.132863] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  967.138777] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  967.144689] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  967.150599] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  967.156511] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  967.162424] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  967.168334] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  967.174246] Function entered at [<c0634a90>] from [<c0634b74>]
�[  967.180158] Function entered at [<c0634b74>] from [<c0636b80>]
�[  967.186069] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  967.191982] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  967.197894] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  967.203805] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  967.209717] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  967.215629] Function entered at [<c0333bb0>] from [<c0339070>]
�[  967.221543] Function entered at [<c0339070>] from [<c03074a8>]
�[  967.227541] ---[ end trace df518fc833e2539e ]---
���[  967.233380] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:fe:cd:25 tid 0
[  967.238253] ------------[ cut here ]------------
���[  967.246256] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  967.251127] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  967.262582] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  967.316948]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  967.340403] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  967.352181] Hardware name: Generic DT based system
�[  967.359836] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  967.364706] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  967.372000] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  967.377913] Function entered at [<c073fe14>] from [<c031dd34>]
�[  967.383823] Function entered at [<c031dd34>] from [<c031dd88>]
�[  967.389736] Function entered at [<c031dd88>] from [<bf234d74>]
�[  967.395647] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  967.401560] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  967.407473] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  967.413385] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  967.419295] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  967.425208] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  967.431120] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  967.437030] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  967.442942] Function entered at [<c0634a90>] from [<c0634b74>]
�[  967.448853] Function entered at [<c0634b74>] from [<c0636b80>]
�[  967.454765] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  967.460677] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  967.466592] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  967.472504] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  967.478415] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  967.484327] Function entered at [<c0333bb0>] from [<c0339070>]
�[  967.490241] Function entered at [<c0339070>] from [<c03074a8>]
�[  967.496235] ---[ end trace df518fc833e2539f ]---
���[  967.502075] ------------[ cut here ]------------
���[  967.506939] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  967.511833] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  967.523288] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  967.577656]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  967.601108] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  967.612886] Hardware name: Generic DT based system
�[  967.620540] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  967.625409] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  967.632704] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  967.638618] Function entered at [<c073fe14>] from [<c031dd34>]
�[  967.644528] Function entered at [<c031dd34>] from [<c031dd88>]
�[  967.648913] ------------[ cut here ]------------
���[  967.650452] Function entered at [<c031dd88>] from [<bf233718>]
�[  967.656391] WARNING: CPU: 3 PID: 1471 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
���[  967.661229] Function entered at [<bf233718>] from [<bf23edf4>]
�[  967.661236] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  967.661242] Function entered at [<bf23d384>] from [<bf234a90>]
�[  967.661247] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  967.661257] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  967.667154] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  967.678955] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  967.678963] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  967.678968] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  967.678979] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  967.684872] Modules linked in:
�[  967.690782] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  967.696702]  pppoe
�[  967.702602] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  967.702611] Function entered at [<c0634a90>] from [<c0634b74>]
�[  967.708514]  ppp_async
�[  967.714772] Function entered at [<c0634b74>] from [<c0636b80>]
�[  967.714777] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  967.714787] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  967.720684]  ath10k_pci
[  967.726596] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  967.726602] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  967.726610] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  967.732512]  ath10k_core
���[  967.738419] Function entered at [<c0333bb0>] from [<c0339070>]
�[  967.741565]  ath
���[  967.747462] Function entered at [<c0339070>] from [<c03074a8>]
�[  967.749558]  pppox
�[  967.755555] ---[ end trace df518fc833e253a0 ]---
���[  967.761383]  ppp_generic mac80211
��[  967.763827] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:04:b8:25 tid 0
[  967.769734]  iptable_nat
���[  967.775679] ------------[ cut here ]------------
���[  967.781556]  ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp
��[  967.784010] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  967.789912]  xt_state
��[  967.795840] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  967.801734]  xt_nat xt_multiport xt_mark xt_mac
[  967.804525] Modules linked in:
�[  967.810430]  xt_limit
��[  967.812540]  pppoe
�[  967.818434]  xt_conntrack
��[  967.820530]  ppp_async
�[  967.825408]  xt_comment xt_TCPMSS
��[  967.828888]  ath10k_pci
[  967.836888]  xt_REDIRECT
���[  967.839664]  ath10k_core
���[  967.844539]  xt_LOG xt_FLOWOFFLOAD xt_CT
���[  967.850803]  ath
���[  967.862268]  slhc openvswitch
��[  967.864702]  pppox
�[  967.870957]  nf_reject_ipv4
[  967.875490]  ppp_generic
���[  967.878612]  nf_nat_redirect
���[  967.881062]  mac80211
��[  967.883145]  nf_nat_masquerade_ipv6
[  967.885930]  iptable_nat
���[  967.888371]  nf_nat_masquerade_ipv4
[  967.891867]  ipt_REJECT
[  967.894293]  nf_conntrack_ipv6
�[  967.897077]  ipt_MASQUERADE
[  967.899867]  nf_nat_ipv6
���[  967.904054]  cfg80211
��[  967.906134]  nf_conntrack_ipv4
�[  967.909266]  xt_time
���[  967.911369]  nf_nat_ipv4 nf_nat
[  967.914146]  xt_tcpudp
�[  967.916932]  nf_log_ipv4
���[  967.920064]  xt_state
��[  967.922521]  nf_flow_table_hw
��[  967.925984]  xt_nat
[  967.928773]  nf_flow_table
�[  967.932265]  xt_multiport
��[  967.934694]  nf_defrag_ipv6
[  967.937827]  xt_mark
���[  967.940613]  nf_defrag_ipv4
[  967.943414]  xt_mac
[  967.945840]  nf_conntrack_rtcache
��[  967.948972]  xt_limit
��[  967.951424]  nf_conntrack libcrc32c
[  967.954546]  xt_conntrack
��[  967.956988]  iptable_mangle
[  967.959775]  xt_comment
[  967.962227]  iptable_filter ip_tables
��[  967.965349]  xt_TCPMSS
�[  967.967442]  hwmon
�[  967.970230]  xt_REDIRECT
���[  967.973034]  crc_ccitt
�[  967.975804]  xt_LOG
[  967.978243]  compat
[  967.981041]  xt_FLOWOFFLOAD
[  967.983124]  ledtrig_usbport
���[  967.986604]  xt_CT
�[  967.989045]  nf_log_ipv6
���[  967.992540]  slhc
��[  967.995311]  nf_log_common
�[  967.998098]  openvswitch
���[  968.000538]  ip6table_mangle
���[  968.004383]  nf_reject_ipv4
[  968.006804]  ip6table_filter
���[  968.008898]  nf_nat_redirect
���[  968.011694]  ip6_tables ip6t_REJECT x_tables nf_reject_ipv6
[  968.014124]  nf_nat_masquerade_ipv6
[  968.016216]  ip6_gre
���[  968.018310]  nf_nat_masquerade_ipv4
[  968.021112]  ip_gre
[  968.024230]  nf_conntrack_ipv6
�[  968.026324]  gre
���[  968.029108]  nf_nat_ipv6
���[  968.031212]  ip6_tunnel tunnel6
[  968.033988]  nf_conntrack_ipv4
�[  968.036777]  ip_tunnel
�[  968.039909]  nf_nat_ipv4
���[  968.042708]  mpls_iptunnel mpls_router
�[  968.045832]  nf_nat
[  968.048970]  mpls_gso
��[  968.054545]  nf_log_ipv4
���[  968.058013]  leds_gpio
�[  968.060453]  nf_flow_table_hw
��[  968.063943]  xhci_plat_hcd xhci_pci
[  968.066026]  nf_flow_table
�[  968.069158]  xhci_hcd
��[  968.071267]  nf_defrag_ipv6
[  968.074041]  dwc3
��[  968.077174]  nf_defrag_ipv4
[  968.080307]  dwc3_of_simple
[  968.082761]  nf_conntrack_rtcache
��[  968.085536]  gpio_button_hotplug
���[  968.089361]  nf_conntrack
��[  968.091470]  crc32c_generic
[  968.093896]  libcrc32c
�[  968.099122]  iptable_mangle
[  968.102280] CPU: 3 PID: 1471 Comm: dnsmasq Tainted: G        W       4.14.171 #0
���[  968.105738]  iptable_filter
[  968.108525] Hardware name: Generic DT based system
�[  968.110963]  ip_tables
�[  968.113757] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  968.113765] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  968.115843]  hwmon
�[  968.118632] Function entered at [<c073fe14>] from [<c031dd34>]
�[  968.121432]  crc_ccitt
�[  968.124904] Function entered at [<c031dd34>] from [<c031dd88>]
�[  968.128381]  compat
[  968.131169] Function entered at [<c031dd88>] from [<bf257584>]
�[  968.131181] Function entered at [<bf257584>] from [<bf25a558>]
�[  968.133956]  ledtrig_usbport
���[  968.136399] Function entered at [<bf25a558>] from [<bf25a65c>]
�[  968.139191]  nf_log_ipv6
���[  968.146831] Function entered at [<bf25a65c>] from [<bf25b740>]
�[  968.146837] Function entered at [<bf25b740>] from [<bf25ba7c>]
�[  968.146843] Function entered at [<bf25ba7c>] from [<c063b268>]
�[  968.146850] Function entered at [<c063b268>] from [<c063b9d4>]
�[  968.149621]  nf_log_common
�[  968.154487] Function entered at [<c063b9d4>] from [<c0720580>]
�[  968.154493] Function entered at [<c0720580>] from [<c0720614>]
�[  968.154498] Function entered at [<c0720614>] from [<c0720744>]
�[  968.154506] Function entered at [<c0720744>] from [<c0720798>]
�[  968.156932]  ip6table_mangle
���[  968.162845] Function entered at [<c0720798>] from [<c072097c>]
�[  968.162850] Function entered at [<c072097c>] from [<c071dfb8>]
�[  968.162855] Function entered at [<c071dfb8>] from [<c063b268>]
�[  968.162863] Function entered at [<c063b268>] from [<c063b9d4>]
�[  968.168751]  ip6table_filter
���[  968.170852] Function entered at [<c063b9d4>] from [<c06a96a4>]
�[  968.176768]  ip6_tables
[  968.179204] Function entered at [<c06a96a4>] from [<c06a9920>]
�[  968.185114]  ip6t_REJECT
���[  968.187209] Function entered at [<c06a9920>] from [<c064645c>]
�[  968.193124]  x_tables
��[  968.199028] Function entered at [<c064645c>] from [<c0649504>]
�[  968.202170]  nf_reject_ipv6
[  968.208074] Function entered at [<c0649504>] from [<c06495fc>]
�[  968.210863]  ip6_gre
���[  968.216774] Function entered at [<c06495fc>] from [<c067c5f8>]
�[  968.216780] Function entered at [<c067c5f8>] from [<c067d11c>]
�[  968.216787] Function entered at [<c067d11c>] from [<c067d8c4>]
�[  968.222692]  ip_gre
[  968.228600] Function entered at [<c067d8c4>] from [<c06a3e94>]
�[  968.234515]  gre
���[  968.237299] Function entered at [<c06a3e94>] from [<c06a5da8>]
�[  968.243215]  ip6_tunnel
[  968.249123] Function entered at [<c06a5da8>] from [<c061f1e4>]
�[  968.255037]  tunnel6
���[  968.260942] Function entered at [<c061f1e4>] from [<c03073c0>]
�[  968.264083]  ip_tunnel
�[  968.270057] ---[ end trace df518fc833e253a1 ]---
���[  968.275913]  mpls_iptunnel mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
���[  968.391098] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  968.404273] Hardware name: Generic DT based system
�[  968.411932] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  968.416799] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  968.424094] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  968.430004] Function entered at [<c073fe14>] from [<c031dd34>]
�[  968.435918] Function entered at [<c031dd34>] from [<c031dd88>]
�[  968.441829] Function entered at [<c031dd88>] from [<bf234d74>]
�[  968.447744] Function entered at [<bf234d74>] from [<bf2374d4>]
�[  968.453655] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  968.459567] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  968.465479] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  968.471388] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  968.477299] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  968.483211] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  968.489122] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  968.495036] Function entered at [<c0634a90>] from [<c0634b74>]
�[  968.500946] Function entered at [<c0634b74>] from [<c0636b80>]
�[  968.506859] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  968.512771] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  968.518686] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  968.524596] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  968.530509] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  968.536420] Function entered at [<c0333bb0>] from [<c0339070>]
�[  968.542332] Function entered at [<c0339070>] from [<c03074a8>]
�[  968.548331] ---[ end trace df518fc833e253a2 ]---
���[  968.554168] ------------[ cut here ]------------
���[  968.559033] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf233718 [mac80211@bf230000+0x62000]
�[  968.563924] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  968.575382] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pppox ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD xt_CT slhc openvswitch nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4 nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c iptable_mangle iptable_filter ip_tables hwmon crc_ccitt compat ledtrig_usbport nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ip6_gre ip_gre gre ip6_tunnel tunnel6 ip_tunnel mpls_iptunnel
���[  968.629754]  mpls_router mpls_gso leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple gpio_button_hotplug crc32c_generic
�[  968.653203] CPU: 2 PID: 64 Comm: kworker/2:1 Tainted: G        W       4.14.171 #0
�[  968.664978] Hardware name: Generic DT based system
�[  968.672635] Workqueue: events_freezable 0xbf230748 [mac80211@bf230000+0x62000]
�[  968.677504] Function entered at [<c030e2a8>] from [<c030a7a8>]
�[  968.684798] Function entered at [<c030a7a8>] from [<c073fe14>]
�[  968.690712] Function entered at [<c073fe14>] from [<c031dd34>]
�[  968.696624] Function entered at [<c031dd34>] from [<c031dd88>]
�[  968.702535] Function entered at [<c031dd88>] from [<bf233718>]
�[  968.708448] Function entered at [<bf233718>] from [<bf23edf4>]
�[  968.714361] Function entered at [<bf23edf4>] from [<bf23d384>]
�[  968.720272] Function entered at [<bf23d384>] from [<bf234a90>]
�[  968.721105] ------------[ cut here ]------------
���[  968.726188] Function entered at [<bf234a90>] from [<bf2374d4>]
�[  968.732114] WARNING: CPU: 3 PID: 0 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf257584 [mac80211@bf230000+0x62000]
��[  968.736968] Function entered at [<bf2374d4>] from [<bf24b9e0>]
�[  968.742899] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  968.754346] Function entered at [<bf24b9e0>] from [<bf210d2c>]
�[  968.754352] Function entered at [<bf210d2c>] from [<bf1e9d98>]
�[  968.754360] Function entered at [<bf1e9d98>] from [<bf1e9fb8>]
�[  968.760258] Modules linked in:
�[  968.766516] Function entered at [<bf1e9fb8>] from [<c0339ce0>]
�[  968.766522] Function entered at [<c0339ce0>] from [<c0339e5c>]
�[  968.766530] Function entered at [<c0339e5c>] from [<c0634a90>]
�[  968.772434]  pppoe
�[  968.778345] Function entered at [<c0634a90>] from [<c0634b74>]
�[  968.784258]  ppp_async
�[  968.787392] Function entered at [<c0634b74>] from [<c0636b80>]
�[  968.793305]  ath10k_pci
[  968.799216] Function entered at [<c0636b80>] from [<bf1e98fc>]
�[  968.805121]  ath10k_core
���[  968.807220] Function entered at [<bf1e98fc>] from [<bf26133c>]
�[  968.813126]  ath
���[  968.815572] Function entered at [<bf26133c>] from [<bf2307f0>]
�[  968.821479]  pppox
�[  968.823925] Function entered at [<bf2307f0>] from [<c03336f0>]
�[  968.829829]  ppp_generic
���[  968.832621] Function entered at [<c03336f0>] from [<c0333bb0>]
�[  968.832628] Function entered at [<c0333bb0>] from [<c0339070>]
�[  968.838527]  mac80211
��[  968.840629] Function entered at [<c0339070>] from [<c03074a8>]
�[  968.846540]  iptable_nat
���[  968.848726] ---[ end trace df518fc833e253a3 ]---
���[  968.854541]  ipt_REJECT ipt_MASQUERADE cfg80211
[  968.857336] wlan0: HW problem - can not stop rx aggregation for 04:f0:21:af:b5:25 tid 0
[  968.863244]  xt_time xt_tcpudp xt_state xt_nat xt_multiport
[  968.869160] ------------[ cut here ]------------
���[  968.871595]  xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS
�[  968.877511] WARNING: CPU: 2 PID: 64 at backports-4.19.98-1/net/mac80211/driver-ops.h:19 0xbf234d74 [mac80211@bf230000+0x62000]
�[  968.880289]  xt_REDIRECT
���[  968.885175] wlan0:  Failed check-sdata-in-driver check, flags: 0x9
�[  968.889689]  xt_LOG
[  968.897693] Modules linked in:
�[  968.903247]  xt_FLOWOFFLOAD xt_CT slhc openvswitch
�[  968.908118]  pppoe
�[  968.914734]  nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv6 nf_nat_masquerade_ipv4
��[  968.926192]  ppp_async
�[  968.928977]  nf_conntrack_ipv6
�[  968.935240]  ath10k_pci
[  968.937323]  nf_nat_ipv6
���[  968.940460]  ath10k_core
���[  968.945334]  nf_conntrack_ipv4 nf_nat_ipv4
�[  968.947429]  ath
���[  968.955768]  nf_nat nf_log_ipv4
[  968.958202]  pppox
�[  968.961337]  nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack libcrc32c
��[  968.963775]  ppp_generic
���[  968.966561]  iptable_mangle
[  968.969351]
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
