Return-Path: <linux-wireless+bounces-28304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC51C0D4E3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BE119A6C34
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA802FF169;
	Mon, 27 Oct 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgNhj7Kp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D92FF658;
	Mon, 27 Oct 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565836; cv=none; b=Xf+PxF6Rn5NfP8G9k0GVws4xdVzLNF9sbyCi9rMpUHZ+gjgU6TfEWmHG5i00e3I146u6GnzAbarAKX/UTx7iflZ3UUTQ6FqDOy1UZTgDtkjuEOKf8I5WjGZqPGgecHrEoIHH2tcMQ0I/HSWX8d/cfQ8EGAx6ulSTQjQE/H/jXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565836; c=relaxed/simple;
	bh=1Nq4OsIRGvzLFnYkMUeCuaM3aAF/kNBZikR/j5G0pus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNtmWiYq79qux0/1v1nIcEsKUR2kf2tPgS0s1bZ8mjqGiiqBorcTrG7foJjPDnJsbB/IKkQlqCh+HwcK79ZnrxhFvK0teealLQ0zEA/RnjR40Bjjn/5hnqFiWRwmGq4eIAZmlOhoGWxes8cJxhFGxl2p5C8XoYItPvifHmXrgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgNhj7Kp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761565834; x=1793101834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Nq4OsIRGvzLFnYkMUeCuaM3aAF/kNBZikR/j5G0pus=;
  b=hgNhj7Kp0On/I8Si7a8/mmFDyvFsDouatwcnvgFPnnypC4kEi23u7/ez
   4sCWgsnxKS97EW5BxZ6mZluhqEgMASBi1S32e/tqC2Z+nlqr/x5hfjL3s
   nBbrgbxz7kSsnS5UbHmE+68LmOi7fGzt6ImNWTshTSqkwzjSSy9NXqkZE
   uakrotL/e9eXOi2JdN/V76re8JOymbLRGxYvncIAol9Wz8189qS0ni3nd
   XX/jB21pM7ECJEvdUK0aF4wfP/1xItT6U4j8/x+X6L56n/EptdDrUcYqK
   omiXqEnlpUHydOx3qgwVrA2qyha09Ji31SPi08EL2IRyeXogcHnCMBZVr
   Q==;
X-CSE-ConnectionGUID: Ndj1tjCIQKGv+85zuB6qvQ==
X-CSE-MsgGUID: jgwmFoGLSBmx+EJz5iUdZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63546810"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63546810"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:33 -0700
X-CSE-ConnectionGUID: yf4hwXKdT0u1qNVHr+E5xA==
X-CSE-MsgGUID: S5tKJIZWSy+k3nbfHateeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185370930"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.31])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E4FCC121EC5;
	Mon, 27 Oct 2025 13:50:22 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vDLjy-00000001dik-3coj;
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
Subject: [PATCH RESEND 2/4] net: ipa: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 27 Oct 2025 13:50:20 +0200
Message-ID: <20251027115022.390997-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
References: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
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
 drivers/net/ipa/ipa_interrupt.c | 1 -
 drivers/net/ipa/ipa_main.c      | 1 -
 drivers/net/ipa/ipa_modem.c     | 4 ----
 drivers/net/ipa/ipa_smp2p.c     | 2 --
 drivers/net/ipa/ipa_uc.c        | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 245a06997055..8336596b1247 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -149,7 +149,6 @@ static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 		iowrite32(pending, ipa->reg_virt + reg_offset(reg));
 	}
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 25500c5a6928..95a61bae3124 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -903,7 +903,6 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_deconfig;
 done:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 8fe0d0e1a00f..9b136f6b8b4a 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -71,7 +71,6 @@ static int ipa_open(struct net_device *netdev)
 
 	netif_start_queue(netdev);
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -102,7 +101,6 @@ static int ipa_stop(struct net_device *netdev)
 	ipa_endpoint_disable_one(priv->rx);
 	ipa_endpoint_disable_one(priv->tx);
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -175,7 +173,6 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	ret = ipa_endpoint_skb_tx(endpoint, skb);
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	if (ret) {
@@ -432,7 +429,6 @@ static void ipa_modem_crashed(struct ipa *ipa)
 		dev_err(dev, "error %d zeroing modem memory regions\n", ret);
 
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index fcaadd111a8a..420098796eec 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -171,7 +171,6 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 	WARN(ret != 0, "error %d from ipa_setup()\n", ret);
 
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
@@ -213,7 +212,6 @@ static void ipa_smp2p_power_release(struct ipa *ipa)
 	if (!ipa->smp2p->power_on)
 		return;
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 	ipa->smp2p->power_on = false;
 }
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 2963db83ab6b..dc7e92f2a4fb 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -158,7 +158,6 @@ static void ipa_uc_response_hdlr(struct ipa *ipa)
 		if (ipa->uc_powered) {
 			ipa->uc_loaded = true;
 			ipa_power_retention(ipa, true);
-			pm_runtime_mark_last_busy(dev);
 			(void)pm_runtime_put_autosuspend(dev);
 			ipa->uc_powered = false;
 		} else {
@@ -203,7 +202,6 @@ void ipa_uc_deconfig(struct ipa *ipa)
 	if (!ipa->uc_powered)
 		return;
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 }
 
-- 
2.47.3


