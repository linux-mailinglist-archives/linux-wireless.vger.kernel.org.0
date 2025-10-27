Return-Path: <linux-wireless+bounces-28305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2AC0D4F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CDF19C0A19
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E411C3009F5;
	Mon, 27 Oct 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ6p/cgQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BE2FFDD9;
	Mon, 27 Oct 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565836; cv=none; b=c5uSnXywlR4eWiw6LpIkJXoWymFbpBBEW3/MmbF5JA9j/zUVUiJ354vPQkEISjaDAN5zXZUnngRXcIxBS/Vbp8RAYQdffx3910JS2DCFNAfIfk/N2DcLWA69R12VQVjSC6kKlo9oXRiMDf3tHroh2m5Tr9+IBjTD6EHY6sAHMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565836; c=relaxed/simple;
	bh=QvmUWNIdDsPwrCr3ijQPU8sgOEBTxiu0DpWh0HAU0cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XidlPezlWbvlHQbh5/eCtgpxOntYoG1AP6opAcynz3BQTCnuDuPokWHmdVxiC+m94xDmOQfLpwFougjxbp9fbLOjiyBDs/Ir5StnkpPpWrNEXtjeS2tfO9917n5hxS4ziNWP2xFkUHKQiheYqUh/Pt20FwuqoubijKQhyWmFdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ6p/cgQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761565834; x=1793101834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvmUWNIdDsPwrCr3ijQPU8sgOEBTxiu0DpWh0HAU0cw=;
  b=EZ6p/cgQbfRin14xRnhaabyODNugCWZVrGckhcoWJukXUG/1VySDhMF/
   inXW4P9N/xTpVZpQ6LJeP6P0klOhD0I4Bji8DuKCmBqu2xy/I+dleDJGY
   XpBsvYKmcJByeffAhuvCVi/vTXdvTvxSLRBpsdLwVLGyLaiyq8weHJyaj
   A9rHkfeA3TKQ8X0MQvr/pWdGrsHOj2RvW7MtrwEezbxxvBemdcWp6e/4K
   U3jDB9EBN8fSjpmNH46Yalxx1sTXL/2jrF2Cgfm3w0Yzk1ffly8zD9rxh
   Uhl6SrmV1uqQNqJ+Rp9AMasELEzer64qpgge+XLy0RYd6nSvvSJHMmb1E
   w==;
X-CSE-ConnectionGUID: 2dtT+KSLQLGLEkWvM7FAnQ==
X-CSE-MsgGUID: iiE8nB/8TVKAVj9THSj1/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81272557"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="81272557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:34 -0700
X-CSE-ConnectionGUID: eQfv2j09T8+JY71Fkc3/AA==
X-CSE-MsgGUID: N2f5JVuYTsOY/CR/Sbzvaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184721514"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.31])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:25 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E6683121EF1;
	Mon, 27 Oct 2025 13:50:22 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1vDLjy-00000001dio-3gzb;
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
Subject: [PATCH RESEND 3/4] net: wireless: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 27 Oct 2025 13:50:21 +0200
Message-ID: <20251027115022.390997-3-sakari.ailus@linux.intel.com>
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
 drivers/net/wireless/ath/wil6210/pm.c       |  1 -
 drivers/net/wireless/ti/wl18xx/debugfs.c    |  3 --
 drivers/net/wireless/ti/wlcore/cmd.c        |  1 -
 drivers/net/wireless/ti/wlcore/debugfs.c    | 11 -------
 drivers/net/wireless/ti/wlcore/main.c       | 36 ---------------------
 drivers/net/wireless/ti/wlcore/scan.c       |  1 -
 drivers/net/wireless/ti/wlcore/sysfs.c      |  1 -
 drivers/net/wireless/ti/wlcore/testmode.c   |  2 --
 drivers/net/wireless/ti/wlcore/tx.c         |  1 -
 drivers/net/wireless/ti/wlcore/vendor_cmd.c |  3 --
 10 files changed, 60 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/pm.c b/drivers/net/wireless/ath/wil6210/pm.c
