Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D757EB427
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjKNPvD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 10:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 10:51:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B212C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 07:50:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F7BC433C8;
        Tue, 14 Nov 2023 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699977058;
        bh=pm9mAUDBFVtpCqwVDUcZHqyzvH1CzLYK8q9R8SJnS4k=;
        h=Date:From:To:Cc:Subject:From;
        b=bTsXNs1oPwi+cIotJ7ZypdJTjc2j98R+ba3mKS2SZJlPxk3ell3k6zbDbeZ/5YNbd
         C3EmFVOdHgMYXVnpIMeNSk4A02ezNmxNL7r2aujqkHefGX9CX30vYliIdE/+Dy7xmH
         QbQosQ+sxw9CNiYGOUQMxBh7zRpeUtS/sPogKlBS6IsMcRcta7e2z52FpBzk8GPXjj
         n9HdYMFRSfzEvSwIlErJZnxZFbxeAA1iaCmws6Mjgc/D3x8no3gyK8mMGn+a2qWegD
         kF5NptsFHLfsQDXxRgrdjdwj/3CAPhknVlxlV+5jatAWohiyJH3xZ1w7TSPUUNOoSp
         yflOA232g6iMQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r2vgl-0003jx-0S;
        Tue, 14 Nov 2023 16:50:55 +0100
Date:   Tue, 14 Nov 2023 16:50:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org
Subject: wifi: mac80211: lockdep splat with 6.7-rc1
Message-ID: <ZVOXX6qg4vXEx8dX@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I get the lockdep splat below when booting 6.7-rc1 with ath11k (Lenovo
ThinkPad X13s).

It's the new assert added by commit 0e8185ce1dde ("wifi: mac80211: check
wiphy mutex in ops") which triggers in drv_get_txpower().

