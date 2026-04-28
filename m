Return-Path: <linux-wireless+bounces-35510-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM3lFhEJ8WmqcAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35510-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:22:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376848B197
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27EB83003808
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B82609E3;
	Tue, 28 Apr 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCQYeByc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE211A3172
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404166; cv=none; b=ckg68e3ogO9OmPlkCJspg2H308cqHcKYZ1oqIrtcW4ONR/87v9E9FJK6+DY6+y+S4XqP+DG6sTuJeqyj+VcQvZe6M9P5GOHMrrWTBQlM1wP1BO/SjdCKEttlT0i0BPa2dGcCpawEilyzy7qqo6RF0qz1KWkBqotQ6tZ0wQaiomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404166; c=relaxed/simple;
	bh=DNmkoghZjVTctfRNGf+Fqmv94CgZfAtFChrcpbdwVYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfXoPkAain8Fr1Y2rN1SVc07bwvy2PrieovOG8sTkzjvRMKJhSodSKnY8sbunB+qv1DioYW2CqhuyW6ZKIZQ0Bx95hD4OxCw0ke/t8haukJfENbjKA7mbDXMfEbq09zdgHWcxQ74M1q8H5YuqU5qr/2bdzDXvJbgz9Q4CfZZQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCQYeByc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b7adb38d65so54703765ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777404164; x=1778008964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRBTVtb7VHeglAHXqHrDRxqCIft9Mc07dM462EhUPT8=;
        b=sCQYeBycTuonLjK7eSR/93dDU1bnbL2bwh/ikAkzenKi6ffO/TYy38zCdTqZQtdJBE
         226Fw5TqziytaLnIcGqxgj/6b+xbd9Pu/zvRiQhAkDGmwUPt817UApCvG9A04DMsTPdb
         cr5syGJ7BDRye8cUesDHce46AqQEQBdb6ykc8zSkEI9IdfI6cW7WAJI2wrcsxe5Hoe4h
         h6SfqB0CHjH1izF2SgKhNOnglBylP953NcIlzcykTH456/q0f4ap6rbZyCSP+zKxZPE/
         uhZpriopSFhZsQb0gXNMZj+YMPlsMvTk1BvWudPsfAGbpdHDAfRLMgbUvGT8nGKq04J0
         uDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404164; x=1778008964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRBTVtb7VHeglAHXqHrDRxqCIft9Mc07dM462EhUPT8=;
        b=GBQmh/H/95fTcGsZBG3xidRpjBe5dT5L4Hiz8Is5SxLEtTHSKD01uDwMmOeM3mZXG6
         77l+zHONOwuIOWWL4QJn39Pjd1hxe3TrfZQzLqMjt/+c4QYbj0ped4QC98EpSkWFAFOC
         YPFVjtFVkCl6nSyPD/nH1cK5tJL9P1k9e6yJd6GxRZfAOvN28r/40/0kIK+tHF+lWd04
         cY1f43Il/TmznKCVFooR0GIW7oUCC2hFTfh7mDXrfA/jOqusz8zINBX0ESWHK9p80cxh
         tJKj3rZiWglQdYTYsD0GygtTwdJ5QA+kXycWe/OrREC2X/3Nike6RMrLz1u797PDxbPV
         1q7A==
X-Forwarded-Encrypted: i=1; AFNElJ9beRSOqLQ0Dr4IZGavsAcJoVU06b/+AZ9Is7Zg0hLQY8fDt2UjM4dISE2ECA0lR6ufus5SYAgdt1wvnlyRDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VYZ5HEuPlmSPAF1V2ZU3Z8EGtqBUoxY2gcd7842r6zWSQMu3
	QhCKJ3raZYDUqtqgWELWGQqPl8zf6NdNGI4u3hekIhc2NQGX8s0Ykjm5
X-Gm-Gg: AeBDies3utHXz2oYX0FJ1MJJT+NNqYFGUQSvBGrpbalGQRclEl/I/8W5S+a7FYm9w4S
	inYDzbpn9+cJuPPzEf8Ts/6l6JMaig5hXUYIdCkjjuYNqhyHjN3BhbXdXnIMFqRBehjqe6MZdUq
	j3W9cB0GneGgot2/dpSpxDsng35Q+p3KrpS7y6E79WBEJ4JzNGROLxYVpLWpk7ba9kTMJOTzYT5
	oXyLoJB2fR29gdO9ZjlWmixFCUeoZgqUHtYzaQB6yc3o/EFbeE23r8+WAeuaBXkYa9TkMi0cR9U
	GlnPMS9ZDd8cG4Yjo2uWhJiLt87UTVtH/sxPwewPNhXRI/faYb0CXgCutzokoxphMuOCZRD1Dys
	mH6wndn5vOzGa/VUfRprGCx/K2noN12Q0otmH6IwFPZoRKS+0VgRcB3WjqBT5K0addM1rp2mMe7
	4+u4sbgY8IYhWADXFhDEKEO/UO7raRbMX/fff11SrztlHXsWl6
X-Received: by 2002:a17:902:f90d:b0:2b2:4ded:954e with SMTP id d9443c01a7336-2b97c4624f4mr28534005ad.24.1777404164217;
        Tue, 28 Apr 2026 12:22:44 -0700 (PDT)
Received: from ideapad.. ([2401:4900:881c:789e:c457:196:87e5:7368])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc29b1fd5sm3885467a12.9.2026.04.28.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:22:43 -0700 (PDT)
From: Ankit Dange <ankitdange37@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	ankitdange37@gmail.com
Subject: [PATCH] wifi: mt76: mt7915: fix GENMASK for chain 3 RSSI in mt7915_mac_sta_poll()
Date: Wed, 29 Apr 2026 00:52:28 +0530
Message-ID: <20260428192228.144654-1-ankitdange37@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8376848B197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35510-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankitdange37@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The RCPI values of response frames are stored as four consecutive
bytes in WTBL DW30. The bitmask for extracting chain 3 RCPI uses
GENMASK(31, 14) which is an 18-bit field overlapping with chains 1
and 2. Fix it to GENMASK(31, 24) to correctly extract the 8-bit
RCPI value for chain 3.

On devices with fewer than 4 antenna chains this bug is masked
because mt76_rx_signal() skips chains not present in antenna_mask.
On 4x4 configurations the corrupted chain 3 value feeds into the
combined ACK signal strength calculation.

Tested on Yuncore AX820 (MT7915, 2x2) by reading raw DW30 register
values and comparing FIELD_GET results for both masks. With
GENMASK(31, 14), chain 3 produces garbage values (e.g., -112 dBm
from a register value of 0xFFFF4248 where the correct result is
+17, indicating an unused chain). No regression on 2x2 operation.

Fixes: 94b335fa88e1 ("wifi: mt76: mt7915: add ack signal support")
Signed-off-by: Ankit Dange <ankitdange37@gmail.com>
---
 mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mt7915/mac.c b/mt7915/mac.c
index b581d8f9..3d7d71ac 100644
--- a/mt7915/mac.c
+++ b/mt7915/mac.c
@@ -221,7 +221,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		msta->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


