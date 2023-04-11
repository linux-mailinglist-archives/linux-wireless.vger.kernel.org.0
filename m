Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017846DE1E8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDKRJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKRJj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 13:09:39 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE25C1BE1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 10:09:32 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 98EEB280064;
        Tue, 11 Apr 2023 17:09:27 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1446A13C2B0;
        Tue, 11 Apr 2023 10:09:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1446A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1681232967;
        bh=7PCok4FZ2fXO9D1zjCHSe4GclWyBqCgD0bRShL4X7V0=;
        h=Date:To:Cc:From:Subject:From;
        b=GcwBwqttnhesKB0uWvex78e8YHps05HhKQWPvHNvDnEUOHfzh1sfEVdI7FsCdw7L9
         /X6ITq9vtOXf2OCX3QLBwpTn3w31y5JuIhXKYDxL6r+v4qlPBOJph06v40/wwPutFg
         UYrFvIUlh0Bm6pVM27+ltqcisyEr2KOAvXLCx93Q=
Message-ID: <0ec935a0-175c-38ae-cf3c-c001989a3334@candelatech.com>
Date:   Tue, 11 Apr 2023 10:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     amol.jawale@candelatech.com,
        Gregory Greenman <gregory.greenman@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 reliable crash in 100Mbps bi-directional traffic test.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1681232968-iutXPBtWulgZ
X-MDID-O: us5;ut7;1681232968;iutXPBtWulgZ;<greearb@candelatech.com>;265462eed456beb3817746e42c55c9f9
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Our test team reports that they get reliable firmware crashes on ax200 radios against multiple
APs when running 100Mbps UL + DL traffic (100Mbps in both directions).

This happens on 5.19-ish kernels as well as 6.2.9+.
ax210 radios in same setup are much more stable.

Please let us know if you would like additional debug information, including binary
crash dump files from the radio....

