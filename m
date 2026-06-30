Return-Path: <linux-wireless+bounces-38388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nSy4EMfQQ2q7jAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:20:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C393D6E55BE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZwRNqyW8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38388-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38388-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C05A307D2CD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6F419303;
	Tue, 30 Jun 2026 14:16:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C122F767
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828965; cv=none; b=bPZEVTEiS3++2CrCABLZRHBohI+AwPuBPcsKXRLcE6n3WSWoIAsR7tz+4Wmcv/rSUHrdnaSsKfN9ACN67/QhwyFqaPjrhHW5NuDPax5g485UJyenz4UadryXc8wxtc/N/lLAvk2RcH/9tEwOQTPI2ornHiD5WO7psE60ljdWhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828965; c=relaxed/simple;
	bh=bjjxLmnNczNi9y0WayD8+RHxMKphOpgbqoVI0yL+cDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwBVlr8WL8OXiOVWGN+qGaX2pVKSb3Vp33pIAXqSZgEdIefN+mUTwozh8Z9Bc7Ni4038L3IPanJUxX+WVrWyUoTbIifWGTLP3HbXUHEZmf7eAU59K23r6WkzkcQWQ67w86wtFrczkc/hEV+gHJ8O+9AB9ldaMOoBtVYERa5CDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwRNqyW8; arc=none smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso8429117a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828962; x=1783433762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJz/P7F4VrtppNA0pc8U+o83RenT1oxuN9baOnApCBk=;
        b=ZwRNqyW8xPMhA5u7CsXa1GWqIh2TyeED9vmHMap38e0zI12zRGUbKt76qTmCWMv3yk
         Xwbm/rNL5kZGzL1f3Cnz0JOMPmLV/w18OtVQs0ucSkmLK8e/HYqpBuRczh53+OYDMwF1
         x70DJ5FAUz3PgQvnbqX7jfhvSu4zgqh8ZZMW+cn9XwrVguUR8l1Q8D6paP0BD3otBoyg
         3WNlZA674PWvLeRja1DIqX1+MPKHecpAkhNlcOaBB3Lw/5uS/Ko931dtsPuJPllwF6Tu
         NCp+LbYgg1WZIBXpaqM/JiKU8W9FHOxS9/Y07+N+id1JjE1I+Djhp4N/XWUXI29k2xks
         wpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828962; x=1783433762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJz/P7F4VrtppNA0pc8U+o83RenT1oxuN9baOnApCBk=;
        b=HKsT73QHYj0VqAD7KZweX1BbKx5EFundXL/PQc3lRQVmVwfv8dSzS1hktKppR6mjTM
         D+hrHzgaGO9pOasF2xaYCfTk3g2x1e4hhFbh1nIvO2dReTIBY8oq6rh5SQBvI9aK+XA3
         80JmdE/A0bULqOMbbxrXMmi7ZmXU+JaUkO1lq6ru53IK7cLNrqEYF0nUf+Vty8cg4O6B
         1ZrHP14RRnQBTGTNHw0YG/xdti/Ow5hL043h98vUx9y+Ciz0cERNcXRSGvVgmF3hxHyR
         S5G+UY3lM/KB78SRm62Nm8HALWyHVTwbH5LZ+7kTHGVZIkHgeb9TimK938hVykb2NBy4
         PO4w==
X-Gm-Message-State: AOJu0Yxx4PifDQzbhBsuXbkdD8OGvxzy5KooUMpvYP2DU1UtcHxy7Yck
	CH4C1YJfyhn5uKRh0TWW+HRqh9qG9qGjvqJTnH9Rk3Tpy+SYklHhrNlF
