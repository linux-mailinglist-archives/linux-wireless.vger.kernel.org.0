Return-Path: <linux-wireless+bounces-38158-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zPAQL4FNPmoRDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38158-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:59:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259506CBE2B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MvnF6QbO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38158-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38158-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA4630C78F9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E143EAC71;
	Fri, 26 Jun 2026 09:57:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362953EB0FB
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 09:57:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467826; cv=none; b=U67/whwMp5zQCnzeQy7Sr2ooBIUe6Nnq+iwpnFITKdTx9gitkLA/vih35CdQ+ndpZQ7T3YcBstcmLSY46ha6s+s8TQ7ztdDnfuvTx1Jez0/HqxuQHVl9ihDg8SDQfCxf1A9UiKJ9GxxGiz1g52/C64o99X+jU76zLfShE0n+GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467826; c=relaxed/simple;
	bh=zepRcPhgTUOLQNEJOkeBPOZR/WJlUAxAtysGwOAHljk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5t5peXMNoI0KisfbQZm/02t61QjwBwEhroedg/F7+0Ne3WssQoR5VsCnNrGV594YVj3mwDILncyOBzDWjin+bmOCPr6Da4vixZO6U5MbMKwG0zAfefdKfa9mlBM2P1k9qBsQE6Q/5jG9w1AYNabTpYTM7l/prr0lbj+vWOj6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvnF6QbO; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697edb1bf6eso1111684a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782467823; x=1783072623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2lPa+Apa+qlyNhAmUOrN3iYqKzl046XVoB47HCRS+E=;
        b=MvnF6QbODTLuSkgRfVtoww0/+/0blDl5DWaKKH7q1UcOOhczzpj9MVHxAJoXKpRWZh
         cv458A4JnVHeIThMs50V3jkDKsU+CRsJJIxZ3acn2tV4GedWd2DJ7Bmq4wOKZl0fM8rZ
         ZRcAsg8Rlsa5AXQmrLgpBfwM2Gyd6zLRIrLyg1HZhgYW02++JbS4Qwf/PZYrt49A4SHk
         5Ad48Tj8eRZdNtXcl/7s4zKq1br6jxYxprQErm/tQsogmWtyV+7TaSkBGQtI+B6nOAtN
         87603N64ZL248HMR3ptvui9FBlSmmQPr5pYkfBywRzWI9g1rzNDmtkOwXhByKz8CINXt
         HDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467823; x=1783072623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2lPa+Apa+qlyNhAmUOrN3iYqKzl046XVoB47HCRS+E=;
        b=eNJ9HrOiOmJmVNIBR3vyro8VT4TWWmqBsItPAxPpH7/4/VeGSL/WM2rUB382Q3oByh
         4B9IxTcZXbes/REAvxmhwpEmskr/UygsEOAP07kV/ZB3G+vuOH+T15aIrvTM7PfXUaag
         LwQ6XLFXipQZDo03FHriob5Chlp+BKZ0RISIRwKudNCuFv+alwPxNENbq+pMu3Ps+6bf
         uSMCFn7Dn6xHIsfpgwo7YXaK6t/JgQ1OHdH9d5I5227QybIGVXzDnevQu/9ASdGJadGy
         10icsc38XrevpUct3ekplK0urlH7/gb50GDgcNXzBC5o/wExiDR6s6LGYQ/eMZTp5ViP
         ruRQ==
X-Gm-Message-State: AOJu0Yw5XguiWmclDW7xqFOcidFm3hwdYBsH8GYmspYmNy5slWwI8oes
	/EUVoKzDG3CGhl3QpdRj5Zay+Cr8lC6N0BfeftA9U2//JJft+pF6dgz2
X-Gm-Gg: AfdE7ckMYk7Jbs0HBhMdXpVaiz/Iw6Wn9OOXFkJ3s1P+cRnWdqBGBeCjwWhCkNxno/E
	G4UblcPUnkYKUplLR1L+9nN4Jb2k2g+/MnPXUhr9ubZBUS6a8aBvmon0oWAbJIPQsWYkQGRzMCS
	/EDxhlyjWkdEEYxMokeMAmZKKmv/btrQRoYrKcYkaGlrgR24HO0QjhuDTTeW3GUESV2Bp2Zu6SO
	1rESN0aGE7H9nJRiduYKXIbNDWHgIlHJUJB3jPev9OWyqLpEbbjEAA9GMRSG8/n+ZGr3EHyKQkv
	e+TFoFGmzlcZ13FU7zVDfzHkKsm21aE5f9Y49DYNr80wq3MVHiUx/TxcJfOSisnt64LN/9hksoV
	3V9Ki7eOW9emNBt0nQcK5wT5N3oYgHD1Sv7Ev6s/YotRo8hXX+YYszUijx4WlheO153k9zHwuQ2
	Nk10VeiH4/NshR/Z5sZcpKpHA=
X-Received: by 2002:a17:906:fd83:b0:c12:30dd:de2 with SMTP id a640c23a62f3a-c1230dd138bmr30240466b.16.1782467823278;
        Fri, 26 Jun 2026 02:57:03 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba677csm313022566b.11.2026.06.26.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:57:02 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v3 3/3] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736
Date: Fri, 26 Jun 2026 11:56:48 +0200
Message-ID: <20260626095648.1124924-4-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38158-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 259506CBE2B

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
index 44121203671c..b5611c5a2cd5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -34,6 +34,8 @@ static const u8 ac_to_hwq[] = {
 static const struct pci_device_id rtl_aspm_quirks[] = {
 	/* ASUSTek F441U/X555UQ */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x11ad, 0x1723) },
+	/* Razer Blade 14 2017 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REALTEK, 0xb723, 0x17aa, 0xb736) },
 	{ }
 };
 
-- 
2.54.0


