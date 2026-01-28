Return-Path: <linux-wireless+bounces-31266-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIlGHSbUeWm6zwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31266-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 10:17:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C49EB75
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 10:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904003012CE2
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6533065D;
	Wed, 28 Jan 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdUWOfAS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A0341AD7
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591843; cv=none; b=AC0N+OMK4PvK79mSM9Z8Q5yZrAV9ec+p5X7G77wgymLhSFWp+2cde6FprFVlNESsoF8WJi3GfdmMolnC2/I4jmaHCt3bo1fB3z9D6+setiKn0aiE2+GkDdrZA3qEArFkFDXIddNPfnOY9Mqx6j9iIe4mvY40oWJfGRFfi7yrHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591843; c=relaxed/simple;
	bh=32wbxUyESH3m7aMBWjlYCyNQDo6IvXCSzsfsqAUfskU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nO5jvbKtyiYRFN8yraXyAWpI8FCfAK9gpc3U8J91xJtI3Ko/PgHJzmffDZ2Z/azAfODq56iFje8zlszNiO8TGVJrTRoJlZ1rR8YQ+as0hDjzWXXI2aKl4uoK7g3ieA57nbh7q+oyt4w/Q/HBhsUWVHDuZN4PyVPdv5TqXPQYYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdUWOfAS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c633984fbeeso287826a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769591840; x=1770196640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPzz6Fs5J73M9AfzdnFQjFqLwU/A9pwIaV7/8cV24RY=;
        b=CdUWOfASBeHkd6EOuVFQxDy/GxQ5l4Q8rJscFR7rQn/eYK1RWdWG+v/LMqPd3Jvexb
         n7vinDmx2BVcSaVdlRDJrngaGlVrGiFEuQxRHEQWhcFtOMf0jkhPpOImieoSEIKLIndS
         +0SkJpYGpbO4BHuI7uHETBPfW46cf49BQNO4NxodizS/lLhctJu0hCVR+mCjFO5Rhj34
         vTdto2IhZiLI/QppEz7bAb4C1IMhNvONVaiAVqjIUFNj58DIKCGRIbTcuqwBQXS0hUwc
         WydRYNDuZuFN8RZPAM+AUwSxgm5pgfjJfIrtd15+1Y+IDaiDMEbWA+dT43ZczSWAybsQ
         AdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769591840; x=1770196640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPzz6Fs5J73M9AfzdnFQjFqLwU/A9pwIaV7/8cV24RY=;
        b=IubyP027Uj5QOe8qsg6/OWVVmyJYwLYLuXaAEKpJ4lL00nkR+0EvRc1pKVdbu823Jk
         JmhPMl6rNNaVwuWSJG5N72yNxKE/W0udirnTZVGiYsCYwfeE3tePcpXquBysih+UbeF4
         oThlCdUXpuLK1r9MS7fbgZgSJ1wvuA3fXgwBLiOLo6DSJuFF3fM/G7FQr+YtFo7Jwlcf
         sGdKdesTjFK2LvRhkeMGqim+x/lz/VXfFQKtVfpUZCuwYLBw2RP0VCGZ/Fu2ifTBSRUV
         2+jaIjMsPM3CvT1WOOVoys5WYqkeUpiufjehpTQxCwyvWYhUqYkaO7o072nhtWW76frO
         ujUQ==
X-Gm-Message-State: AOJu0YwrIIu/743w1AmT7ytxaPSdaKpB1Ab5DPY1HqSMDmYzf5b0veUX
	XEK0mF80EMvASuMBTbBlu7bWdXpSzKr+YVQeMeKNRiynCzd2ny9NtUdu35g1Uw==
X-Gm-Gg: AZuq6aJZhd9yf6Xkh4lPLtuze0fjDKoj3sfP11NoS72khukjitYRRXjtFTQwq36FHeL
	JIT4yebjXaaAzio/6+4ZCyA/37v+X+TIfo0A8wCLCls1w8Kn1NrY7f3GNpftRmVQnUlAnSwmC86
	bxjwEDRqHtAQj8paFyAHmWRKjrAc+bQ7Q9hLvqi1ovK7yDWoy7YVkO1Ua0xGZJKfc4QXmHC1FK9
	qtvKwEVw0OJVd40eXG9TGDkaz8PR2Lm9cYEiBrL3/MLt5WPcADhmk4AoqaR0gOYC1J6fJm+PKiJ
	tIiUXoN/0+egU4wbWebibHQii9iBU4rpaJrlXbEvYqyTpLYkjsvsAM0j/Prd/yxczkeEWahhh6z
	g6az8e/dnZGfeOc9h1dRNFUa1AGoYJWo4Y61fly5YNWQvI1I3OtGQwW+loNwSUjD++2XD/lPi7T
	YA5tZjXDH6b5JN8PMEGAIcWMzlrtK6hsKOnKoDXJIYn1PtbdNb/HvUZw==
X-Received: by 2002:a17:903:190:b0:2a7:a9f4:9fb6 with SMTP id d9443c01a7336-2a87132b446mr40781315ad.24.1769591839568;
        Wed, 28 Jan 2026 01:17:19 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a88b4c3d2bsm17106345ad.53.2026.01.28.01.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:17:19 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Tunisia (TN) on 6GHz for 2025
Date: Wed, 28 Jan 2026 17:16:34 +0800
Message-Id: <20260128091634.28983-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31266-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A8C49EB75
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

By decree no. 2024-641 of December 11, 2024 [1], which applies to
frequency band 5925-6425 MHz, with power limits 200 mW, for use inside
buildings, in compliance with EN 303 687.

[1] https://www.anf.tn/sites/default/files/2025-01/Arr%C3%AAt%C3%A92024_4611.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index dc72989b5b40..7abbe3f1341a 100644
--- a/db.txt
+++ b/db.txt
@@ -1929,10 +1929,13 @@ country TH: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
+# Source:
+# https://www.anf.tn/sites/default/files/2025-01/Arr%C3%AAt%C3%A92024_4611.pdf
 country TN: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 # Source:
 # Technical Criteria for Radio Devices and Systems Excluded from Frequency Allocation, Sept 9, 2022
-- 
2.25.1