index f521af575e9b..c866cfd144c7 100644
--- a/drivers/net/wireless/ath/wil6210/pm.c
+++ b/drivers/net/wireless/ath/wil6210/pm.c
@@ -458,6 +458,5 @@ void wil_pm_runtime_put(struct wil6210_priv *wil)
 {
 	struct device *dev = wil_to_dev(wil);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
diff --git a/drivers/net/wireless/ti/wl18xx/debugfs.c b/drivers/net/wireless/ti/wl18xx/debugfs.c
index 80fbf740fe6d..ac756318e8ea 100644
--- a/drivers/net/wireless/ti/wl18xx/debugfs.c
+++ b/drivers/net/wireless/ti/wl18xx/debugfs.c
@@ -272,7 +272,6 @@ static ssize_t radar_detection_write(struct file *file,
 	if (ret < 0)
 		count = ret;
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -312,7 +311,6 @@ static ssize_t dynamic_fw_traces_write(struct file *file,
 	if (ret < 0)
 		count = ret;
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -374,7 +372,6 @@ static ssize_t radar_debug_mode_write(struct file *file,
 				       wl->radar_debug_mode, 0);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index fa3a3f71dd15..9d73ba933a16 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -213,7 +213,6 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
 	} while (!event);
 
 out:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 free_vector:
 	kfree(events_vector);
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index eb3d3f0e0b4d..bbfd2725215b 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -63,7 +63,6 @@ void wl1271_debugfs_update_stats(struct wl1271 *wl)
 		wl->stats.fw_stats_update = jiffies;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -113,7 +112,6 @@ static void chip_op_handler(struct wl1271 *wl, unsigned long value,
 	chip_op = arg;
 	chip_op(wl);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 }
 
@@ -287,7 +285,6 @@ static ssize_t dynamic_ps_timeout_write(struct file *file,
 			wl1271_ps_set_mode(wl, wlvif, STATION_AUTO_PS_MODE);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -357,7 +354,6 @@ static ssize_t forced_ps_write(struct file *file,
 			wl1271_ps_set_mode(wl, wlvif, ps_mode);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -830,7 +826,6 @@ static ssize_t rx_streaming_interval_write(struct file *file,
 		wl1271_recalc_rx_streaming(wl, wlvif);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -886,7 +881,6 @@ static ssize_t rx_streaming_always_write(struct file *file,
 		wl1271_recalc_rx_streaming(wl, wlvif);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -934,7 +928,6 @@ static ssize_t beacon_filtering_write(struct file *file,
 		ret = wl1271_acx_beacon_filter_opt(wl, wlvif, !!value);
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -1015,7 +1008,6 @@ static ssize_t sleep_auth_write(struct file *file,
 		goto out_sleep;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -1090,7 +1082,6 @@ static ssize_t dev_mem_read(struct file *file,
 		goto part_err;
 
 part_err:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 skip_read:
@@ -1172,7 +1163,6 @@ static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
 		goto part_err;
 
 part_err:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 skip_write:
@@ -1247,7 +1237,6 @@ static ssize_t fw_logger_write(struct file *file,
 
 	ret = wl12xx_cmd_config_fwlog(wl);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 6116a8522d96..12f0167d7380 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -154,7 +154,6 @@ static void wl1271_rx_streaming_enable_work(struct work_struct *work)
 		  jiffies + msecs_to_jiffies(wl->conf.rx_streaming.duration));
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -181,7 +180,6 @@ static void wl1271_rx_streaming_disable_work(struct work_struct *work)
 		goto out_sleep;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -234,7 +232,6 @@ static void wlcore_rc_update_work(struct work_struct *work)
 	}
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -711,7 +708,6 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 	}
 
 err_ret:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -1047,7 +1043,6 @@ static void wl1271_recovery_work(struct work_struct *work)
 	}
 
 	wlcore_op_stop_locked(wl);
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 	ieee80211_restart_hw(wl->hw);
@@ -1943,7 +1938,6 @@ static int __maybe_unused wl1271_op_resume(struct ieee80211_hw *hw)
 		goto out_sleep;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -2131,7 +2125,6 @@ static void wlcore_channel_switch_work(struct work_struct *work)
 
 	wl12xx_cmd_stop_channel_switch(wl, wlvif);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -2201,7 +2194,6 @@ static void wlcore_pending_auth_complete_work(struct work_struct *work)
 	/* cancel the ROC if active */
 	wlcore_update_inconn_sta(wl, wlvif, NULL, false);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -2694,7 +2686,6 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 	else
 		wl->sta_count++;
 out:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out_unlock:
 	mutex_unlock(&wl->mutex);
@@ -2774,7 +2765,6 @@ static void __wl1271_op_remove_interface(struct wl1271 *wl,
 			}
 		}
 
-		pm_runtime_mark_last_busy(wl->dev);
 		pm_runtime_put_autosuspend(wl->dev);
 	}
 deinit:
@@ -3200,7 +3190,6 @@ static int wl1271_op_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 	}
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -3315,7 +3304,6 @@ static void wl1271_op_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -3531,7 +3519,6 @@ static int wlcore_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	ret = wlcore_hw_set_key(wl, cmd, vif, sta, key_conf);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out_wake_queues:
@@ -3695,7 +3682,6 @@ static void wl1271_op_set_default_key_idx(struct ieee80211_hw *hw,
 	}
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out_unlock:
@@ -3724,7 +3710,6 @@ void wlcore_regdomain_config(struct wl1271 *wl)
 		goto out;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -3772,7 +3757,6 @@ static int wl1271_op_hw_scan(struct ieee80211_hw *hw,
 
 	ret = wlcore_scan(hw->priv, vif, ssid, len, req);
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -3823,7 +3807,6 @@ static void wl1271_op_cancel_hw_scan(struct ieee80211_hw *hw,
 	ieee80211_scan_completed(wl->hw, &info);
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -3860,7 +3843,6 @@ static int wl1271_op_sched_scan_start(struct ieee80211_hw *hw,
 	wl->sched_vif = wlvif;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -3887,7 +3869,6 @@ static int wl1271_op_sched_scan_stop(struct ieee80211_hw *hw,
 
 	wl->ops->sched_scan_stop(wl, wlvif);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -3916,7 +3897,6 @@ static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw,
 	if (ret < 0)
 		wl1271_warning("wl1271_op_set_frag_threshold failed: %d", ret);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -3948,7 +3928,6 @@ static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, int radio_idx,
 		if (ret < 0)
 			wl1271_warning("set rts threshold failed: %d", ret);
 	}
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -4714,7 +4693,6 @@ static void wl1271_op_bss_info_changed(struct ieee80211_hw *hw,
 	else
 		wl1271_bss_info_changed_sta(wl, vif, bss_conf, changed);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -4779,7 +4757,6 @@ static void wlcore_op_change_chanctx(struct ieee80211_hw *hw,
 		}
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -4828,7 +4805,6 @@ static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		wlvif->radar_enabled = true;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -4871,7 +4847,6 @@ static void wlcore_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		wlvif->radar_enabled = false;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -4941,7 +4916,6 @@ wlcore_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 			goto out_sleep;
 	}
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -4995,7 +4969,6 @@ static int wl1271_op_conf_tx(struct ieee80211_hw *hw,
 				 0, 0);
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -5029,7 +5002,6 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *hw,
 		goto out_sleep;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -5342,7 +5314,6 @@ static int wl12xx_op_sta_state(struct ieee80211_hw *hw,
 
 	ret = wl12xx_update_sta_state(wl, wlvif, sta, old_state, new_state);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -5467,7 +5438,6 @@ static int wl1271_op_ampdu_action(struct ieee80211_hw *hw,
 		ret = -EINVAL;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -5511,7 +5481,6 @@ static int wl12xx_set_bitrate_mask(struct ieee80211_hw *hw,
 			wl1271_tx_min_rate_get(wl, wlvif->basic_rate_set);
 		ret = wl1271_acx_sta_rate_policies(wl, wlvif);
 
-		pm_runtime_mark_last_busy(wl->dev);
 		pm_runtime_put_autosuspend(wl->dev);
 	}
 out:
@@ -5566,7 +5535,6 @@ static void wl12xx_op_channel_switch(struct ieee80211_hw *hw,
 	}
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
@@ -5645,7 +5613,6 @@ static void wlcore_op_channel_switch_beacon(struct ieee80211_hw *hw,
 	set_bit(WLVIF_FLAG_CS_PROGRESS, &wlvif->flags);
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -5699,7 +5666,6 @@ static int wlcore_op_remain_on_channel(struct ieee80211_hw *hw,
 	ieee80211_queue_delayed_work(hw, &wl->roc_complete_work,
 				     msecs_to_jiffies(duration));
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -5748,7 +5714,6 @@ static int wlcore_roc_completed(struct wl1271 *wl)
 
 	ret = __wlcore_roc_completed(wl);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -5839,7 +5804,6 @@ static void wlcore_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->signal = rssi_dbm;
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 out:
diff --git a/drivers/net/wireless/ti/wlcore/scan.c b/drivers/net/wireless/ti/wlcore/scan.c
index b414305acc32..f6dc54c1dbad 100644
--- a/drivers/net/wireless/ti/wlcore/scan.c
+++ b/drivers/net/wireless/ti/wlcore/scan.c
@@ -69,7 +69,6 @@ void wl1271_scan_complete_work(struct work_struct *work)
 
 	wlcore_cmd_regdomain_config_locked(wl);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
 	ieee80211_scan_completed(wl->hw, &info);
diff --git a/drivers/net/wireless/ti/wlcore/sysfs.c b/drivers/net/wireless/ti/wlcore/sysfs.c
index 65ca5dc569a0..5ab6c1683675 100644
--- a/drivers/net/wireless/ti/wlcore/sysfs.c
+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
@@ -58,7 +58,6 @@ static ssize_t bt_coex_state_store(struct device *dev,
 		goto out;
 
 	wl1271_acx_sg_enable(wl, wl->sg_enabled);
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 
  out:
diff --git a/drivers/net/wireless/ti/wlcore/testmode.c b/drivers/net/wireless/ti/wlcore/testmode.c
index fc8ea58bc165..7c0cb1b7fef0 100644
--- a/drivers/net/wireless/ti/wlcore/testmode.c
+++ b/drivers/net/wireless/ti/wlcore/testmode.c
@@ -127,7 +127,6 @@ static int wl1271_tm_cmd_test(struct wl1271 *wl, struct nlattr *tb[])
 	}
 
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -192,7 +191,6 @@ static int wl1271_tm_cmd_interrogate(struct wl1271 *wl, struct nlattr *tb[])
 out_free:
 	kfree(cmd);
 out_sleep:
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 464587d16ab2..f76087be2f75 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -863,7 +863,6 @@ void wl1271_tx_work(struct work_struct *work)
 		goto out;
 	}
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/vendor_cmd.c b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
index e4269e2b0098..5bb9eb300f97 100644
--- a/drivers/net/wireless/ti/wlcore/vendor_cmd.c
+++ b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
@@ -60,7 +60,6 @@ wlcore_vendor_cmd_smart_config_start(struct wiphy *wiphy,
 	ret = wlcore_smart_config_start(wl,
 			nla_get_u32(tb[WLCORE_VENDOR_ATTR_GROUP_ID]));
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -92,7 +91,6 @@ wlcore_vendor_cmd_smart_config_stop(struct wiphy *wiphy,
 
 	ret = wlcore_smart_config_stop(wl);
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
@@ -140,7 +138,6 @@ wlcore_vendor_cmd_smart_config_set_group_key(struct wiphy *wiphy,
 			nla_len(tb[WLCORE_VENDOR_ATTR_GROUP_KEY]),
 			nla_data(tb[WLCORE_VENDOR_ATTR_GROUP_KEY]));
 
-	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
-- 
2.47.3


