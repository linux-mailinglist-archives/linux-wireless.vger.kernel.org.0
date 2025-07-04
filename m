Return-Path: <linux-wireless+bounces-24816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B19AF8BA8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA55B56320F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0752EE26D;
	Fri,  4 Jul 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEejTh0y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F22EAD0C;
	Fri,  4 Jul 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615690; cv=none; b=SkAo3AOnc9RauDLmhCTL2d7efNqJ5O27nLjFTgzse9UkRq+KtJybkswPipmYh47sKnUtrQLcLKg3dzK4sEyItIqjYnpGnOtg/OT6kA1dLpSLIrj8pBy6lWheF/O5QnB6VChHsEXWr4crXt7wDfOSTRxCnAamhb6VjTsrkMov7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615690; c=relaxed/simple;
	bh=HrouddiiiZ8tRNEOT5O2n4uTgzGX88z0KiQIrcIFHkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h86Umy6MI9VpYxZ0396++WYIUYhUwI3EKJd/nNWol8FoqbAbxAGQhhxdoXzF6BNfdFzZQK/aiA4kBvpQx4/5BjmvelIraSPHEAmc8polNLvlERwbabyIi5LYzDsZcgO4YkplPWn7yx3zDbg0i71wwljIQ3MSI2N4DQpJQubxPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEejTh0y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615687; x=1783151687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrouddiiiZ8tRNEOT5O2n4uTgzGX88z0KiQIrcIFHkY=;
  b=QEejTh0y0XXVIczJ2fOzweslmnIOJmKyzmmG4/OJbyNNeBGo09b5TVoy
   A9KrxdFK8A+UhuHkKJ8esuPPHgUyp5r8N46WxWcTo299179aJFtP+p3ed
   uz4NG+YJb+/3thoxf/9R4rIBH5eBzdTUMIwPX2TW+MuD2GkeO6XvPHsD3
   zl7t6/kAIlyV764CcyZ8ec6E6w90oDkGYj/uQeBWW+r6AtQgT7MH79nsE
   bLNl4enYL6pyOseT/bGMSDbihmh/DCjMOrJgHUZYKmpUskY7AdBXL8T/E
   K6Ahdxo9miMXY0BY/wkW5ITBTscmpAZDlW64Owqtr0I3Wda+dnY2a0Pdg
   g==;
X-CSE-ConnectionGUID: If3xGhalTtKdVBJzct7plA==
X-CSE-MsgGUID: QIIFVv5ISumA+sZJGj06tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194169"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194169"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:45 -0700
X-CSE-ConnectionGUID: griQfTS3QnybE8I9hXZrpg==
X-CSE-MsgGUID: P1HaKl35TyiydesJN2FrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616611"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:40 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 2479C44433;
	Fri,  4 Jul 2025 10:54:38 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kalle Valo <kvalo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 48/80] net: wireless: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:37 +0300
Message-Id: <20250704075437.3220878-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
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
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

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
2.39.5


