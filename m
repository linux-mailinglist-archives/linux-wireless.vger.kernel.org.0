Return-Path: <linux-wireless+bounces-38108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1y3wFsz8PWoM+AgAu9opvQ
	(envelope-from <linux-wireless+bounces-38108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:15:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CE6CA124
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:15:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J0dSl2v5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38108-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38108-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB6930722F1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 04:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537A384CE4;
	Fri, 26 Jun 2026 04:10:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5239768F
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 04:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447017; cv=none; b=isKZxLTVnP/gDdNP5N5ZNs3x3KHMkIUJke+E5fRDTb7FPJ3xPf9iM7CbPTchqXnCqSLAbpmE7ABKoty8TYK5SDJ5S1tDQL/WZlEWDOCNjYk92cqwp1varUCkIJ8k5gPbg5PiyCnlZ8c3iGRhnDTtPVTaw1EAyp2fROTNR3d3FXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447017; c=relaxed/simple;
	bh=Z7PEm0588yWqu+t0ZOme97u5bbYjfelGlCrcrE8324M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=av+XJ20S5q7zlgtahL1qbXiXGdvodg/TX8QrYwwx+RydPdEpGXrD9w54b/UEjzbXH/7BlpQKAZNgYHBwtoZ572uRtZv9nNk+EymRByNlawuBqvL5ytZuaHx4R8rLmU/5xtGj+0wTIu0F5O5Eb5RsMiQbIJCvDixHZ5OV4/sH9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0dSl2v5; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842358aaf36so204718b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 21:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782447015; x=1783051815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VajJu/wk8wk7RNe/rjqp2e4ZKVCEWthZPhYfYg7pOE=;
        b=J0dSl2v5TfM5TBZ4W0/Wn8rVdcDRRuQ9LwgXS2uIIHoIpBPF7CpPCXgrko0v3K1NAZ
         2fYBNmmB0t0X2+2xySB9mRMFbiJQxJ/hoznYLRQ8+Rkfop939/nAHmJ3dkMj/S9z9GeS
         V0kH4IeET4anibbH9pzi2Y+brSzHoW4Kl9G2zlClYn1/wQUpMryh1LAhgowTug9A63Fn
         veuGxMoBCkaDcqu22p+ZPGQ4uHOOF0dZYF+6mvDqWEBhC3/9uEK9ed86R7JJBJRu9EP7
         4Pd7RgUPg6wCFt9BSl9viJ86QJzghqJwdHSHTu2hGeEVLzErvakLS0spdi3OvU/OsMJp
         /FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782447015; x=1783051815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VajJu/wk8wk7RNe/rjqp2e4ZKVCEWthZPhYfYg7pOE=;
        b=NOYgssEcP1USFAg6n/aFsQEEuHZqgtGh0E3rbAVRv4UdO78awojIfX1YY4bWVz6gyC
         nOE5bxuy4V4YSHIwBwk1JkIfmlEqbllMQwzttF4XrDvwqkWEW8BDNSol4UoaR8X/plbY
         gl2I/+w1O1Xt2W+QoTZwtCfnvZLC/7cULdCiNnvK5sqS/8uXcQGWR8M8NVyPwt/iFLQs
         J2nEFQDakLDADCCn2aO5Dc5xGK85X/fJVceWt3eXbEKSvrikKuJd3OY100nzNFfH1kBO
         /xQGvKS43GlyB26fPppR3XWiVuwgNF5Jm7WiDi32m5aqOA0MAwcRy1IHhoFhsg73lF1t
         GDpw==
X-Gm-Message-State: AOJu0YwGaWAMP5Ks002L3hkRc3/GWn192S1olqufNJ+7YqmEa0hQg1lZ
	+EPQIVZFaQ+fXpdJ8PmuILnULJJjw6kPV6eq3t3ItXZOGha9Xf2xMV+zJt606Q==
X-Gm-Gg: AfdE7cmzCjoHM1rMhOlKuD5Y+JBDKTcYn/WSKq0CoVNwJzT8JUcI47z/dJFOD+HYWa6
	CIwaI2nxwe/bjj3uhm3F0p4ttjPzwzpIOiaGMjDfaaVy6N3eL0la9v1RjyXTauxBuDQKBNDyLav
	H6EWhZdUk91QS4theNDXKwUsqLclQYEN2gnpA8DfiUicNZth7SRLuy4TP2JdNIizOoSwjaQSO+c
	/q0CLDKmtj6K0ne+FmSN2aKYmOUfugn5KUVnH4hfY+b/2WouGfo7yASUfsw0+aIXQzpCfwQp85j
	5/G1KealJFzzoSBmSQoMFp0Acqah6fCnBPeqW7IP9c+Doiz/i5oul+ZGzwKuCDmnyUbgQmXGXNk
	3lPFUAZNGn3VOmptqeS7p/yikIDpcZGy7GFSnCPWfGP2EZz8TtBDKOQ9swJifJRU0FWK2RU53bZ
	0S5hplA+l9SOdEAIgpYxcnt0b0aWb/N9hA72vJKNwjBh3qsVZiv/ppmwXhCTBpzt9J9kXrxwZkx
	wjbaVu4GBr2MIH5XmXm
X-Received: by 2002:a05:6a00:1382:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-845b39a255cmr7441406b3a.7.1782447014981;
        Thu, 25 Jun 2026 21:10:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:5b5d::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40f05f9sm5876961b3a.42.2026.06.25.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 21:10:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath9k: return ath_buf to pool on A-MPDU subframe retry
Date: Thu, 25 Jun 2026 21:10:13 -0700
Message-ID: <20260626041013.859834-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38108-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF4CE6CA124

When an A-MPDU subframe needs retransmission, its ath_buf descriptor was
moved to a local bf_head list that went out of scope without returning
the buffer to the free pool (sc->tx.txbuf). This progressively depletes
the 512-entry TX buffer pool under normal retransmission conditions,
eventually stalling all TX.

Unmap the DMA mapping (a new one will be created on retry), clear the
buffer references including fi->bf to prevent reuse of the freed
descriptor on retry, and return it to the pool via ath_tx_return_buffer.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: set fi-bf to NULL.
 drivers/net/wireless/ath/ath9k/xmit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 3334f570be50..31187753a819 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -665,6 +665,16 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 			 * queue to retain ordering
 			 */
 			__skb_queue_tail(&bf_pending, skb);
+
+			if (!list_empty(&bf_head)) {
+				dma_unmap_single(sc->dev, bf->bf_buf_addr,
+						 skb->len, DMA_TO_DEVICE);
+				bf->bf_buf_addr = 0;
+				bf->bf_mpdu = NULL;
+				fi->bf = NULL;
+				list_del(&bf->list);
+				ath_tx_return_buffer(sc, bf);
+			}
 		}

 		bf = bf_next;
--
2.54.0