[19241.588542] sta0001: Limiting TX power to 27 (30 - 3) dBm as advertised by 28:80:88:f3:b2:00
4[19245.998099] iwlwifi 0000:12:00.0: Microcode SW error detected. Restarting 0x0.
5[19246.004160] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
6[19246.008457] iwlwifi 0000:12:00.0: Transport status: 0x0000004B, valid: 6
7[19246.013867] iwlwifi 0000:12:00.0: Loaded firmware version: 72.daa05125.0 cc-a0-72.ucode
8[19246.020573] iwlwifi 0000:12:00.0: 0x000022CE | ADVANCED_SYSASSERT
9[19246.026241] iwlwifi 0000:12:00.0: 0x00002EF5 | trm_hw_status0
10[19246.030719] iwlwifi 0000:12:00.0: 0x00000000 | trm_hw_status1
11[19246.035186] iwlwifi 0000:12:00.0: 0x004FBE16 | branchlink2
12[19246.039381] iwlwifi 0000:12:00.0: 0x0000196C | interruptlink1
13[19246.043835] iwlwifi 0000:12:00.0: 0x0000196C | interruptlink2
14[19246.048290] iwlwifi 0000:12:00.0: 0x00000078 | data1
15[19246.051967] iwlwifi 0000:12:00.0: 0x00000184 | data2
16[19246.055640] iwlwifi 0000:12:00.0: 0x04000000 | data3
17[19246.059316] iwlwifi 0000:12:00.0: 0x0B016C45 | beacon time
18[19246.063508] iwlwifi 0000:12:00.0: 0x7A1B33B9 | tsf low
19[19246.067354] iwlwifi 0000:12:00.0: 0x00000005 | tsf hi
20[19246.071109] iwlwifi 0000:12:00.0: 0x00000000 | time gp1
21[19246.075042] iwlwifi 0000:12:00.0: 0x0080BD5E | time gp2
22[19246.078972] iwlwifi 0000:12:00.0: 0x00000001 | uCode revision type
23[19246.083857] iwlwifi 0000:12:00.0: 0x00000048 | uCode version major
24[19246.088746] iwlwifi 0000:12:00.0: 0xDAA05125 | uCode version minor
25[19246.093631] iwlwifi 0000:12:00.0: 0x00000340 | hw version
26[19246.097730] iwlwifi 0000:12:00.0: 0x00C89000 | board version
27[19246.102093] iwlwifi 0000:12:00.0: 0x8065FC18 | hcmd
28[19246.105695] iwlwifi 0000:12:00.0: 0xE6F00400 | isr0
29[19246.109295] iwlwifi 0000:12:00.0: 0x08400000 | isr1
30[19246.112885] iwlwifi 0000:12:00.0: 0x00F80002 | isr2
31[19246.116471] iwlwifi 0000:12:00.0: 0x44D3281C | isr3
32[19246.120058] iwlwifi 0000:12:00.0: 0x00000000 | isr4
33[19246.123646] iwlwifi 0000:12:00.0: 0x0351001C | last cmd Id
34[19246.127841] iwlwifi 0000:12:00.0: 0x00012EEE | wait_event
35[19246.131949] iwlwifi 0000:12:00.0: 0x00004288 | l2p_control
36[19246.136134] iwlwifi 0000:12:00.0: 0x00002820 | l2p_duration
37[19246.140415] iwlwifi 0000:12:00.0: 0x00000000 | l2p_mhvalid
38[19246.144612] iwlwifi 0000:12:00.0: 0x000000E7 | l2p_addr_match
39[19246.149067] iwlwifi 0000:12:00.0: 0x00000009 | lmpm_pmg_sel
40[19246.153346] iwlwifi 0000:12:00.0: 0x00000000 | timestamp
41[19246.157369] iwlwifi 0000:12:00.0: 0x0EBC1894 | flow_handler
42[19246.161737] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
43[19246.166019] iwlwifi 0000:12:00.0: Transport status: 0x0000004B, valid: 7
44[19246.171424] iwlwifi 0000:12:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
45[19246.176754] iwlwifi 0000:12:00.0: 0x00000000 | umac branchlink1
46[19246.181383] iwlwifi 0000:12:00.0: 0x80455E3C | umac branchlink2
47[19246.186010] iwlwifi 0000:12:00.0: 0x80472146 | umac interruptlink1
48[19246.190890] iwlwifi 0000:12:00.0: 0x80472146 | umac interruptlink2
49[19246.195773] iwlwifi 0000:12:00.0: 0x00000400 | umac data1
50[19246.199880] iwlwifi 0000:12:00.0: 0x80472146 | umac data2
51[19246.204018] iwlwifi 0000:12:00.0: 0x00000000 | umac data3
52[19246.208139] iwlwifi 0000:12:00.0: 0x00000048 | umac major
53[19246.212245] iwlwifi 0000:12:00.0: 0xDAA05125 | umac minor
54[19246.216354] iwlwifi 0000:12:00.0: 0x0080C054 | frame pointer
55[19246.220719] iwlwifi 0000:12:00.0: 0xC0886264 | stack pointer
56[19246.225090] iwlwifi 0000:12:00.0: 0x006C019C | last host cmd
57[19246.229460] iwlwifi 0000:12:00.0: 0x00000000 | isr status reg
58[19246.233925] iwlwifi 0000:12:00.0: IML/ROM dump:
59[19246.237161] iwlwifi 0000:12:00.0: 0x00000003 | IML/ROM error/state
60[19246.242072] iwlwifi 0000:12:00.0: 0x000057D9 | IML/ROM data1
61[19246.246448] iwlwifi 0000:12:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
62[19246.251703] iwlwifi 0000:12:00.0: Fseq Registers:
63[19246.255123] iwlwifi 0000:12:00.0: 0x60000000 | FSEQ_ERROR_CODE
64[19246.259663] iwlwifi 0000:12:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
65[19246.264725] iwlwifi 0000:12:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
66[19246.269958] iwlwifi 0000:12:00.0: 0x0000A503 | FSEQ_OTP_VERSION
67[19246.274600] iwlwifi 0000:12:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
68[19246.279919] iwlwifi 0000:12:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
69[19246.284557] iwlwifi 0000:12:00.0: 0x00100530 | FSEQ_CNVI_ID
70[19246.288843] iwlwifi 0000:12:00.0: 0x00000532 | FSEQ_CNVR_ID
71[19246.293126] iwlwifi 0000:12:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
72[19246.297930] iwlwifi 0000:12:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
73[19246.302741] iwlwifi 0000:12:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
74[19246.309284] iwlwifi 0000:12:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
75[19246.316368] iwlwifi 0000:12:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
76[19246.316371] ieee80211 wiphy2: Hardware restart was requested
77[19246.316405] iwlwifi 0000:12:00.0: FW error in SYNC CMD STATISTICS_CMD
78[19246.321630] CPU: 1 PID: 3146 Comm: btserver Tainted: G        W  O       6.2.9+ #13
79[19246.321632] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
80[19246.321634] Call Trace:
81[19246.321635]  <TASK>
82[19246.321637]  dump_stack_lvl+0x44/0x60
83[19246.321643]  iwl_trans_txq_send_hcmd+0x3e2/0x440 [iwlwifi]
84[19246.321662]  ? destroy_sched_domains_rcu+0x20/0x20
85[19246.321667]  iwl_trans_send_cmd+0x7f/0xe0 [iwlwifi]
86[19246.321706]  iwl_mvm_send_cmd+0x16/0x40 [iwlmvm]
87[19246.321722]  iwl_mvm_request_statistics+0x13a/0x180 [iwlmvm]
88[19246.321731]  ? iwl_mvm_tcm_iterator+0x20/0x20 [iwlmvm]
89[19246.321739]  iwl_mvm_mac_sta_statistics+0x22d/0x3e0 [iwlmvm]
90[19246.321748]  sta_set_sinfo+0xb7/0xc20 [mac80211]
91[19246.321794]  ieee80211_get_stats2+0x457/0xaf0 [mac80211]
92[19246.321816]  ? __alloc_pages+0xed/0x210
93[19246.321819]  ? __alloc_pages_bulk+0x3e0/0x690
94[19246.321821]  ? __vmap_pages_range_noflush+0x392/0x4c0
95[19246.321826]  dev_ethtool+0x1d28/0x2a60
96[19246.321831]  ? path_openat+0xa33/0x10a0
97[19246.321835]  ? netdev_name_node_lookup_rcu+0x5e/0x80
98[19246.321837]  dev_ioctl+0x2bd/0x4d0
99[19246.321840]  sock_do_ioctl+0x9c/0xe0
100[19246.321844]  sock_ioctl+0x15a/0x2b0
101[19246.321846]  ? __call_rcu_common.constprop.0+0x97/0x280
102[19246.321848]  __x64_sys_ioctl+0x7a/0xb0
103[19246.321850]  do_syscall_64+0x35/0xb0
104[19246.321854]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
105[19246.321858] RIP: 0033:0x7f7894f2cf9b
106[19246.321861] Code: 0f 1e fa 48 8b 05 ed ce 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 8b 0d bd ce 0c 00 f7 d8 64 89 01 48
107[19246.321863] RSP: 002b:00007ffe96f42b68 EFLAGS: 00000203 ORIG_RAX: 0000000000000010
108[19246.321865] RAX: ffffffffffffffda RBX: 00000000035331b0 RCX: 00007f7894f2cf9b
109[19246.321866] RDX: 00007ffe96f42ba0 RSI: 0000000000008946 RDI: 0000000000000007
110[19246.321867] RBP: 00007ffe96f44700 R08: 000000000364cb70 R09: 0000000000080000
111[19246.321868] R10: 0000000000000000 R11: 0000000000000203 R12: 0000000000467a24
112[19246.321869] R13: 000000000090c704 R14: 0000000000000000 R15: 0000000000000000
113[19246.321871]  </TASK>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

