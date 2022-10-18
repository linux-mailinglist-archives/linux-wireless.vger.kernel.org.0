Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B9602771
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJRIr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJRIrz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 04:47:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC61A3A7
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 01:47:52 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I8KrX4017835;
        Tue, 18 Oct 2022 08:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h3AcMk37TS01DjVdFrsykWtJg8QY60IHsx6d4j9cbgQ=;
 b=ctA9+YmVfw1UTm2TLt+tEUn8Q8XWpXrPkLTQ6Pg4RMvKpzGLnuCY+XydJGZ9JzoFlnRQ
 jIFyqbOY0N0LTfDbbJ08Q07VCK3z7JKVHz8hW3ce1WXfnqvyRU0R+4X+yJ73Eg3jwpor
 hBn4rele6gSvl8IJcvf4ZMv+0YqbycMCrnlu9/UCNUeHHRRb2BfTEA7/O5GYpiCHhO3W
 MgU/QP0W8rarf0ua7lsYnBClOATRSdN2SqknI1njt3URO0x6xUlYbKzPYmFgORFMBlRp
 ix5s1c6zHz5bNrVNAueKriSdV8l4xkx/FgoE4GN3ujgJv768WDF1OfO9j0DQJrsIh4pt OQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9n2p0kj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:47:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I8ldRP019214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 08:47:39 GMT
Received: from [10.253.75.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 01:47:37 -0700
Message-ID: <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
Date:   Tue, 18 Oct 2022 16:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>,
        <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Drb8F50-VE7QPmY8arKO2QuPK7EeViJe
X-Proofpoint-GUID: Drb8F50-VE7QPmY8arKO2QuPK7EeViJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/2022 3:39 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Split the bss_info_changed method to vif_cfg_changed and
> link_info_changed, with the latter getting a link ID.
> Also change the 'changed' parameter to u64 already, we
> know we need that.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   
...
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 0c81ae492df4..6165b90bf0e2 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -199,15 +199,84 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
>   	return ret;
>   }
>   
> +#define BSS_CHANGED_VIF_CFG_FLAGS (BSS_CHANGED_ASSOC |\
> +				   BSS_CHANGED_IDLE |\
> +				   BSS_CHANGED_IBSS |\
> +				   BSS_CHANGED_ARP_FILTER |\
> +				   BSS_CHANGED_SSID)
> +
>   void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
> -				      u32 changed)
> +				      u64 changed)
>   {
>   	struct ieee80211_local *local = sdata->local;
>   
> +	might_sleep();
> +
>   	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>   		return;
>   
> -	drv_bss_info_changed(local, sdata, &sdata->vif.bss_conf, changed);
> +	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
> +				    BSS_CHANGED_BEACON_ENABLED) &&
> +			 sdata->vif.type != NL80211_IFTYPE_AP &&
> +			 sdata->vif.type != NL80211_IFTYPE_ADHOC &&
> +			 sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
> +			 sdata->vif.type != NL80211_IFTYPE_OCB))
> +		return;
> +
> +	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
> +			 sdata->vif.type == NL80211_IFTYPE_NAN ||
> +			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
> +			  !sdata->vif.bss_conf.mu_mimo_owner &&
> +			  !(changed & BSS_CHANGED_TXPOWER))))
> +		return;
> +
> +	if (!check_sdata_in_driver(sdata))
> +		return;
> +
> +	if (changed & BSS_CHANGED_VIF_CFG_FLAGS) {
> +		trace_drv_vif_cfg_changed(local, sdata, changed);
> +		if (local->ops->vif_cfg_changed)
> +			local->ops->vif_cfg_changed(&local->hw, &sdata->vif, changed);
> +	}
> +
> +	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
> +		/* FIXME: should be for each link */
> +		trace_drv_link_info_changed(local, sdata, 0, changed);
> +		if (local->ops->link_info_changed)
> +			local->ops->link_info_changed(&local->hw, &sdata->vif,
> +						      0, changed);
Hi Johannes,

I think you/someone will change here later for the "/* FIXME: should be 
for each link */", right?

It lead error/kernel crash as below while reconfig single MLO link which 
link id is 2.
When test with single MLO link which link id is 0, not found 
error/kernel crash.

I think it is because the sdata->vif.bss_conf link id is 0, but
the actual MLO link id is 2 when error/kernel crash happened.

Now I did a temp workaround to skip the crash.
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 061b5460799d..46249b9919ac 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -243,7 +243,8 @@ void ieee80211_bss_info_change_notify(struct 
ieee80211_sub_if_data *sdata,
local->ops->vif_cfg_changed(&local->hw, &sdata->vif, ch);
         }

