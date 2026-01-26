Return-Path: <linux-wireless+bounces-31182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHkNLlamd2lrjwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:37:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7F8B8EE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D893012C76
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD872D73A0;
	Mon, 26 Jan 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="okMjlXvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDA168BD
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449044; cv=none; b=kWi0qPvaeTNr/toRcX8feixAfzXzigaOtlxaoEO7uXwP8PlaE1OG+JSPI73Mva3goRY823L58g7SbPy7KV4xcCARxuSx61pzAEKMLl7ZRg1xMh2MpAOVrSdvt19ZcMXcuWKe4ELItZj71YRZCBeNhyzgSNaAchcJUQc2IKv4Xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449044; c=relaxed/simple;
	bh=M6J026tyN0+1bI8lGoGlBhu3u/gOkyqHd7YIftHSJ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8LfbPmYvH9CrGOfjgxX1rrvG+xjahN0nT0uH8y4MJZaRJM94la4Bwgff7DfLiBrYZiCQNa8p5A+V7RwjGm4GGDCuwHhpFvK5SaFG1eLp9DqUyql+aaXuq+gHm0UO7zV2vWbYFWHPgwBCdrvD/KUFLgATNoSb0OdUI45LmJZILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=okMjlXvw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-432d2670932so4407675f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769449040; x=1770053840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXET+yKR11nAsd6NXzgFkGpzSC8xPOk/Tq9mMH8TKLY=;
        b=okMjlXvwm9+8RfmTXZPCXN0NDtKHsfinzWfCSmTt4FixxpPEFoIv3m/UmQoJYH8des
         EgLMRAaVZ9+Sl9FSQ/Jxkn7f90UfDbJxw6C/8ttizSstHN/K5WV9gA5K8TC0jBh5VWgI
         y0QsnZWQCOPnMTWS24aaDjhv3Q6wMmgnbqqF82T+raZikiGuruRdO5BD8J8EUjPD7vaT
         E+yKG8TQ3DtPSF2hha2ZPybRchK3uX+TJhWwBaE+laNuSd2JcfUzDtdGWlk3cPfwB5Oz
         sfpt5EPjmcPhsEJhfK7uPtOYKdES83XVcrSGj8J2MEdd7np70hGuO5ppOvhF9sibM8ZD
         3HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449040; x=1770053840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXET+yKR11nAsd6NXzgFkGpzSC8xPOk/Tq9mMH8TKLY=;
        b=AtHgTvqBJf4YmQgpN8zumaT0M6WAbCHReTDGDcpACYMULwHkHiQSbCuLT2rG5YTf2o
         3FWRHxuj7OJqWnpoorbKOqJXiOLReQzL6titmTDmkl40m4xCeWBIwIqtp1Q3FMSkAB4I
         aQC1dC71AKbNlASSanKLEDcT/2L/SicK8xBvhMRlPO77pxF8998pAIljzNxnXfnCe2BR
         INvYqjbXuuiGoUVXu2WEWIK3tQyOJm8gzD8GcUCnUFuTcRGhr0cnlY26mNX3zsi97va2
         dzT7y6L3fFBWGtCvqda9Aqm59fJbZb0WGFRes8MiUgmvbmKZ00UIIjGjy7eiqpkGG2yc
         qIVQ==
X-Gm-Message-State: AOJu0Yx874zMLR0xZ42UySSxYqW8b0zqMPiVNz/Q1MUOBM4vE5YNg33E
	2w4NK76b39HoDYyViV7Z9JQ0oqS1bHPlSOJEgHc4nbpF4u9HyMOhCbAZkIQoQnQ1ZQ8=
X-Gm-Gg: AZuq6aID75s/3+OwDlr3Int5bxV4U2AK2umWhghAdexDI+mW6P4pMP/RwrilhXAHuMv
	d2/jt3D/Ud+Hxf+s7fXBfzaw5HkQjnzLvOh8OK6KVYXqztbnOteHo4T7KUHrQerqQTS3Kf/2Y2i
	tMBy1XOfDpJhhWcRibH711kX2otQMdABtPPcOYCol9gnPVa+E1dIiETqVtP34TzEcfmoPAcifpZ
	op5sh1cOC+cMrJvhY2Vqe3VgHexOjUbYO17BeAnN4ap4ExCZo4+ePjchkkc86cI/NzfNEkZNNeO
	3ZdqyUF1YYo5wtdxZ+qhtVRNWcij5OwsZEYzHdI/d+YuUiI1qPHWdCDQZ1XWILhRHgFsjtEFHjg
	qBjjSbXbIfnz5FOq79iQ10+/T3smu1DJ01oBvL+G2/KKIMaEaDxYrvE+t2kYhCNLuJHWbO77US7
	QMamAJpUkF0oStA2c7HvxM4lHFHhYBxI4SH5lN1kVohHYV3sn3H5INIMATx118VvsRHra+
X-Received: by 2002:a05:6000:26c1:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-435ca1aa92dmr8226709f8f.47.1769449039905;
        Mon, 26 Jan 2026 09:37:19 -0800 (PST)
Received: from pablomg-ThinkStation-P620.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm31558460f8f.12.2026.01.26.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:37:19 -0800 (PST)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: ath12k@lists.infradead.org,
	jeff.johnson@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH ath-current v2] wifi: ath12k: fix wrong TID passed when stopping AMPDU session
Date: Mon, 26 Jan 2026 18:36:54 +0100
Message-ID: <20260126173655.1369715-1-pmartin-gomez@freebox.fr>
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
	TAGGED_FROM(0.00)[bounces-31182-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:mid,freebox.fr:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CD7F8B8EE
X-Rspamd-Action: no action

When handling a DELBA request, ath12k_dp_rx_ampdu_stop() calls
ath12k_peer_rx_tid_reo_update() to tear down the BA session for the
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

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d28d8ffec0f8..f2327c82953b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1289,7 +1289,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 		return 0;
 	}
 
-	ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath12k_peer_rx_tid_reo_update(ar, peer, &peer->rx_tid[params->tid], 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
 	if (ret) {
 		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
-- 
2.43.0


