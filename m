Return-Path: <linux-wireless+bounces-38071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iFhQDnKUPGpUpggAu9opvQ
	(envelope-from <linux-wireless+bounces-38071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 04:37:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD46C2693
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 04:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ePtYT9OS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38071-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38071-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7832730292DE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D230D3FB;
	Thu, 25 Jun 2026 02:37:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95B202C48
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 02:37:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355054; cv=none; b=RuijGrTI5IlBQ4y+pLzl+oAm3N70N39yw5QKnQaetSsn6eCblkzKIJtpIopLm9xHurNISobrXii0s0ZDIGSIU9aRSUjN0uSjJHI0wjQgFdrOaZY/cjKYYVUND23p75XnzfH+8YMzJQAYh0RoqVbV/sH16Xwr105WZj/Uu22Sy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355054; c=relaxed/simple;
	bh=VHxlxuQvJlNA0UWoVIyaXIelcSlBdqlwTsdrQ2MJzzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/eFEp+mCAT2JSuwCyJ+arRv7fpcl6lSiIsqz5koOEhP4RCWrujLxkN8kq6iSxPzrbZ6dABCRIO3NpWWXFwqrnkp+sDCD6xrgPVLjxyzSdKmnYqUue95oRQbAToOzJQwlVSQqpNLcLKEnaHPsf2A1h21DSvnrBK0cpt7Zdjedk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePtYT9OS; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7ee3952f2so4290605ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 19:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782355052; x=1782959852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbYdrtiz0S1qZwSlV7SlhIGyN4CrZOKaqjvP5DOs/o=;
        b=ePtYT9OSd/85ANMkm08LPUdJyfFkeHZpX0g4UfPPw8J83CWbsTRi6KJXTxDgvdishC
         2lJ6Yf7TD6X3Ozym8I9nKOrTA1+Gn2otNlKUTHxXUK24n4JTSRVSZFCFLgref9oWbaGD
         ezlR3+/1znhIG3itbL4CfCpAljJ9mR7zSAARoS7z+stJ9ba4UnnybrFhKRyZQfNULw9s
         7J2tf7j8+s3o4Ohn0X/kNMkRMNFXK5+DH0x9Bb8jcq3+SMeyPYtdcRupuGDkVY+KGHxC
         GrbfbNR6zczPNoOVc30V5wAkUmTDQiwqud6Fx7jz5TTA6vGiL/rpI+dF+2lwyDOPI6ZM
         jdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782355052; x=1782959852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RbYdrtiz0S1qZwSlV7SlhIGyN4CrZOKaqjvP5DOs/o=;
        b=GCf0Fdhnwe4G5mTs2fCiMgFyuHN4PhptS4iewvFF3kOTZ+xpkyIy0Je/8FLOFMv9qP
         PcaPAuPAbkWUB36CwdNZ2qHth6BoGfmkcPGCXzGnn7KkuT8lRkn4n8zjF6POwAex9PgN
         4F/cg4qAArcO9KRv4VLr4r0RoskdI7C/4u0GH+d5qHobcG9lXWQn4Qm9GBMciZnkQ+XP
         hPJeDlraO2dphsiHT6Y0aWxJ5KCTWrXS4BGx3IiQj8H5clgHbm59/QI9/iNcBciDUA/p
         cK21SjMy6xXWo9Cu33mg0qyS7jgzdRWOegXZ+gs8A4WakM9+oPDnmMt9a0EH1qGwONHv
         3e2g==
X-Gm-Message-State: AOJu0Yx6aD3c2zaTcFKbndV0Qooq8Q3nFZAaG3S1UsB80KZJx9gE6ALV
	GIGBrXoo6RzZGytqtRAFf2Ee3P5NhZoBjWFbiPbHJ+jt3hbTUI609lJZNWnJgg==
X-Gm-Gg: AfdE7cnwFLNKzG8Ktuz7rhXl8hbDpfOc0mpHcJtIIEDdhjNrQM+Moc4IGT9h31Hi6Ir
	mZjI2hHDRnmgV+11zgqsZphiWEP2Za1XyarL5hnKxnjMWPQkqMwFVP1JkSU74YSH8f8XnjMXvTI
	X0TH2iI3paG3iOMXp2Jqd0dof5svDQuWGQpIrcMwoY1o4Yi+V6LBcu1fm+tONUhqhZ6HTERbql2
	U3U4bdeErbRKhk7aPB3z0zSdF1G4hmg8NoevgDaDzR7NtR9dM333RG2ut0Z9wRkKwI8h78WuOpU
	Le6TZJyj3cYD79AYtGl0dj1qtkpPilfr8fIAu3ZksIcQSlZz0PB64MvtjRazC1JeG0Vq8vLc/Sw
	NbRfyvOnykrL64xGOBu8DsIBFHTmgYKwYyPA6K4i19srO5BTSowup2gJejY0p9tuCpQcdXfd5wT
	1cnW9QIObqje/w2lwrPsscvg5ejp7mxA3B9Fo3VyjM24wdSiJOz9M+HnqOA48xeaBXpXBVVUMgK
	UQJYe1TZw==
X-Received: by 2002:a17:902:e54d:b0:2c6:c9e0:2c15 with SMTP id d9443c01a7336-2c7fc74c0c3mr8282565ad.22.1782355052349;
        Wed, 24 Jun 2026 19:37:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:5b5d::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8c26sm9283685ad.1.2026.06.24.19.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:37:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] ath9k: return ath_buf to pool on A-MPDU subframe retry
Date: Wed, 24 Jun 2026 19:37:30 -0700
Message-ID: <20260625023730.345134-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38071-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91AD46C2693

When an A-MPDU subframe needs retransmission, its ath_buf descriptor was
moved to a local bf_head list that went out of scope without returning
the buffer to the free pool (sc->tx.txbuf). This progressively depletes
the 512-entry TX buffer pool under normal retransmission conditions,
eventually stalling all TX.

Unmap the DMA mapping (a new one will be created on retry), clear the
buffer references, and return it to the pool via ath_tx_return_buffer.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 57e451548958..350eed276cc0 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -665,6 +665,15 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 			 * queue to retain ordering
 			 */
 			__skb_queue_tail(&bf_pending, skb);
+
+			if (!list_empty(&bf_head)) {
+				dma_unmap_single(sc->dev, bf->bf_buf_addr,
+						 skb->len, DMA_TO_DEVICE);
+				bf->bf_buf_addr = 0;
+				bf->bf_mpdu = NULL;
+				list_del(&bf->list);
+				ath_tx_return_buffer(sc, bf);
+			}
 		}

 		bf = bf_next;
--
2.54.0


