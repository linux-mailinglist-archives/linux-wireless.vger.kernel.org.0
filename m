Return-Path: <linux-wireless+bounces-28307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68420C0D58A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE842408F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87B30DEBB;
	Mon, 27 Oct 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUw7gXgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C912FE07B;
	Mon, 27 Oct 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565837; cv=none; b=WAy5msTvuLSItXUMtI7e5zj7zvBeWQ/G27BGIbMqyc7rzVuKXsRpCOxoh5aDYBJuO66oEBPrVsmmKeiYkjJn7F2XDo1R9BwR5X5KlsxBlxbZThkKqISHpWRdL5C/DZ1a2/5SljhNKPPcJTa7r8UOHGrFo9w3I8/Eq490otZOr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565837; c=relaxed/simple;
	bh=JUbvz9IlQ6+L8KQRASSmO9wSpjWPjTFfbMmzkjCOkKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeOm0vCA4g41iTEPp0H6IagUZzM4G9B0sF+XI3t4V17hDNA++6vGLMnmao6gC1CGf6eQK9p05QkS53aXR+/qThx75GsIJbghtdne0OoF/j+1/4j7Zi6iPwBmP01mSVBTIx9+rbbW5NQyBTyB/Nu2kM70Mn8xyYWhqyb1R6qBPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUw7gXgK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761565836; x=1793101836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JUbvz9IlQ6+L8KQRASSmO9wSpjWPjTFfbMmzkjCOkKw=;
  b=FUw7gXgK8+Zw9zkB+/SoBFXqpx+Vn4tLIGTXoGeSnTDfnkwLpY8EOa0c
   6Vu0yf6ppBVPtQ6nPwayxpP52RBTllvpGEskngm8+AuadXKMioX0EwoLs
   g8lxoi5c83CbiOPfmkUc0HrSeHae7haFd8yQm66vGK1hMzkxEyMPR0urK
   W/1J+GN7hSaYspRwPyRktMQqqzZ+2+i55k+B/ukYR1FjCQJrPllTnG9Bk
   /PKdJ6ujaGocscmipwWs/87aAV0Vz4aRKq/T0xeA4t5bpzMfQaRwsZleB
   +Ln7bYikUVysjkTn8cTpx4eueuXLq+1H0h7vCbrEK8AdiUeHuAZxfvewd
   A==;
X-CSE-ConnectionGUID: pf1IEuwKSuGZLXsRdtO5UA==
X-CSE-MsgGUID: F1mmnnPkTLSDI1tpmVYuvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66255493"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66255493"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:35 -0700
X-CSE-ConnectionGUID: Y//c0Xe2R4mKJhZnCmw5ow==
X-CSE-MsgGUID: 3vN27GmFQu6atX8oq4aP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="215675020"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.31])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DC6F6121E63;
	Mon, 27 Oct 2025 13:50:22 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vDLjy-00000001dih-3XzH;
	Mon, 27 Oct 2025 13:50:22 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Nemanov <michael.nemanov@ti.com>,
	Kalle Valo <kvalo@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH RESEND 1/4] net: ethernet: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 27 Oct 2025 13:50:19 +0200
Message-ID: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/net/ethernet/cadence/macb_main.c  | 5 -----
 drivers/net/ethernet/freescale/fec_main.c | 8 --------
 drivers/net/ethernet/renesas/ravb_main.c  | 4 ----
 drivers/net/ethernet/ti/davinci_mdio.c    | 7 -------
 4 files changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 39673f5c3337..847c4ab9df23 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -327,7 +327,6 @@ static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
 mdio_read_exit:
-	pm_runtime_mark_last_busy(&bp->pdev->dev);
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
@@ -373,7 +372,6 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int mii_id, int devad,
 	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
 mdio_read_exit:
-	pm_runtime_mark_last_busy(&bp->pdev->dev);
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
@@ -405,7 +403,6 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 		goto mdio_write_exit;
 
 mdio_write_exit:
