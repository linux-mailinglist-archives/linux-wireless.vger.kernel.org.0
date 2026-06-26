Return-Path: <linux-wireless+bounces-38155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3OPGLBlNPmriCwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF946CBDFF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="duP/jXdj";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38155-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38155-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B50A30262CC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC63EA947;
	Fri, 26 Jun 2026 09:56:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7D3BB66C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 09:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467817; cv=none; b=Ct/2c8+5w3mzw2GQXrI3MWmtRVjKhjsB/DN+IoUjgdyLfoSodaAbfIIJDpXqNthFd1RlTFFT0JcwR5T2xmHAuK8WiN1DMRG/fuW85Ih7ky3Ydegy3PHz00SofrktuWG4p6tL0hstHrOC8e/HvXTnZzvXvnx9mfyOp0rzDuBR5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467817; c=relaxed/simple;
	bh=JEemrDxTj8LHfgA6mJFtYRHl5FdaKjrhg22p9xG1wJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rInzcyxBAHffHSVOphajcTWib8/wzLpRHYEjwJjQfOvJ7Cvc+4723r3RGZ8WNNpQ4EwrDUWwhjFSPqhZl5k5F77pLm1uaKTLI4tHZbziQrjSkpgjOuHvYQpaGH7IdVBghL+1lQwDodaOfdZBNurmGolKZ6byhEpnzv7URjYW5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duP/jXdj; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso1224736a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782467814; x=1783072614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T8IHP369eTZYQZP+8gHvpgNRB9oBkLjALn1J6r4A8M=;
        b=duP/jXdjHpS0z0DJiKpw2iRV38nj5c0dU94XOmspvM0n/B4zsysf1nyqooUDF5s338
         wQ7gjs7HfxFFh0bteVZ4+t5eq2VZl0dFRl2/p56aSri+53lY6r67pJu1litjl6g9Iikw
         XXNKRZXbL2iwNf+0FPpW1WpT05mAw5NDF2N6aviQXDtDX8ilj06fOQTKnlY4d73UHCXr
         +DfgHnltMYozKiCupVNuADt5Fh22nI5uKibMzjPmzgdMEFROxBFJTgzH4OUbzaq06uuH
         9xzz27LVswcjG4Mq9fasJggyhXa6dy0d6qAdfK+LX5FoVYuu7GafApZAtDxn5tniDju9
         kldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467814; x=1783072614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T8IHP369eTZYQZP+8gHvpgNRB9oBkLjALn1J6r4A8M=;
        b=fVRr9Or3VFenQuger1sl0F+GNbjHGZbGw+sei+9JAgqaoxLyGaCgZpyt4pepQZxvc4
         2PY3bq6S3Jjzv6RITMm/4H4bPk7ECC8hEQVp2vOz/Z38S2imW7NL6sjDNqDjeU8cU+AU
         /LLw+Jt8yoHqsewogFI2BrknwcRk2darrg4BuOZXB+HsHTqUmgAIJMO4zJZN34PDq2vJ
         rXWJXZctboL1dQpeS7KzcUu9JjevUIQOD7ijbC+nmfMeykYI64jOUbiwYycV+e4itxHg
         RJ9O9WPgCZSDewEWzcc+J9GUbEDmNphu9MWinaw4bb7msCfWfHVGUr5MpS/MVYlY4a+R
         U+dg==
X-Gm-Message-State: AOJu0YzhruYJDkiOm76LBcJHkfyMxjzdNT9pcnZnSR0YeSB/2uPmH2st
	B2S2TT0RnOOPAE2UuYBGvLiOWKdVUacerg7XplAhrAnz3ro1bOtuaVfD6YX6JILX+nA=
X-Gm-Gg: AfdE7ckOlsL10Xczl8u9HUlsLBspkz8oJeoQNqp1zp5XJZnBSkTbS2981OahXYmJ4Az
	InqROrBZe1ioFaVQvcyWczQ985yBIUgqyr7p1ZWaLU3HkzjvW9ezS0/TVYtKMYuGswF7/jD+M1g
	eBgFD2JbTv2BI55JC+iUt31HrxvIsShWubEya66JsAA56/mNc9KcfOX4uTadWta4IMNnennC0a4
	oRuBftffhWmkdi0KgVubg93SJKX3c0r4qKEFikE6Y50jTU+PR0o6Be+mIeaHk0KdXhB0/6L7iXt
	Cve1ydW7nkmseLA6lk+M8sWzUuqSXq1BFUHtxVqTtLlqY8OtjKgq7/P0EqSz6rv7ZiVqrk676Rk
	RANSxoucsFuqm8oCL7XLNoaMeCHQAG6byXYepe2cae+w27nNYr6nyt38fFiowvgTZE9OSQOieJR
	On6m0prXHR6VsgWEBLyk0Y9W0=
X-Received: by 2002:a05:6402:190b:b0:697:ef1c:b5f7 with SMTP id 4fb4d7f45d1cf-69810a32487mr1771897a12.7.1782467813901;
        Fri, 26 Jun 2026 02:56:53 -0700 (PDT)
Received: from localhost ([80.208.66.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aeb509sm2577084a12.10.2026.06.26.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:56:53 -0700 (PDT)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH rtw-next v3 0/3] wifi: rtlwifi: fix ASPM AER flooding on RTL8723BE devices
Date: Fri, 26 Jun 2026 11:56:45 +0200
Message-ID: <20260626095648.1124924-1-william.hansen.baird@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38155-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DF946CBDFF

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


