Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02972758C21
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 05:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGSDbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jul 2023 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGSDbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jul 2023 23:31:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3F18E
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 20:29:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J3BOP3031255;
        Wed, 19 Jul 2023 03:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1TKpe4IXnzVLSA2xPSb0s8+w6vTjD696bEELmj0GTDo=;
 b=Chu2YvrNl2H1BKeCDUeZnVbV1gXvBURpibIVvPR/nKzz70A+RqZ0VnVwt0w0gOHfT7+W
 25etvzv1n4xB1zFK6xFv2O5B/MLk65MkCSObTbGut2XhmSqr+MWOIV3ZxbWPqjooFrIq
 Ke1dJjX5clV/a1BsbHjgLFV9uTx587M4e2PlymYcgfXDr2i21Y/0rUwSRHRrwjD9yGRw
 D8zhYMW6GFdg7stgpbLbYmlS9bT0bIFMUg6/aBMI4qyMpJnHR1ud0GnTXaqvc2rPpZaK
 0Vp2yzGxCpXGIAll5GfGIo/wKiqxf99dzOP7n5hliJzmLDKgE0iesm2g5BcZdAa3yjle /w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwpphj8e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 03:29:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J3TQG2003477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 03:29:26 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 20:29:24 -0700
Message-ID: <6c0ac15f-8e46-b79c-ea70-e781615aa5b2@quicinc.com>
Date:   Wed, 19 Jul 2023 11:29:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
 <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
 <5c85b2bcfbffb617c5aa3f55e7ae94a1ab4df743.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <5c85b2bcfbffb617c5aa3f55e7ae94a1ab4df743.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IZbdhbb4pRvZMNsqpeXHhHF5Xh1qFOjA
X-Proofpoint-ORIG-GUID: IZbdhbb4pRvZMNsqpeXHhHF5Xh1qFOjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=512 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190032
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,
On 8/26/2021 6:57 PM, Johannes Berg wrote:
> On Thu, 2021-08-26 at 18:50 +0800, Wen Gong wrote:
>> it is memset here i this patch:
> Oops, missed that.
>
> But is that really a good place for it? Doesn't really seem to belong to
> assigning a channel context - maybe put it into set_disassoc()?
>
> johannes
We hit buffer overflow issue while connecting to 6 GHz AP fail and fail.
Will you fix it? Or do you have any suggestion to fix it?

[  227.539928] wlp90s0: authenticate with 02:03:7f:12:66:66
[  227.601846] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  227.633902] wlp90s0: authenticate with 02:03:7f:12:66:66
[  227.633906] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  227.657203] wlp90s0: 02:03:7f:12:66:66 denied authentication (status 1)
...
[  263.014661] wlp90s0: authenticate with 02:03:7f:12:66:66
[  263.075667] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  263.112427] wlp90s0: authenticate with 02:03:7f:12:66:66
[  263.112433] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  263.132507] wlp90s0: 02:03:7f:12:66:66 denied authentication (status 1)
[  279.668551] wlp90s0: authenticate with 02:03:7f:12:66:66
[  279.728848] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  279.763685] wlp90s0: authenticate with 02:03:7f:12:66:66
[  279.763696] wlp90s0: send auth to 02:03:7f:12:66:66 (try 1/3)
[  279.790867] wlp90s0: 02:03:7f:12:66:66 denied authentication (status 1)

for above fail, ieee80211_set_disassoc() is not called, so the
bss_conf->tx_pwr_env_num never reset and it is increased each
time in ieee80211_prep_channel().

Finally the bss_conf->tx_pwr_env_num arrived to 20+(it should be 1 for 
correct
value), it has exceeded the max value IEEE80211_TPE_MAX_IE_COUNT(8), and
lead access bss_conf->tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT] overflow.

