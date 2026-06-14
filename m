Return-Path: <linux-wireless+bounces-37789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UobgHwGzLmr01wQAu9opvQ
	(envelope-from <linux-wireless+bounces-37789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:56:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E27FE6813BF
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:56:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="S9VW/z+7";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37789-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37789-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AF4F3012CB4
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1133C4169;
	Sun, 14 Jun 2026 13:55:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691873C4167
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 13:55:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445337; cv=none; b=uSPQQaqQLXckdUNInRhhzSyhXpUkXSVUglmqcHi65F2UxSEs6nL5c1LbtTlld3eIyRJuxDl1IwAHgesLar2AzbKoykoe7vrQhLrCoy2Hy+Ru8r/WDa+4SaVoE/W5mBWQ6uSAkaxeZ1eXL3NMVbe7nRGaTSwRy4HA5wB747Ru4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445337; c=relaxed/simple;
	bh=Xa98AKiKcVUO/aqfcL3TAwjRjOxsvH9hzGWzpq0oexE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv33zS6Ybr09IwASUrIFnu+C13lC3qoFG+ALd3fbToHnCN+8rMbUG9v0fQ68KtcmdwT3K2NGPq3+l16aptIeaywoAfBeNktSEZM+HxfDau4jiWo66wmfKHXJ9D2ROwR8MUcHvtkbrJs3vzfCYw/Z6naeyN7GIyAFFJdrf4g9Ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9VW/z+7; arc=none smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so4220962a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781445335; x=1782050135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBAMZyQvR64d5NhC4Qon5z7w1J8o4+UrVvHoYzfF/pc=;
        b=S9VW/z+7NCZ8TJ0OdB3P9Qf/cn1uTl63dFOjJMZUnhPacCfw8QBKYPkToYhPVk3pws
         y5fX+XmL2jAueoZOK0gEuPrpQw/0Fy/F3vLiVGbGCw0aITiQjxmgTqNDwGJx3gEQEMDN
         SbSHRruxEjpbKfzYdh7fPDHjBzt5hYEKruRmXlTFgVcZ6iEh+YYKFZqncyTukc4U1fLr
         Kcg3sLa38o+B+QYJhs3S/lv0JJbnPngQvRJZZALSj+8YJTpPOFQK/V8icHst+PrgLFhL
         lcrCQ38A69B7WWY3R4AW2WpNbcluRFTLB7PgoYQ2chomMjZECR9SaGk46DpUk5ouCR5o
         ZZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445335; x=1782050135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBAMZyQvR64d5NhC4Qon5z7w1J8o4+UrVvHoYzfF/pc=;
        b=ZGuy2KZfYuxJRrNbIL38L5+OXxdsX9s9u5jm2eswXevWW+Dqv52P8wPr9dRCLlL7GB
         7ow3ktxGLEnz8y7ejBXRBAUhQX2qzeU2MDXmUfv4WlbyxDgIM5WtHj8Frw+LQ9WG6Ax1
         dRc731OmtY8Z3PgzpG7buVuEWFhztvFkA1yLAKOEv9/Qd/129HXqUJAMRoB+mNjmBY3x
         3wYTvTympPOdmtDoCmDqb1ysKpMc6BWBoACzetRu+rtHuNIY8Z2ubF/JTh9FHr0JKO9d
         iYMLfxe7yUDKgE9WDj4Okl9er0WqwtiKWBYKl+ClGNsxlLnBzGo3IiUzW8R5EzK7n+er
         QxuA==
X-Gm-Message-State: AOJu0Yw0i2vAMF3w9cGCH46FHXNrmsbJeZubriHZDvYxmpEXzR/7nLSu
	lxedc1Q2Qg0gCOtqd/3Ur4bHcvd6Juh92BPf13xH4s8Qs1MJL7AqTdpEi0HCjKSVrJ8=
X-Gm-Gg: Acq92OEeBJUixToQfpUg3LpMh1xpV5/yqEfdGFe5FUTiVh/En2WT28hzlw/qfRyYStb
	kSKFOtBt1+Pddxak8DBU0dbhjOulWywT1SUFn+ucdqaDQtJze4RL8/YtdcQ/7jEHMCYhQfCqmJg
	VJih0D/86kGvIwu/jagNKYzHoGP6eKAwiir5ai87oemmvYmjiJ0g67l9IKyk3BxIszwBhqM6XjP
	OyKQBXUMwGUymlkrjfBpOMNKXe33w3DdylCU9ZrVFEKZjEdYippSnXl5xGmwqAL3u2utD6Nv4Bw
	FRbBnfVKAm2cn0O+mt+r2Yxb0z4YKFtVNrRAABrKl3oqJYmQJfAGqS9QAVXKIYSOMJzErY6DhRI
	XabMp5lqEBKjeYByVa1F48Jj1WazobGYKm2dk7PJ8KYkOYzRBe9Sh7y1r7Xsw2V3ow1NifQVzgA
	P6+x3CLno3KrU3c2reUfaft1PAxPyhukYy
X-Received: by 2002:a17:906:7312:b0:bed:38b8:9b59 with SMTP id a640c23a62f3a-bff4a10ae54mr305059166b.9.1781445334528;
        Sun, 14 Jun 2026 06:55:34 -0700 (PDT)
Received: from localhost ([37.185.178.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b22b21sm325119266b.16.2026.06.14.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:55:32 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next 2/3] wifi: rtlwifi: convert pci ID if-statement to table
Date: Sun, 14 Jun 2026 15:55:07 +0200
Message-ID: <20260614135508.70307-3-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37789-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E27FE6813BF

Refactor the ASUSTek quirk logic from an if-statement to a standard
pci_device_id table. This allows future devices with the same quirk
to be added more easily and avoiding a large if-chain.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 4ef1faf649e9..03b743809258 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -31,6 +31,11 @@ static const u8 ac_to_hwq[] = {
 	BK_QUEUE
 };
 
+static const struct pci_device_id rtl8723be_aspm_quirks[] = {
+	{ PCI_DEVICE_SUB(PCI_ANY_ID, PCI_ANY_ID, 0x11ad, 0x1723) },
+	{ 0 }
+};
+
 static u8 _rtl_mac_to_hwqueue(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
@@ -327,14 +332,12 @@ static void rtl_pci_init_aspm(struct ieee80211_hw *hw)
 
 	_rtl_pci_update_default_setting(hw);
 
-	/* RTL8723BE found on some ASUSTek laptops, such as F441U and
-	 * X555UQ with subsystem ID 11ad:1723 are known to output large
+	/* RTL8723BE with certain subsytem IDs are known to output large
 	 * amounts of PCIe AER errors during and after boot up, causing
 	 * heavy lags, poor network throughput, and occasional lock-ups.
 	 */
 	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8723BE &&
-	    (rtlpci->pdev->subsystem_vendor == 0x11ad &&
-	     rtlpci->pdev->subsystem_device == 0x1723)) {
+		pci_match_id(rtl8723be_aspm_quirks, rtlpci->pdev)) {
 		rtl_pci_disable_aspm(hw);
 		ppsc->support_aspm = false;
 	}
-- 
2.54.0


