Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623877534C1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjGNIKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjGNIJo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F01993
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 01:07:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E5o685006957;
        Fri, 14 Jul 2023 08:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GRJxRZYX8/TLFKZnVbTXIBZCD0EbKZFqer4iIiHbxn0=;
 b=DFYbxdlv1ioSsdbL7t1mWnJeGkd+HnAyf0NsPz2/5bJup5Cjkbetu6bBhwa1iYjKGQKV
 4QaX7l9fVfYD5/RTGaf1snL56hXLGx8AMWOB7uspXL3LAJ+YJddOTUpdzXN0zlC6wz/t
 ISTd3bL1pEk6KT7gZY+jrbNzqVAV2QyKhJI4LyOVsPttJsYCmb031vKGv3ZH71PXHbmh
 vN1zqou2ZtlML2+dhRrqIS7DSDSXOxdE6HQx2/HwNIY6WfFGTMt8NiqTOlswizSSFxlq
 KegY9pR3y1Gm6XEJPMcc2jMbsd3vgz6l5KW1i9DWIfIjSX6C4Ts78GJTU9vQ78rnuU2t 5w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpuks7c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 08:07:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E87MaF031866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 08:07:22 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 01:07:20 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: Use pdev_id rather than mac_id to get pdev
Date:   Fri, 14 Jul 2023 16:06:58 +0800
Message-ID: <20230714080658.3140-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CflymAcPqNJ1REY9jyXNCFjdmC0S-Roa
X-Proofpoint-GUID: CflymAcPqNJ1REY9jyXNCFjdmC0S-Roa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing kernel crash in below test scenario:
 1. make DUT connect to an WPA3 encrypted 11ax AP in Ch44 HE80
 2. use "wpa_cli -i <inf> disconnect" to disconnect
 3. wait for DUT to automatically reconnect

Kernel crashes while waiting, below shows the crash stack:
[  755.120868] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[  755.120871] #PF: supervisor read access in kernel mode
[  755.120872] #PF: error_code(0x0000) - not-present page
[  755.120873] PGD 0 P4D 0
[  755.120875] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  755.120876] CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Not tainted 5.19=
.0-rc1+ #3
[  755.120878] Hardware name: Intel(R) Client Systems NUC11PHi7/NUC11PHBi7,=
 BIOS PHTGL579.0063.2021.0707.1057 07/07/2021
