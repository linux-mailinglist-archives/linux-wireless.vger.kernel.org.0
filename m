Return-Path: <linux-wireless+bounces-38156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ukrDKPBMPmrOCwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E246CBDF0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KiROF9ai;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38156-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38156-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6738F3034234
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F83EAC8A;
	Fri, 26 Jun 2026 09:57:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674333EB118
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 09:56:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467821; cv=none; b=EltrgPjeFkeRUn7GMEuzJQxjAdOEVKzrlrhbimffp4RG1ihDEL9COk+GcEf80smvf6WafAioR3T1YiJpFgglm2uTgyBP5RTlwHsdwGp6G9TKYAzEX/5pJ5bfzTFVCEn1WprmlLFrQiT+6/vA+WFKfGWyM4/lfFxIh+sc9pN6RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467821; c=relaxed/simple;
	bh=Kd+TnaDGPJyWK7v4ONuf2eQp5WbJgJhQDgrvEIGvASU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+kwOPl4AcreYTmJpU/2Rs23PsdTqLtimuI33SUAzGUljuKpbGWhZI0aGnxlsr8z7XLtUDZaVK+sAS5t9Vv7BFlvNz0yw0FzzCah6QIvIDSemZ4yBpn9rPLerbBGr+yQAds/Txg78rx7QjzP7NrQn6rL8yfXwFHkfBB8PezjUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiROF9ai; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c0c964d6470so84108766b.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782467818; x=1783072618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL6Sc/C42ZpW30JL0f7H1Tdck+5JPnz3ydDM2HzSp1I=;
        b=KiROF9aiH298o6PYM3ZUcfn/2+0GBA9pNcvyTdKBduE3zjMCb+1/9A/DXGzSxmbzch
         RG7A5Hb5VZ1XwApjQE8kH3ZEoyXeIZfh9weBkFQPxR1x1fQNExSD3TT/CqwxrEdWuEKq
         NhrKqjBzClxTIojEx+2HyOivW/9nDcfO8OGMzkRlXim+Hz1rTW1x+I3fHXsQvKtC2DL+
         m26NsFvGiS8O+hVwmlIrynFpHIry6dSAuuiWcuIHxhQ0t6oCkiJbVIC+SxiMIGbWe2l+
         Ddn4cV/XRkFhRpvpoaYMAuEVC0okiN69YR0Ra1vATv877QBeZ3QKWjWV0CmBL2RaL/RI
         kvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467818; x=1783072618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FL6Sc/C42ZpW30JL0f7H1Tdck+5JPnz3ydDM2HzSp1I=;
        b=NCc7+1e5VoBIJepLHsHkjPJeRidvaqeEHocTfaWNAwOvHYRbtzGNNCgQBcTOKPCzJO
         NSQCqFIXnwL1c99Mg5ZboQDDSW1qgtzV/Lz73RaqNPDQJa0Pr/F+mJNtbzuaHE5k0Vsc
         c/wNY4/fzGL2uUiN1ZzNXbgGBTekBznraiTiEPDlK+Zf1+MJBy+9akd6BfWJWmxJ7FWH
         iuYlLtoA/qRMxRraUez4RMC3uN3ZKttPwIka/RabzoFU0VoVJB31KZ+J0vbMWcCb2O2J
         junstIbDNJbKYBelPKNFVlCrRa9sMYWP6VA2Ttcm86gNBrWDRFBbYL7gm8vgusvzABQX
         5mCg==
X-Gm-Message-State: AOJu0YzsOSpRzDKv1tQRmvuypQrCxidG6fEYwlz7eyCof58EhxSV/cEb
	yy7+17JOsapOHaM7F70ZKM93qMgpYBy2Owv5zkfRCHmsM37ZOZ4d5SoM
X-Gm-Gg: AfdE7cm/CcPDwhi7+wILpgiIiVV3sp7V97nok+b9VQ32ZOYAMCX6b7ZMJYDFNg9TKOv
	aA0D+CHxHPlPE4UygHzzRnePPYwLYQk0yGR962hMr5Boee6stkuX1SdBdRKzOvtdM/rN5ECsQ1G
	Anct59ZmuGWxgapG5jOSe0lqvMBooc2KKca3NrovffuSTkRVUM0MxJZJUcqFZNfNesXcfbuEjNL
	7xg5BiVdIT0is8GTDLdfXNN95hoqUR/dcjKs10A+0nmhf/0Ot6CgQartNcAGcYS7WpxQfIE4pQD
	wIfAeilZyGYCV6beemMpqxmYj6OArDGOcxkEN2//55+sOqo++6dzu4tCc9JEf/wHIVMQOYDeOf9
	cI2iDpB1XOnkZ4/4841QaeTK8avBhpRy7kDb/pyXIDkgewoEXshdOSGN9ZSed4szUd7/cTW0Udr
	XbLNF2E+2YUaILHraivsbn3e8=
X-Received: by 2002:a17:907:7203:b0:c12:1d59:23cf with SMTP id a640c23a62f3a-c121d5936a6mr176524366b.35.1782467817511;
        Fri, 26 Jun 2026 02:56:57 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05f9csm311638166b.31.2026.06.26.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:56:56 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v3 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
Date: Fri, 26 Jun 2026 11:56:46 +0200
Message-ID: <20260626095648.1124924-2-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
References: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38156-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43E246CBDF0

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
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 39 ++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 73018a0498b4..38eca8d91581 100644
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


