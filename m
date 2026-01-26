Return-Path: <linux-wireless+bounces-31183-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FaPITmnd2lrjwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31183-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:41:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D27178B970
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CEC301E3CC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0134A790;
	Mon, 26 Jan 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="HCJAPjGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237E33BBD3
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449257; cv=none; b=PQ7zh8YnOshZIPRx9QlMdlLkri/UMo+RPTKQ9fSGIpz1Au25jaXTLON9SdIKbqn5ZIyvC+9Fddn8t1JRVglelFd3MplN2My0boEBA1OL3prVTZHq2hibR1tIm579K2+zx/YoKoToHKIMszopDgQGrGLucL4ZaHzrsDJFA8vbKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449257; c=relaxed/simple;
	bh=mpfKr4NRlUyUS/NpG2WpQb+SfLuKaD45V8I2E1VnzYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRWrg8C99BIKijHtPB4uevaxZRPTVWGYPP6ehp2BgmH0rJqUEsrwa38HavDcFKyISurVfhCcAIl1g1T8b7zLCZxRIAxbVY4XKFJkaSHsV0Ers6KB2ic5Ho8Gq/AdhVe1buLicrbTencZTvwAjqpi72ZsLI/C1iHOUiwDQnR6M3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=HCJAPjGc; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so39843855e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769449253; x=1770054053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LJkjl0M29U6XjMWaR4NN1SXpHq9BdU5oG5ebxqQ4ok=;
        b=HCJAPjGcTJrIar3Yy8NfPBEtUy7bS8nBdFquzaYkROeqZtWHV0XehW2twzWLxwFS+R
         1tNMetIkHTY6Z2Z3PJ/LRWTuShR/t7FuSvsv1l7UzzMKWC3G7uytvvs7xOlBu3D0DHtp
         PaKF8cfX/GC0adve/GQuCKdszmVK23yTrg7I2Wou8SpcPAxT4EStyJ8viGYnA4RaApKC
         K87MbEMXrWH3P9KdbS8qcRmacO96L1J5K238AoHnEGSQk0CuA1QOrAgY36h7/UBOmS0l
         viWV3pgZdYjlFM7HUy5zP4jig9iuRD0F7qyzJ9NHwUQp2y0ZxNvsbtRLOl+h4gYTU7tQ
         X4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449253; x=1770054053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LJkjl0M29U6XjMWaR4NN1SXpHq9BdU5oG5ebxqQ4ok=;
        b=mNGDuG9wq3zXgcLlx7weNYQOrRL3d7xjLhc67wvvuyTlm9C+Vldq4ewkjS4J7HJyfB
         ac1upgnbkV/kH02GsFo3YrNImityjTM1QwBYe+wLrjwU3h/XpdkRuC/P6wGLfhvotH97
         A8XaF7xutliYDuUgK1QsZungs7yV3ZJIVzIN8R5bCSXbUggosRTObybdpRys46uFk/WG
         zddlFyM7q/VwjngCY4AgTN1CKRUaydnuGw5Cq2CGRvMxfv07ag+2avJWo6R7QNCpR+aI
         gVJ4t7SlPGcUVeWjflBWcuzMSp2XBIubbb2s7xUR7vzyfAPpPoNuJsHigNHqBLYzFePm
         a+nA==
X-Gm-Message-State: AOJu0YzShtmURcoUB23hJ9QzHepasmhS0A4k1XQ5htMz2HwkkDk1tuK2
	aV9VmZUX2kaEWqDNQxGKhTVQkZXWwqBR3nxwe8BJiJbztUHOK+vpBElJRxPbUFdxwp22OMtN2Dw
	lLInDSSY=
X-Gm-Gg: AZuq6aJLFmhx5PCxkLym39TSJjI9zzIKQDalitGLHTNwfhbOaWljPj6KvyGx0y3s5JD
	MPadKzd/mdRNXBNVA79NUXgNOLdiaux3Ju4xpOai+iM0DZ1hjm6oLKn8IjYDI4C5da5GqjFBiTM
	Wlf6tam3xueHxsHEL3wfmYW81AwmY/Cr7KvojIisNZkchNGmlIumb0INnIwJtvFpKcD8cP0wqC9
	Jj7rZdSLmwlxZGGXFM5pcT81B6rZqJBKOmwOhH7xTd2AddhekA17ceS2Ut3/yaaKWHp2KKVITRr
	sIg8SD1Jxl/N2jdUUsttr6Q3pccVbNS23wGHCJkpf2oilouF0JKbdKPxRCZt2eTE65pTaZTaefe
	lZ1beGlc9u1csl3ESYYx/xmBhtBibZjW0RP4uewO/H+2gOrBfppEQ7P7144sfXvEYa/E4hSs/04
	EuyCJu0WBG2J1KBuMUb9G/Ar//82drhdYOoTb2MDD3RxL1FTbQh3JoKYllVSAoSTNlU88O
X-Received: by 2002:a05:600c:b96:b0:47e:e2b0:15ba with SMTP id 5b1f17b1804b1-4805cd407a7mr76500085e9.8.1769449253594;
        Mon, 26 Jan 2026 09:40:53 -0800 (PST)
Received: from pablomg-ThinkStation-P620.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c05e5csm4057015e9.11.2026.01.26.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:40:53 -0800 (PST)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: ath11k@lists.infradead.org,
	jeff.johnson@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH ath-current v2] wifi: ath11k: fix wrong TID passed when stopping AMPDU session
Date: Mon, 26 Jan 2026 18:40:49 +0100
Message-ID: <20260126174049.1370659-1-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31183-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D27178B970
X-Rspamd-Action: no action

When handling a DELBA request, ath11k_dp_rx_ampdu_stop() calls
ath11k_peer_rx_tid_reo_update() to tear down the BA session for the
specified TID. However, it currently passes peer->rx_tid instead of the
entry corresponding to params->tid.

Since peer->rx_tid is an array, this decays to a pointer to the first
element, effectively operating on TID 0 regardless of the TID in the
DELBA request. As a result, the BA session for TID 0 is stopped while
the intended TID remains active.

This leads to incorrect BA session state and may significantly reduce
RX throughput, as traffic that should use aggregation falls back to a
BA window size of 1 on TID 0.

Fix this by passing the correct TID entry:
  &peer->rx_tid[params->tid]

Fixes: fe201947f8bd ("ath11k: update bawindow size in delba process")
Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b9e976ddcbbf..8db04c38dfba 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1132,7 +1132,7 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 		return 0;
 	}
 
-	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath11k_peer_rx_tid_reo_update(ar, peer, &peer->rx_tid[params->tid], 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
 	if (ret) {
 		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
-- 
2.43.0


