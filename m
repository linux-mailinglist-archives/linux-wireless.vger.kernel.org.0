Return-Path: <linux-wireless+bounces-38389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BcrTEObQQ2rQjAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:21:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B060C6E55D3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:21:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bi1ZlCRY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38389-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38389-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C653136CA7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18B33ADA7;
	Tue, 30 Jun 2026 14:16:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988A2248B4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828969; cv=none; b=QwrPw3vNsD8tnJcC5xnq8lyCuNafP8LVBV9da62cxWUIW2c11xKEqTSwXP2J2ig6MxQofvILxc23ohOfFfc0e9ri90GkNSBdrRkRELMPiuVElODC9Qj8aTH9Wc7e3n3YmmRVzrJD0+ChAcHGzb9h1xsqcOKlto+mOoxa8zqYRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828969; c=relaxed/simple;
	bh=tto2rfCYdsH4DCmsQ3VkPbRQvNS9U5GQfTh6DJwpX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBBZTNU7Gy+JZeUMKDD0CVidj6aiDLBYjLWnKAqo5peUof/7Vb94vvCkttIiwpmGn6DDJpUDhzJhmdcAkgEIUKHCLoaac6PVCdlezUkYi/pHJfyiu+fa1e99r95e2rfpq/JfUYz5w252sfOY2v69yUaG0WLajlZJtLVuzzTbSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi1ZlCRY; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1274802697so203036566b.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828967; x=1783433767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK+dNZ8FTunYuRNHjOXWfA8/Iqk2Bd3g0hrdFJP9Rrc=;
        b=bi1ZlCRY5sC+bsdR3llLt5I6yFwKj7hlBVHqPCbNMSQUqO/ZCKgjjahXJeC0x8Lp3U
         JA2EhuR5wPv9rcPXwoXwzoKs6zzoreaFe0T17OzqQ7gM+8hWhp9Gxvlnq1pw46nItT9i
         uZv7hYAT3/eV92Grhi/gecTORsAPowtI4toP/zlXj56UR+fmvbxV+0sFpriAvHwPTXf+
         vCenawWksoCaO+aSqm+0gbBupi3XP/kmCmHR7z6/m8EKz9RMWDLIk3s1YMkeHSbWzo0U
         wcR4nv9+dmIGEQkxjtnKdgYFQwag8H7hhJliybwdlRffB8nDPuIDpr0ZamxXP+JoKpc9
         atwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828967; x=1783433767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hK+dNZ8FTunYuRNHjOXWfA8/Iqk2Bd3g0hrdFJP9Rrc=;
        b=aTUJ5tXM6x9IklIQGnTi9uFhpRzG/uCYwExND8nnvFrD1swav3/ij9sGQPcb9lc/Bw
         liJnJhLRSquP/GhPf6Ms0VGg9qvPk5qpGJN7zQOsKPwlngH/xSs8A4vK6j9H7Rd/ZthM
         jtpaIIpRCgvF8hzAlk3MFOPZ8em9jyxhbdcjJJBt3CpuKQLONyLwK2BQ4X1ZxjY8sVd8
         X2ZQhXNqtXt5CPSvI92O6XeBT9rel8JhLobgJaO2bZ1eDEU2XE70wDZsWf9T+LX9/Inu
         A8jC1H4tYIU69zuXhMEu2UQRq2yv8Wi0tf3/FURJCiogn4fvxts3K4IBMWBFmDmLupiG
         JwVw==
X-Gm-Message-State: AOJu0YzcHlqiWI/Dtzx8oLDus0JNiPMe6TFWxMwnKp5fm0uxgBnYbUP0
	+5AYC9KhqUsURGpJssYbBgipCP/nY9/0D4d3KLr8AJpevF9+zqrzfgLgouQoqUaEv9c=
X-Gm-Gg: AfdE7cl35hPyBJWQLvQmZWP0KDRh0ejdGFQdc0AcwBO2oHJwsg/T066wq+yPSysDd/d
	owMN7KJhf+xJTyRQ3LK1deFLNJ6ZAgf20pdmpigJoZg5zo72g13nmIXlIWapMPOwwsltsGPD3Fp
	sGfdXaauk6weLFTN7S0SVunfgRuVnmc9pqDMiQlMITniESRM4sRzInv3qx1+QkJsEJmq2mJBpux
	VH9mGdDorXn3/fOL2s7ovIfXQ6ZEovPhF7zb8b+ViOZ3I1y8xHMmanC9s6JvF6hze07yHkVvY8U
	wpmX175rCnC0QGo3GE34LfR9pyPjCCoIPtho7HSbMrlk+wObc5EyloEmWyyLIgN8r5y7x1ILFst
	OnkSWB3aPRMCb0L+BzgU6sENMw0DIB3GGhAWbHuTF8NpxPFzE+YdZU/v644vNyYMAlCNIWB0Qx8
	Xcam+Yw3naN/A2W5k61/SIiVidtZG0jW7qRA==
