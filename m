Return-Path: <linux-wireless+bounces-32805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNztNbKFr2lvaAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:45:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339112444C8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B939730500E0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DD39900E;
	Tue, 10 Mar 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUVUxvjI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B03A961F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110703; cv=none; b=D6yHG+tcvnaZ5rydDvQlOOq6P2HjJ/bjYfd3A5SVaxrTCkHx2MONRlFljYRUTAzNpRnA+1pIJJ3GXgv92Kl8Bhh5KwUD9TTA/p27+w/WOIYsh71yuwvEpgfn+WLN9sR29w3NcUX5LybK5+IXZL9ng6tFySSyoQ8k96cSeVfoLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110703; c=relaxed/simple;
	bh=NrhFoEUS4s5magNSiO6aI8PRbcPWRr/xNciVIxz9CFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzeJrM0FXsgOU5sC96Avj4zW4NTwnJ9ckmFlkvge5323wBFsMLdfITC+Mg0IHPj7VTygu1fV6u1XfI3wRLFW7uGlCLG+ia7vjFqaTxnIrlL1F482ZGrRI4AL+MI1zjuUXmliUlBB/X3zi++Ys+8TUMSAM6SVSfGeskjIZOqWi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUVUxvjI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso6660759a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773110702; x=1773715502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOboup7oLRUcKhmnSCiuT0y1k3/298+wfQJlrTpRp68=;
        b=MUVUxvjI5Eg8uIeFnC5pF45jmSlIRzicpoA8JzQBKGm/f3S7PLJl4JvALX/AJyiOy/
         pyLcceYgFK56XBIn0Tgfhto523mrf+1Lvnr0wC77M2RlH9YpVsdl1d0tFyFDMZtMRfg+
         9TdqlGAJRXpFPHl7eCRQdaeQEn40XPk8EgjNeMdQIjL9E5sFNiyMiqQ5CbJj2M9/LKF3
         Wg7oFI9r9IfgWLGRCgP8hbffN2n0+XpkSB71WzYfUEwKSduoyD2yrQtN+PKsLIuiM9ay
         Ew5iUG8SuKXQtLOQ8kobdkzvM3wXaHmHkYaUjo1P2xGK0pPpSiLPvs82u33tfM0JrWA/
         KmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773110702; x=1773715502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOboup7oLRUcKhmnSCiuT0y1k3/298+wfQJlrTpRp68=;
        b=EYsd+k3cWebsyF7tIEyg4ZRfjlk+vsP3yKUgvlDGYGUSf8xVqYtdrNIK/xQvVYQbfd
         OZ7WrR0MTU2ceRudgl6MaDjyA2n/G4AHHQKxC9cwJVbSXEoRw4cLfSZJRIlrPlTLKOlN
         vQh5Q/plx+xuiiWr5InkfDwRzTvZDTNRVu27HXAmWe9xNFFY7xa9Ffv57oILkU6QCJoy
         phZqsv6xEZc3zrTm9jFDr1Vye+YrxghBuC4Led3VlptPP7iIbth9suE+5saZZqx2Ixbu
         FNP2m2mIAN37o6dECGs924yqRLxTTVuacs2ZiSbI5Yn/rjSVMCbvB2gB8Go+YIgD0vRa
         rKBw==
X-Forwarded-Encrypted: i=1; AJvYcCVBbi35ctJO8kqd1s0XjUkj39RLXOhCHf4uNAZXWfbOyIij9WI60EM43l2YoiWFd1LZZVCZwQDQP5hxY3pZgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87E35b+1HNZcsvabwxsDM6HuijPeANv5dMvkbo+sC/C5giL2i
	iJKKFZBXYZKPJOvb2zMnmeq9IfWUqABpIKyOODGEbGhFQPOBX8uMIOPD
X-Gm-Gg: ATEYQzwOZ6mKwaHtG5s02C3DSpiy7ZGMKv7dtVnaJ3e+sVXC+g+mq0BIYsXZSs0fb0S
	/0t2scBVtN8sXLWs5q1YfvVAtwA/jvpUX1c0c7fHSITR85RTbTx4ckMnCDt0Ltrl6XUvC1m6+Qe
	Ran+wFFO4i9dal1lyN+n7UiS9TqcjxWtijIO2Kg2FlO8+wnMSC6LT80oA+Bb2EphxohgkRPyOYp
	rDuAqNoOtcrpVwOUFpSjD6cd0LPOhRSDbk90lHruA/zgozTEHaEiz4Ew/SE7eq2lBKVyLMaauTo
	Grkxf5yLSoDfy2zmGtOZFacVr6PWEcdsDCxEehEtsYTWEZNtrE0OCqBkjvCalCROmjG90YXL5QA
	rkrVKOGtw/ULugSmd08kW6fEwvw597+IQNp+qDvRwX8jG4vx4dWdDubnwyKquAKZINrBaGtLHoy
	xekuQbCskR5rYaK8pORBHf4979sKjrjpi2lJfd22fFDjMaSdekymwyLrw=
X-Received: by 2002:a17:90b:1848:b0:359:7a1f:1b83 with SMTP id 98e67ed59e1d1-359be34da3dmr12193517a91.26.1773110701749;
        Mon, 09 Mar 2026 19:45:01 -0700 (PDT)
Received: from localhost.localdomain ([119.204.109.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bcbc6fe9sm4781365a91.12.2026.03.09.19.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:45:01 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: jjohnson@kernel.org
Cc: quic_srirrama@quicinc.com,
	quic_ramess@quicinc.com,
	kvalo@kernel.org,
	stable@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH] wifi: ath12k: fix use-after-free of arvif in assign_vif_chanctx()
Date: Tue, 10 Mar 2026 11:43:05 +0900
Message-ID: <20260310024305.555408-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 339112444C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[quicinc.com,kernel.org,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-32805-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

In ath12k_mac_op_assign_vif_chanctx(), arvif is obtained from
ath12k_mac_assign_link_vif() and then passed to
ath12k_mac_assign_vif_to_vdev(). Inside that function, when the
target radio (ar) differs from arvif->ar (multi-radio configuration),
the old arvif is freed via ath12k_mac_unassign_link_vif() -> kfree()
and a new one is allocated internally. However, only the ar pointer
is returned to the caller — the caller's arvif still points to the
freed memory.

The caller then continues to dereference this stale arvif pointer
at multiple locations (arvif->vdev_id, arvif->punct_bitmap,
arvif->is_started, etc.), resulting in a use-after-free.

Fix this by re-fetching arvif from ahvif->link[link_id] after
ath12k_mac_assign_vif_to_vdev() returns, since the link pointer
is always updated when a new arvif is assigned.

Fixes: 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b253d1e3f405..ee44a8b59e9b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12069,6 +12069,17 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
+	/* ath12k_mac_assign_vif_to_vdev() may free and reassign arvif
+	 * internally when switching radios (ar != arvif->ar). Refresh
+	 * arvif from ahvif->link[].
+	 */
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	if (!arvif) {
+		ath12k_hw_warn(ah, "failed to get arvif for link %u after vdev assignment",
+			       link_id);
+		return -ENOENT;
+	}
+
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
-- 
2.43.0


