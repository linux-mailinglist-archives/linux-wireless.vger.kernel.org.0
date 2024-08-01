Return-Path: <linux-wireless+bounces-10800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08416943FA1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6021F21749
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6C1E8BCA;
	Thu,  1 Aug 2024 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1PwMtJJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CF1E8BB7;
	Thu,  1 Aug 2024 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472822; cv=none; b=n+gHgt0zHSkIrH4j7FPWDERKnG807PzMsS7Q/xd3or08n7otIzrPIQjy8GELu/E/gjeMQ6Fy3k86+ieqABv1G+jykAFEbBnaqUr4wtmBl2My8hlojzfBeZ9kB7DlA/k4vGrpyVjD5GnvCXeNF2PagkATKmlwCo6gD2EfPRK4i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472822; c=relaxed/simple;
	bh=jpH5QLHPeL4UPbHzhYfTGVPS+btmG64QSgSRXdaGc6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp3fnbpWFIFzZwmI8DG0/8lN6hpUWZLJP5cSmVhNGinsgMqRa/f6o8OvIgsBbQinLhfW5fSTLDCyqamargGrLrkAKA6FoP/fWQM3aTsbbdRxaFN61motnUXkMD28rBpPXsx/oq0m5N8CJjIUOi2MWeyuxTvTzyuAQ0+j7SpTE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1PwMtJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C8C116B1;
	Thu,  1 Aug 2024 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472821;
	bh=jpH5QLHPeL4UPbHzhYfTGVPS+btmG64QSgSRXdaGc6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1PwMtJJ9H52Im4kqrfheem1msmTR2a9lHkRgZNYq+BEMXuvkUNjiwTRigC4+Jeqz
	 55p0ZlxaTq8DPIb5XK/65CokAGXDBzSKWZ3Tlx25ZNxbj4uFG+3UlB+UUgmcZVvCjZ
	 q7UUguUvQGqijCYG6IXJ9QHrY70Yu4AuoY6NDJWroUHrajPZuqod9qwjANXPaLjwFI
	 aUB/QtjRmaVbcNYp+XsvxkwRYZtdJalakBahSwg/xfQNbuVLTVSfjb6kEKfBcfVy24
	 MYjDeP+vm9F08mGT0hF9sXcZKYaZerRvEzFgGwaMbu2n0V7QGqBLIPLx76IBQgXDTl
	 KlVLF59/OkHLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmantipov@yandex.ru,
	linus.walleij@linaro.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/22] wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
Date: Wed, 31 Jul 2024 20:38:51 -0400
Message-ID: <20240801003918.3939431-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index fa5634af40f7c..2e7f31bf38002 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1307,6 +1307,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 
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


