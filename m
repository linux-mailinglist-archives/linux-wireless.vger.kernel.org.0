Return-Path: <linux-wireless+bounces-10445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDAC939B7D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 09:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08AA1C21BE8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BA14B97D;
	Tue, 23 Jul 2024 07:10:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3714A62B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718621; cv=none; b=FxnHLZb2CnI9whN4uIbY04PuzBD8dkpv8oCZuG1RB28+vZR7ZWx4RFHF1LnHAbvKM/ngLqmOPtCeJmIdbRQBiRf/+XKCznK4p0a1xKEruU0rqlxrlgnw2SMO3foeS5a3lwxgn5eUDL4KzSKhtSLbVyg6uc3RmyUl825bZqQZmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718621; c=relaxed/simple;
	bh=wzn/r/5WRn+jiDnO4sEyQ2Ina1Q4p7Vzlb7yDTY/sSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYwlODqeYJpr10qUGyHrfa6Qqdl6MpLUtAdGJ104FQ0C7MS6Rf+gdHw0fWQ7yRX+XsgEM2rCuYD2gNbxwRXSz/2ZrCIEevz8gKsKNxBMtNi9C+mndP5fZrcAIRTn7T9RLjcJXi12Duao8k6dEIqJLoe2lS44oT4vie0eWx/j+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9ev-0007O8-Fu; Tue, 23 Jul 2024 09:10:05 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-001ZAY-K6; Tue, 23 Jul 2024 09:10:03 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-00FQKO-1j;
	Tue, 23 Jul 2024 09:10:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 23 Jul 2024 09:09:58 +0200
Subject: [PATCH v3 2/3] wifi: mwifiex: fix key_mgmt setting
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721718603; l=1724;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=wzn/r/5WRn+jiDnO4sEyQ2Ina1Q4p7Vzlb7yDTY/sSc=;
 b=AxKGRepMpo0W0EVZ8c2FWJEiZslEtRkvmjjz/rUcNIdnSOYfifcSBpFb54Iu9i54J5pKUJA2W
 HXe+VeGpYSzA5pEdISkIiliHPg9LAcaDgyEbTqi4QriqoahNW0ff+JS
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

bss_config->key_mgmt specifies the AKM suites that are usable in
hardware. This variable is set to specific values while iterating
over the advertised AKM suites. This means the final value of the
variable depends on the order of the entries in the AKM suites
array. Instead of setting the variable, just set the relevant bits
in the key_mgmt bit field to make us independent of the order of
entries.
This behaviour is derived from the downstream driver that does the
same.
Also, set bss_config->key_mgmt to zero explicitly right before the
loop. bss_config has been zero allocated by the caller already, but
do so again to safe the reader from following the code path.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 7f822660fd955..57280eaae483c 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -52,13 +52,14 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
 		bss_config->protocol |= PROTOCOL_WPA2;
 
+	bss_config->key_mgmt = 0;
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			bss_config->key_mgmt = KEY_MGMT_EAP;
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			bss_config->key_mgmt = KEY_MGMT_PSK;
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
 			break;
 		default:
 			break;

-- 
2.39.2


