Return-Path: <linux-wireless+bounces-37839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0179NPBcMWphiAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:25:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB03690740
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 16:25:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G0L6QKC0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37839-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37839-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A6513356704
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F0379C4A;
	Tue, 16 Jun 2026 14:16:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AA421F17
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 14:16:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619416; cv=none; b=GAKFzOJItPUd1ue7FTyGTqkNaWchXLBbFEribOc92s5Bcm55lzireXds3k3Wkm/jsQfGYmkUWRY4soSP2G2wGe1IGXTxTZZrPEGiba7Zw1EymMe6pRp4Hgzwi8qo9NfW5clinZWJ/qQMjBWuIWCxPEXZf4PyANeyGpTGBppwC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619416; c=relaxed/simple;
	bh=HMuqQZtEAPpuECh0YIsn3D1n+CdV9Wt9yoJX4xoWZ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4eFSiKTo51fMRwQBZNRlVtb5yLhMV4zVzhUQRzk4LqFZQbAcRW4izleRlk/Rk25uQyRcaF//6kOfCCwAWmafxbgBth8pMrorH/3S9fEkuxr5AQXTuf34dLTXjAEjgJ6DHjUte4KWIqCRbLcPsnmvpEmGGXiInsTdhslkyZMq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0L6QKC0; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so7803905a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781619413; x=1782224213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJgY6JYNixqVvD+kx1N9JDoSc3UDp9PKwiXsL7zqozM=;
        b=G0L6QKC0pwNt55HQqBJHsnm7zNahGijAC0zF+BlvIaF77Ix1g32SmzWrkL79xsbcaX
         2rg2xtVVQEapqCMS87cUtUhnCzAGhfJSsqCNaICy84m4Q2ck8y0mMvKNmFbQ3lmK3Csx
         oF7RXfSb8AxcvfepNbqde87iT/wdoFT4DgZBeuJGXTUrHmEJMxSsuGrhPblvTYxNvD6q
         l6OppKlHLxgQULWCaLzHyRUY+hrsrg4N8PNoAaT5lO+jCND28jISMZdGxOX/vvjAVtRh
         FJeKTBi65kxWejd6NPCMX8xEKLqZk4Q98ANl4ZsMNef+BgmV8v0Fu3Bic3eaOTtpbs6m
         UK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619413; x=1782224213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJgY6JYNixqVvD+kx1N9JDoSc3UDp9PKwiXsL7zqozM=;
        b=Omnr7BCcztcTrRvOoKhgUh17g896Z0JEHfGqLAHmxuHWNcSdwcsa1k0x33/nHAGpd0
         PIVfNpHLQc7WtDRSmyxOR57IN/bk+TqsO+MF6j9Snzu4iSPB0SShEOjctW8pCDzn7DL3
         AS/tnjbBTDz+khw0evbi4RjecC056l2YfYSz5+IrM9RwF3xnxeSMM06tawqDhr12VFQx
         aBbjb7rHMuPrWXFpf8jDLZa+MyHsUl4D9E47iIxSoEDEIKTEFRSLss2eAt/hshU+FWxj
         xLDFOi0QAuhRc9zS0lQL4bKd0QCViUX3zknu99NFBQB+m2iyjvI+qmRdKXzzSIS1opw2
         DZsg==
X-Gm-Message-State: AOJu0YyNvCaEQNvkMyXXbxx67jm6/CP+6HuRol/pvfoW6m2QIvF8+OLg
	FKt6fwFKxsGm+92XtFV/htS2hbFb9u7VmzJBkyVWSfPHjxt5k5sIRw6O
X-Gm-Gg: Acq92OEKB0aVRf86rUuqclT4pRXFMbSY1I40ngFKURdnVxNSSw3v5dRNPatdaBTWekn
	xYTn7vxnmICXJoyysqx8N8SqubmWg9T3zeZfPAxER4I6f/WbTbGncClI5UbCQmawRGjQhW9QAPa
	hLHtf6Qfw7EU4T0HNCo9b2TOJnNje3xYX6J3TR5teHE0S7tcJ/tWVtT6ZIKYlI4HjDlCdFIQZqh
	5ZlT9DdS6QDQabaSDL73tM8Z57+sgTryOeGbQnWS59+xhWUAjewo3O1m7zg+o2gKBp7zcuKhPC+
	YxQ1BZsXWPzm+Ya8OlZdMhrtdzl2mYe3pQ6a7jPg3yEUDqdlI/aoFiFmES7XJqdvxsbwQ7TMmjf
	ax8d+F/YubxOMdqfLsREHmux8Xl9H0sNrfECF/QKaJb3JnEsTyTyAcrCzEtt+qrOF7GZxMDFkR7
	7J5rNK+U3eWEKM6XXmJfMa+fpQfIVaiHkFXw==
X-Received: by 2002:a05:6402:4498:b0:68c:bf82:884c with SMTP id 4fb4d7f45d1cf-695086dce09mr2261369a12.6.1781619413514;
        Tue, 16 Jun 2026 07:16:53 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949bc4esm5331722a12.25.2026.06.16.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:16:53 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v2 2/3] wifi: rtlwifi: convert pci if-statement to ID table
Date: Tue, 16 Jun 2026 16:16:19 +0200
Message-ID: <20260616141620.91081-3-william.hansen.baird@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37839-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3BB03690740

Refactor the ASUSTek quirk logic from an if-statement to a standard
rtl_aspm_quirks pci_device_id table. This allows future devices with
the same quirk to be added more easily while avoiding a large if-chain.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index a5bab06f2b61..9de396879806 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -31,6 +31,11 @@ static const u8 ac_to_hwq[] = {
 	BK_QUEUE
 };
 
+static const struct pci_device_id rtl_aspm_quirks[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	{ 0 }
+};
+
 static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
@@ -328,21 +333,17 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 
 static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 {
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
 	_rtl_pci_update_default_setting(hw);
 
-	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
-	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	/* Certain pci devices are known to output large
 	 * amounts of PCIe AER errors during and after boot up, causing
 	 * heavy lags, poor network throughput, and occasional lock-ups.
 	 */
-	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
-	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
-	     rtlpci->pdev->subsystem_device == 0x1723)) {
+	if (pci_match_id(rtl_aspm_quirks, rtlpci->pdev)) {
 		__rtl_pci_disable_aspm(hw);
 		ppsc->support_aspm = false;
 	}
 
-- 
2.54.0


