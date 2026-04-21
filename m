Return-Path: <linux-wireless+bounces-35172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GE0KheD52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A09743BAF7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0C830C297C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F63D9DAD;
	Tue, 21 Apr 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azELihOr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F733D7D8E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779432; cv=none; b=LdUo802+MunR13vOHOQOzGfPkf15Vlu0lMj6pfLLa4n3xU/pqqiYyfZuIL0FyVHFZk77LG53K3Kf1GHgosz5Cmeuhx55kBTX6CFBZoYvhmlXUgOWHnAeVzY8RM1GEBq8/MtvFTaVw/q7pQhPUJ5jwxM0wP1rOQ/KImGcwChO5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779432; c=relaxed/simple;
	bh=8wWgQ6maEJ+lt6MzKA1A6fZ7Z5bt0JX/o3/C/RjI+3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHDfFaRY+8lGpqkT2r4J2QKH0GZVoDBqhEIOrb07tg9S0QN8PovVzp2UoAbMfROmos8ZlLpuBTrOVT0tfMbkiyf9YGixFD3lAVhEu1avf+Vtv6HacF6dtpK/2yMNaydnyhqQ0UU0wwbv/bYq2u3kBw+sbreaTLGrLmif8IfM678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azELihOr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so40450955e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779429; x=1777384229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1deOAAomkWggu2M0bCnsp5M0iXdhC8qdB5EdeRQzsI=;
        b=azELihOrI7g8c1aeyK4D+WUKQ8al8duRfcSQvUdqVgJd9QsRd9hEKEfrRP2NctoJ7D
         88uFpZ8Pg3ULKarfqCEIKjnCVizGa+udH/ePDNeOOx7L40Fakjop+inEStfJ3SOUh/TM
         PPU3U8LaEw4Fl7FyEaUpluhh6d4JOZ2d7Vet1JCG1PLvTPUUeFP0IbLsdbUaSveB2EuW
         X8yKomWCh4xTWCSLymLHFAF1ZqX3sq7xdLqXaBqy9V1GST0dwzxvy/RoW3JOfbfmGd1Q
         FuqhBkpqScHEpvA2dgSgxJ42GOEvUumzb6KwqVTRbnprky5FN4baJPNFCWs8UlLBj/fA
         n6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779429; x=1777384229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1deOAAomkWggu2M0bCnsp5M0iXdhC8qdB5EdeRQzsI=;
        b=UIvU2BbVmsA5K6ftfecGskPtobW6vaJKCQMqdrTPSAE8yCGiFLg797krQBZOhnsNkv
         lYj4PsFGKWEDvZPnBj2vHQAq1nfYUHVv4Pop0eSChOm9Bz1hVxBDgVNXfXkKECVkYrP8
         RuQ6SKSzqrbECZf1Qk7jays+gm3Mp3mAwgq6tuyOrPgKcUoRRGZEMyBELX5MdmKYnT/z
         sxhxr8KT4kfX/kBP14j8MRf/q0zH+EqufMImsm4v1BT6dqGVf+sH1xnsMN25JCagmFMe
         7Bcnda3RLnEvMKCUR509c5ntcYEmVwr5dmOr1w9fkTQtkb2Oahqtc+ZKHAT3oT3GE1R3
         zkxA==
X-Forwarded-Encrypted: i=1; AFNElJ/mGcq0DITkZaeGKEoGN5twefzegnAYQaA6VWNw3Go+WGdRibd1bSGpX4cbJAiaOlN/Q3mHvt4+22W66Gr0Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLBjAY5Az/HoEOFQ36rrSDo3MHjcKwQ386s7IxnVZMgJf7YvE
	d5AkNaM7k9rELprQEkKMoV1UwSRicpEt0nxQmeILLm+3HusyEWTkEms=
X-Gm-Gg: AeBDiesx6cuYAjceomJVHzj7hXQjcx/s5y3EVXqs0KMBhblwtykd3x8c6t9MfA9FJ+0
	gME8nZnSRkBQlyRBFF7ZshmfA1z5qLaO4lJpYpEqMpqqsC5MXZKSqUbwSU7ylQLgvqF4j+u0UBK
	qUN+OSSr1xtyBGuTNffnQtAsP5DZdL9pqfIsj/ETHqMj3xEJ/SqEGjz24ukEDZv80bAljtu/Nme
	4q6em+cW2rwxPdDRzWw6wBesh/klW+OYaB844Bzhi1ljX9tkqNtoR2ZOzTs35JpS4DKNnAdqr2u
	VdRiR1O67QGjMkPQjs/v4SdFwMcL5AxwQ7rLh2ZobBneuVyoKJiAnodDTP+zfo1xife9M4nxklB
	MGq3BrLnYs/RZo1hGuRnTe270RKyn2bIhRUKkKuaNhGZZ0cBDKDQfzDo6BENgJMlJLnC748N+D9
	yoHv8=
X-Received: by 2002:a05:600c:3b97:b0:488:af7f:7707 with SMTP id 5b1f17b1804b1-488fb769dbfmr283962735e9.18.1776779428970;
        Tue, 21 Apr 2026 06:50:28 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm394031315e9.5.2026.04.21.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] wifi: libertas: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:50:25 +0000
Message-ID: <20260421135027.357622-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35172-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 4A09743BAF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the Marvell libertas driver.

Patch 1 validates pkt_ptr offset in the RX path. Patch 2 checks
bssdescriptsize in scan responses.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (2):
  wifi: libertas: fix OOB read from firmware pkt_ptr offset in RX path
  wifi: libertas: fix OOB read from firmware bssdescriptsize in scan
    response

 drivers/net/wireless/marvell/libertas/cfg.c | 8 ++++++++
 drivers/net/wireless/marvell/libertas/rx.c  | 9 +++++++++
 2 files changed, 17 insertions(+)

-- 
2.47.3


