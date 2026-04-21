Return-Path: <linux-wireless+bounces-35165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOlcF5SD52m+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:03:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1243BB55
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5930D52BD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4433D1707;
	Tue, 21 Apr 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsWrkNqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F053D6CC8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779415; cv=none; b=qJJSXJQIcJJT2CADu1wkheVRMPm89p1YGMn4mx0unVlBgcx0ic4QGNvffmicO0Xypzu7eVc7bUyQuG+js+guIsaT2hx7Q+Hk4D5fsZrR0JlYw/Ris0WJOt1Lm/PWd4D8JoNSq73MVgND+sDBHIJ/COl02rw+E50u9d1WLOgTJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779415; c=relaxed/simple;
	bh=7xHdMKpkxXstirzQNsKPmRsSC1m6fp9kR0giIOUpbKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApC+kv4SCALn6DUWSEScVnlUel92YOQsLcCYP6Ac7OacGWRINmf5LvKQcLF2dONjLSVr5CclNNRbJepNRkK5UDJQzDE5Sjq/6FzZS72ST9Dc/v76ZLvS6B2dwY87KrvHOmLwZqWLwuQExGpgDhhMuAPN+Fgxu/FaLIrPUDeO+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsWrkNqx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so6800935e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779412; x=1777384212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVTTdLSY03WpD7raO4AFtimw/W+4ZUAurUEteTPSXv4=;
        b=PsWrkNqxekPgOeI45DvlfYrNftfX4DEaAs9pUiZ38q13o2wxRTH+55iEJmh3Dfzhrm
         COgo327eI1T0OHeI6f7GsccfCTYLm4XtPYGUYpyaHn9X4QF5X9WSwMEGcE7Tb4RLg+j8
         qKxdAou4tMWZPEt32gyxVP8G536nzAOC9g5ec18JoCX+KtVZd2IB/mMM1lYNh/4LRV9V
         eRSSpmzYAVWSVJW9QqB1uS7MHTOLORikrXvlKX63VII5Yv+j2iR3XP1PfrTYQVao7axC
         Nhm0juDhOt446KppNAguQA8VzdTFQ8tzCL6w1w0vf7MiyQqhqFnx52J26x/bvOzdeCv9
         9mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779412; x=1777384212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TVTTdLSY03WpD7raO4AFtimw/W+4ZUAurUEteTPSXv4=;
        b=aIMFdguCVZFfRl4pBKikftFRiOH0QAA8iIrHf3o2k+jW0Vft8BJomn/PtIp9ECYjv6
         kLWF+bsND95eyR06TVHTzCm5KKEu2FgrJlobIuZdRNswtvAdXXe08GvkzUYFkiTsn1/V
         sQlEQ06fA/QDDIwZ80ui5waYXs0RWQsjD+0ff6m3M1U+c/zJRI4whXXRM2d81V3qENKP
         WG9gIfHI2AwH/OiArpfEcXHwJ4KQ1GsN7N191+YyL0zcN6JTvj5nlCZVY3l0axlBnGB3
         9HjJWvJv8o7LB6IPpfYIdX6xfYBQ2+xRAAR+cnKHKAfWIcxNcwgNHa6l4kpS2hZHz3kV
         u3Lg==
X-Gm-Message-State: AOJu0Yx1A+NSZcTq8zKtZI3BlvVwB1hJRL/aivTsufV5vflhol4mCNlW
	iaCqXueQ95DaDCN/jiKnJFGp9ExXVqwBj1w+/YDHZExvBKdGAJBnhW9dy1aG
X-Gm-Gg: AeBDiettqFNESKnS+8Wa4z0rsfmSftbtYQ5a3AQcKen0Ut8OnABCNxfWXWYd/T1+rfI
	GCMWspW3qbduuS4X6kZxwfYypz7Rrvyus0xD6lv8wpaLxbxxMUduSxI9sSwUnFWFF0Q17RLKyab
	GDsp7d6qJyg9VuGhv6iS23mZgGuu/sBxca6Av1sV+WgZQL4kf7GYGR5rImiA4wU7pkzsmiVW1bw
	sm+mrq/pWVoJ6kz/WEvLlSI6o0xorIhTT9BZWQPbTIj7CpL2e5OjMaayXgHHlV/62jKUmCXxmMf
	C4Q5R8SHEheqxXaIxszKpzCetNhfNtPnhr5JtgZ/aHBt826sl5/v1VSaU2BgNjL8TDHq6giDYQi
	bmRumTt+Ji7q/S6s5Z2u8EZNPZ1wn3plw9MDOIrY1FjmLOYMCzqhIzzZGYqAczd9LbFJhz/FGSW
	LIk9Q=
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr214825115e9.2.1776779411691;
        Tue, 21 Apr 2026 06:50:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74eed9sm165464395e9.1.2026.04.21.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/3] wifi: ath6kl: fix OOB access from firmware ADDBA window size
Date: Tue, 21 Apr 2026 13:50:07 +0000
Message-ID: <20260421135009.348084-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135009.348084-1-tristmd@gmail.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35165-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: CAC1243BB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
zero-size or overflowed allocations and subsequent OOB access.

Return early when win_sz is out of the valid range.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 97fdac7237e26..5575b535f94cd 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1723,9 +1723,11 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
 
 	rxtid = &aggr_conn->rx_tid[tid];
 
-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
 		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
 			   __func__, win_sz, tid);
+		return;
+	}
 
 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);
-- 
2.47.3