-       if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
+       if (((!sdata->vif.valid_links) || (sdata->vif.valid_links & 
BIT(0))) &&
+           changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
                 u64 ch = changed & ~BSS_CHANGED_VIF_CFG_FLAGS;

                 /* FIXME: should be for each link */

kernel crash:
[  779.959413] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[  779.959418] #PF: supervisor read access in kernel mode
[  779.959421] #PF: error_code(0x0000) - not-present page
[  779.959424] PGD 0 P4D 0
[  779.959429] Oops: 0000 [#1] PREEMPT SMP PTI
[  779.959433] CPU: 2 PID: 2603 Comm: kworker/2:0 Kdump: loaded Tainted: 
G        W  OE     5.19.0-rc6+ #4
[  779.959438] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW 
(1.33 ) 07/29/2011
[  779.959442] Workqueue: events_freezable ieee80211_restart_work [mac80211]
[  779.959493] RIP: 0010:ath12k_mac_link_info_changed+0x31/0xc70 [ath12k]
[  779.959517] Code: 89 e5 41 57 41 56 49 89 d6 41 55 49 89 fd 41 54 49 
89 f4 53 48 89 cb 48 83 ec 48 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 
c0 <48> 8b 06 83 e1 40 48 89 45 a0 48 8b 40 08 48 89 45 a8 0f b6 46 08
[  779.959521] RSP: 0018:ffffbb7f4318bcf0 EFLAGS: 00010246
[  779.959525] RAX: 0000000000000000 RBX: 00000000021424fe RCX: 
00000000021424fe
[  779.959528] RDX: ffffa0878dd95bd8 RSI: 0000000000000000 RDI: 
ffffa08792b6a080
[  779.959531] RBP: ffffbb7f4318bd60 R08: ffffffffc0e8db90 R09: 
c00000010005e8a2
[  779.959534] R10: 0000000000000000 R11: ffffbb7f4318b6b0 R12: 
0000000000000000
[  779.959536] R13: ffffa08792b6a080 R14: ffffa0878dd95bd8 R15: 
ffffa08792b6a080
[  779.959539] FS:  0000000000000000(0000) GS:ffffa088ba280000(0000) 
knlGS:0000000000000000
[  779.959542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  779.959545] CR2: 0000000000000000 CR3: 0000000103030006 CR4: 
00000000000606e0
[  779.959548] Call Trace:
[  779.959551]  <TASK>
[  779.959557]  ath12k_mac_op_link_info_changed+0x47/0x60 [ath12k]
[  779.959575]  ieee80211_bss_info_change_notify+0x182/0x2a0 [mac80211]
[  779.959617]  ieee80211_reconfig+0xc40/0x1570 [mac80211]
[  779.959672]  ? _raw_spin_unlock_irqrestore+0x27/0x43
[  779.959678]  ? try_to_del_timer_sync+0x53/0x80
[  779.959686]  ieee80211_restart_work+0xfe/0x160 [mac80211]
[  779.959726]  process_one_work+0x227/0x440
[  779.959732]  worker_thread+0x31/0x3e0
[  779.959736]  ? process_one_work+0x440/0x440
[  779.959739]  kthread+0xfe/0x130
[  779.959744]  ? kthread_complete_and_exit+0x20/0x20
[  779.959749]  ret_from_fork+0x22/0x30
[  779.959758]  </TASK>
[  779.959760] Modules linked in: michael_mic ath12k(OE) qmi_helpers 
qrtr_mhi mhi(E) qrtr mac80211(OE) cfg80211(OE) libarc4 rfcomm bnep 
nls_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel kvm irqbypass snd_ctl_led 
crct10dif_pclmul ghash_clmulni_intel snd_hda_codec_conexant 
snd_hda_codec_hdmi snd_hda_codec_generic aesni_intel snd_hda_intel 
snd_intel_dspcfg snd_hda_codec crypto_simd cryptd rapl intel_cstate 
snd_hda_core snd_hwdep uvcvideo thinkpad_acpi videobuf2_vmalloc 
videobuf2_memops videobuf2_v4l2 nvram ledtrig_audio videobuf2_common 
videodev snd_pcm platform_profile snd_seq_midi snd_seq_midi_event mc 
btusb i915 btrtl btbcm btintel bluetooth cec rc_core snd_rawmidi 
drm_buddy ecdh_generic ecc snd_seq ttm drm_display_helper snd_seq_device 
snd_timer drm_kms_helper snd i2c_algo_bit fb_sys_fops syscopyarea 
sysfillrect sysimgblt soundcore mei_me mei at24 joydev input_leds 
serio_raw mac_hid wmi_bmof sch_fq_codel parport_pc ppdev lp parport drm
[  779.959856]  ip_tables x_tables autofs4 crc32_pclmul sdhci_pci e1000e 
firewire_ohci i2c_i801 ptp ahci pps_core psmouse libahci i2c_smbus 
firewire_core cqhci lpc_ich sdhci crc_itu_t wmi video
[  779.959883] CR2: 0000000000000000
> +	}
> +
> +	if (local->ops->bss_info_changed)
> +		local->ops->bss_info_changed(&local->hw, &sdata->vif,
> +					     &sdata->vif.bss_conf, changed);
> +	trace_drv_return_void(local);
> +}
> +
...