X-Gm-Gg: AfdE7cmXja1wyOuRdk0i5H3nVioo+JEGaKu3NawFXqMI0WRJSESjdz8RPnaGWGJBazq
	MmLawLA75QmZNB7BFhdgDN+Vc09DERfKvLvI3VnS6K/azAjRPYE11uTtTK6ujoWV+KXEOUVIkru
	L0ZxH6QeJ5eaWLoFh8JBz4vLbUkJa7oBj9F7Le6Uan18xkmTGiT/7rtRSU5zMVQ3psUsQE1485R
	DC43nqzmanzSYuuBfyAHxj9xnYo1+7NEJOF8Hbsw2m31l0SZIEgydSsEq6GIzl7KY2JUbZuWLn8
	73stDi2u4C38M47/kpmphYtWq9rpwVMV7Zmb7kJVlGsOtDaSLnNIhnEUs0fvyelI3K3n2oAR6sg
	UfF+br808n/OYpHJLFGXDGPB7ciXQ4RTzabVyCF6CyYIdIz3e4oVbzRYUOw65cp5UFaLEJBLvHB
	/lL0sxZ4EwUu1c//5qNLWDzMo=
X-Received: by 2002:a05:6402:3590:b0:697:6417:ce7 with SMTP id 4fb4d7f45d1cf-69879decd3dmr1996479a12.11.1782828961524;
        Tue, 30 Jun 2026 07:16:01 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c98921asm1279531a12.31.2026.06.30.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:16:00 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v4 0/3] wifi: rtlwifi: fix ASPM AER flooding on RTL8723BE devices
Date: Tue, 30 Jun 2026 16:15:50 +0200
Message-ID: <20260630141553.785769-1-william.hansen.baird@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38388-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[80.208.66.169:received,209.85.208.48:received];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C393D6E55BE

This series fixes AER error message flooding and system slowdown caused by
RTL8723BE with subsystem ID 17aa:b736. The flood is found to be caused
by ASPM, and disabling it stops the AER spam.

This flood of AER error messages for the RTL8723BE is not unique to
subsystem ID 17aa:b736. 
Commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
targets the same issue for subsystem ID 11ad:1723.
The fix applied in that commit, however, does not correctly
disable ASPM. It merely disables driver control of ASPM.

Patch 1 fixes the previous commit such that it properly disables ASPM for
subsystem ID 11ad:1723.

Patch 2 converts the if-statement check of subsystem IDs to a
rtl_aspm_quirks pci_device_id table matched with pci_match_id() 
such that future devices can easily be added if they have the same error.

Patch 3 adds the RTL8723BE with subsystem ID 17aa:b736 to the 
rtl_aspm_quirks table to disable ASPM for it. Testing on a 
Razer Blade 14 2017 showed this stops the AER error message flood and 
wifi works as it should.

---
v4:
- Patch 1: remove trailing whitespace
- Patch 2: remove space from {} in rtl_aspm_quirks table
- Carry forward Acked-by from v3 for Patch 1 and 2

v3:
- Replace { 0 } with { } in rtl_pci_quirks table as recommended by Uwe
  and requested by Ping-Ke
- Added comments to rtl_pci_quirks table describing what machine
  correspond to the pci ids
- Replace net-specific comment style with wireless comment style
- Removed misleading Fixes tag from patch 1.
- Patch 3: carried forward Acked-by from v2

v2:
- Implement __rtl_pci_disable_aspm() in patch 1 which disables ASPM 
  without checking ppsc->support_aspm. 
  This is called both by rtl_pci_disable_aspm(), guarded by the original
  check of ppsc->support_aspm, and the new quirk code.
- Rename rtl8723be_aspm_quirks to rtl_aspm_quirks and fill out system 
  vendor and device ID alongside subsystem vendor and device ID in the
  rtl_aspm_quirks table such that we can use pci_match_id() alone
  without the RTL8723BE check.

William Hansen-Baird (3):
  wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
  wifi: rtlwifi: convert pci if-statement to ID table
  wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736

 drivers/net/wireless/realtek/rtlwifi/pci.c | 43 +++++++++++++++-------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
2.54.0


