Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD15A7D2B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfIDHzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 03:55:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:31776 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfIDHzi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 03:55:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 00:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="198969767"
Received: from pgarraul-mobl.ger.corp.intel.com ([10.252.2.140])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 00:55:36 -0700
Message-ID: <e4f97f9b0bc46569c39d8c422e54ccbe36960728.camel@intel.com>
Subject: Re: [linuxwifi] Issue with Intel(R) Wireless-AC 9260 in wifi direct
 in 5GHz
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Equipe Soft <equipe.soft.isere@gmail.com>, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed, 04 Sep 2019 10:55:35 +0300
In-Reply-To: <CAFb4eQ=MhqhKL9_wCo++g94F+z_-15ZJitiYh1dLqf99CKwTog@mail.gmail.com>
References: <CAFb4eQnHy5GFRq21C-knnOc9jrcXUYYameoS2Onk9jqp2Pjqig@mail.gmail.com>
         <CAFb4eQ=MhqhKL9_wCo++g94F+z_-15ZJitiYh1dLqf99CKwTog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry for the delay.  This bug was already reported[1] and fixed[2]. 
But it seems that you are unfortunately using an old kernel (v4.18)
that hasn't been maintained for about 10 months... Please update your
kernel or try to cherry-pick the patch on top of your tree.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=201105
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=82715ac71e6b94a2c2136

HTH.

--
Cheers,
Luca.