[  755.120879] RIP: 0010:ath12k_dp_process_rx_err+0x2b6/0x14a0 [ath12k]
[  755.120890] Code: 01 c0 48 c1 e0 05 48 8b 9c 07 b8 b2 00 00 48 c7 c0 61 =
ff 0e c1 48 85 db 53 48 0f 44 c6 48 c7 c6 80 9d 0f c1 50 e8 1a 25 00 00 <4c=
> 8b 3b 4d 8b 76 14 41 59 41 5a 41 8b 87 78 43 01 00 4d 85 f6 89
[  755.120891] RSP: 0018:ffff9a93402c8d10 EFLAGS: 00010282
[  755.120892] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00303
[  755.120893] RDX: 0000000000000000 RSI: ffffffff93b7cbe9 RDI: 00000000fff=
fffff
[  755.120894] RBP: ffff9a93402c8e50 R08: ffffffff93e65360 R09: ffffffff942=
e044d
[  755.120894] R10: 0000000000000000 R11: 0000000000000063 R12: ffff8dbec54=
20000
[  755.120895] R13: ffff8dbec5420000 R14: ffff8dbdefe9a0a0 R15: ffff8dbec54=
20000
[  755.120896] FS:  0000000000000000(0000) GS:ffff8dc2705c0000(0000) knlGS:=
0000000000000000
[  755.120897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  755.120898] CR2: 0000000000000000 CR3: 0000000107be4005 CR4: 00000000007=
70ee0
[  755.120898] PKRU: 55555554
[  755.120899] Call Trace:
[  755.120900]  <IRQ>
[  755.120903]  ? ath12k_pci_write32+0x2e/0x80 [ath12k]
[  755.120910]  ath12k_dp_service_srng+0x214/0x2e0 [ath12k]
[  755.120917]  ath12k_pci_ext_grp_napi_poll+0x26/0x80 [ath12k]
[  755.120923]  __napi_poll+0x2b/0x1c0
[  755.120925]  net_rx_action+0x2a1/0x2f0
[  755.120927]  __do_softirq+0xfa/0x2e9
[  755.120929]  irq_exit_rcu+0xb9/0xd0
[  755.120932]  common_interrupt+0xc1/0xe0
[  755.120934]  </IRQ>
[  755.120934]  <TASK>
[  755.120935]  asm_common_interrupt+0x2c/0x40
[  755.120936] RIP: 0010:cpuidle_enter_state+0xdd/0x3a0
[  755.120938] Code: 00 31 ff e8 45 e2 74 ff 80 7d d7 00 74 16 9c 58 0f 1f =
40 00 f6 c4 02 0f 85 a0 02 00 00 31 ff e8 69 79 7b ff fb 0f 1f 44 00 00 <45=
> 85 ff 0f 88 6d 01 00 00 49 63 d7 4c 2b 6d c8 48 8d 04 52 48 8d
[  755.120939] RSP: 0018:ffff9a934018be50 EFLAGS: 00000246
[  755.120940] RAX: ffff8dc2705c0000 RBX: 0000000000000002 RCX: 00000000000=
0001f
[  755.120941] RDX: 000000afd0b532d3 RSI: ffffffff93b7cbe9 RDI: ffffffff93b=
8b66e
[  755.120942] RBP: ffff9a934018be88 R08: 0000000000000002 R09: 00000000000=
30500
[  755.120942] R10: ffff9a934018be18 R11: 0000000000000741 R12: ffffba933fd=
c0600
[  755.120943] R13: 000000afd0b532d3 R14: ffffffff93fcbc60 R15: 00000000000=
00002
[  755.120945]  cpuidle_enter+0x2e/0x40
[  755.120946]  call_cpuidle+0x23/0x40
[  755.120948]  do_idle+0x1ff/0x260
[  755.120950]  cpu_startup_entry+0x1d/0x20
[  755.120951]  start_secondary+0x10d/0x130
[  755.120953]  secondary_startup_64_no_verify+0xd3/0xdb
[  755.120956]  </TASK>
[  755.120956] Modules linked in: michael_mic rfcomm cmac algif_hash algif_=
skcipher af_alg bnep qrtr_mhi intel_rapl_msr intel_rapl_common x86_pkg_temp=
_thermal intel_powerclamp coretemp snd_hda_codec_realtek snd_hda_codec_gene=
ric ledtrig_audio kvm_intel qrtr snd_hda_codec_hdmi kvm irqbypass ath12k sn=
d_hda_intel snd_seq_midi crct10dif_pclmul mhi ghash_clmulni_intel snd_intel=
_dspcfg snd_seq_midi_event aesni_intel qmi_helpers i915 snd_rawmidi crypto_=
simd snd_hda_codec cryptd cec intel_cstate snd_hda_core mac80211 rc_core no=
uveau snd_seq snd_hwdep btusb drm_buddy drm_ttm_helper nls_iso8859_1 snd_pc=
m ttm btrtl snd_seq_device wmi_bmof mxm_wmi input_leds cfg80211 joydev btbc=
m drm_display_helper snd_timer btintel mei_me libarc4 drm_kms_helper blueto=
oth i2c_algo_bit snd fb_sys_fops syscopyarea mei sysfillrect ecdh_generic s=
oundcore sysimgblt ecc acpi_pad mac_hid sch_fq_codel ipmi_devintf ipmi_msgh=
andler msr parport_pc ppdev lp ramoops parport reed_solomon drm efi_pstore =
ip_tables x_tables autofs4
[  755.120992]  hid_generic usbhid hid ax88179_178a usbnet mii nvme nvme_co=
re rtsx_pci_sdmmc crc32_pclmul i2c_i801 intel_lpss_pci i2c_smbus intel_lpss=
 rtsx_pci idma64 virt_dma vmd wmi video
