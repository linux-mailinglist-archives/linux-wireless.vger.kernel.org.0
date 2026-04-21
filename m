Return-Path: <linux-wireless+bounces-35141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKCXM7qA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8F43B8CC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87DD73051D89
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C339D6EC;
	Tue, 21 Apr 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiP6Sg90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EB3D75DC
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779362; cv=none; b=HLgQ7Thkn1xmdkitu0fN2pQi4WkvNKIAFY2VTuvsiWPucvG2f3L6irKqjmGosNAxzuoWyDSyqG6YVEty7BIkVnd9MmlUjZQrRfTostyh7cBSFOvzKy7VSqjCoJe5/YscieAieGQzRXSdy5CXztkf/NtiJW33xTfCGpOu3CZQkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779362; c=relaxed/simple;
	bh=yiFIMgY/m0qQyNUVx7UPEwdEdWU7dYMgU+uY1eQAiUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2KIf8uiyTn/G4rbimBOeV7SHow4mLRbdz1DhDlEqf7b2aTSlj9MCnVtbwXbLrWr+xgPdWZW2yEgCreVHGL3DIh2Rv9dNvonQT4zWE5bMe6MNnY/Wbun8wX6RiHhtBGq9aIjnt0kNQZxrrR7LMJqd/xjbNBpVsgFQLI1p5UNZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiP6Sg90; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso33310765e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779358; x=1777384158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jsaSD6s1cWFaT5D2OjSz63ST/7VdtfKF1kM7/LQPcQ=;
        b=JiP6Sg90SCF6zCQTdKM40Lb4Sr5AkhgrvxahP56beDyNo4WRoYzRthes4OM778QvTF
         lbxQAi2rRgWgiSIV3A0de3dRi7xVj46ZGqk0DT/fq71z1zjpzVGPw2HHtGteKlJWYmSR
         yixY/1evU72ft/QlGXjlXd6nhoz1drdoFAaIUl1YPD4acN2/bYS9pZR/+xPVi+ccTPUH
         xoY5WC4CtZ8+yTGbwrdhxeXDK6f69sy8cPnLw6XR+6zTSqV3As+38IzYt3vt/Err8C5R
         Uk0RaOYcBrMsdPeWWeLK4A6NcyL7QKCgu9HkK/FB4vMbby0v8zIoHobQHJeLdJXFL/3u
         obKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779358; x=1777384158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jsaSD6s1cWFaT5D2OjSz63ST/7VdtfKF1kM7/LQPcQ=;
        b=Il1q/2g1MXBoP3k+SsRJvqU1VAa7ZZ5BU/iiSE+r15aRXXwfrMTaw/fjlaUL4aqEh/
         XqDWBbaF1Meae3hogo3zBWH5aluVuaebhhKU5C4BrVGCPuCoIpVuICmv0oy4cgBP/5ZQ
         xqBUbls5jTuljytFfnjhYcmTxqmfXNVBw5wx4TKWYsWzlayHHklSO9XP8ukBiIJUTXvg
         FEWxok1XZUWkE8/TWS1tkqicm5A/x/KtMqwsM/XY0DFo61+X47MDVKoo5a07vxDnxLbV
         ICnZxld7gJrLqRu1fB0gPLv01UkIBLtXVsBL9vEDM2b5WI+Qdu6nZ6oowjnttKlSlKXw
         n22A==
X-Gm-Message-State: AOJu0YwyMjb16NavO/P9tuqbmGu/2hhrol8tYjhqEv0CGjgetDtcl2zl
	dR/5ty3JH+jRUbx8jOeA/H9Gs3/jHeSjntnZUMG1Q2b5giZqLGXHk7I3YaD4
X-Gm-Gg: AeBDieuL1m4zvu+QtKdbndyp+CcHE1koTlHyrs/GY+FZYIE3RNLl1Jq7QMQpOc6MpT8
	4r2gZCJFXhFerCpxiQOyQtTBfPqIhLEgM/TU6eJoXTSZj6rUld0ObU730OJcQqr19u1NUvGodXn
	gsencrwZUx98S2/nq8BsEqzXrhlTXVEszqROWtpnczdsOZ3lu5UsEMtYL66ITpLzPfLWoSkJYus
	IalsUDdro+qwgg6IkgKFBpqKFZw0bKm+DBo1yt6BKhz3bSizYB6t+mhXIZqE64U3xXjVHyYq3zY
	0Eg7bdadogL/K+lxAqlBKMXr5qnqNyvcvdcAokthXCIRBBaxP9iIHXkKBx7wLxhyYfpHHz9R6kj
	yGrkZZkWTPQGss8HFuE2nWnwk6QB9VZ8ahM5wIyKtHHL7HYX+jBYZzlRRqRugfw3d4ESjGWZpbG
	S4uYo=
X-Received: by 2002:a05:600c:8588:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-4892005b4e9mr68436925e9.19.1776779358001;
        Tue, 21 Apr 2026 06:49:18 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm134028065e9.22.2026.04.21.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:17 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/5] wifi: rsi: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:49:11 +0000
Message-ID: <20260421134916.317971-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35141-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FB8F43B8CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the RSI 91x driver (rsi_91x_main.c, rsi_91x_core.c, rsi_91x_mgmt.c).

Each patch addresses a specific field that the firmware can set to an
out-of-range value, causing OOB reads or infinite loops in the host
driver.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes and clean diffs (v2 had post-processed
    index lines that prevented git-am application).

Changes in v2:
  - Clarify firmware trust model in commit messages.

Tristan Madani (5):
  wifi: rsi: fix integer underflow from firmware extended_desc in
    rsi_prepare_skb()
  wifi: rsi: fix OOB read from firmware-claimed length exceeding actual
    frame size
  wifi: rsi: fix OOB read from firmware pad_bytes in management RX path
  wifi: rsi: fix infinite loop when firmware sends zero-length packet
  wifi: rsi: fix OOB read from firmware offset field in SDIO RX path

 drivers/net/wireless/rsi/rsi_91x_main.c | 20 ++++++++++++++++++++
 drivers/net/wireless/rsi/rsi_91x_mgmt.c |  6 ++++++
 2 files changed, 26 insertions(+)

-- 
2.47.3


