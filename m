Return-Path: <linux-wireless+bounces-37838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+F3FuZcMWpdiAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:25:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC3690730
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:25:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rIrLKTW+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37838-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37838-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8FD336E67B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA540DFC5;
	Tue, 16 Jun 2026 14:16:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AE36F42A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 14:16:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619413; cv=none; b=RBlI0ot2buW9PBYJrtK20tjZAJPEOfd3vcavhSo+JRyP5VpN7iQlQwsDF1AJT8cZTnuqiYiH042297qA+0FvSrrrwFdHc4NEcv0MPdeadZ9cGS7bHXdbyfSk+UKGUryqnzo/zzdTnVhWCWe6hSRduesK3yMA4vwo7/pGR0aq7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619413; c=relaxed/simple;
	bh=rJyACaiama/hH0/dDvDxgISPef9RXUZwHeUgkb9Fzbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBGQi6C5gxDzwvl9p0weSI4fYVGcwkGdcEsG6k2rjyS7gHGLVt09nlfkf6npi5pMHDE4loCQRJBCufaQLY3PfEL6a2xo8tGeEUH+EkARWw3tVthkK7YCSxbJPpCtyqgQKZatg5wRG2Jl2PjEr8yTYIGaR0+KaUvsRnVEnoO9Eio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIrLKTW+; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so7176604a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619410; x=1782224210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2a9hA+PF0fA31kviGfm+Sq4O7e9fjo85MgaBgSex4U=;
        b=rIrLKTW+uO0kOSW7GvebQxsM1lRqXJX/NH7r/bMcX8zQ3kR+0dy79/6G0150AlBDap
         VMc2mEAz8HzfpyKFUnCWGlUCGyrkwTCFDxn+SJzJ0RALkOK3jrtrZyCByarNVQfAqmSP
         Doy/m8SKJQRvgihZv4s7akK1FJ9eKXDJtx9FrEhK/Y7NKlxx/azGvUjm3EpgAAeu5H2P
         CEL9apQ5+se0R0Y8TGB/6/S/azODv3X+Y/DbzZzaX0IFBj1SfD62xV5OXfL17Gz4q9gl
         3oRdeCS/Ao2F7rz3tyFoAyaGfbkqWuOBTDx5pwKGLpYQvdfGomNfCz8QBCjPUVl2fi1k
         htHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619410; x=1782224210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2a9hA+PF0fA31kviGfm+Sq4O7e9fjo85MgaBgSex4U=;
        b=fZMc7Nl1hdsU6S/ErT1fw8OMOWw+aGw7ccfpkkuWluxXitVk9rRMFm13NMCF73dw/Y
         y6bZZgluq2g4iZre0iLj92M2dlgET9NEKOWZYpwqKozVUXu1L8WClh3ng96NDOWMJ8hG
         OcW9DfiyOcR+esDl63yRTD8OotALf5x3wxthTTNNZ9dEQlm2XdLOnuTY3K6LAJrWTgIj
         3nVCIolXzJq1O/vwseU3V9HgVazYqgg18kToIlFg0rYVVkyalPLsl/v0aRSN0SqxtCSI
         dBezq2P/46lRIvPRQaaeJgCZRXcrN8tGSAaH1LAbY9thMIK87/9xQKYXXNm/P29peVMP
         rEXQ==
X-Gm-Message-State: AOJu0YxgoC2qq60PgMsVoOz1OTF0KOXBO0AYL3sonJFrf6XlUWIhYpSX
	ntmkTMCPW+EytV90IlVZrpw0wC6I2/GGAC4QsJwVP7w8zT90IGZiWvbq
X-Gm-Gg: Acq92OHSnIccJ84PWSNQmlqnyMdxTCcOFFJP/Kv5jnni1Rjj+GrN1/0a99+Q/rJ9Qda
	NBiOVFXy8oqeYOzTT+RRfGdT1hrl3sGfVK1yILUjG7iAKfhfRvgbI8NmxudUV/zF/2uk6aODHkW
	R3yzzYGCLyEJumx6JZVl8e3Z1cA/8mSd5UGwlLdjOYx6JUaqfJaR5K7RiJChYpkyLBVIAU1TdT6
	NXongkBPgO2C3cDC+rPGzHcqx2xekvyASE2eZIJG4x9UgWcd3U28WkIMW0PhaZYHSpcZyhxZ4Tw
	Bm7VNiFIP7JRTC5tQWPCl15CdcnLDLa+6fMZR1eW47H2cduux5fD3K4rg1KMnP07B6piwjL1OfH
	gX/td3jwin2TFY7nzbOgOp2CnVk0E5O8KN9QyXI9I3xbM8dBa37Q4fB9gLXQY1ZXdu4sc2IzhsQ
	x00j0ovCpwxAvsjSrLRcB4NN5vZSf6M1UtB4Z+c9PoCCe7
X-Received: by 2002:a05:6402:5246:b0:691:b0f8:f2c6 with SMTP id 4fb4d7f45d1cf-695087ce047mr2026138a12.17.1781619409987;
        Tue, 16 Jun 2026 07:16:49 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949bc64sm5122136a12.26.2026.06.16.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:16:49 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v2 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
Date: Tue, 16 Jun 2026 16:16:18 +0200
Message-ID: <20260616141620.91081-2-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616141620.91081-1-william.hansen.baird@gmail.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260616141620.91081-1-william.hansen.baird@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37838-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7EC3690730

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

Fixes: 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 38 ++++++++++++++--------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 73018a0498b4..a5bab06f2b61 100644
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
@@ -330,10 +328,24 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 
 static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 {
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
 	_rtl_pci_update_default_setting(hw);
 
+	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
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