Naively adding locking around the call in ieee80211_get_tx_power()
(e.g. similar to 6b348f6e34ce ("wifi: mac80211: ethtool: always hold
wiphy mutex")) does not work as there are other paths that call this
function with the lock held, specifically via ieee80211_register_hw().

Johan


[    7.122642] ------------[ cut here ]------------
[    7.125125] WARNING: CPU: 1 PID: 453 at net/mac80211/driver-ops.h:1262 ieee80211_get_tx_power+0x19c/0x1c0 [mac80211]
[    7.126869] Modules linked in: cbc des_generic libdes algif_skcipher md5 algif_hash af_alg r8152(+) mii ip6_tables x
t_LOG nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_conntrack libcrc32c nf_defrag_ipv6 nf_defrag_ip
v4 snd_q6apm(+) iptable_filter qrtr_mhi panel_edp snd_soc_hdmi_codec venus_dec venus_enc videobuf2_dma_contig videobuf2
_memops apr rpmsg_ctrl rpmsg_char qrtr_smd fastrpc qcom_pm8008_regulator venus_core ath11k_pci qcom_battmgr pmic_glink_
altmode ath11k snd_soc_wcd938x v4l2_mem2mem hci_uart mac80211 leds_qcom_lpg snd_soc_wcd_classh libarc4 btqca videobuf2_
v4l2 led_class_multicolor snd_soc_wcd938x_sdw videodev regmap_sdw bluetooth snd_soc_lpass_rx_macro videobuf2_common snd
_soc_lpass_va_macro snd_soc_lpass_tx_macro snd_soc_lpass_wsa_macro snd_soc_sc8280xp msm cfg80211 qcom_spmi_adc_tm5 snd_
soc_qcom_common soundwire_qcom snd_soc_wcd_mbhc ecdh_generic snd_soc_qcom_sdw snd_soc_lpass_macro_common qcom_spmi_adc5
 qcom_spmi_temp_alarm gpu_sched ecc phy_qcom_qmp_combo mc qcom_pon
[    7.127338]  drm_display_helper gpio_sbu_mux drm_dp_aux_bus snd_soc_core reboot_mode qcom_pm8008 mhi rtc_pm8xxx drm_
kms_helper industrialio rfkill mfd_core dispcc_sc8280xp nvmem_qcom_spmi_sdam qcom_vadc_common typec qcom_stats snd_comp
ress qcom_q6v5_pas regmap_i2c llcc_qcom phy_qcom_edp icc_bwmon pinctrl_sc8280xp_lpass_lpi snd_pcm videocc_sm8350 phy_qc
om_qmp_usb qcom_pil_info snd_timer phy_qcom_snps_femto_v2 gpucc_sc8280xp qcom_common qrtr pinctrl_lpass_lpi lpasscc_sc8
280xp snd qcom_glink_smem qcom_q6v5 soundcore qcom_rng pmic_glink qcom_sysmon soundwire_bus pdr_interface mdt_loader rn
g_core icc_osm_l3 qmi_helpers qcom_wdt socinfo pwm_bl dm_mod ip_tables x_tables ipv6 pcie_qcom crc8 phy_qcom_qmp_pcie n
vme nvme_core hid_multitouch i2c_qcom_geni i2c_hid_of i2c_hid drm i2c_core
[    7.127494] CPU: 1 PID: 453 Comm: iwd Not tainted 6.7.0-rc1 #4
[    7.127501] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (1.25 ) 10/12/2022
[    7.127506] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.127513] pc : ieee80211_get_tx_power+0x19c/0x1c0 [mac80211]
[    7.127603] lr : ieee80211_get_tx_power+0x198/0x1c0 [mac80211]
[    7.127682] sp : ffff8000821e36c0
[    7.127686] x29: ffff8000821e36c0 x28: ffff08bb443dcd00 x27: 0000000000000000
[    7.127696] x26: ffffa0d9a6fb6638 x25: ffff08bb58ad0700 x24: 0000000000000000
[    7.127706] x23: ffffa0d9b3cc0b80 x22: ffff8000821e3784 x21: ffff08bb58ad0000
[    7.127715] x20: ffff08bb57a4cb10 x19: ffff08bb58ad0e40 x18: 0000000000000002
[    7.127724] x17: 0000000000000000 x16: ffffa0d9b3629db8 x15: 0000000000000002
[    7.127732] x14: 0000000000000000 x13: 00000000fffffffc x12: 0000000000000000
[    7.127741] x11: 0000000000000010 x10: ffffa0d9b45d7258 x9 : 0000000000000000
[    7.127750] x8 : ffff08bb4d663200 x7 : 0000000000000000 x6 : 0000000000000078
[    7.127759] x5 : ffffa0d9b3ec0000 x4 : ffff08bb4d663200 x3 : 0000000000000000
[    7.127767] x2 : ffff67ece049d000 x1 : 0000000000000000 x0 : 0000000000000000
[    7.127777] Call trace:
[    7.127780]  ieee80211_get_tx_power+0x19c/0x1c0 [mac80211]
[    7.127859]  nl80211_send_iface+0x208/0x6a4 [cfg80211]
[    7.127946]  nl80211_dump_interface+0x120/0x254 [cfg80211]
[    7.128027]  genl_dumpit+0x48/0xcc
[    7.128045]  netlink_dump+0x120/0x3c4
[    7.128051]  __netlink_dump_start+0x198/0x2c8
[    7.128057]  genl_family_rcv_msg_dumpit+0x88/0x114
[    7.128063]  genl_rcv_msg+0x118/0x28c
[    7.128069]  netlink_rcv_skb+0x58/0x13c
[    7.128075]  genl_rcv+0x38/0x50
[    7.128080]  netlink_unicast+0x1d4/0x2c0
[    7.128086]  netlink_sendmsg+0x1ac/0x414
[    7.128092]  __sys_sendto+0x130/0x184
[    7.128098]  __arm64_sys_sendto+0x28/0x38
[    7.128102]  invoke_syscall+0x48/0x114
[    7.128113]  el0_svc_common.constprop.0+0xc0/0xe0
[    7.128120]  do_el0_svc+0x1c/0x28
[    7.128127]  el0_svc+0x48/0xd8
[    7.128136]  el0t_64_sync_handler+0xc0/0xc4
[    7.128143]  el0t_64_sync+0x190/0x194
[    7.128148] irq event stamp: 44690
[    7.128152] hardirqs last  enabled at (44689): [<ffffa0d9b2ef6adc>] __kmalloc_large_node+0x120/0x194
[    7.128162] hardirqs last disabled at (44690): [<ffffa0d9b3627f78>] el1_dbg+0x24/0x8c
[    7.128170] softirqs last  enabled at (39582): [<ffffa0d9a737b0d4>] ieee80211_get_txq_stats+0xb0/0x1ac [mac80211]
[    7.128252] softirqs last disabled at (39580): [<ffffa0d9a737b060>] ieee80211_get_txq_stats+0x3c/0x1ac [mac80211]
[    7.128331] ---[ end trace 0000000000000000 ]---
