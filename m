Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B846924F1F4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 06:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHXEdJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 00:33:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54978 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgHXEdI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 00:33:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598243587; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LJeQMa/6oxjRaE+iQIl/9pXAf4cEkuFLkz/1TglC0ug=; b=XDUsokUNSNZQCp9i8Rgmft8+PmB3mzxVWKLvimXKpEsBZ8uEOXmKoV3EG59vceLOCXMQ4kIA
 vDUVmWipJH0Iu32GBHZ0xkJmWI4jiP+KofjjVCuzGUPPr2x9UCukgZHIq+Ta1CKksnq8/97k
 1boqBZ0JYO0dH7DXz10v/JgmdDU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f4343020c97c4532aac75ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 04:33:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20827C433CB; Mon, 24 Aug 2020 04:33:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73B80C433C6;
        Mon, 24 Aug 2020 04:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73B80C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2] ath10k: add flag to protect napi operation to avoid dead loop hang for SDIO
Date:   Mon, 24 Aug 2020 12:33:32 +0800
Message-Id: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It happened "Kernel panic - not syncing: hung_task: blocked tasks" when
test simulate crash and ifconfig down/rmmod meanwhile.

Test steps:

1.Test commands, either can reproduce the hang.
echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;sleep 0.05;ifconfig wlan0 down
echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod ath10k_sdio

2. dmesg:
[ 5622.548630] ath10k_sdio mmc1:0001:1: simulating soft firmware crash
[ 5622.655995] ieee80211 phy0: Hardware restart was requested
[ 5776.355164] INFO: task shill:1572 blocked for more than 122 seconds.
[ 5776.355687] INFO: task kworker/1:2:24437 blocked for more than 122 seconds.
[ 5776.359812] Kernel panic - not syncing: hung_task: blocked tasks
[ 5776.359836] CPU: 1 PID: 55 Comm: khungtaskd Tainted: G        W         4.19.86 #137
[ 5776.359846] Hardware name: MediaTek krane sku176 board (DT)
[ 5776.359855] Call trace:
[ 5776.359868]  dump_backtrace+0x0/0x170
[ 5776.359881]  show_stack+0x20/0x2c
[ 5776.359896]  dump_stack+0xd4/0x10c
[ 5776.359916]  panic+0x12c/0x29c
[ 5776.359937]  hung_task_panic+0x0/0x50
[ 5776.359953]  kthread+0x120/0x130
[ 5776.359965]  ret_from_fork+0x10/0x18
[ 5776.359986] SMP: stopping secondary CPUs
[ 5776.360012] Kernel Offset: 0x141ea00000 from 0xffffff8008000000
[ 5776.360026] CPU features: 0x0,2188200c
[ 5776.360035] Memory Limit: none

