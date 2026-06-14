Return-Path: <linux-wireless+bounces-37787-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BAyECtGyLmrv1wQAu9opvQ
	(envelope-from <linux-wireless+bounces-37787-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:55:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDC6813A9
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 15:55:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HrkcoHlS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37787-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37787-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9901B300797C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0B3C378F;
	Sun, 14 Jun 2026 13:55:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BEF3C416B
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 13:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445324; cv=none; b=UY5meTS6MPhNbIA+w8zPqTgSHNjJwDaC/x0I4hnzzgmIpT6L6j+Scn9/7fmt9p/ENJ5k013IWaEWWdJbXzHmY4lXvvGiLBmeKii4nuQS1HEd8Vq9ewxOG+L/5Tlpm9ubjwTqwm7PXY3qrL/HUiuGBhXXNhQyIY1XT2CmjK/F0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445324; c=relaxed/simple;
	bh=FOTH5pbLKjMo/q/s3k+tCEF1O8WkvwOAfvZCQa/ce3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1014PhxixoDAOUTmnuAnDDjS0rcl9JoXO1/ti0T0YFyuLmw4dHeJeti8aE/SqBi7VVW7563jxVXSpz8Q+Ohb6FybZWG7Li2hNyXYJehpm+7RvJTQQQ1oAcuHSx7xoetxCrYzt+TBo4IObYfmRGXJpwhyeS+UIG3IilTxE9yYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrkcoHlS; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bed2195323cso360504066b.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2026 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781445322; x=1782050122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OihU9r8K3X5JHSCdMwb8k3zIs2scuLguMW/J6GvYRFQ=;
        b=HrkcoHlSh+0EJqMPgjt/jB1PZPA//G8HN0fhOJ9WCIbcbZ5fdZxZxKgY/K/LKkhk2l
         dJk9Uj4j5aHvu3DVrlQAda0Dq2VRJCC1y55YubMzsnbVFCtWJX4u7A5y8T17O9sjUqWA
         ZV31FzHWIZ1oYu7HNiGdH+pbxURbNe2nsEY4eAeWKmJyH8tXE+EzJWBjpQpXoaiWswBV
         TLYzrwpQ+ljTQiDkiku9F0uj5l36pz90yo4AR9VagwF2sxhk7tzyZZTh2ORq/3Fqwv0H
         uPTlCBVGxJ4BCvwGeNaEdaPw5kSSvDPlEKdXIFQjuI/CL7ia9/N2PfA0KU8sRrZ9aMD7
         pwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445322; x=1782050122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OihU9r8K3X5JHSCdMwb8k3zIs2scuLguMW/J6GvYRFQ=;
        b=EJusBC+xbMAJxtu0M4qe6dNCaU5afV57ee9JbqfXGADEuZAFdPQJz4COp6OYRKjRUX
         gx0KXrBfyxiplYGbz4ikayKrokB9SCOCJPbRtbQWDXMVtFx5VoAMUM4lz2UY7sJoek5z
         i5MkNMFWmM+Pivd1qr5lNLwrKpjqlRlswLwJN1vno8cu++G8503v5v6o+mDZYHP8leKE
         hCO9kJjDTZEnKpurIozVFjeW4/oohWFciXLmzdlMMOKHcJyyrATVw0wqTFYhEQdALMab
         jHfRSyoQ7yU0GKVyj1Rgpqh3JRl3had9aiwVjUYoYMusVo60QC5X0FEkcpkI6DPTI8j+
         aaXg==
X-Gm-Message-State: AOJu0YyD7vw/cWHoG/YnO4ZotGj2O22ieopJLNzNbPWoWw/XJ5rr1sW7
	1aJHPQ/qNJj3oiLqeOJ1Hss4qaTEVfJB6Tsy18PYNLcTOv/pPwPW/m2x
X-Gm-Gg: Acq92OHpScfhZHhO9xIOaiVAIea+WNUqU0Z/vGaod1rhmvJ63+oJb8Hgps3tw4iCpET
	yHPDIthb4SyVaGfl5b+4z6ki2814QJCYLZCvRubAzV1zpvYl0j7nibjxBCDXIdHtxwsLJfKjgss
	bl/lc/N6/+0I9uHGOxHgjEpm0iqQYU9OUuKLoO/Wqc64tZ9WfOKYf9ERXjo5B6x27TDeECOVJVZ
	65B6fK1H4zHR2B4N3xJ6L8JyhSpKpduK1jFkiZvDfHMaqn90K5PL6ZZLW/HLfkFHluuvL7bWBbQ
	/2upq/rABa0mTmjDJ5PkGGHhahg+bis3uLVNysIA3/J3eMVj+M+hzqbHDOriF8WrjneHm6SfUab
	vBCX7Howe0NmG6Qy4wZAtZBOQbOKuwqQIiLFI4D0+Mo5QRX8D28hLiOk7qi3/XN1dRfAOkhguTL
	f0MEHH9EFYTJHEvFApeDSu3pm+v3FZPDb3
X-Received: by 2002:a17:907:d19:b0:bfb:ced2:2f83 with SMTP id a640c23a62f3a-bfe26f34566mr445878866b.17.1781445321508;
        Sun, 14 Jun 2026 06:55:21 -0700 (PDT)
Received: from localhost ([37.185.178.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb522167dsm321105766b.25.2026.06.14.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:55:20 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next 0/3]  wifi: rtlwifi: fix ASPM AER flooding on RTL8723BE devices
Date: Sun, 14 Jun 2026 15:55:05 +0200
Message-ID: <20260614135508.70307-1-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37787-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:william.hansen.baird@gmail.com,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[williamhansenbaird@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89BDC6813A9

This flood of AER error messages for the RTL8723BE is not unique to
subsystem ID 17aa:b736. 
Commit 77a6407c6ab2 ("wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723")
targets the same issue for subsystem ID 11ad:1723.
The fix applied in that commit, however, does not correctly
disable ASPM. It merely disables driver control of ASPM.

Patch 1 fixes the previous commit such that it properly disables ASPM for
subsystem ID 11ad:1723.

Patch 2 converts the if-statement check of subsystem IDs to a
pci_device_id table matched with pci_match_id() such that future 
subsystem IDs can easily be added if they have the same error.

Patch 3 adds the subsystem ID 17aa:b736 to the pci_device_id table
to disable ASPM for it. Testing on a Razer Blade 14 2017 showed this
stops the AER error message flood and wifi works as it should.

William Hansen-Baird (3):
  wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
  wifi: rtlwifi: convert pci if-statement to ID table
  wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736

 drivers/net/wireless/realtek/rtlwifi/pci.c | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.54.0


