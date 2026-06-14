Return-Path: <linux-wireless+bounces-37790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPPyHhizLmr21wQAu9opvQ
	(envelope-from <linux-wireless+bounces-37790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:56:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF36813C2
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:56:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SiYLsuME;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37790-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37790-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F29A0300C81D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE23C4176;
	Sun, 14 Jun 2026 13:55:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3923C4175
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 13:55:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445343; cv=none; b=GQMoKtzisvzHoA/7dI3O49gEDYkXDmNak2P3zcS7s57pLmTQnrOlIFljiRSpIJRkwT9cKoAODsencR57qRnvFWbvM3Di7sLAX0/gnZKqK7Vvr2JafDUVZNvrqbJ9O48/X5zYWoEFgRdPQIF/gE67YEjE+3f3VyGMKQlPdTs8U4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445343; c=relaxed/simple;
	bh=9qZLpcO3gJ6MEYjUO7nVo7stZ8m/j90vl3xa31SfUCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUAsRzzPxdPANeGYHb6xzqQ4BntBBllfDgn+CUX2ghbAjhT912Pyc6VsuXniqiDOgZOwT/2dqArdH7cpjkUVDALb3lA52Z0iqAvgasd0/uMtf4TITCpyf5elkC9ih0p0UxoSPZJQrIqlxi4rzY46LhVCoYUbk9VkaSE14TMwa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiYLsuME; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso4866442a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781445341; x=1782050141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsmYdcxOz/Y2mPrBax1nImxLpzzA/YJ0UetvRSf3ydk=;
        b=SiYLsuMEkeBs8I3/7cJxnQlX5UIS0WNjhuDmh1uqZXB3qx3cWTqBjH6PmpWuRTrhCw
         wV767Zsv2Tp9NPQuv5L75iYlmcJ5hWjNkzueDPXCHNOpsaa/bH0PIbluyCYuDnKJKpAm
         VVV2/qYjv7iHSYyBS3XO3eXu8X9L8T/1CaWnpqx70NxipoRr9bJLvXnU58KdSD4Q/ayD
         GVZfKJwrTgQrdmOHavpEmkz363oMBY7fcEZNB3zscicgKFA+V/4lyl0YLzL/HwiszWyY
         9PBdbHeGyqSGpDLnJJCbQymGDto4Ez2nfj2qOlfTZeVoibV/uiV4OYfi81VMmGSgjyM7
         dBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445341; x=1782050141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsmYdcxOz/Y2mPrBax1nImxLpzzA/YJ0UetvRSf3ydk=;
        b=o7G+JycCTHuH0ux98yl7uXec1hlwD9kvIKV/MpwwEt+KgoEDPTkpCfLed5X1LIGJVR
         T5kjuiAemxZLk2Vdu/y8RU0mNETALXyOZfXp33TTIYoVyiOpGBt2JqfIZ3CWpEHQ5faC
         235emWmofuy3mOrE3RHnghH2Iz5PUcj7e31tVhTY7S885xW9MJSRjKnWVTi9Fann5Xrg
         eCqqbzma0jq8bNrFPc3EmHtf5kx108U3UOj8gKiqe74jAYgKamTg/kx7X0wITi9m79hl
         AGHJB9GK7EPjt0uRW7UjOLe2hZg6JgQE5pmE7LJUeCllUbzGZjmnTlrlVidA+7DoegDL
         Wvyg==
X-Gm-Message-State: AOJu0YxMWnByJpqV1MjzppjKzdas4pO8Y+QaW9NgLkecq4Mbhi2hxecP
	glWrZkL58ERZBHQmvy3V1VozdNrfT50ArAY2WeqA08Fgmkfyau2a/gUb
X-Gm-Gg: Acq92OFHtQNe1JZUZxI7CdpvVfaoKP4jbiHNZ+zcE3sD5vp/Sge1cd/1jN4sNSPj6Sb
	7TGw7bw5+gDiXMaC2F5lGQrXWo3vYLCybLal7JT8Sn6FPtdGxPvQcjcs8DGihZ877YPGlo7itc2
	4fP7BBxlzjfrKZZ2RXi/gAdfCl1pXksNzEXqLmbV7eNIHH1oQ1Xlw0LndwaF2t4T/c/lCtP8cVE
	T0ARsUd1N17+Oac2J1Yni9Q5Kpny/WEHRAYNfPmy3ZzB4kqF0xpHgNlNWnJBhPLDVXJeS7FEg5Z
	Un62Y+HRSlSL07P+XBOYzRLnR5hNfZlt0wI1P1PYe+VmGv8XIUlUvDuUJSZYcf0UE18+YN8tbUV
	WEJ6IcSTZUe91l5VJKs5PnXeMhIzuI4/Z1e3HZsCyyEuQGlam7d6FMn59iQirwPblye2SIv0xwV
	loALho2hcb1twls8vObK6F7shbQtHP3PSi
X-Received: by 2002:a05:6402:14d4:b0:688:e4c6:fd1c with SMTP id 4fb4d7f45d1cf-69368bfbbc7mr2917735a12.8.1781445340787;
        Sun, 14 Jun 2026 06:55:40 -0700 (PDT)
Received: from localhost ([37.185.178.0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693c43a6d9csm1574236a12.13.2026.06.14.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:55:39 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next 3/3] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736
Date: Sun, 14 Jun 2026 15:55:08 +0200
Message-ID: <20260614135508.70307-4-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37790-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: DEBF36813C2

RTL8723BE outputs a large amount of PCIe AER errors during and
after boot, even before probe and when driver is never loaded.
This causes significant system slowdown.

The errors are the same as reported by 
commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")

Add the subsystem ID 17aa:b736 to the rtl8723be quirk table to stop
the AER errors. AER errors can still be present prior to pci probe, 
as the device by default may have ASPM enabled.

Testing on a Razer Blade 14 2017 which shipped from the
OEM equipped with an RTL8723BE card with this subsystem ID 
confirms that this patch resolves the AER flood and allows the
wireless card to function normally once the driver takes over.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>

---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 03b743809258..bbcd1922acb2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -33,6 +33,7 @@ static const u8 ac_to_hwq[] = {
 
 static const struct pci_device_id rtl8723be_aspm_quirks[] = {
 	{ PCI_DEVICE_SUB(PCI_ANY_ID, PCI_ANY_ID, 0x11ad, 0x1723) },
+	{ PCI_DEVICE_SUB(PCI_ANY_ID, PCI_ANY_ID, 0x17aa, 0xb736) },
 	{ 0 }
 };
 
-- 
2.54.0


