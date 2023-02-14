Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD7695B82
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 08:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjBNH6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 02:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjBNH5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 02:57:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0921A10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 23:57:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E6Pji6008737;
        Tue, 14 Feb 2023 07:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hMriGOvRa0Gd301jF1pbpMXT7nBvAydhQTKXRyN2lOo=;
 b=JBahX4wdL8KO/MAtOLQOaKU03JsuWkw6kajk3pySJA0xO4ArfjNIawbyHiyZvhjS94WF
 PMzGBSRtJTMrRoKmW07vzBf7qPFB0qaODSqILA3JF7+JrEpmCwgbHuvJ14PmjTJHuplh
 vuq9/QlESfsg9Zwg6MPzXEnww1sPQp4GfgMDRiCgwepAynsLZYw7oPAG2x4NseoDTYVe
 9XJBaElwpLPqDcxldrgEQr52CQuUCL1IrJnsRoKcnXqfNd4rcqkNcT1jeEqQTRKsbcrG
 RuGUUBLB6RHnrRiHJWa3CXHmd4V6qQFRsRUxuEPePxnXsnjxhsCvLAMwZtBNvKxU70/l GQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsusf7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 07:57:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E7vTMm029906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 07:57:29 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 23:57:27 -0800
Message-ID: <34121f87-4aa6-7f20-fb1e-4d5b02d06f28@quicinc.com>
Date:   Tue, 14 Feb 2023 15:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 04/15] mac80211: make channel context code MLO-aware
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC:     Johannes Berg <johannes.berg@intel.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
 <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20220601093922.fb3f0f434c72.Icea7e695b0626177e27ab73bc8799202d623cebf@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TvjmZLQtYUxVLYfC551Dq83O46nHBZQ4
