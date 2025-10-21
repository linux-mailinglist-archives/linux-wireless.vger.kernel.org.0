Return-Path: <linux-wireless+bounces-28133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01383BF5F31
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A596519A0493
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37382F28EB;
	Tue, 21 Oct 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="idg6nFMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AED2F0C7F
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044864; cv=none; b=K7gXNQF3bfxtUc5w+rv9D6GSweyZx+zSZmwyMYGUKKuxWe+yzy5V4TqXORtuzXEODSKVy7AyYzImBxVDqFii0oZcYqVgAGKIge2/5A5387kBHNIGchwTLivNKHcVce2Ps6bAvo+ZZ4y+42eij3DtgWzdwn1E+SxEjADXf3vFINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044864; c=relaxed/simple;
	bh=1Bpqd8lrgo2+0MhiSpeX+mng/wohV+Y3Epwiemg2Gq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KP79/NB4khLCHOWQXfQOCygUmTfDtY9kqnuXpNNXlkdjcqzadZKjjlv0b9AT73M4ssjx6jLGduyKQbXrf/iHikFKE8iEQK8nU8zYGhH1OJpXPJ/KJCdX4aF8VrWoAJOh8KH9WS62iJSUOAPhH3QaweN5pVPfKYtZgyA/NT0V/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=idg6nFMs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e0798so86750465ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1761044862; x=1761649662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvbRL9UqpsUU8q/T1vY0eSi4B+AlOiGHVqp7wFWeSGg=;
        b=idg6nFMsh1xUJMNNq9eN7vifeLzFeo5OlygGMIxWJNFzjMmslnho4WIU3HVPkcbGq6
         zJHMAOqk0yWpxJ/WHcf0tPNckFWuSXda4vX651omMdcSISfVPuTIp0pbjpKIwbGg37Ex
         A4Gqwu6/NAPoKPZ9BkZPEEnWqiOlYGnc503nGZDNz0g3lhKQKkGVUBLlbOdzoRSpg4z5
         k1XFzN0aN2LaZbBZnAV+Ogq9yZvI1eGZTS5QP5UM4+T2rc/0cv29rmC59xjHynux6jef
         arwI7pEp5WFmUlnQ8a5nYQa38NgjzG1ZRj3peytNdILXwJp71nqqUnp57S4O7NF11Znk
         X9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044862; x=1761649662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvbRL9UqpsUU8q/T1vY0eSi4B+AlOiGHVqp7wFWeSGg=;
        b=YqQR+sxe1R5YOIKeRNFXXbjrcu/3iA3kpnKKfI24thzIocIVQl4jt9rMancqoNJFnS
         kjjQLJ2LJlgpXhoNtWhRymwnmnAkWtSJLDda6E/wrI7xETgxWP6x4krIASXtB4aGpmWH
         6a8IJfvJen7Og9rMdylSKT0sfPN7ba1R2mKA+TQGt1HSNUA+9uFars1tWwz7hRkMvXvD
         8tMWyV4S9uqDu3hLJugzPNIql5xQLmV/m6loceZxgfY2QtPAqIKRG7hU/5BGr+/hGI4W
         7QK5Sf30IZ71d7LMTemXvTcNQmupjxomuI2Bg0Z/ZErlM+ficOiUE7g+Ko5tf+qAihhU
         lo8Q==
X-Gm-Message-State: AOJu0Yza8rkhY6Jhl2G/RzUnPsbTd+w8B47EsuO2xndHYVhsS2gMhGOv
	puteAmZ9Xur6PbnmzoEaIp8TIdh150pXrRvSsz5ShF+BuL/sAv5nkFa4CuX/4w0LB2s=
X-Gm-Gg: ASbGncsZaWEywCGKkSqGHhaJJcbDAViSj/mvjKNIEvGzAmjIfKbxSvhTBM2teS9U1F+
	FTDSIG4zDeL4LcSc0QTCTVAViqm2cpLeg4Sz/ixFhl27cdKNm8hqjdnJzKiQlU6pPs4/h9hWvGm
	0eBvTO7+YdxAgOBD1XKOEQ13AmDvxUudoyDEGUKAvGFqFEM08zyFPWnQafUmO4BltsJtLRugOkv
	TCvXM9xfPy8+3r2N9T0w1L/rxk1zhFSuUvl5N5G44N58BEMQ5J2hpyYW+ZSUCE2V8b/bcMAQyqN
	26tbXx71/Qfm+MzIPyi+FAbrSeVVja+GX4+izsVCf7Z1v0idb/1HfpgK3Sw7adDJvGygX3nC1qM
	vVvwJVDHBgDJ3oJozxTWogTWHzUSmagQKFUmhH0oPcSGjySaonWJaMbBficj+zJxIey0tf/w7AF
	H+engZCaJsaVJf+GR8kegSn7+AVVbXKijc4Qn5/+CEtjDHFPa2Eg==
X-Google-Smtp-Source: AGHT+IGctx4M6/0AMtFJbVTpegZshaOh4Gn3wZweo6x2cXay9AVuEkuymFY+PQL2Xs7th6ZemPiKEA==
X-Received: by 2002:a17:902:d508:b0:28a:2e51:9272 with SMTP id d9443c01a7336-290cbc3f200mr236599475ad.48.1761044861646;
        Tue, 21 Oct 2025 04:07:41 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.210.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5868sm105543275ad.60.2025.10.21.04.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:07:41 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless] wifi: cfg80211: return center freq for 1Mhz S1G chan start/end
Date: Tue, 21 Oct 2025 22:07:25 +1100
Message-ID: <20251021110725.397982-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The frequencies returned by cfg80211_s1g_get_{start/end}_freq_khz()
for 1MHz chandefs are off by +-1000KHz. This prevents some 1MHz
channels from being used as the range returned is larger leading to
adjacent 1MHz channels being included in the validation process.
Channels on the band edge may be prevented from being used if any
of those extra channels are disabled / no primary etc. To fix return
the center frequency as 1MHz channels don't contain any subchannels.

Fixes: d0688dc2b172 ("wifi: cfg80211: correctly implement and validate S1G chandef")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/cfg80211.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 781624f5913a..a1e362e0054d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10194,7 +10194,8 @@ cfg80211_s1g_get_start_freq_khz(const struct cfg80211_chan_def *chandef)
 	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
 	u32 center_khz =
 		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
-	return center_khz - bw_mhz * 500 + 500;
+
+	return (bw_mhz == 1) ? center_khz : center_khz - bw_mhz * 500 + 500;
 }
 
 /**
@@ -10209,7 +10210,8 @@ cfg80211_s1g_get_end_freq_khz(const struct cfg80211_chan_def *chandef)
 	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
 	u32 center_khz =
 		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
-	return center_khz + bw_mhz * 500 - 500;
+
+	return (bw_mhz == 1) ? center_khz : center_khz + bw_mhz * 500 - 500;
 }
 
 /**
-- 
2.43.0