-	pm_runtime_mark_last_busy(&bp->pdev->dev);
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
@@ -451,7 +448,6 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 		goto mdio_write_exit;
 
 mdio_write_exit:
-	pm_runtime_mark_last_busy(&bp->pdev->dev);
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
@@ -5564,7 +5560,6 @@ static int macb_probe(struct platform_device *pdev)
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
-	pm_runtime_mark_last_busy(&bp->pdev->dev);
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1edcfaee6819..4875101c4f3f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2231,7 +2231,6 @@ static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
 
 out:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -2280,7 +2279,6 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
 	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
 
 out:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -2312,7 +2310,6 @@ static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	if (ret)
 		netdev_err(fep->netdev, "MDIO write timeout\n");
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -2356,7 +2353,6 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
 		netdev_err(fep->netdev, "MDIO write timeout\n");
 
 out:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -2839,7 +2835,6 @@ static void fec_enet_get_regs(struct net_device *ndev,
 		buf[off] = readl(&theregs[off]);
 	}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
 
@@ -3616,7 +3611,6 @@ fec_enet_open(struct net_device *ndev)
 err_enet_alloc:
 	fec_enet_clk_enable(ndev, false);
 clk_enable:
-	pm_runtime_mark_last_busy(&fep->pdev->dev);
 	pm_runtime_put_autosuspend(&fep->pdev->dev);
 	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
 	return ret;
@@ -3647,7 +3641,6 @@ fec_enet_close(struct net_device *ndev)
 		cpu_latency_qos_remove_request(&fep->pm_qos_req);
 
 	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
-	pm_runtime_mark_last_busy(&fep->pdev->dev);
 	pm_runtime_put_autosuspend(&fep->pdev->dev);
 
 	fec_enet_free_buffers(ndev);
@@ -4616,7 +4609,6 @@ fec_probe(struct platform_device *pdev)
 
 	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c3fc15f9ec85..21a45583e7e1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1975,7 +1975,6 @@ static int ravb_open(struct net_device *ndev)
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 out_rpm_put:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 out_napi_off:
 	if (info->nc_queues)
@@ -2404,7 +2403,6 @@ static int ravb_close(struct net_device *ndev)
 	if (error)
 		return error;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -3116,7 +3114,6 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
@@ -3301,7 +3298,6 @@ static int ravb_resume(struct device *dev)
 
 out_rpm_put:
 	if (!priv->wol_enabled) {
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
 
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 68507126be8e..9f049ebbf107 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -234,7 +234,6 @@ static int davinci_mdiobb_read_c22(struct mii_bus *bus, int phy, int reg)
 
 	ret = mdiobb_read_c22(bus, phy, reg);
 
-	pm_runtime_mark_last_busy(bus->parent);
 	pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
@@ -251,7 +250,6 @@ static int davinci_mdiobb_write_c22(struct mii_bus *bus, int phy, int reg,
 
 	ret = mdiobb_write_c22(bus, phy, reg, val);
 
-	pm_runtime_mark_last_busy(bus->parent);
 	pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
@@ -268,7 +266,6 @@ static int davinci_mdiobb_read_c45(struct mii_bus *bus, int phy, int devad,
 
 	ret = mdiobb_read_c45(bus, phy, devad, reg);
 
-	pm_runtime_mark_last_busy(bus->parent);
 	pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
@@ -285,7 +282,6 @@ static int davinci_mdiobb_write_c45(struct mii_bus *bus, int phy, int devad,
 
 	ret = mdiobb_write_c45(bus, phy, devad, reg, val);
 
-	pm_runtime_mark_last_busy(bus->parent);
 	pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
@@ -332,7 +328,6 @@ static int davinci_mdio_common_reset(struct davinci_mdio_data *data)
 	data->bus->phy_mask = phy_mask;
 
 done:
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return 0;
@@ -441,7 +436,6 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		break;
 	}
 
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 	return ret;
 }
@@ -478,7 +472,6 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 		break;
 	}
 
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
-- 
2.47.3


