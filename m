Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B05B85C5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiINKAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINKAl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 06:00:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F005E54A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 03:00:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8Tnb9021758;
        Wed, 14 Sep 2022 10:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Zzm5q7Pa/JgIsxNXTQ2YDAm1+mnNoS/LPBSMr3PwmSc=;
 b=NkNQm7P338VVlDjZSctXyEdVAcnhxLZ8sNiqtWXRJBh4+CBF5+zdlqQxn3pJb3UQMh4M
 aNnY5q0VSmDiCJDgYKamnqqGzMIEMze3k6Fyt4ItMD5+If3j6jYzKy1BoPZkI1Cx1djH
 w6g+74JZfWR0DYunwwic58Muac23vWZ68pagrMCfPR1tY1U/1cUMr28CqhtztGs8YGo4
 8KtA3YrPT38zQU05ZgBmx/kxjFWgWieWx06a1ri5PSHS8lfD5FhktSceUIHQf8fd/7pf
 9fCdoZRMUghoewlSqhctcbpTgs2NunJWlf0F1w1T1ZUTXiH/8YU4H70vdHMeMbQ1nJMD 2w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0e20yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 10:00:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28EA0Mem013433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 10:00:22 GMT
Received: from [10.253.15.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 03:00:21 -0700
Message-ID: <509e18bd-3004-9db5-459c-1935ee4eba5f@quicinc.com>
Date:   Wed, 14 Sep 2022 18:00:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 35/76] wifi: mac80211: mlme: use
 ieee80211_get_link_sband()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
 <20220713114425.35973aa556f0.I1394dd82298f09c6cb452be538dba8ba13f11b01@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220713114425.35973aa556f0.I1394dd82298f09c6cb452be538dba8ba13f11b01@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WypAgVHHlzRND5OoXAqToNuCrZqvsspJ
X-Proofpoint-GUID: WypAgVHHlzRND5OoXAqToNuCrZqvsspJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140048
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/13/2022 5:44 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This requires a few more changes.
>
> While at it, also add a warning to ieee80211_get_sband()
> to avoid it being used when there are multiple links.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/mac80211/ieee80211_i.h |  2 ++
>   net/mac80211/mlme.c        | 12 ++++++------
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 3e360bcaa03b..a0743c78d171 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1539,6 +1539,8 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
>   	struct ieee80211_chanctx_conf *chanctx_conf;
>   	enum nl80211_band band;
>   
> +	WARN_ON(sdata->vif.valid_links);
> +
>   	rcu_read_lock();
>   	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
>   
Hi Johannes,

Now I hit below warning here in ieee80211_get_sband() in my MLO test for 
station.
Will you have more patch to fix the warning?

[  712.857016] ------------[ cut here ]------------
[  712.857020] ath12k_pci 0000:05:00.0: ext irq:40
[  712.857021] WARNING: CPU: 2 PID: 39 at 
net/mac80211/ieee80211_i.h:1572 
___ieee80211_start_rx_ba_session+0x8fe/0x930 [mac80211]
[  712.857140] Modules linked in: michael_mic ath12k(OE) qmi_helpers 
qrtr_mhi mhi(E) qrtr mac80211(OE) cfg80211(OE) libarc4 rfcomm bnep 
nls_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul 
ghash_clmulni_intel aesni_intel snd_ctl_led snd_hda_codec_conexant 
crypto_simd cryptd rapl intel_cstate uvcvideo btusb snd_hda_codec_hdmi 
snd_hda_codec_generic btrtl btbcm snd_hda_intel btintel 
videobuf2_vmalloc bluetooth videobuf2_memops snd_intel_dspcfg 
ecdh_generic ecc videobuf2_v4l2 i915 videobuf2_common videodev cec mc 
rc_core drm_buddy ttm snd_hda_codec drm_display_helper snd_hda_core 
drm_kms_helper snd_seq_midi snd_seq_midi_event snd_rawmidi snd_hwdep 
i2c_algo_bit snd_seq snd_pcm thinkpad_acpi fb_sys_fops syscopyarea 
sysfillrect sysimgblt snd_seq_device snd_timer nvram mei_me at24 
ledtrig_audio platform_profile mei joydev input_leds snd soundcore 
serio_raw mac_hid wmi_bmof sch_fq_codel parport_pc ppdev lp parport drm
[  712.857298]  ip_tables x_tables autofs4 firewire_ohci sdhci_pci 
psmouse ahci firewire_core crc32_pclmul libahci i2c_i801 cqhci crc_itu_t 
i2c_smbus e1000e sdhci ptp lpc_ich pps_core wmi video
[  712.857336] CPU: 2 PID: 39 Comm: kworker/u16:1 Kdump: loaded Tainted: 
G        W  OE     5.19.0-rc6+ #4
[  712.857344] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW 
(1.33 ) 07/29/2011
[  712.857348] Workqueue: phy0 ieee80211_iface_work [mac80211]
[  712.857442] RIP: 0010:___ieee80211_start_rx_ba_session+0x8fe/0x930 
[mac80211]
[  712.857526] Code: a1 da 41 be 25 00 00 00 66 44 89 75 88 e9 54 fc ff 
ff b9 08 00 00 00 e9 7e fe ff ff e8 4b 91 a1 da 4c 8b 4d 88 e9 d8 fc ff 
ff <0f> 0b e9 05 fe ff ff 4c 89 5d a8 e8 32 91 a1 da 4c 8b 5d a8 e9 90
[  712.857533] RSP: 0018:ffffbafa401bbce0 EFLAGS: 00010206
[  712.857539] RAX: 0000000000000000 RBX: 0000000000004018 RCX: 
0000000000000000
[  712.857543] RDX: ffff8f48e1489e40 RSI: 0000000000000009 RDI: 
0000000000000103
[  712.857546] RBP: ffffbafa401bbd80 R08: ffffbafa401bbbc8 R09: 
0000000000004000
[  712.857550] R10: ffff8f49c0042a00 R11: ffff8f48f304c300 R12: 
ffff8f49c42f9000
[  712.857554] R13: ffff8f48e2b888e0 R14: 000000000000401b R15: 
ffff8f48c714c9c0
[  712.857558] FS:  0000000000000000(0000) GS:ffff8f49fa280000(0000) 
knlGS:0000000000000000
[  712.857562] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  712.857566] CR2: 000055a204665fe4 CR3: 000000004e00a003 CR4: 
00000000000606e0
[  712.857571] Call Trace:
[  712.857617]  <TASK>
[  712.857639]  ieee80211_process_addba_request+0xb7/0x190 [mac80211]
[  712.857740]  ieee80211_iface_work+0x3d1/0x410 [mac80211]
[  712.857803]  process_one_work+0x227/0x440
[  712.857812]  worker_thread+0x31/0x3e0
[  712.857817]  ? process_one_work+0x440/0x440
[  712.857822]  kthread+0xfe/0x130
[  712.857829]  ? kthread_complete_and_exit+0x20/0x20
[  712.857836]  ret_from_fork+0x22/0x30
[  712.857846]  </TASK>
[  712.857848] ---[ end trace 0000000000000000 ]---
...
>   
