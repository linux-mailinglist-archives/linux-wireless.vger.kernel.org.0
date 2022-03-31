Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA424ED4D5
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiCaHdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCaHdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 03:33:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D31F2DCC
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648711890; x=1680247890;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EsbNOxaI4TSjnvamWuXkKRx5Bm+r7m06xpngszb7A6E=;
  b=xlrjiJPFWreCm13ilrR/8s3Ure5czezE6guenmGGg6hOBnJdoRKvScqZ
   a0sKZU0gCxq3diXisabgL10nBHkRhwL0ynvNHDrQErqZzke4vDC18KTis
   Ju2oXwdcL2AqOcXTiO8bxxa7iYtnnVSbHA6QVLPGKxEu20Erh65up9BgM
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Mar 2022 00:31:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:31:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 31 Mar 2022 00:31:28 -0700
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 31 Mar 2022 00:31:27 -0700
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH v5.18] ath11k: fix driver initialization failure with WoW unsupported hw
Date:   Thu, 31 Mar 2022 13:01:10 +0530
Message-ID: <20220331073110.3846-1-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the "ath11k_wow_init", error value "EINVAL" is returned
when the check for firmware support of WoW feature fails,
which in turn stops the driver initialization.

Warning message:
[   31.040144] ------------[ cut here ]------------
[   31.040185] WARNING: CPU: 1 PID: 51 at drivers/net/wireless/ath/ath11k/wow.c:813 ath11k_wow_init+0xc8/0x13a8 [ath11k]
[   31.043846] Modules linked in: ath11k_pci ath11k qmi_helpers
[   31.054341] CPU: 1 PID: 51 Comm: kworker/u8:1 Tainted: G        W	5.17.0-wt-ath-594817-ga7f6aa925cf8-dirty #17
[   31.060078] Hardware name: Qualcomm Technologies, Inc. IPQ8074/AP-HK10-C2 (DT)
[   31.070578] Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work [ath11k]
[   31.077782] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.085676] pc : ath11k_wow_init+0xc8/0x13a8 [ath11k]
[   31.092359] lr : ath11k_mac_register+0x548/0xb98 [ath11k]
[   31.097567] sp : ffff80000aa13c40
[   31.102944] x29: ffff80000aa13c40 x28: ffff800009184390 x27: ffff000002959f20
[   31.106251] x26: ffff000002828000 x25: ffff000002830000 x24: ffff000002830000
[   31.113369] x23: ffff000002820000 x22: ffff00000282854c x21: 0000000000000000
[   31.120487] x20: ffff00000295cf20 x19: ffff000002828540 x18: 0000000000000031
[   31.127605] x17: 0000000000000004 x16: ffff0000028285fc x15: ffff00000295b040
[   31.134723] x14: 0000000000000067 x13: ffff00000282859c x12: 000000000000000d
[   31.141840] x11: 0000000000000018 x10: 0000000000000004 x9 : 0000000000000000
[   31.148959] x8 : ffff00000289d680 x7 : 0000000000000000 x6 : 000000000000003f
[   31.156077] x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff000002820968
[   31.163196] x2 : 0000000000000080 x1 : 0080008af9981779 x0 : ffff000002959f20
[   31.170314] Call trace:
[   31.177421]  ath11k_wow_init+0xc8/0x13a8 [ath11k]
[   31.179684]  ath11k_core_qmi_firmware_ready+0x430/0x5e0 [ath11k]
[   31.184548]  ath11k_qmi_driver_event_work+0x16c/0x4f8 [ath11k]
[   31.190623]  process_one_work+0x134/0x350
[   31.196262]  worker_thread+0x12c/0x450
[   31.200340]  kthread+0xf4/0x110
[   31.203986]  ret_from_fork+0x10/0x20
[   31.207026] ---[ end trace 0000000000000000 ]---
[   31.210894] ath11k_pci 0000:01:00.0: failed to init wow: -22
[   31.215467] ath11k_pci 0000:01:00.0: failed register the radio with mac80211: -22
[   31.221117] ath11k_pci 0000:01:00.0: failed to create pdev core: -22

Fix this by returning value "0" when FW doesn't support WoW
to allow driver to proceed with initialize sequence and also
remove the unnecessary "WARN_ON".

Fixes: ba9177fcef21 ("Add basic WoW functionalities")
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 93714df834b2..6c2611f93739 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -810,8 +810,8 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 
 int ath11k_wow_init(struct ath11k *ar)
 {
-	if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
-		return -EINVAL;
+	if (!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map))
+		return 0;
 
 	ar->wow.wowlan_support = ath11k_wowlan_support;
 
-- 
2.17.1

