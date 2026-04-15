Return-Path: <linux-wireless+bounces-34832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK6/Nx0Q4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEF408956
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAAF5307311E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFF3947AA;
	Wed, 15 Apr 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0hnPQzP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE65391500
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291817; cv=none; b=ikV4p3Ooei+5IhACedKMo1VFDcdrrzj6O/U6wqRrNc3kvB66Ej5dnAZmkcQjoO4k2fnC5kg3sUcK7SFZokAt4g7tLXRhICZ3swZ8lTSnoXeH5W4LUdSb7K27XD6dr6HaOmCsowASGS0i2IxUGcUS5x34yCumCVnrrqx8+iZAc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291817; c=relaxed/simple;
	bh=tZjNaZEXvnSFPEDZzHmrMt9aRXiBa+bJDj1WSm7wEDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiIaGcVANih2No68lKQkBW/idFUuCMCokeUyHJoeMebMOVu7UQ1ysnjj0U2VQzzDHlic8K1tLFh4P/b86RXBCJquC2/1Ts8f7GUJa9Ic2dcLe9Y/M8F4jmZmQfvnMnsrRwVY/1slmIKMxWDMKhMeAuOei0WSC3jzXEm/UtKCR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0hnPQzP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso112611515e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291811; x=1776896611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58lzRs6nO9P0m/wYeIkyHuOnKofA9zauhmvpRE3UfRM=;
        b=a0hnPQzPtL+eQmh0IZxap92h8szglN7k2WJCGKLF+IgSPcOpSa017yE7c7CGMkdRnG
         +2uLMlVzZ0Ei3k1YqpGmoxEqdi+uUXSaGxrN/EKTBTGaJ+cOzMU7RJ/we6Bhordewoi9
         6Tu5c8VFaLVgp4l0HuOgqEVRPptiK0R6m3Xtn089LPp5bnkFUQMsgJOdP3bIFqSp+OUK
         GVojr6Ug9I3YHhTdWyPfaFsNAxf814b/vpgco/fEGK0SS9xgLU5WZ5PyMEQ36FB3RKYZ
         V7elHzb5+hdWAy3ygt7ad1DsYd2XGQCvG/ZW06XD0Dr0uHVgHNrCeleBYQEyvs9lrxDL
         01iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291811; x=1776896611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=58lzRs6nO9P0m/wYeIkyHuOnKofA9zauhmvpRE3UfRM=;
        b=CURbaj321vKxcp4jOVS2/WoNyAovJYcYtMCs0dkRluHihmqoK9iKcYkxhZazGuWaxU
         PCYXDPp4tjW6SQba0cYXGxNxN8HTOA/kVCh0H0pxVtPXg+1dm0i1y6FXSb+ykHyLDcJt
         sqPbbnG5fFkgoqQoBAaF7tZW9EeyTg96TIV1np4cYOzb/cr0UOLMZhVplaWk9/rOkhFq
         Fy2PSpDcYYwQUzjLk/lib6j3T7dEOQtHsoDov3lM8VuyWevqtfXGAMYxhzIgYLoU/qVC
         xdzEf2lxce3oQuSjWOE+He2iYNYLtNpainLevbTgeK9+h0a3XEMLcr4JHICDpqkApJHQ
         nvlQ==
X-Forwarded-Encrypted: i=1; AFNElJ89lQslEC0GiN5owlySjLyAL/r5BxOlpEYVRo22Pd0Nq9W201HeO4da+5Sg2zGEXAn/q60F0iRWm6F6d+6tXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3KyyvIxlqY476GdWJrS+gpj1ubCGQySEPxKLfPs/WvihShXZ
	8UP1pgJMk3I4cPirW/C5LSt12P0T9xkkR22qaiEpG44TAjTaNiFx9xw=
X-Gm-Gg: AeBDietDshtkLl3p4KtuQEc0i4KlJJb5Nz6sP49uAp30HDGjF3zAIXVoTAm3gMEVcio
	7FJ6DCOzMTd/0XYfUkyL92Pq6yIGISomMvKyXErOWnzHTGBxdFlZwpUzzSM1+tj/fTHBih/fly8
	+gnjJkL1CtYuh3XUfOqUdoYYLpgNQIK1vEew76fUqrkM54rkDVmDrTEjOEwgKvIZGD2inv8x/dw
	KI0qg86sGUwK7zfkhtWq2B3y78GVZOH6yrP/yftpKDitXt10RsPUVfUSuuEHo0Wv15MreIG/Mgz
	hK6+IBT4RE5E1+USeZg9zAQBumsch8cxYe01mVrp+YM0KO8rIM7sVbXEV30AhqCQLUiM+v+wIv7
	TGMYVxQo6JxPOTzQVd0brm+9UB3WZxmPh9F2vXGuEKOfTZj2eURdafuYLrF91QR9BGD1mXdilIw
	GUgl8=
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488d67e370bmr223489645e9.9.1776291810987;
        Wed, 15 Apr 2026 15:23:30 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] wifi: mwifiex: fix OOB write from firmware queue_index in WMM status response
Date: Wed, 15 Apr 2026 22:23:22 +0000
Message-ID: <20260415222327.1539269-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34832-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FAEF408956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled queue_index (u8) from the WMM queue status TLV
is used to index the 4-entry ac_status[] array without validation. An
out-of-range value causes out-of-bounds writes of three firmware-
controlled bytes into adjacent struct fields.

Add a bounds check before using queue_index as an array index.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/wmm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -945,6 +945,11 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
 				    tlv_wmm_qstatus->disabled);

+			if (tlv_wmm_qstatus->queue_index >=
+			    IEEE80211_NUM_ACS) {
+				break;
+			}
+
 			ac_status = &priv->wmm.ac_status[tlv_wmm_qstatus->
 							 queue_index];
 			ac_status->disabled = tlv_wmm_qstatus->disabled;