On Wed, 2019-09-04 at 09:20 +0200, Equipe Soft wrote:
> Hello, do you have any news about the issue?
> 
> Le mer. 28 août 2019 à 19:17, Equipe Soft
> <equipe.soft.isere@gmail.com> a écrit :
> > Hello,
> > I'm trying to set up a wifi direct group between my AC9260 wifi board and a android tablet supporting WifiDirect.
> > 
> > I tried several configurations and I faced some issues.
> > Here follow the testing sequence. All the following command are sent through wpa_cli:
> > 
> > > p2p_find
> > P2P-DEVICE-FOUND f2:ee:10:c2:ce:68 p2p_dev_addr=f2:ee:10:c2:ce:68 pri_dev_type=10-0050F204-5 name='[Tablet] Galaxy Tab S3' config_methods=0x188 dev_capab=0x25 group_capab=0x0 vendor_elems=1 new=1
> > 
> > > p2p_connect f2:ee:10:c2:ce:68 pin 1234 go_intent=1
> > 74493685
> > 
> > PIN is set on the tablet then, on my terminal I see:
> > 
> > P2P-GO-NEG-SUCCESS role=GO freq=5785 ht40=0 peer_dev=f2:ee:10:c2:ce:68 peer_iface=f2:ee:10:c2:4e:68 wps_method=Display
> > P2P-GROUP-FORMATION-FAILURE
> > P2P-GROUP-REMOVED p2p-wlan0-0 GO reason=FORMATION_FAILED
> > 
> > dmesg :
> > 
> > [ 1875.593069] IPv6: ADDRCONF(NETDEV_UP): p2p-wlan0-0: link is not ready
> > [ 1875.659199] iwlwifi 0000:01:00.0: Microcode SW error detected.  Restarting 0x2000000.
> > [ 1875.667246] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> > [ 1875.672851] iwlwifi 0000:01:00.0: Status: 0x00000100, count: 6
> > [ 1875.678718] iwlwifi 0000:01:00.0: Loaded firmware version: 38.755cfdd8.0
> > [ 1875.685466] iwlwifi 0000:01:00.0: 0x000014FC | ADVANCED_SYSASSERT
> > [ 1875.692498] iwlwifi 0000:01:00.0: 0x00A0A200 | trm_hw_status0
> > [ 1875.698270] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> > [ 1875.704048] iwlwifi 0000:01:00.0: 0x00454EF6 | branchlink2
> > [ 1875.709561] iwlwifi 0000:01:00.0: 0x0045E90E | interruptlink1
> > [ 1875.715330] iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
> > [ 1875.721096] iwlwifi 0000:01:00.0: 0x00009D00 | data1
> > [ 1875.726084] iwlwifi 0000:01:00.0: 0x00000741 | data2
> > [ 1875.731070] iwlwifi 0000:01:00.0: 0x00090010 | data3
> > [ 1875.736076] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> > [ 1875.741589] iwlwifi 0000:01:00.0: 0x6F091C80 | tsf low
> > [ 1875.746757] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> > [ 1875.751833] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> > [ 1875.757081] iwlwifi 0000:01:00.0: 0x6F091C81 | time gp2
> > [ 1875.762325] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> > [ 1875.768529] iwlwifi 0000:01:00.0: 0x00000026 | uCode version major
> > [ 1875.774731] iwlwifi 0000:01:00.0: 0x755CFDD8 | uCode version minor
> > [ 1875.780934] iwlwifi 0000:01:00.0: 0x00000321 | hw version
> > [ 1875.786352] iwlwifi 0000:01:00.0: 0x00C89004 | board version
> > [ 1875.792044] iwlwifi 0000:01:00.0: 0x801BF402 | hcmd
> > [ 1875.796951] iwlwifi 0000:01:00.0: 0x24022000 | isr0
> > [ 1875.801853] iwlwifi 0000:01:00.0: 0x01000000 | isr1
> > [ 1875.806751] iwlwifi 0000:01:00.0: 0x08301802 | isr2
> > [ 1875.811653] iwlwifi 0000:01:00.0: 0x00415CC0 | isr3
> > [ 1875.816559] iwlwifi 0000:01:00.0: 0x00000000 | isr4
> > [ 1875.821462] iwlwifi 0000:01:00.0: 0x000501D1 | last cmd Id
> > [ 1875.826975] iwlwifi 0000:01:00.0: 0x00000000 | wait_event
> > [ 1875.832399] iwlwifi 0000:01:00.0: 0x000000D0 | l2p_control
> > [ 1875.837928] iwlwifi 0000:01:00.0: 0x00018014 | l2p_duration
> > [ 1875.843527] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
> > [ 1875.849040] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> > [ 1875.854811] iwlwifi 0000:01:00.0: 0x0000000D | lmpm_pmg_sel
> > [ 1875.860412] iwlwifi 0000:01:00.0: 0x04071046 | timestamp
> > [ 1875.865758] iwlwifi 0000:01:00.0: 0x0000C0E4 | flow_handler
> > [ 1875.871405] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> > [ 1875.877037] iwlwifi 0000:01:00.0: Status: 0x00000100, count: 7
> > [ 1875.882889] iwlwifi 0000:01:00.0: 0x00000070 | ADVANCED_SYSASSERT
> > [ 1875.889020] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> > [ 1875.894959] iwlwifi 0000:01:00.0: 0xC0087CB8 | umac branchlink2
> > [ 1875.900904] iwlwifi 0000:01:00.0: 0xC0084264 | umac interruptlink1
> > [ 1875.907134] iwlwifi 0000:01:00.0: 0xC00847C8 | umac interruptlink2
> > [ 1875.913344] iwlwifi 0000:01:00.0: 0x00000800 | umac data1
> > [ 1875.918764] iwlwifi 0000:01:00.0: 0xC00847C8 | umac data2
> > [ 1875.924184] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
> > [ 1875.929606] iwlwifi 0000:01:00.0: 0x00000026 | umac major
> > [ 1875.935026] iwlwifi 0000:01:00.0: 0x755CFDD8 | umac minor
> > [ 1875.940448] iwlwifi 0000:01:00.0: 0xC0887F30 | frame pointer
> > [ 1875.946128] iwlwifi 0000:01:00.0: 0xC0887F30 | stack pointer
> > [ 1875.951810] iwlwifi 0000:01:00.0: 0x0006012B | last host cmd
> > [ 1875.957488] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
> > [ 1875.963268] ieee80211 phy0: Hardware restart was requested
> > [ 1875.968932] iwlwifi 0000:01:00.0: iwlwifi transaction failed, dumping registers
> > [ 1875.976275] iwlwifi 0000:01:00.0: iwlwifi device config registers:
> > [ 1875.983647] iwlwifi 0000:01:00.0: 00000000: 25268086 00100406 02800029 00000000 e0000004 00000000 00000000 00000000
> > [ 1875.994312] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000 00148086 00000000 000000c8 00000000 0000012b
> > [ 1876.004835] iwlwifi 0000:01:00.0: iwlwifi device memory mapped registers:
> > [ 1876.011780] iwlwifi 0000:01:00.0: 00000000: 00c89004 00000040 00000000 ba00008b 00000000 00000000 00027e1f 00000000
> > [ 1876.022251] iwlwifi 0000:01:00.0: 00000020: 00000000 0c040005 00000321 d55555d5 d55555d5 d55555d5 80008040 041f0044
> > [ 1876.032714] iwlwifi 0000:01:00.0: iwlwifi device AER capability structure:
> > [ 1876.039694] iwlwifi 0000:01:00.0: 00000000: 14c10001 00000000 00000000 00462031 00000000 00002000 00000000 00000000
> > [ 1876.050219] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
> > [ 1876.056838] iwlwifi 0000:01:00.0: iwlwifi parent port (0000:00:00.0) config registers:
> > [ 1876.064933] iwlwifi 0000:00:00.0: 00000000: d02110ee 00100006 06040000 00010000 00000000 00000000 000c0100 00000000
> > [ 1876.075399] iwlwifi 0000:00:00.0: 00000020: e000e000 0001fff1 00000000 00000000 00000000 00000040 00000000 0000012b
> > [ 1876.085869] iwlwifi 0000:01:00.0: FW error in SYNC CMD BINDING_CONTEXT_CMD
> > [ 1876.092773] CPU: 1 PID: 498 Comm: wpa_supplicant Not tainted 4.18.31-yocto-standard #1
> > [ 1876.100680] Hardware name: ********
> > [ 1876.105290] Call trace:
> > [ 1876.107744]  dump_backtrace+0x0/0x158
> > [ 1876.111403]  show_stack+0x24/0x30
> > [ 1876.114723]  dump_stack+0x80/0xa4
> > [ 1876.118064]  iwl_trans_pcie_send_hcmd+0x5d0/0x5e8 [iwlwifi]
> > [ 1876.123649]  iwl_trans_send_cmd+0x68/0x108 [iwlwifi]
> > [ 1876.128644]  iwl_mvm_send_cmd_status+0x44/0xe0 [iwlmvm]
> > [ 1876.133889]  iwl_mvm_send_cmd_pdu_status+0x6c/0x98 [iwlmvm]
> > [ 1876.139480]  iwl_mvm_binding_update+0x148/0x230 [iwlmvm]
> > [ 1876.144809]  iwl_mvm_binding_add_vif+0x5c/0x80 [iwlmvm]
> > [ 1876.150048]  iwl_mvm_start_ap_ibss+0xe0/0x238 [iwlmvm]
> > [ 1876.155268]  ieee80211_start_ap+0x218/0x488 [mac80211]
> > [ 1876.160473]  nl80211_start_ap+0x3f4/0x6a8 [cfg80211]
> > [ 1876.165446]  genl_family_rcv_msg+0x1cc/0x338
> > [ 1876.169718]  genl_rcv_msg+0xa0/0xd8
> > [ 1876.173207]  netlink_rcv_skb+0x60/0x120
> > [ 1876.177043]  genl_rcv+0x3c/0x50
> > [ 1876.180186]  netlink_unicast+0x194/0x210
> > [ 1876.184109]  netlink_sendmsg+0x1a0/0x348
> > [ 1876.188036]  sock_sendmsg+0x34/0x50
> > [ 1876.191523]  ___sys_sendmsg+0x288/0x2c8
> > [ 1876.195357]  __sys_sendmsg+0x7c/0xd0
> > [ 1876.198933]  sys_sendmsg+0x38/0x48
> > [ 1876.202330]  el0_svc_naked+0x30/0x34
> > [ 1876.206366] iwlwifi 0000:01:00.0: Failed to send binding (action:1): -5
> > [ 1876.213092] iwlwifi 0000:01:00.0: Failed to remove MAC context: -5
> > [ 1876.219353] iwlwifi 0000:01:00.0: PHY ctxt cmd error. ret=-5
> > 
> > It looks like the module firmware got an error when trying to set the module in AP in 5GHz. I know there could be some regulatory limitation for IBSS in 5Ghz, but why this does not work for wifi direct.
> > Thanks for your time.
> > @team.
> > 
> -------------------------------------
> linuxwifi@eclists.intel.com
> https://eclists.intel.com/sympa/info/linuxwifi
> Unsubscribe by sending email to sympa@eclists.intel.com with subject "Unsubscribe linuxwifi"