[  755.121002] CR2: 0000000000000000

The crash is because, for WCN7850, only ab->pdev[0] is initialized, while m=
ac_id here is
misused to retrieve pdev and it is not zero, leading to a NULL pointer acce=
ss.

Fix this issue by getting pdev_id first and then use it to retrieve pdev.

Also fix some other code snippets which have the same issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICO=
NZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 11 +++++++----
 drivers/net/wireless/ath/ath12k/dp_tx.c |  8 +++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless=
/ath/ath12k/dp_rx.c
index ffd9a2018610..67f8c140840f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2539,7 +2539,7 @@ static void ath12k_dp_rx_process_received_packets(str=
uct ath12k_base *ab,
 	struct ath12k_skb_rxcb *rxcb;
 	struct sk_buff *msdu;
 	struct ath12k *ar;
-	u8 mac_id;
+	u8 mac_id, pdev_id;
 	int ret;
=20
 	if (skb_queue_empty(msdu_list))
@@ -2550,8 +2550,9 @@ static void ath12k_dp_rx_process_received_packets(str=
uct ath12k_base *ab,
 	while ((msdu =3D __skb_dequeue(msdu_list))) {
 		rxcb =3D ATH12K_SKB_RXCB(msdu);
 		mac_id =3D rxcb->mac_id;
-		ar =3D ab->pdevs[mac_id].ar;
-		if (!rcu_dereference(ab->pdevs_active[mac_id])) {
+		pdev_id =3D ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		ar =3D ab->pdevs[pdev_id].ar;
+		if (!rcu_dereference(ab->pdevs_active[pdev_id])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}
@@ -3385,6 +3386,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, =
struct napi_struct *napi,
 	dma_addr_t paddr;
 	bool is_frag;
 	bool drop =3D false;
+	int pdev_id;
=20
 	tot_n_bufs_reaped =3D 0;
 	quota =3D budget;
@@ -3440,7 +3442,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, =
struct napi_struct *napi,
 			mac_id =3D le32_get_bits(reo_desc->info0,
 					       HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
=20
-			ar =3D ab->pdevs[mac_id].ar;
+			pdev_id =3D ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+			ar =3D ab->pdevs[pdev_id].ar;
=20
 			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc, drop,
 							  msdu_cookies[i]))
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless=
/ath/ath12k/dp_tx.c
index d3c7c76d6b75..d661fe586651 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -347,6 +347,7 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base =
*ab,
 {
 	struct ath12k *ar;
 	struct ath12k_skb_cb *skb_cb;
+	u8 pdev_id =3D ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
=20
 	skb_cb =3D ATH12K_SKB_CB(msdu);
=20
@@ -357,7 +358,7 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base =
*ab,
=20
 	dev_kfree_skb_any(msdu);
=20
-	ar =3D ab->pdevs[mac_id].ar;
+	ar =3D ab->pdevs[pdev_id].ar;
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 }
@@ -536,7 +537,7 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base=
 *ab, int ring_id)
 	struct hal_tx_status ts =3D { 0 };
 	struct dp_tx_ring *tx_ring =3D &dp->tx_ring[ring_id];
 	struct hal_wbm_release_ring *desc;
-	u8 mac_id;
+	u8 mac_id, pdev_id;
 	u64 desc_va;
=20
 	spin_lock_bh(&status_ring->lock);
@@ -605,7 +606,8 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base=
 *ab, int ring_id)
 			continue;
 		}
=20
-		ar =3D ab->pdevs[mac_id].ar;
+		pdev_id =3D ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		ar =3D ab->pdevs[pdev_id].ar;
=20
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 			wake_up(&ar->dp.tx_empty_waitq);

base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
--=20
2.25.1

