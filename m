Return-Path: <linux-wireless+bounces-36059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI3hISlz/GkEQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:10:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE174E7422
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5AA43038165
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2A34F24E;
	Thu,  7 May 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg6aOoCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6523093D8
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151852; cv=none; b=SHHEIAaW3NSIdfn05PowHQp8D/nkOa7gdO+NQ2phO919e/Yya7YUFEVC2c8HPJu6bQAXsSxY9xwHdKYOiU8uQToGNSfyAQnOJZ0irfGrki11eM3tAAxbYWVMmtpY3wmeR6Gn0Vi8B1mSOvshPoHTm1tbU1xSf8Woj1R+4Yz0HN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151852; c=relaxed/simple;
	bh=muy4ln8oosRMTLMN8Ir5RlGdNWkfxHNe7px5ZbQvV90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsSjg1FoG5u+RsSiJby8fnpyXJ7HljedBnQJevlS1dnuDZVN/kPXpMy41/0UT6rNfAFvLAmRe7tneTzgy0sBXHHaTVHBnBMXOB8rJCsNQ0wcY0gPq1VUX3MrxASCMV6EBJ1FbKeE/RMZNTtxuE94hhcmE9cowVRmc7Myu5xK44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg6aOoCs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c801b30188dso260911a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151850; x=1778756650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmrgafWER5TklrlynvzNXexUVxLr7++bugjx6nPpFyQ=;
        b=lg6aOoCsQOoRdgaZ6Nb2ZcEFdGIAiz7gAVSladZLaak2XyA7i95gK9R1azMUrrRtub
         lDo+c0Na/EB+3lAnGUxtSKwxI1JSu8tFG7gva28yJHzkYtJyASBm+adtHFi8QFTquOPf
         wJfwY8hLRfywKCaIdKPdJkIDk91alavQDlu4A5JixVSbjP5QJaHPPhllQcJN9zJWXodQ
         6ahgX3GgJ1tPG1ldemGuPvpOrp6GWTdVZPJv9D0lVLuLHGzJpYAYXVUOKUU4lt7qDqX6
         oBsuDrT6kKItitC/jm8IcvEK37DhJxIvCIh4yu/muvPk8Zk3uMzUELHAppNjlic0Pzlu
         bFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151850; x=1778756650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmrgafWER5TklrlynvzNXexUVxLr7++bugjx6nPpFyQ=;
        b=diPDpZ/WBboY5Ryml9RhnqlOE4G9TjB1411/2VTCRfLEMc6rIwl62mQHGJZBsHyUJW
         ShC7T+N4Gdpf5xj59l052DarRG6yhjT+KbhCqLLjiu1Qd+AMcAxR8pvjjZQCQRR+tze3
         ne4VtxsAo3aFK8TxxeVMZJFpA0XLnxIGoQ+Awb63bwFjHY/jxyRiJpjIBNBkQjehQzZR
         Ozx9DXQSPq9jy3GLISMQy0479fFqA12kqXcjWPU88BSnIzbbaDlrCb1MMqIklMfRN+5j
         VMN25URhvAnzFO7XIXdqwa5vhG/XeDdc0t2P79cJgdBVLVMOulDD4FZQci36a9OiPnc8
         l+Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+lyFD6ulHIDEUgpf2Gm9tBnMJFkb8CS980nlH9Wx+byymEq5t2iTqtDtbtojieifGTSV0biiBak/TFEfWW/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHK3F90ubTbs7WppEbmJ1jq56fVYHdSj6+KhlKGI2s7DNls04Q
	Cl81D8alqkrnEZUSXg4mo6KZpZBW5qSXfmso6f7Tja0Y8ks+dfN1bgsk
X-Gm-Gg: AeBDies4hqZySh0RDtSAnEFACM0llHrwne/CW0l4ISL4Bib+aegusxsT8U1mrOE+JiD
	MbAzWb7b4m4PShBxm9NvC8v2w16n8QH2Fj8LxsuAcmzXsHQ+5aiLak3+vLtARVdozaZ1mXBVMfw
	Ga2pCau5qRlL6NbkvmvuI/BAfPx4WemkJrSEVTDYhFD/xq00WifwywdwlfZ7YtNAwC5Cy9oiXk3
	645iNs/dvsDjjpI3gycTNbnZHpQu0u/nxfhmKF+SXulypQFWNQOs20UC1UNgPj/Y2gu4uVeJsIU
	NayzvckvDFId/aI06BurWlaT5qb6AedG5wcR2O/E5hGf4klejSk0TN8oPGud60wWc2D7uge5pKt
	DdDOynSLTsUOuG+rOVlXfNiHe7afkg6/HiFr+nm3EX/swWbT6gmz3k1q3hOUYk/hcAL7X2hfx6b
	xwHkTopx0i9b0hhT2KbOaRknZFDmVcTBcfEmiJrJCLy1o6AZ0n9LM=
X-Received: by 2002:a05:6a20:6a2c:b0:39f:24a5:3065 with SMTP id adf61e73a8af0-3aa5a72c4abmr8140964637.7.1778151849968;
        Thu, 07 May 2026 04:04:09 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253b493c5sm1835163a12.28.2026.05.07.04.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:09 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/3] Add str_alloc_free() helper
Date: Thu,  7 May 2026 19:03:02 +0800
Message-ID: <cover.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FE174E7422
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36059-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jqqlijiazi@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Currently finds 4 locations:
./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_alloc_free(valid)
./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_alloc_free(valid)
./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for str_alloc_free(alloc -> pages [ i ])
./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)

Patch 3 is based on
https://lore.kernel.org/linux-hardening/CAHp75VdHY814NRfyUfWeqRd4-DwYzHGh25OTsUB5EFpRKpVQLQ@mail.gmail.com/T/#t.

---
Changes in v3: Add first user for this helper

v2: https://lore.kernel.org/linux-hardening/CAHp75Vdvdr0TPzuDDPSoJ4Nixk-6qO_x6Or9iY9LNwSO1Q6mHg@mail.gmail.com/T/#mfb405519f7b3a06f4fcaa8e5a799da5299d9ee85

Jiazi Li (3):
  lib/string_choices: Add str_alloc_free() helper
  wifi: rtw89: Make use of str_alloc_free helper
  coccinelle: Add rules to find str_alloc_free() replacements

 drivers/net/wireless/realtek/rtw89/fw.c     |  4 +--
 include/linux/string_choices.h              |  6 ++++
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.49.0