X-Proofpoint-ORIG-GUID: TvjmZLQtYUxVLYfC551Dq83O46nHBZQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_04,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140066
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/2022 3:39 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Make the channel context code MLO aware, along with some
> functions that it uses, so that the chan.c file is now
> MLD-clean and no longer uses deflink/bss_conf/etc.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
...
> diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
> index f22381127948..b268088585eb 100644
> --- a/net/mac80211/rate.c
> +++ b/net/mac80211/rate.c
> @@ -90,14 +90,17 @@ void rate_control_tx_status(struct ieee80211_local *local,
>   }
>   
>   void rate_control_rate_update(struct ieee80211_local *local,
> -				    struct ieee80211_supported_band *sband,
> -				    struct sta_info *sta, u32 changed)
> +			      struct ieee80211_supported_band *sband,
> +			      struct sta_info *sta, unsigned int link_id,
> +			      u32 changed)
>   {
>   	struct rate_control_ref *ref = local->rate_ctrl;
>   	struct ieee80211_sta *ista = &sta->sta;
>   	void *priv_sta = sta->rate_ctrl_priv;
>   	struct ieee80211_chanctx_conf *chanctx_conf;
>   
> +	WARN_ON(link_id != 0);
> +
>   	if (ref && ref->ops->rate_update) {
>   		rcu_read_lock();
>   

Why link_id must = 0 here?

Now I hit a warning here.

[421752.744684] wlan0: [link 1] AP 02:03:7f:01:52:26 changed bandwidth, 
new config is 6435.000 MHz, width 1 (6435.000/0 MHz)
[421752.744760] ------------[ cut here ]------------
[421752.744762] WARNING: CPU: 4 PID: 3844301 at net/mac80211/rate.c:104 
rate_control_rate_update+0xe2/0x100 [mac80211]
[421752.744833] Modules linked in: tls cpuid rfcomm ccm michael_mic cmac 
algif_hash algif_skcipher af_alg qrtr_mhi bnep intel_rapl_msr 
intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic 
ledtrig_audio edac_mce_amd snd_hda_codec_hdmi snd_hda_intel 
snd_intel_dspcfg qrtr snd_hda_codec kvm_amd snd_hda_core binfmt_misc 
ath12k snd_hwdep kvm snd_pcm mhi irqbypass qmi_helpers nls_iso8859_1 
snd_seq_midi crct10dif_pclmul btusb snd_seq_midi_event 
ghash_clmulni_intel mac80211 snd_rawmidi btrtl aesni_intel crypto_simd 
snd_seq cryptd btbcm btintel snd_seq_device rapl input_leds bluetooth 
joydev wmi_bmof serio_raw snd_timer cfg80211 k10temp ecdh_generic ecc 
snd libarc4 ccp soundcore ucsi_acpi typec_ucsi typec mac_hid cm32181 
industrialio sch_fq_codel msr parport_pc ppdev lp parport ramoops 
reed_solomon drm efi_pstore ip_tables x_tables autofs4 ax88179_178a 
usbnet mii hid_generic usbhid hid crc32_pclmul nvme ahci i2c_piix4 
libahci nvme_core wmi video
[421752.744982] CPU: 4 PID: 3844301 Comm: kworker/u32:2 Kdump: loaded 
Tainted: G        W          6.0.0-rc2+ #3
[421752.744989] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS RCD0080A 
09/04/2019
[421752.744993] Workqueue: phy0 ieee80211_iface_work [mac80211]
[421752.745048] RIP: 0010:rate_control_rate_update+0xe2/0x100 [mac80211]
[421752.745100] Code: e8 f3 a3 33 d0 48 8b 73 50 44 89 f1 4c 89 ea 4c 89 
ff e8 71 16 fe ff 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 de 24 20 
d1 <0f> 0b e9 4c ff ff ff 0f 0b e8 c0 a3 33 d0 eb dd 0f 1f 40 00 66 2e
[421752.745104] RSP: 0018:ffffadc0911efab0 EFLAGS: 00010202
[421752.745109] RAX: 0000000000000000 RBX: ffff9e8619b20000 RCX: 
0000000000000001
[421752.745112] RDX: ffff9e8619b20000 RSI: ffff9e8412ac3610 RDI: 
ffff9e8412ac08e0
[421752.745115] RBP: ffffadc0911efaf8 R08: 0000000000000001 R09: 
c000000100b1fe35
[421752.745117] R10: ffff9e8412ac04f0 R11: ffffadc0911ef9c0 R12: 
0000000000000000
[421752.745120] R13: ffff9e8619b20ab0 R14: 0000000000000001 R15: 
ffff9e8412ac08e0
[421752.745123] FS:  0000000000000000(0000) GS:ffff9e86ff700000(0000) 
knlGS:0000000000000000
[421752.745127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[421752.745130] CR2: 00007f03cdb34538 CR3: 00000002f020a000 CR4: 
0000000000350ee0
[421752.745133] Call Trace:
[421752.745137]  <TASK>
[421752.745147]  ieee80211_chan_bw_change+0x100/0x130 [mac80211]
[421752.745213]  ieee80211_change_chanctx+0x51/0x2a0 [mac80211]
[421752.745263]  ieee80211_recalc_chanctx_chantype+0x133/0x180 [mac80211]
[421752.745287]  ieee80211_link_change_bandwidth+0xf5/0x180 [mac80211]
[421752.745306]  ieee80211_rx_mgmt_beacon+0xc82/0x1b30 [mac80211]
[421752.745333]  ? update_load_avg+0x224/0x770
[421752.745338]  ? update_load_avg+0x224/0x770
[421752.745339]  ? native_send_call_func_single_ipi+0x1e/0x30
[421752.745344]  ieee80211_sta_rx_queued_mgmt+0x173/0xad0 [mac80211]
[421752.745364]  ? newidle_balance+0x256/0x410
[421752.745367]  ? preempt_count_add+0x7c/0xc0
[421752.745370]  ? _raw_spin_lock_irqsave+0x28/0x60
[421752.745375]  ieee80211_iface_work+0x2fc/0x400 [mac80211]
[421752.745395]  process_one_work+0x227/0x440
[421752.745398]  worker_thread+0x31/0x3e0
[421752.745400]  ? process_one_work+0x440/0x440
[421752.745402]  kthread+0xfe/0x130
[421752.745404]  ? kthread_complete_and_exit+0x20/0x20
[421752.745407]  ret_from_fork+0x22/0x30
[421752.745412]  </TASK>
[421752.745412] ---[ end trace 0000000000000000 ]---

...

>   
