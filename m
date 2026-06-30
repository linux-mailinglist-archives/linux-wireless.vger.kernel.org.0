Return-Path: <linux-wireless+bounces-38390-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9c+PDebPQ2oSjAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38390-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:17:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F86E5505
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H090Aedv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38390-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38390-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 870DB30533A9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031E425CD0;
	Tue, 30 Jun 2026 14:16:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823B419314
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:16:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828976; cv=none; b=DJgYG7CJn2nDBN4G7gWKWArqPwfcfFnAkdsiF5VGfHwzzp0OvRlh1nSJDHOaRksi6N1QZZipET6b+8nTtdj7/9k6P0Wqdikl6fo0RU33ESst7/hVCU9KgLECMH3X+sbpFiSLYPjWEwO16Qdv3IJIUSJPxsAfsIH7CSGM1G5CXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828976; c=relaxed/simple;
	bh=hecuA/M4wyHtxy2jfoYNxWdWdqE6q2SRRxQRDlq9Mlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMxBLO20t7U17ORTyG0ZQMhJecclu/LWbqGVrlnWyNbugsq5ORWonDLgU3SCt/7+Vl2PeW5M97B9EFQFw9Xl/sRonHSxAjbEId9wQo6a9Koa+lIt5WuyQFwlTYhCikV9uP00CBCyb44nS+CpJRQV4c76yGeuMu7/KQMP3IsMpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H090Aedv; arc=none smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c125fbfbae0so284882866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828973; x=1783433773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Hvl1tVUpvwT3K0Y2brCZLwhdqznUZBwd64pb6xOUcw=;
        b=H090Aedvvisih6ZPl7n8ymMmGbhypOKnHlRfVwyMrYxA9xpEnqhetox7QorjRmonLh
         elnsvWs85qI1k0aiHxgaIn0cZzmcAMQjQwcjR4+32Zx8Ri4F0pig6VQDcfOiYcgG2m+q
         6OqFcZwH4fHTwXmAQp7hjtAjxKxWg/sqNpYIB7nRphWrZ7owpqKMm34VAcHcXsA91lAz
         J+rvOSCuj8kVChuPYs8r5ClU95gLSp+JKSFBiLGS7MvX/Oo61hl9gCSIFRShfzVmmf4p
         09XQdgwxS0wWIbOWKR28kMmNg31UBKqLcklEtHuq/evAxQ0Yjvtj23OJWHsd2QFxZA08
         SnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828973; x=1783433773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Hvl1tVUpvwT3K0Y2brCZLwhdqznUZBwd64pb6xOUcw=;
        b=s3oCliwp1+spOtHJl+IgoKjArQ7VwDpGso9i6hHxYP4ulmae6uk/R5xmLusWHBer54
         IYAjTlu9Hk/m9jYJp9lk5mhk3c7x+B7ne0aO6/8r4AHuWIvBTiU527kBBLkPh3TgAKBm
         gkBZhYiV0P8bqebw1jDRXIdox4FQGgPHX28virSrnw+Ij1Qu0e/sPhNpgG033pXQjstp
         Ljun9Ljcc+OFXMwLoBAmcOWN8eUykFadIwIbx6TThYxBPUY7HzVdNr5sX+djuGuw/3/C
         4Vt+US7r9QKH9ypiUjVqIYWxjTNeG6oR/Iw6PqL3Vs5em6wcsKpqiqDsK9VidVHATnYx
         zePA==
X-Gm-Message-State: AOJu0YyLNh1jd5rm996eZ3M7Y5mG4tslhM+2XP3MsLW0WicR4UI9To7E
	0B++9+G0PzrFLX/59IsvQoWpymJnO/RSpl2sRgzqnVucQ+0MlwGVy+pbeRYAuYNWwHk=
X-Gm-Gg: AfdE7ckdP53gxlJb6hASBSQgjT0asu67/tIiFtwgutw6pgUacHLhdNiSXw4uma2HNnd
	23TIIM3qTN5/aT7KDA4vlRYfohf9ApK2S3AQQs0g3SQnJk8pbqW/FrvRXFeEjMeL+ugoX/ZrYNN
	MTwZV/GDPdjkb1+M0QP+9BzfHqHBZ7xnDLeSVaHMhHoGunba82SzUAQ/pPLwsqzvnI1r65VDXIM
	x6QmN7maqSdVX5pw4uEP/cM0JIXUZPBmxF9g+mEDNTGferLIHkjNQyEDBdj9GLkZtcaDT8ytJjh
	k5k9hNS/Z8r7KvcQ20FJIVkH7p7jFB17aIF9//dd1nBnLic2iE7aE9aAA8uc0gAnZXPA1iaBM+G
	07UYEtew4Lle2S1Qz3GyASimqOVaW7SnqB4IeLRwiyYGCF0H+MZ4yrtVcoz30jICRixQRrgKCve
	NrMVojksSa9bFKd89MIuna3Qm5tsXrQB8Z4Q==
X-Received: by 2002:a17:906:3ad2:b0:c12:48dc:43c9 with SMTP id a640c23a62f3a-c12871929e8mr136814766b.23.1782828971229;
        Tue, 30 Jun 2026 07:16:11 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12891741e8sm134974266b.55.2026.06.30.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:16:10 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v4 2/3] wifi: rtlwifi: convert pci if-statement to ID table
Date: Tue, 30 Jun 2026 16:15:52 +0200
Message-ID: <20260630141553.785769-3-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38390-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE7F86E5505

Refactor the ASUSTek quirk logic from an if-statement to a standard
rtl_aspm_quirks pci_device_id table. This allows future devices with
the same quirk to be added more easily while avoiding a large if-chain.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index f706575f92ce..9a9c895b0bef 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -31,6 +31,12 @@ static const u8 ac_to_hwq[] = {
 	BK_QUEUE
 };
 
+static const struct pci_device_id rtl_aspm_quirks[] = {
+	/* ASUSTek F441U/X555UQ */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	{}
+};
+
 static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
@@ -330,19 +336,15 @@ static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	_rtl_pci_update_default_setting(hw);
 
 	/*
-	 * RTL8723BE found on some ASUSTek laptops, such as F441U and
-	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	 * Certain pci devices are known to output large
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