X-Received: by 2002:a17:907:6ea4:b0:be2:7f13:8e33 with SMTP id a640c23a62f3a-c128730a922mr190485566b.45.1782828966333;
        Tue, 30 Jun 2026 07:16:06 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4a137sm135831866b.50.2026.06.30.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:16:05 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v4 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
Date: Tue, 30 Jun 2026 16:15:51 +0200
Message-ID: <20260630141553.785769-2-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630141553.785769-1-william.hansen.baird@gmail.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
 <20260630141553.785769-1-william.hansen.baird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38389-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[80.208.66.169:received,209.85.218.45:received];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B060C6E55D3

commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
adds code which sets ppsc->support_aspm to false in
_rtl_pci_update_default_setting() in order to disable ASPM.
This does not, however, disable ASPM. Rather, it disables driver
control of ASPM, and blocks calls to rtl_pci_enable_aspm()
and rtl_pci_disable_aspm().

In some cases, the pci device supplied to the probe function has
ASPM enabled. The code would therefore not disable ASPM, as it means to,
but rather just leave it enabled.
This was discovered through testing on a Razer Blade 14 2017.

Implement a new __rtl_pci_disable_aspm(hw) function which does not check
ppsc->support_aspm before disabling and call it from
rtl_pci_disable_aspm().

Then move the code added in the previous commit to rtl_pci_init_aspm() to
allow adding a call to __rtl_pci_disable_aspm(hw).
This makes sure ASPM is disabled while still disabling
driver control of ASPM to block it from being enabled later.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 39 ++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 73018a0498b4..f706575f92ce 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -156,15 +156,6 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 				PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_CCC))
 		ppsc->support_aspm = false;
 
-	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
-	 * X555UQ with subsystem ID 11ad:1723 are known to output large
-	 * amounts of PCIe AER errors during and after boot up, causing
-	 * heavy lags, poor network throughput, and occasional lock-ups.
-	 */
-	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
-	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
-	     rtlpci->pdev->subsystem_device == 0x1723))
-		ppsc->support_aspm = false;
 }
 
 static bool _rtl_pci_platform_switch_device_pci_aspm(
@@ -203,7 +194,7 @@ static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
 }
 
 /*Disable RTL8192SE ASPM & Disable Pci Bridge ASPM*/
-static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
+static void __rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
@@ -215,9 +206,6 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	u16 aspmlevel = 0;
 	u16 tmp_u1b = 0;
 
-	if (!ppsc->support_aspm)
-		return;
-
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_UNKNOWN) {
 		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
 			"PCI(Bridge) UNKNOWN\n");
@@ -240,6 +228,16 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
 }
 
+static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
+{
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+
+	if (!ppsc->support_aspm)
+		return;
+
+	__rtl_pci_disable_aspm(hw);
+}
+
 /*Enable RTL8192SE ASPM & Enable Pci Bridge ASPM for
  *power saving We should follow the sequence to enable
  *RTL8192SE first then enable Pci Bridge ASPM
@@ -330,10 +328,25 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 
 static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 {
+	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	_rtl_pci_update_default_setting(hw);
 
+	/*
+	 * RTL8723BE found on some ASUSTek laptops, such as F441U and
+	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * amounts of PCIe AER errors during and after boot up, causing
+	 * heavy lags, poor network throughput, and occasional lock-ups.
+	 */
+	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
+	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
+	     rtlpci->pdev->subsystem_device == 0x1723)) {
+		__rtl_pci_disable_aspm(hw);
+		ppsc->support_aspm = false;
+	}
+
 	if (ppsc->reg_rfps_level & RT_RF_PS_LEVEL_ALWAYS_ASPM) {
 		/*Always enable ASPM & Clock Req. */
 		rtl_pci_enable_aspm(hw);
-- 
2.54.0


