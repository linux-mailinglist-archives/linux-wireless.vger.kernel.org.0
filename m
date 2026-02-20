Return-Path: <linux-wireless+bounces-32046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNLfB9PGl2lg8QIAu9opvQ
	(envelope-from <linux-wireless+bounces-32046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 03:28:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F5164424
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 03:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E28C301F993
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61E29D294;
	Fri, 20 Feb 2026 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmdTEN0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288B1CAA65
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554480; cv=none; b=cm9velFgitEnlvzJBBZGb6RMnaA6As1emmmbOZrHKxxBVszeg9ZwwBDuRlx1NUMGvjNyM6j5lo+LekHleV/G3fA8FZNcXwTaQyAsTQJBL2XOGY0/zqqd01qZtHAnsAWb3GssfyxR6WdJ2n0mTz0JrSvOx40iNhAPsXvuhrYtrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554480; c=relaxed/simple;
	bh=z0S+zYxCh5ZAGTpi8o0OuRy1X+bKoH18PQz5rt7kZjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhFoXl8TFXTSAHuAQ+iSa8+SJlKSNte7K5uIdSeM3SbNAzWEYV14ZM1T3b3f6qGsQ1NtjCr02AquTx8RqnuhCdWIg864uRpBVyYgsDLUNvAQVqgZg4+3ttuoCJTvEJIG1X13MmQkuGN1P0+XRRQpwzC73doV3ATRTIT6pqY0q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmdTEN0g; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79801df3e42so23224367b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 18:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771554477; x=1772159277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaxTrnZCeT1cAUjaI26ZzZAsxZfpYi5XVIt7dxhlksQ=;
        b=UmdTEN0gVMGlGTzmjThI2S/5+jg/mZ/da6HWz6R9YKYI2DqeGy7N8+W+cuEmpFMtDn
         EYTeV4OYBswKtk6Seu/h4PbNB0F52tyq/Xe0j2aEQXmFbvvOR9mAULUYiuTrZO3WR6b7
         KJyaUicmMfjlEiOX2RnpnqGIoqfajrY6L5UzMlR9qTQ04hNlRyUilEkm7yRxm/eHqjMB
         St65vg8tetiXdh7MXYTZoB1UQHILmmBrVJVOrfSs3ukECM2mvW2x+Ic3ClMXGbA1DPze
         XAwr5tu6RUoiSzjtTOVu2yrJvSu7qukDNzmqsYmtJbdoF/98Wwbnonk0Vuriugn1OgBd
         UsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554477; x=1772159277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaxTrnZCeT1cAUjaI26ZzZAsxZfpYi5XVIt7dxhlksQ=;
        b=MvlU8VVbEWibZ1ujOPjqpvtoIZFP+wkye443E8xmUbZ2voUXU2KGF22Xg6i7UCaL1x
         +2bYFR0kGz3Yqz2drOimjRiHd8RuywJ2GJDwGhmc1alCgjkK4/qpqQ9gE9zdelGdQ3Wq
         BQBbr1MwQA7kafywg+Tmi2giIFY9YGmE3BuQMQ3LtagWjw/LhfdMmKBLpLcR+i9LhqLN
         kFmOi3SpSL+KTaJ+M4O6LxHK31TNYY5PicooTIdVcUoC7jSRHmOfxz7H6qjdRRHPY5N3
         mfbImpY9mhutvZUpNBQrDUq4ajvSd9vPTyZSDDS+t39S79+mfDNdMfla9RQhIcRVVur/
         xzKg==
X-Gm-Message-State: AOJu0Yzhn+3dbzJBrfxTgwHJDWxNX6py1TyhC1rzb9NZm+7kX/8jEMK1
	xiw2j85VkjKA8gEM8LNQ9qc3ASDKGmL9RNM/ebEYAqMbx+WG/pKx68kZ7uQrwqcEp8E=
X-Gm-Gg: AZuq6aKo6dACYLxleUrC9n/oPvXw/dRp0OfiMBaE3DH0UKKi0NZ/BKPdqF+0cFMUoT2
	UXeSNGVORNpBWikONc5V9iT03rorzddT+kBJGIH1UdczrWfEqGd0DfDaGO2xllpfmvj1doIozjv
	shMobfScAwTUEHf5kgNEImHSVB80DV8ekUv6QPX10i+B7gnV6e9t+tJ54EBvalmZNmkIcDoTyzq
	Dm3E0CmrYJRkGUAPjYZYeiY4CaQr+PEdzVEcVv2yc41Lq4uqO7k97Zl2VITzf101okeYv0FGtJl
	0WqIpmDVaw3duokLfxIm1BS5YL9bCfuvD2doBNebn4d+Jztbvr/dBTlMghPFg34but2j3Hhy+uo
	0o7owuZNx7BW/H3ZUpY6zm9YaN9FyV7918+0d5vA5Qa9byxNRf3MsO8YCLFHxgDJLc2VC
X-Received: by 2002:a05:690c:f09:b0:794:c283:5fb8 with SMTP id 00721157ae682-79807d19561mr29435477b3.25.1771554477482;
        Thu, 19 Feb 2026 18:27:57 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm137116877b3.45.2026.02.19.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:27:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: brcmfmac: of: defer probe for MAC address
Date: Thu, 19 Feb 2026 18:27:39 -0800
Message-ID: <20260220022739.41755-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-32046-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 749F5164424
X-Rspamd-Action: no action

of_get_mac_address can return EPROBE_DEFER if the specific nvmem driver
has not been loaded yet.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 1681ad00f82e..03efae36a0b2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -128,7 +128,9 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);

-	of_get_mac_address(np, settings->mac);
+	err = of_get_mac_address(np, settings->mac);
+	if (err == -EPROBE_DEFER)
+		return err;

 	if (bus_type != BRCMF_BUSTYPE_SDIO)
 		return 0;
--
2.53.0


