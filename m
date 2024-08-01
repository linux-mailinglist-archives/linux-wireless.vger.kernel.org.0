Return-Path: <linux-wireless+bounces-10801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FA943FC2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743C31F210D0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229FE1C9EC2;
	Thu,  1 Aug 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUKInJTF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA042170A3C;
	Thu,  1 Aug 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472870; cv=none; b=CpZLWT/5G09MQRIj4B4tQ6DHwOJusWUsgmy9hV0h/kkjD9KhwRQOxNej4IVqs168n5w2s1WmbIMF3Zp29l+n7kct2LqdHpBBxFpK8HW66LwTToI7HHiE2vpzKHsFtJEdl4qjSETCRZmQnPkFaUHf+uHfpyKNCANW9EDeRwlO+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472870; c=relaxed/simple;
	bh=/T/WOUqglZM5VGsry8EYlw0dkYeiHwm2QVE0zYOmcTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjQm86hgzgZ3yk5u9hu5N8k9Jr6Q+FxgHZjto+7Ma82vhvxVnodYPsl9FM4iI+kGpv9epw6IjTujRMGxIHYmIgeC+Sx8DkBXJjHiVnU08oG5WQoWLuBEMWMpUP1ezcrvrUzh8EoX7aCsYwm4ivLxXiaItIy99d88d//wsn6xrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUKInJTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CF7C32786;
	Thu,  1 Aug 2024 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472869;
	bh=/T/WOUqglZM5VGsry8EYlw0dkYeiHwm2QVE0zYOmcTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUKInJTFBE6JNZ/6HBNEXnaXcMIpENY8XXxqrJMqy6EkZ65rTf0bnx6Zak03HiYX9
	 1lXlAS1U0CDDGnFLWW6dZUXjALgOiBqry2srsINwxfkq1R6uZKsNTEyPrmSS5JGuWN
	 bLvBLDXCu2T3gBK5/KJv9zIRLeRixwid1m4o5f7M407GRYZ5m8GQTbC4FRWVFG2nHO
	 thVWv5ogqDCrWKxlPyWEW26GGsCGqoGHaSDs8InVCnrJTleG/8Jip/6o+sFUky6iWY
	 ChXI3FJW7P5B5gjeQk//w5lS5it/zHTCfoZq/oDbj3JOsrp/0+3ITZJMWpuMShXut8
	 Wae2B7368vHgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmantipov@yandex.ru,
	johannes.berg@intel.com,
	linus.walleij@linaro.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/14] wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
Date: Wed, 31 Jul 2024 20:40:22 -0400
Message-ID: <20240801004037.3939932-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit c145eea2f75ff7949392aebecf7ef0a81c1f6c14 ]

mwifiex_get_priv_by_id() returns the priv pointer corresponding to
the bss_num and bss_type, but without checking if the priv is actually
currently in use.
Unused priv pointers do not have a wiphy attached to them which can
lead to NULL pointer dereferences further down the callstack.  Fix
this by returning only used priv pointers which have priv->bss_mode
set to something else than NL80211_IFTYPE_UNSPECIFIED.

Said NULL pointer dereference happened when an Accesspoint was started
with wpa_supplicant -i mlan0 with this config:

network={
        ssid="somessid"
        mode=2
        frequency=2412
        key_mgmt=WPA-PSK WPA-PSK-SHA256
        proto=RSN
        group=CCMP
        pairwise=CCMP
        psk="12345678"
}

When waiting for the AP to be established, interrupting wpa_supplicant
with <ctrl-c> and starting it again this happens:

| Unable to handle kernel NULL pointer dereference at virtual address 0000000000000140
| Mem abort info:
|   ESR = 0x0000000096000004
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x04: level 0 translation fault
| Data abort info:
|   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
|   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046d96000
| [0000000000000140] pgd=0000000000000000, p4d=0000000000000000
| Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
| Modules linked in: caam_jr caamhash_desc spidev caamalg_desc crypto_engine authenc libdes mwifiex_sdio
+mwifiex crct10dif_ce cdc_acm onboard_usb_hub fsl_imx8_ddr_perf imx8m_ddrc rtc_ds1307 lm75 rtc_snvs
+imx_sdma caam imx8mm_thermal spi_imx error imx_cpufreq_dt fuse ip_tables x_tables ipv6
| CPU: 0 PID: 8 Comm: kworker/0:1 Not tainted 6.9.0-00007-g937242013fce-dirty #18
| Hardware name: somemachine (DT)
| Workqueue: events sdio_irq_work
| pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : mwifiex_get_cfp+0xd8/0x15c [mwifiex]
| lr : mwifiex_get_cfp+0x34/0x15c [mwifiex]
| sp : ffff8000818b3a70
| x29: ffff8000818b3a70 x28: ffff000006bfd8a5 x27: 0000000000000004
| x26: 000000000000002c x25: 0000000000001511 x24: 0000000002e86bc9
| x23: ffff000006bfd996 x22: 0000000000000004 x21: ffff000007bec000
| x20: 000000000000002c x19: 0000000000000000 x18: 0000000000000000
| x17: 000000040044ffff x16: 00500072b5503510 x15: ccc283740681e517
| x14: 0201000101006d15 x13: 0000000002e8ff43 x12: 002c01000000ffb1
| x11: 0100000000000000 x10: 02e8ff43002c0100 x9 : 0000ffb100100157
| x8 : ffff000003d20000 x7 : 00000000000002f1 x6 : 00000000ffffe124
| x5 : 0000000000000001 x4 : 0000000000000003 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : 0001000000011001 x0 : 0000000000000000
| Call trace:
|  mwifiex_get_cfp+0xd8/0x15c [mwifiex]
|  mwifiex_parse_single_response_buf+0x1d0/0x504 [mwifiex]
|  mwifiex_handle_event_ext_scan_report+0x19c/0x2f8 [mwifiex]
|  mwifiex_process_sta_event+0x298/0xf0c [mwifiex]
|  mwifiex_process_event+0x110/0x238 [mwifiex]
|  mwifiex_main_process+0x428/0xa44 [mwifiex]
|  mwifiex_sdio_interrupt+0x64/0x12c [mwifiex_sdio]
|  process_sdio_pending_irqs+0x64/0x1b8
|  sdio_irq_work+0x4c/0x7c
|  process_one_work+0x148/0x2a0
|  worker_thread+0x2fc/0x40c
|  kthread+0x110/0x114
|  ret_from_fork+0x10/0x20
| Code: a94153f3 a8c37bfd d50323bf d65f03c0 (f940a000)
| ---[ end trace 0000000000000000 ]---

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240703072409.556618-1-s.hauer@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 7e526014b6385..89774e0316bdc 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1306,6 +1306,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+				continue;
+
 			if ((adapter->priv[i]->bss_num == bss_num) &&
 			    (adapter->priv[i]->bss_type == bss_type))
 				break;
-- 
2.43.0


