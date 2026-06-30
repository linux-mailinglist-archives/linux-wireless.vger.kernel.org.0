Return-Path: <linux-wireless+bounces-38391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BG7tAQvRQ2rojAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:22:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003286E55F7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:22:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=K1XRhGvu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38391-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38391-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FB77304715F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553D426D2F;
	Tue, 30 Jun 2026 14:16:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CF426699
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:16:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828982; cv=none; b=qyT7BWCxj+a+olfLxQhHjsTTS6sOhpGK6jJcmq57Y26yPlDoHxHdxm2MA1Qz+FCcXLp+LbHcaHA0JiUQOKv3QvCt8Se3/suCvR8+UFOMZQguipCLqOSHUZoBdDFei8m+0N0Kdc/2J2fU3QLzC/ZIVvhzTN7ifDxjadFfYIygCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828982; c=relaxed/simple;
	bh=Jwaz5+P5JLELYSiQoBrjlChk/VXwwTGdI4LLbp2RcGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u08PotVCoBg3fX1DhB60ai/5uwFGVcvOVi+5XtU2St+Oa3zLaBiurSNOjxZ3YGVynWxl7DWLDjCtdYSfTW1EEhOIOasFgJeTkDplGkrbSwJR81JkoC02eI1lyh3rPRuYxqiblhaRYzWOXzfCj0JOKFRJZb+PCvac55xKcqBIAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1XRhGvu; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-697df404e32so9569608a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828979; x=1783433779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDnrMt5EbmXvXJEQ9FwkKXed3+1otjrG3rcRHcpz/mI=;
        b=K1XRhGvuO9paqcPOjHfyscXHcT6jj+HecjNlbub7s3VQwP59nOMHzIqx0H+CzQBJiF
         d5fnCT+eaTFW98VwULDQ1yU28BV6wl+y9++ZD/jbaMTjw1hTmTJoY7E38nFDOfRa57n0
         0rsYTEDRiHiWzmR2oil6N8DmW/sWf5POAe5fz0iMUL79E3AD+DjnlQ+qpT83vkxfIrtU
         lNhbNW0O6mTw32PE9H6ncFzNCJFDPtL8Q8/SjDkGsL2qSnoSMcfhnSGieQf1H89byp9n
         I3UVDmceH8Z5inYGTsFC/NWu4luATcy/7ECTHrRDwgbbaUD42qfahusH+78sG3YWsnmJ
         2CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828979; x=1783433779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uDnrMt5EbmXvXJEQ9FwkKXed3+1otjrG3rcRHcpz/mI=;
        b=aVrvXqCxt1u7/tQ7fckNtUvRfPOMMBN9oGGvJT+0I74REjlHlsV8vZqC3tU6WVJUIp
         +qGZOJFpNMrKxGqYCMk/KQJ2eMOpGixngY+X/esURT7acckNPhNowkZuXArjeH0JUiqC
         cNMB1ago6m9wFLgbl9fWmlvyy/uTtIZKXJGdUeRfaR0encysRIZVYRMXI6Ah8GnIWxZY
         WXvq6SCcY9fg9oFxonrxyq8ecVSToqYGxrYW/Kuez7cqarIubbQSAqx05XutD5RunxvS
         ZUACSDiMK6h5H4L06fQZlxAYLjHJUaSUJYd7AQf1OPKXYk6QHEAMKCuOXPkVM++S7OEB
         pHcQ==
X-Gm-Message-State: AOJu0YwB7osdlUoMvf5gOtOfaWrHez2HYqmsahxmaFUKZZjp7xDL5JvE
	WDbGyUnkEya8zKysedpOszJA6MpzUnpbOXDToWNf1zNj2WJk7tpx61fk
X-Gm-Gg: AfdE7ckPlkjyH52pPfz1lzpUZ8mOwcVJtE+r4hjGUeznRl8+hM4eNwYRUJkjVW8HsHZ
	WHhmAUKSprGA644462E1M9qWy5bfyQc6ymbjtMhRZqWadNmNwCasU703TjFc8+XVSJYXiQiLxlc
	uksrImiU+ghVNbEIqBfgPYPb1siw7N2F/z5VnDItK6BobuMiHAMrQuSKkh56X47iq2Vzszi0mYM
	JoCrCYHw1XP5VVD5+cNRog7Uvjjby6ftevSidrRmeD4eqkSYNZr95QJ17GRY0y6pEk+k7ikjr/q
	mHzdiuWZQ3GCTdCw5gJGIdsF1qoDR1KXaeswLp8kyGjC3/UhJIl7apbt54rdZWBKSoie/n2i+Cu
	UGctNNeCr092mh2v2ax/c+60EoXGOgIMylbdz2Ib5tOuggQBTBpquNSlxd7IbTXnZ6s2emXhJ1c
	tTMg7YkW6ppxbfLE/D9O8WE+A=
X-Received: by 2002:a17:907:3d43:b0:bd1:ba38:c724 with SMTP id a640c23a62f3a-c1297ee260amr47680066b.32.1782828978275;
        Tue, 30 Jun 2026 07:16:18 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6a400sm136421566b.20.2026.06.30.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:16:17 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v4 3/3] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736
Date: Tue, 30 Jun 2026 16:15:53 +0200
Message-ID: <20260630141553.785769-4-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38391-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[80.208.66.169:received,209.85.208.44:received,100.90.174.1:received];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 003286E55F7

RTL8723BE outputs a large amount of PCIe AER errors during and
after boot, even before probe and when driver is never loaded.
This causes significant system slowdown.

The errors are the same as reported by
commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")

Add the RTL8723BE with subsystem ID 17aa:b736 to the rtl_aspm_quirks
table to stop the AER errors. AER errors can still be present prior to
pci probe, as the device by default may have ASPM enabled.

Testing on a Razer Blade 14 2017 which shipped from the
OEM equipped with an RTL8723BE card with this subsystem ID
confirms that this patch resolves the AER flood and allows the
wireless card to function normally once the driver takes over.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 9a9c895b0bef..220fb4dc7927 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -34,6 +34,8 @@ static const u8 ac_to_hwq[] = {
 static const struct pci_device_id rtl_aspm_quirks[] = {
 	/* ASUSTek F441U/X555UQ */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	/* Razer Blade 14 2017 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x17aa, 0xb736) },
 	{}
 };
 
-- 
2.54.0