command "ifconfig wlan0 down" or "rmmod ath10k_sdio" will be blocked
callstack of ifconfig:
[<0>] __switch_to+0x120/0x13c
[<0>] msleep+0x28/0x38
[<0>] ath10k_sdio_hif_stop+0x24c/0x294 [ath10k_sdio]
[<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
[<0>] ath10k_halt+0x120/0x178 [ath10k_core]
[<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
[<0>] drv_stop+0xe0/0x1e4 [mac80211]
[<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
[<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
[<0>] ieee80211_stop+0x20/0x30 [mac80211]
[<0>] __dev_close_many+0xb8/0x11c
[<0>] __dev_change_flags+0xe0/0x1d0
[<0>] dev_change_flags+0x30/0x6c
[<0>] devinet_ioctl+0x370/0x564
[<0>] inet_ioctl+0xdc/0x304
[<0>] sock_do_ioctl+0x50/0x288
[<0>] compat_sock_ioctl+0x1b4/0x1aac
[<0>] __se_compat_sys_ioctl+0x100/0x26fc
[<0>] __arm64_compat_sys_ioctl+0x20/0x2c
[<0>] el0_svc_common+0xa4/0x154
[<0>] el0_svc_compat_handler+0x2c/0x38
[<0>] el0_svc_compat+0x8/0x18
[<0>] 0xffffffffffffffff

callstack of rmmod:
[<0>] __switch_to+0x120/0x13c
[<0>] msleep+0x28/0x38
[<0>] ath10k_sdio_hif_stop+0x294/0x31c [ath10k_sdio]
[<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
[<0>] ath10k_halt+0x120/0x178 [ath10k_core]
[<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
[<0>] drv_stop+0xe0/0x1e4 [mac80211]
[<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
[<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
[<0>] ieee80211_stop+0x20/0x30 [mac80211]
[<0>] __dev_close_many+0xb8/0x11c
[<0>] dev_close_many+0x70/0x100
[<0>] dev_close+0x4c/0x80
[<0>] cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
[<0>] ieee80211_remove_interfaces+0x58/0x1a0 [mac80211]
[<0>] ieee80211_unregister_hw+0x40/0x100 [mac80211]
[<0>] ath10k_mac_unregister+0x1c/0x44 [ath10k_core]
[<0>] ath10k_core_unregister+0x38/0x7c [ath10k_core]
[<0>] ath10k_sdio_remove+0x8c/0xd0 [ath10k_sdio]
[<0>] sdio_bus_remove+0x48/0x108
[<0>] device_release_driver_internal+0x138/0x1ec
[<0>] driver_detach+0x6c/0xa8
[<0>] bus_remove_driver+0x78/0xa8
[<0>] driver_unregister+0x30/0x50
[<0>] sdio_unregister_driver+0x28/0x34
[<0>] cleanup_module+0x14/0x6bc [ath10k_sdio]
[<0>] __arm64_sys_delete_module+0x1e0/0x22c
[<0>] el0_svc_common+0xa4/0x154
[<0>] el0_svc_compat_handler+0x2c/0x38
[<0>] el0_svc_compat+0x8/0x18
[<0>] 0xffffffffffffffff

The test command run simulate_fw_crash firstly and it call into
ath10k_sdio_hif_stop from ath10k_core_restart, then napi_disable
is called and bit NAPI_STATE_SCHED is set. After that, function
ath10k_sdio_hif_stop is called again from ath10k_stop by command
"ifconfig wlan0 down" or "rmmod ath10k_sdio", then command blocked.

It is blocked by napi_synchronize, napi_disable will set bit with
NAPI_STATE_SCHED, and then napi_synchronize will enter dead loop
becuase bit NAPI_STATE_SCHED is set by napi_disable.

function of napi_synchronize
static inline void napi_synchronize(const struct napi_struct *n)
{
	if (IS_ENABLED(CONFIG_SMP))
		while (test_bit(NAPI_STATE_SCHED, &n->state))
			msleep(1);
	else
		barrier();
}

function of napi_disable
void napi_disable(struct napi_struct *n)
{
	might_sleep();
	set_bit(NAPI_STATE_DISABLE, &n->state);

	while (test_and_set_bit(NAPI_STATE_SCHED, &n->state))
		msleep(1);
	while (test_and_set_bit(NAPI_STATE_NPSVC, &n->state))
		msleep(1);

	hrtimer_cancel(&n->timer);

	clear_bit(NAPI_STATE_DISABLE, &n->state);
}

Add flag for it avoid the hang and crash.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h |  1 +
 drivers/net/wireless/ath/ath10k/sdio.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5c18f6c20462..11a6b18c272d 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1230,6 +1230,7 @@ struct ath10k {
 	/* NAPI */
 	struct net_device napi_dev;
 	struct napi_struct napi;
+	bool napi_enabled;
 
 	struct work_struct set_coverage_class_work;
 	/* protected by conf_mutex */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 81ddaafb6721..873f5492f93c 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1859,7 +1859,10 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	int ret;
 
-	napi_enable(&ar->napi);
+	if (!ar->napi_enabled) {
+		napi_enable(&ar->napi);
+		ar->napi_enabled = true;
+	}
 
 	/* Sleep 20 ms before HIF interrupts are disabled.
 	 * This will give target plenty of time to process the BMI done
@@ -1986,8 +1989,11 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
 
 	spin_unlock_bh(&ar_sdio->wr_async_lock);
 
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
+	if (ar->napi_enabled) {
+		napi_synchronize(&ar->napi);
+		napi_disable(&ar->napi);
+		ar->napi_enabled = false;
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.23.0

