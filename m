Return-Path: <linux-wireless+bounces-35164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP0COHuC52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD943BA58
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BEE302E91F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976A3D7D72;
	Tue, 21 Apr 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIQMYuiA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73723D6682
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779414; cv=none; b=pUFJaTLJSbj2p+9sjSC8raVKp3OngCG8SFjABmcIGwOBoWb72mMW2OTyIKjzoOcWeDcf2dqaj13EnW1ale1MSCF1oquqc4abniTvgDLB5/GV1Dg2qcOAa5yZtCSo5XuN0CQpxE0HUR5HxKsOPIlGFGZpnooqwONUeMkg9VGfYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779414; c=relaxed/simple;
	bh=nqO4skkkw+I5e+zHSyIepDMc0uuc8F0wPXGLMmtCqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVFeuyF7d2Sotp+Tgji5+5qV12KgLjOubkfSmeLZU2WaA3ZQkPp7vPAEUwRxpH/nL7yHIQ4Cu6B7yZgSxzg3VUR+Y0rBLJN96mY+8HFlZzUthh3DjpEttzFpaFTNnLEanuL/vYweU/M9dl0RBvTu+8tahCLKMX1UbRw+CgrL/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIQMYuiA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48899305e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779411; x=1777384211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRgBRh5FvMKK2ALpNWiLCInpdsRH59KtYiBo4XTfEVs=;
        b=KIQMYuiASaajsKL4XIoXhrVx6mJbXcgNsE7h0p9Hq0DI5MKyk+XAABCI9iL+qRjmOj
         02et0JZhKmgCQN23vGO23HYlgO06Ab65yTubNP/oJCjwl7zc4X35enZKE2Njxj0GKlSg
         /fDr2DyTyExKG+B6+3+3yTUwhvHcyoNT7jGcz4UyEwFwI+y9I0TkYV+cfNqJhpL5c6Ri
         4AUhAsRUTg+NJsqA4b3osIKig7tMQaaWkXH1Py1eiITpQcq2JoNziQ7Ygp+8clwC4UFe
         vbycVa6TVTjUaKtjg8C2tCQYHZiAUhQwvxB899CuV86wX9N4/rNPe6oytnouP2f1wnS7
         v8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779411; x=1777384211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRgBRh5FvMKK2ALpNWiLCInpdsRH59KtYiBo4XTfEVs=;
        b=UX0XWnbSDX2v9NJ9Nis2V2P8IsNo+IaCRAChWfWpNlWPF6yaiHGNVhknRAy7G1oIYH
         +Z/OpiglFe0F5+5KmddRBsH6Um3jagF/FY9rcnBeKuuCAxAJSkkEtgNdaIykzhaRSKHe
         9WZxm7jqf55QIExeI1cAV4luUrk08MQghtD7SIH1xZ4ZeX17fFE9V1VoP2IRDP8yfzj8
         5g1xEw0l0Vil6wEJa1sVBTyIUiXUnlRPjywPj6ig3p44iAJ/frOwnAZvt1ddqlXOSzDn
         b63KQEBGnh6QkV5fEoFXLsQh4zusjKIMC95UeHok5PwPPTiQgc/Y7fltiwE6r5LQFKYK
         ZwfA==
X-Gm-Message-State: AOJu0YyhVUJXULEdkK5tzJVDEa00SBFfegCTv9bCDtT6D1BpsPP41EPU
	L3+QcGz9HRZz/j3Dk/VV8bAmojccHbC10PoqN8FB6UhY8A6JCHplKRhszyE/
X-Gm-Gg: AeBDieuljH4V2EqrqgAfZ4baZsDbOFec8q8H8/cwIK4KpH1X2Q8AtjD9ljaoigendoS
	tE9FxncvLswghW1+egUDj+l+87vWW0MsE6d3yIrYLmUi++PV47tsgtt8sZ2oCJT2rBD/apVj0UM
	RojuwDxfNjXR+mbovK7YrjjnBEKkkyRV7riQVAPI9Sn8UqZenUvy25I2lwQkHdx+Hu1d0L4x68R
	VG17Qn7HpinjFJKQqpEDvIFlVBJFm2mvCCsqdlg1+Fa8bE3+wkr24HGy8yC0rriKDmERla9zxVC
	lqkXjJmdpZLc16E1PZmI/HIPFKyqTT9GcjFjoFZMgr59JCvQKZzTDW3zUfsDRfBcOd3dr7kyrqq
	VD9kuL2yECpMEpK5Hx1l48KrH2modZfBVeGvU5fRvxzD2M1NkSD+vU7/ex6JoxfZPNNVw4X2O5z
	QjT2A=
X-Received: by 2002:a05:600c:8592:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-488fb779acbmr178716545e9.15.1776779410931;
        Tue, 21 Apr 2026 06:50:10 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74eed9sm165464395e9.1.2026.04.21.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/3] wifi: ath6kl: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:50:06 +0000
Message-ID: <20260421135009.348084-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35164-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40BD943BA58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the Qualcomm ath6kl driver.

Patch 1 returns early on invalid ADDBA window size. Patch 2 validates
connect event IE lengths. Patch 3 checks TX complete handler num_msg.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (3):
  wifi: ath6kl: fix OOB access from firmware ADDBA window size
  wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
  wifi: ath6kl: fix OOB read from firmware num_msg in TX complete
    handler

 drivers/net/wireless/ath/ath6kl/txrx.c |  4 +++-
 drivers/net/wireless/ath/ath6kl/wmi.c  | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.47.3


