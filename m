Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3B159D8A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 00:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgBKXkM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 18:40:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59099 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgBKXis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 18:38:48 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 5033a46d26c3f379; Wed, 12 Feb 2020 00:38:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 20/28] drivers: net: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:24:36 +0100
Message-ID: <10624145.o336LLEsho@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/update/remove_request() instead of
pm_qos_add/update/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c   | 13 ++++++-------
 drivers/net/wireless/ath/ath10k/core.c       |  4 ++--
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 10 +++++-----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index db4ea58bac82..0f02c7a5ee9b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3280,10 +3280,10 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 
 		dev_info(&adapter->pdev->dev,
 			 "Some CPU C-states have been disabled in order to enable jumbo frames\n");
-		pm_qos_update_request(&adapter->pm_qos_req, lat);
+		cpu_latency_qos_update_request(&adapter->pm_qos_req, lat);
 	} else {
-		pm_qos_update_request(&adapter->pm_qos_req,
-				      PM_QOS_DEFAULT_VALUE);
+		cpu_latency_qos_update_request(&adapter->pm_qos_req,
+					       PM_QOS_DEFAULT_VALUE);
 	}
 
 	/* Enable Receives */
@@ -4636,8 +4636,7 @@ int e1000e_open(struct net_device *netdev)
 		e1000_update_mng_vlan(adapter);
 
 	/* DMA latency requirement to workaround jumbo issue */
-	pm_qos_add_request(&adapter->pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(&adapter->pm_qos_req, PM_QOS_DEFAULT_VALUE);
 
 	/* before we allocate an interrupt, we must be ready to handle it.
 	 * Setting DEBUG_SHIRQ in the kernel makes it fire an interrupt
@@ -4679,7 +4678,7 @@ int e1000e_open(struct net_device *netdev)
 	return 0;
 
 err_req_irq:
-	pm_qos_remove_request(&adapter->pm_qos_req);
+	cpu_latency_qos_remove_request(&adapter->pm_qos_req);
 	e1000e_release_hw_control(adapter);
 	e1000_power_down_phy(adapter);
 	e1000e_free_rx_resources(adapter->rx_ring);
@@ -4743,7 +4742,7 @@ int e1000e_close(struct net_device *netdev)
 	    !test_bit(__E1000_TESTING, &adapter->state))
 		e1000e_release_hw_control(adapter);
 
-	pm_qos_remove_request(&adapter->pm_qos_req);
+	cpu_latency_qos_remove_request(&adapter->pm_qos_req);
 
 	pm_runtime_put_sync(&pdev->dev);
 
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5ec16ce19b69..a202a4eea76a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1052,11 +1052,11 @@ static int ath10k_download_fw(struct ath10k *ar)
 	}
 
 	memset(&latency_qos, 0, sizeof(latency_qos));
-	pm_qos_add_request(&latency_qos, PM_QOS_CPU_DMA_LATENCY, 0);
+	cpu_latency_qos_add_request(&latency_qos, 0);
 
 	ret = ath10k_bmi_fast_download(ar, address, data, data_len);
 
-	pm_qos_remove_request(&latency_qos);
+	cpu_latency_qos_remove_request(&latency_qos);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 536cd729c086..5dfcce77d094 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -1730,7 +1730,7 @@ static int ipw2100_up(struct ipw2100_priv *priv, int deferred)
 	/* the ipw2100 hardware really doesn't want power management delays
 	 * longer than 175usec
 	 */
-	pm_qos_update_request(&ipw2100_pm_qos_req, 175);
+	cpu_latency_qos_update_request(&ipw2100_pm_qos_req, 175);
 
 	/* If the interrupt is enabled, turn it off... */
 	spin_lock_irqsave(&priv->low_lock, flags);
@@ -1875,7 +1875,8 @@ static void ipw2100_down(struct ipw2100_priv *priv)
 	ipw2100_disable_interrupts(priv);
 	spin_unlock_irqrestore(&priv->low_lock, flags);
 
-	pm_qos_update_request(&ipw2100_pm_qos_req, PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_update_request(&ipw2100_pm_qos_req,
+				       PM_QOS_DEFAULT_VALUE);
 
 	/* We have to signal any supplicant if we are disassociating */
 	if (associated)
@@ -6566,8 +6567,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	pm_qos_add_request(&ipw2100_pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	cpu_latency_qos_add_request(&ipw2100_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 
 	ret = pci_register_driver(&ipw2100_pci_driver);
 	if (ret)
@@ -6594,7 +6594,7 @@ static void __exit ipw2100_exit(void)
 			   &driver_attr_debug_level);
 #endif
 	pci_unregister_driver(&ipw2100_pci_driver);
-	pm_qos_remove_request(&ipw2100_pm_qos_req);
+	cpu_latency_qos_remove_request(&ipw2100_pm_qos_req);
 }
 
 module_init(ipw2100_init);
-- 
2.16.4