[  327.391621] wlp90s0: authenticate with 02:03:7f:12:66:66
[  327.434036] BUG: kernel NULL pointer dereference, address: 
0000000000000018
[  327.434039] #PF: supervisor read access in kernel mode
[  327.434040] #PF: error_code(0x0000) - not-present page
[  327.434042] PGD 0 P4D 0
[  327.434044] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  327.434047] CPU: 2 PID: 804 Comm: wpa_supplicant Kdump: loaded 
Tainted: G        W          6.2.0-rc8-wt-ath+ #13
[  327.434050] Hardware name: Intel(R) Client Systems 
NUC11PHi7/NUC11PHBi7, BIOS PHTGL579.0063.2021.0707.1057 07/07/2021
[  327.434052] RIP: 0010:ath12k_mac_fill_reg_tpc_info+0x292/0x3b0 [ath12k]
[  327.434080] RSP: 0018:ffffb7330160f448 EFLAGS: 00010246
[  327.434081] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 
00000000005a8f98
[  327.434082] RDX: ffff9c7de1cb7f00 RSI: 00000000006cdf18 RDI: 
ffff9c7de2000508
[  327.434084] RBP: ffffb7330160f4b8 R08: 0000000000000000 R09: 
ffff9c7de1cb7f00
[  327.434084] R10: ffff9c7de2000508 R11: ffffb7330160f0e0 R12: 
ffff9c7dda376090
[  327.434085] R13: 0000000000000001 R14: 0000000000000010 R15: 
ffff9c7de2002080
[  327.434086] FS:  00007f8258ee9c00(0000) GS:ffff9c8170480000(0000) 
knlGS:0000000000000000
[  327.434087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  327.434088] CR2: 0000000000000018 CR3: 0000000108fec006 CR4: 
0000000000770ee0
[  327.434090] PKRU: 55555554
[  327.434090] Call Trace:
[  327.434091]  <TASK>
[  327.434094]  ath12k_mac_vdev_start_restart+0x6c8/0x7f0 [ath12k]
[  327.434104]  ? crypto_alloc_tfm_node+0x60/0x130
[  327.434108]  ath12k_mac_station_add+0x163/0x440 [ath12k]
[  327.434117]  ath12k_mac_handle_link_sta_state.isra.79+0x76/0x420 [ath12k]
[  327.434126]  ath12k_mac_op_sta_state+0x19f/0x350 [ath12k]
[  327.434136]  drv_sta_state+0x89/0x5d0 [mac80211]
[  327.434160]  sta_info_insert_rcu+0x222/0x580 [mac80211]
[  327.434176]  sta_info_insert+0xf/0x20 [mac80211]
[  327.434190]  ieee80211_prep_connection+0x200/0x490 [mac80211]
[  327.434214]  ieee80211_mgd_auth+0x2aa/0x4f0 [mac80211]
[  327.434237]  ? __local_bh_enable_ip+0x3b/0x80
[  327.434239]  ? _raw_spin_unlock_bh+0x1d/0x30
[  327.434243]  ieee80211_auth+0x18/0x20 [mac80211]
[  327.434263]  cfg80211_mlme_auth+0x94/0x180 [cfg80211]
[  327.434297]  nl80211_authenticate+0x392/0x3f0 [cfg80211]
[  327.434315]  genl_family_rcv_msg_doit.isra.19+0xf4/0x120
[  327.434318]  genl_rcv_msg+0x1a5/0x2a0
[  327.434320]  ? __cfg80211_rdev_from_attrs+0x1f0/0x1f0 [cfg80211]
[  327.434336]  ? cfg80211_prepare_cqm.isra.79+0x170/0x170 [cfg80211]
[  327.434352]  ? nl80211_put_signal.part.56+0xd0/0xd0 [cfg80211]
[  327.434368]  ? genl_get_cmd_both+0x60/0x60
[  327.434370]  netlink_rcv_skb+0x5a/0x110
[  327.434372]  genl_rcv+0x28/0x40
[  327.434374]  netlink_unicast+0x1be/0x290
[  327.434375]  netlink_sendmsg+0x377/0x4e0
[  327.434377]  sock_sendmsg+0x9a/0xa0
[  327.434380]  ____sys_sendmsg+0x22b/0x2f0
[  327.434382]  ___sys_sendmsg+0x88/0xd0
[  327.434384]  ? dput+0x5f/0x2e0
[  327.434386]  ? __fsnotify_parent+0x109/0x350
[  327.434389]  __sys_sendmsg+0x6c/0xc0
[  327.434391]  ? __sys_sendmsg+0x6c/0xc0
[  327.434393]  __x64_sys_sendmsg+0x1f/0x30
[  327.434395]  do_syscall_64+0x37/0x90
[  327.434398]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  327.434400] RIP: 0033:0x7f8258927b17
>
>
>
>
