Return-Path: <linux-wireless+bounces-35151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG7UChWD52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46943BAF0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3368830AB479
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF93D9053;
	Tue, 21 Apr 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK0mLezH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89F3D9046
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779385; cv=none; b=LExGMJlnpM/eLhNOic9tFd3ZmEyqUUEIe0ZH1eZxwef5DqE4JCtOsh10bJEvhDpJZttoyhZdZe8M5Ta/KUL031pE7ZKC4Thp3ihbtXYYuz7Sv9uMtgtADnez98/FgRR+mIbWNpCIsKGlZShvqNUcNg2qwHynhXJOsDMl6O1hGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779385; c=relaxed/simple;
	bh=IPJFO0XuZnfLHj2jRJaHRAXCrTHUnQT5a5JwoEsGCjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8LlZYbhQCJwndYPDXATaSdZqQxtkavytNQgbDjyu7tBj90R8ArOsDK/oFmJm1EHK19RYf5AmDy7F/BAkMgJ1qgUgQWpCiqhCfck1fwKPdE36w5AmS08vu4mga0s0TDv47KXa5DTzKl/IbC6N9tOvyxCxfB55cHDwOf0eZcQkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK0mLezH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so54921345e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779382; x=1777384182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh9fb/N2f0SHfw65j02+jLw0UeHqZ95OWigIzfZAhz0=;
        b=TK0mLezH9rbyBkTq8h19pZud/nyjT2rUV3ad7iqmTHRvYVfeJELO5z1R/dsiqKlInb
         qQFoE6XzDYAOxDa/7WsycO03WUYvMa7hZ31tJ25N1Sx7HI2BTIWpVbrhsmlO9epJfQYP
         jEIphQX6bDGIruSFmyunTSj0U+Zho6qHYVwTWrBmt20+FADVWYNFB2zsYvxgHDvKatQF
         2hDHGTc9HBDpd2TBh5pTOacqvTbTiNUPpxWkrUXdpYCIALuCDfFeMWd874jjbS8oKjgw
         VdwuiOXXEUhZMWGQM4mo+i7IlP+riS+aUCFLY0STIAFVduQKZay9GlsA1lsTyIwmKQ/C
         2O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779382; x=1777384182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh9fb/N2f0SHfw65j02+jLw0UeHqZ95OWigIzfZAhz0=;
        b=PHQudrU7sWqAeYppr+l4Snauv/1E3omtiyV7AJxv4PhGf2jBH+e6t/jBZzkXvJ5wm7
         BsV2iQcP15rOhbdz6JicRNiEKe3MQaKhSlEjzM0TOn5JbsPoEbV+WSa5TolEcfLmaJwv
         GQhVlyoJ0Cc55imvYi2TY4ysjwsv1MRgWt8Unrjz9G2vGh18uRR8X233OWJ1zQebIt84
         e+Vt/V2xpJHT67i6+t171Au3cTR2KW66/ztWuRBpNRO/6cA0brM2L7ANL01n31r5r7/a
         3XWdjlkFHa2/tocTRzwYwTU+RD0mF2Udm4Iv9UPYwj/9aWTGbMf9mF3zkn/jjTZwjcqV
         BoXg==
X-Forwarded-Encrypted: i=1; AFNElJ95gvFfLXtpYncrtJa/DL23w//TOvt7ovTIvCAS3hJ4c19wa9jzvklhQVlvVi9FYMEKPG+gtLmdpEBy9F1Fug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbO7Uxqr78mqUHHoX2XTB86v4pTBrssfLzxx3V8+LnlUP3HyW
	8OOOn14OFOqt9DA5FBP5AR2ma2nob5Pj2vXz/MpWcI4nn57G6kBDJmQ=
X-Gm-Gg: AeBDiesHP4SU2hhGorWkmYTjC2rms28vTfRpJIbZ9yNAhQ+S3ENU334iIenPC9fWqfd
	s2J/4hAvcmsEw0i8mriXVavx2tHvuHjDT768FwmOOqucgkSHjiexrHuPzn1PpPRkFpbys9UXmjX
	HPTC9wi19mfbWp+bRAzBorKQ9a9BXqjVpsa1SHpm30xL8Iyg8gEGsOMWUMgvVoyQ89kGYQmYxA2
	UjxJM/R311Yy2cLn/9q3aGr3UA6q7uuH2bUEFWb6IYG92RI8QdtPSQvdJ/VgmHzeRFKib6lZPbw
	BcshXzeWIggSYeSetwQnCygUoZvjU65HuobCTTDlDN8e1TA4ODNsI0OqF1s2IvhW8v+n4o4TbAI
	WoNVPe3triwNdzz9GSVHpFIUjLlPqDfeDxG0lLLXdsDGiwckY3uHkxutw6DAzQjKGESnEKeaAV2
	ylUW0=
X-Received: by 2002:a05:600d:1b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-488fb771438mr221635435e9.19.1776779381560;
        Tue, 21 Apr 2026 06:49:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/6] wifi: mwifiex: fix OOB write from firmware queue_index in WMM status response
Date: Tue, 21 Apr 2026 13:49:33 +0000
Message-ID: <20260421134938.331334-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35151-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE46943BAF0
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
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/wmm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 841505e83c7fd..27e6dedcca2e8 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -943,6 +943,11 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
 				    tlv_wmm_qstatus->flow_required,
 				    tlv_wmm_qstatus->disabled);
 
+
+			if (tlv_wmm_qstatus->queue_index >=
+			    IEEE80211_NUM_ACS) {
+				break;
+			}
 			ac_status = &priv->wmm.ac_status[tlv_wmm_qstatus->
 							 queue_index];
 			ac_status->disabled = tlv_wmm_qstatus->disabled;
-- 
2.47.3


