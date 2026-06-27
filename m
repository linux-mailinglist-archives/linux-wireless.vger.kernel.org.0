Return-Path: <linux-wireless+bounces-38211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gKAfAZM/QGqFeAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 23:24:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C366D2B3F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 23:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AweJms17;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38211-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38211-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C063008238
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACA37DEB6;
	Sat, 27 Jun 2026 21:24:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2B2DC334
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 21:24:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595463; cv=none; b=GwLsw6IvZv5ti+lWDDBSgHghgqcBVbU9SrWxRF/rFzx6iRLc3D9H2l0LpKFPc1ZI/hnUS3oRecRDGxcvPBis3u3T+T0bHq3nnLlvNfD9bww28KEpQnkBCE3wGWH5xfChIqZ5XMAXGnAv36fMMmO8FE5DglWnguydE3lFHkp6wDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595463; c=relaxed/simple;
	bh=IUyoAwh6Lj6kLlHT6+22O+dIusg/oxs3tvggN0o137o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fatYUazUhGMiLCYtaAmzm3k+K7V4+eAO12hSeNRAAnxrkoVn6zythVBlNBDG/sjP8oPxN38jUFcuFE8djNF94eMWO4wDo4dD8DVHqawdFmTVjazNEzgSGTzTctXsAmGGB6KcfZHbrW1mnPzMT1Z4jHadpsuQZs+AWs0vnMKNlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AweJms17; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c82da9504cso5101345ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782595461; x=1783200261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igs8wchjNfL4A9LCwiFhYRNoXyP6j1PwR4BSWRj01Xo=;
        b=AweJms17w8pBg2w0PoglWG450jNzq+e2J21JVgWQyLLx/X4OBgM7jH24wQS5uTmZP7
         7QkN4FfHNobhXdYoTGHJmDsau5Zds5H/BqFL6XUhCed1xg1rEQ+B3cF0Frd8xTBSsNzP
         MxAFC8Nt+hemxlvCs42zqznIPwXgTgc3g4vAXnEnYHJQYXXkrRarVNfI84kPadpfWcBo
         EE4WueJprkj2dXAbUKROv/67pOY4KgfBBw7fuG2BYGL0UJUK8maflt1UiDzi5wI9cEFy
         TFDdyQl7BB9g54hIhV9KVpdDaPK+jgh/47dn3Sr9OYizMfwDbmtj2PIYaJAtoH9KiCfM
         4idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782595461; x=1783200261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igs8wchjNfL4A9LCwiFhYRNoXyP6j1PwR4BSWRj01Xo=;
        b=c/uAqtORT0U0G4kz3AfaXPhn8EmiqOLVdepsKWCJZpU/xiPDKx7ZR4ij2w8kTeePZO
         BEkJHMxkSfb6+Iw1nzaU70nAkX0YStRSN98/C+IqP8w8AC1HI9+8imSdaAINX+aa1VXe
         9Za/lAzY8UUICGNEw5kZ+BkmGwuNRFJ6oOjsGDww0w+bx1Hvmr/ebeOA6cw6SLeAVmdo
         qjrv+gAyEMgQpljJGK5AQgczpVkk7RKV5EMUvYdrGe5UYnSsHUx7USmfJBFCx4vNDEHH
         d2/UR1Doec+IQ6tSOWV+F99CX05Ax5XrCVRGzH2m2Q4L1XlWypvFNUI/MUZOlvHMS8L/
         S2Nw==
X-Gm-Message-State: AOJu0YzWM+QvMlrHDBebAs7HDJ3yO/HDHmJXWEDSlUDYeJ0YsWXavHT5
	gutShu5wGd9QT5v686up1v+FHTgrcmtroaGuSM9aVHNmjgyBTMNmMzC4SILK3Q==
X-Gm-Gg: AfdE7cmfECRC5HX4hKwGQYsLKl4UeKAYSXdL9UAOKj7b9fW4BgUuZqdGcKYGxI5P799
	mgqpbAfIS5wjxO801hGAoeqzIgmWELPsrZ+sGP7RKFSA7bG5W0dL1ct/RzYeCD37sQ6n5rNRv4F
	KkI5jIID4a1vz/Jw0ZWZ9O/OBBr+/m494gt7Z9J3EpiR5MRZmOGV5KyS/1yckSmAr5faP+Oxr2z
	SVQmKB28FDTtKty+446ST/FWrxnx+i31ek9dbxZa5vyxOvR9VSvDo8cIyIQpGuDvzpuJbEplRE0
	xXr5GchkauMli0rBK7FDjvKMI//Oh3TPixtC+58e/ONDYoGAdtMETTSYfGu25zH5xzpxPI/r9bx
	AX+E9hg2siI6ZbPUU8YNuZqxts0kNaI2lMx8ausQljvVjRy4c6LzZudQS9bezBN/xHUhzDy/EEn
	EfxutX1QcqPQjSqGg1PY2MKXtwTFNyNTCvlyFJY1QSQ5Vc8wy/ssX6//r+LSTcdoGuH40VOKvfl
	/sF32ufpQ==
X-Received: by 2002:a17:903:1b4b:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2c9854c82dbmr46250585ad.15.1782595460956;
        Sat, 27 Jun 2026 14:24:20 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8988sm63753185ad.15.2026.06.27.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:24:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 ath-next] wifi: ath9k: fix stale list pointers on A-MPDU subframe retry
Date: Sat, 27 Jun 2026 14:24:17 -0700
Message-ID: <20260627212417.448046-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38211-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58C366D2B3F

In ath_tx_complete_aggr(), subframes that need retransmission are moved
to the local bf_head list via list_move_tail() For retry frames
(txpending), the skb is requeued to bf_pending, but bf_head goes out of
scope at the end of the loop iteration, leaving bf->list pointing to freed
stack memory.  On retry, the buffer is recovered via fi->bf in
ath_tx_get_tid_subframe(), and list_add_tail() in ath_tx_form_aggr()
overwrites the stale pointers harmlessly, so there is no leak, but the
stale pointer is technically a use-after-scope bug.

Fix by calling list_del_init() to cleanly remove the buffer from the
dead bf_head and reinitialize its list pointers before the iteration
ends.  Do not unmap DMA, do not clear fi->bf, and do not return the
buffer to the pool - the buffer is needed on retry with the original
sequence number to keep the Block Ack window consistent.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: simplify to just delete. No need for handling others.
 v2: set fi-bf to NULL.
 drivers/net/wireless/ath/ath9k/xmit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 7e134dd8b8c8..adb3af1b43d4 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -667,6 +667,9 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 			 * queue to retain ordering
 			 */
 			__skb_queue_tail(&bf_pending, skb);
+
+			if (!list_empty(&bf_head))
+				list_del_init(&bf->list);
 		}
 
 		bf = bf_next;
-- 
2.54.0


