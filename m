Return-Path: <linux-wireless+bounces-30863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E923DD29825
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1AC30CE2C4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2F317704;
	Fri, 16 Jan 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9uvqedC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970F3148B7
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525536; cv=none; b=MdtijuZWaQdOWBQvjkeeCZosdzcH//7o8sTYBCVx2Q4w4h3CKzviv7wYY71rPdx3WaHsB4V3qLJuiCbTizg0V3DjOW2OHrIHMCYAu5kVLaIBgrHWhObZlWBVslsOnezNu8Nc/rtsa2DlWRzMkfZF3WSVmr4UXILILnJswZcTASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525536; c=relaxed/simple;
	bh=bTBkoR/HGMUKUB0iBrEP++9Evouf7Ac6pUXzKhtf6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anzkFCdFJrsvffOKjNNnHJQGSpOGJVfbqHzg84Q66IFB5ELduEfcpVQu1ZKbjRKBJbsgLYo7DEldMiWhdrIICQUPTDt+1H4viokjRe996JYYJMRJQNameWG5P9sLlB76UdYl2WuooHwZaIz4a7q0AaaR3z6RzJaQxqfdPEg39qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9uvqedC; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae61424095so1666477eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525528; x=1769130328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9d/7gkP0dehSO2kv5Bs0x2eBF89HHL2x635aV3XfFw=;
        b=m9uvqedCAl6WqnsmwzDThrZAG4kUMsuLpebC4Dt5ndhqYkitrWyyC17lnP6i5mw+Fk
         02nN66gwNFMTzgxXlUzNyZySEJ9mKgbjJZcWiTMVo4ZrpvcOZa/MiQNnFRejTE8K4Rcd
         Cc3QgWOT9gCd8Gwx4i/pHMJPmZMGpP0+eiEgsFGhLiMFk6ARUubHWP9HtOk++RsO0yYT
         eC1epEImNxkw6MlSP/4KbVJVvz1n+zeTl2IpQLb/ln9iyoAlO37wdDrPI0d+AUnqWRzu
         KHq4ZQ1avSSxDyZWtkeDIj9w4iz9bbUM51m+7yDoPGjCq65HQZUmepQYhmEe8kSudX9q
         sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525528; x=1769130328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9d/7gkP0dehSO2kv5Bs0x2eBF89HHL2x635aV3XfFw=;
        b=JvATxJTz/ghDqHCWDONd/0lM688H4dO9Hs9r/FMwhNU+FsgaJedeJD/lHrT1l4YYUO
         ZQni6LD9o418TC/tRReEiah07I2adQyDy24AOn5Z8U1UrLVCpoZojJFUFsb6eNzWsVay
         Zxn7VN3em8wT/O1iG9P6DW1j3xxi6zGSMaJ9I01mUz2oTTB4hz+Bm1jX0ky366sfeJmy
         VcD+oZfVTC+oXj65LJAaEIpex2m4me9TjGbi0oo1TcOdWR/87LtYy5lQ+FHNhi1wUM1N
         HHzDaoPBmRcRba9wyQebuQKLQV6S686FR8VKhep+SJWQrNPd4EAQotH2M4pUHCTvq2kn
         GJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8mf7gLF+frmcPd2h+NQ4yB36G2rmjUoCj2julv41taEjdSIatOl8JW6ZqnLq86c86jAXjSJ7PkVtrHey9yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzZsDY1dz+qyxLNV9l9IzWvBHQLEdSjhmcqoDc8Mi/4nsqenX
	Y2imS7VFn9SXf6cN9H9BOz/u9D6kdDRxcSYwqPIufrfRznMiCG1C+Bh1
X-Gm-Gg: AY/fxX6szFZkacysilB6lwOsL4PCLUfSSw2LC8znNHOpuhBGxAChkxAS6lZFEEhBTQU
	i7bDoQo9K7+roZdJtdM6VUm//vcEwJWSkTvGu/U+UmVSxV/z0LMViMWrvbajes41cmbZiaCTlGn
	S3U4BIX2YiQrD3lXC9wlJP0OQSNiCau6Sc7Qm9d2HBQ9BZmOJx6e7ZUVd4oE+zmvDnFmRaYtF5c
	f8bOS+Kn5XkrTuGrX0lW6dRqZsHxgifdgACrDQ+JVfIK34Y0Teb9W0z1tZ9zJTOWweV4ljwKYxw
	dsr2Mj80r1LZkw2qDd/qxCnI0/lN8MUHrM3XTBvu0LLUZUXI+VImceEFyJKy2LsmMqVYicfrvey
	bc2gPh1OQV8QDvY6WkOZG9n7Bsx1aQc3U0bgfb8Qsde6Q7DSACAks2ZP1BpUwWr6CBp4tVDoTR2
	5mHIHoG9Sh5QLeA3byEpl6hkgvSztoUEcDIWY0AW66kFprCcgyXEybV4IqJviWuA==
X-Received: by 2002:a05:7301:290a:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b6b4e8a496mr1565789eec.22.1768525527714;
        Thu, 15 Jan 2026 17:05:27 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:27 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 03/21] wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO PM
Date: Thu, 15 Jan 2026 17:05:01 -0800
Message-ID: <20260116010519.37001-4-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

Two additional code paths iterate over active interfaces and call MCU
functions without proper mutex protection:

1. mt7925_set_runtime_pm(): Called when runtime PM settings change.
   The callback mt7925_pm_interface_iter() calls mt7925_mcu_set_beacon_filter()
   which in turn calls mt7925_mcu_set_rxfilter(). These MCU functions require
   the device mutex to be held.

2. mt7925_mlo_pm_work(): A workqueue function for MLO power management.
   The callback mt7925_mlo_pm_iter() was acquiring mutex internally, which
   is inconsistent with the rest of the driver where the caller holds the
   mutex during interface iteration.

These bugs can cause deadlocks when:
- Power management settings are changed while WiFi is active
- MLO power save state transitions occur during roaming

Move the mutex to the caller in mt7925_mlo_pm_work() for consistency
with the rest of the driver, and add mutex protection in
mt7925_set_runtime_pm().

Found through static analysis (clang-tidy) and comparison with the
MT7615 driver which correctly acquires mutex before interface iteration.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3001a62a8b..9f17b21aef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -751,9 +751,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
@@ -1301,14 +1303,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
 		return;
 
-	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		if (!bss_conf)
 			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
-	mt792x_mutex_release(dev);
 }
 
 void mt7925_mlo_pm_work(struct work_struct *work)
@@ -1317,9 +1317,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					      mlo_pm_work.work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_mlo_pm_iter, dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_scan_work(struct work_struct *work)
-- 
2.52.0


