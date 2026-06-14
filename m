Return-Path: <linux-wireless+bounces-37788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 234mH+WyLmrx1wQAu9opvQ
	(envelope-from <linux-wireless+bounces-37788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:55:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE36813B1
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:55:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pwHETO30;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37788-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37788-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1919300E248
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B63C4166;
	Sun, 14 Jun 2026 13:55:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA03BBFBC
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 13:55:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445330; cv=none; b=KJ78znx3x8xTgtPdFGXp/RhIwScePokNsP8OtpBni6sh9P8Pq7yXe8kLMe0cjuJr8EFfsdPg6Ux06qstqHPBHhCVBBnb3c1mwgFbTE3h+14KeOQHZ6BRL4Ufdhnga+s6emfo33wA1ihCVdtLbVIdxIGLjgADFm78Y9R7C10H8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445330; c=relaxed/simple;
	bh=IOEELMBHPTQoy/DJQ3hmBqjNjGBRksgiX6uD4Astx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym71BkkjmSep8CpjLNuSrBzFB9wOhbBDQwTXT7uAgg+0YKwObJWvgnaaeIlzWYHg57+NAIvcm1rFuf7xeixwLuHyf7K5hqvmZ4K4SoObMaWGx4wmDy1iEqCBcfJqrZAl8QqP/bWfZ9eRf8kea2YGCdj6Y5pv+EU06Blh7W6CYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwHETO30; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bf046d4da1fso220382966b.3
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781445327; x=1782050127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyZ7rRMd2nepnzLpbMXPQjOGTvYeVQr8u2XVEvw4Sf4=;
        b=pwHETO30jrNs5JN1FjnJSihL1lxOuAOAxD8pHCau47QQaaER86r2AgiIL++ng2XCCC
         3XmYsV6KM549w/X7xlWGMwWzYNHBjiXftQ7/HAuspCuSMGmOfMITlyT39KByH1vaa8dq
         WqqcUiWjn4CkHR/1s5O1kbcX4UH9bS3xkz1qDzVldepp6pQ/HeJMwEumz/h97Y+CG+gV
         H/cqHS34peNYWp279lOSb2ZEqq34884lYxxuQangFSHj1x+kfHiCvHY8GTji/CN56bpy
         7nWuFRvGd/tAD9cGopeEiQoSw1CGqFgeKkSFrP0IkS+ojdWaLpoTCTSkdyyk9r3IAIEy
         en8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445327; x=1782050127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyZ7rRMd2nepnzLpbMXPQjOGTvYeVQr8u2XVEvw4Sf4=;
        b=nDppbK9YvETy8/nO2MCKcisnnR4Sld9TpsY01amQkjPxLm5H5rACqCocbU+oXmNbdE
         70wHuKXognm6oWhXAlmGYyLdyFbrfsRc8u8bzO+ewQO+4abrUSFe0RNTQZqV8LXmeRZn
         Vt2KIwikGjQ7aPzQgecZ2iRkmTgCjeVbMeAh3u1HeuQBbD56d4/Lvlnja1l2XegszWyb
         yO8ZzgP2N7nVFgfaroSB12dS6fSSoBNxY2kPb7JhcAV9LJ4TgAqWq3r2x91Hfq45NMB5
         s8VNW2vFifu0XSxeR4iEucSdz8mYhDd/KhKuNYWd3j1UaCuGTxgJ/+YSfVyGxFLeo1GI
         Nncg==
X-Gm-Message-State: AOJu0YxQjN+ZoKE3eVX3CGP665YBHigjkvte5mRG2mIcPNaj6hpD2dI1
	20EV06JDX1BgOLC9LwsA0D5RaETtly2eMRZqrj7oe27bZLEA/S/8St8+
X-Gm-Gg: Acq92OE1C56FRjZTosPoKsAdvSM7pJ8DpKb3LApgkbka5J+9K1iNSAb0O2fTTdMFiCe
	MH6e/X/GcGbyQny5FqjUeFayXXzPbuysbkrw+joVYqVEXJlPEdpIAgdjE1Bz450arureifcwOAx
	Y+l3f3zLYZxmKaZClY64cqHDa0iseprxy5OjUD5PKpOquRsAfbQ9+ZONMVuKb8+g0jhDFO0Q/Ep
	GzSPbprbPICFstgkWkNF9r2QC+A9vU5hACqmk6rCqeeREPKl22/8MkKRYklWlCtA9B4FpF9wZjY
	G0Mj8M4ijntqGV/sWBjqoEqCsIMsjneZMpKmTjE43r/v5XJXDzRAMFMwpirQT53zmrRCni3tKy2
	Ce6IRJkpk6fl0H+5KzX2Mz/RLZGjzXn/fjsSjhDq4C9Xza7C25ZQhhsRWUA3aszfiLzUB+PbM1T
	BuqeLwu3FEuwpZYvN+YDDtsrnW6B+zPSN1
X-Received: by 2002:a17:907:c0d:b0:bed:afd7:185 with SMTP id a640c23a62f3a-bff4c6fb2c9mr284460466b.43.1781445326848;
        Sun, 14 Jun 2026 06:55:26 -0700 (PDT)
Received: from localhost ([37.185.178.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8b23f8fsm316775366b.53.2026.06.14.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:55:26 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next 1/3] wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
Date: Sun, 14 Jun 2026 15:55:06 +0200
Message-ID: <20260614135508.70307-2-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614135508.70307-1-william.hansen.baird@gmail.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37788-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7DE36813B1

Commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
adds code which sets ppsc->support_aspm to false in
_rtl_pci_update_default_setting() in order to disable ASPM.
This does not, however, disable ASPM. Rather, it disables driver
control of ASPM, and blocks calls to rtl_pci_enable_aspm()
and rtl_pci_disable_aspm().

In some cases, the pci device supplied to the probe function has
ASPM enabled. The code would therefore not disable ASPM, as it means to,
but rather just leave it enabled.
This was discovered through testing on a Razer Blade 14 2017, where ASPM
was enabled by default for the pci device.

Move the code added in the previous commit to rtl_pci_init_aspm() to
allow the adding of a call to rtl_pci_disable_aspm(hw) prior to disabling
ppsc->pci_support. This makes sure ASPM is disabled before disabling
driver control of ASPM to block it from being enabled later.

Fixes: 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 73018a0498b4..4ef1faf649e9 100644
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
@@ -330,10 +321,24 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 
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
+		rtl_pci_disable_aspm(hw);
+		ppsc->support_aspm = false;
+	}
+
 	if (ppsc->reg_rfps_level & RT_RF_PS_LEVEL_ALWAYS_ASPM) {
 		/*Always enable ASPM & Clock Req. */
 		rtl_pci_enable_aspm(hw);
-- 
2.54.0


