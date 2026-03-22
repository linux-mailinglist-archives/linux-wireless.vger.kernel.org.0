Return-Path: <linux-wireless+bounces-33665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBspM1zzv2kgBQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:49:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 370452E9822
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04499300C807
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259E358364;
	Sun, 22 Mar 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEDnRlVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020F1A6830
	for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187353; cv=none; b=d7VFgKyLPSlwg7Anrmgu+8mUhXFWeozkWupuKj6QyKo98kK89K+cPH120zNnR/vKzKErpbkdk9aVBEy1RtdDVfrkgezuBaoFS8QJhLWaFErF9W+j435od2Wkx7W9sOWdUMTLRc5o9e6XvBqobzXAg6R3X9wvRge+K5KJ0oZ/hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187353; c=relaxed/simple;
	bh=zAEGMePgNmVByhLS4konr1t6FFFdoaY/H6P68u9vHD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIDUMBSJn2eB2YMhRb7YMWOwLGLs8aasTI+YeUbzhdthFLYp6Eps31NzER91pAQkn/EsQ4HSGOZZcNIiWGw2CouHA+sG+DoXBrskBn+QMXiw5ZOOg8Ohovjl6P61HKU82y/+vm6WLoEnlaYGabNtCbIrohUFqG9kyYjpYQ4OJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEDnRlVl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so17009665e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774187351; x=1774792151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsofZZy80LqOViURd0Cth7grp341lX7nawvGMXam0pQ=;
        b=jEDnRlVlhR/5+eKTsC5KVIAEEAFUZQy+lD3a2LQ5Z7oUELRfv4ytHh8Q4GKa7Wihmc
         /ClMmTeX9pIEHTTIhcVucB79lUNkkqe2sN3J1sdnrYVrqHiqXyohNFka9QFbt91nmTKS
         KsXm1lZCrAdyDzaOlLrU7X4byiXkHijhv0mvJwCMyuCe+Pr4MCGmIi0lg43zTG/WKjRt
         +qnEI89tXASryj//9TjJVXEd03Fy+BZE3i4Tn+9/NgHNdrMtRFwOSZFPwseRno4xFS4y
         CmM+X1lQ3bKOp6RRKK1CaLPAW3Mv54De0wNZYnkMQeOECUV6XPLvWF1FOe2rxEfSipFt
         5WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187351; x=1774792151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsofZZy80LqOViURd0Cth7grp341lX7nawvGMXam0pQ=;
        b=MwF3qciqRuQcrQAvbQnMNfGxIMQ42IRpPc3i4b5SRqkDAuLhIkTVID6vBc+ccHvJ4G
         3WrXhX5ZpximdWEiPs9O5fSH3BlIuYmpTqS480WF+FxDdNptROZEbozsLzEFXN4AIpYd
         v6fBRCGqS8fgv6qeV2AfhUP8RfI4FID2yN1jvLZ/57YSppZWg0UyZRAYbfIn8ow+kY5r
         hzINjD5rE/gyeJgP87a/UwECKpIe2DTEqPbKak8O0Xg7/3f7bxBrr3vrheYM1pogWkBU
         J9w0TMTmckrpzpMl7nAk4N5Ds6MMk6fh06Q0HVlWNItw871ikiPNud9yLRcM+hkgDKur
         t6Zw==
X-Gm-Message-State: AOJu0YzFxAsXIFe6Dl5ShlF9ABUvS/FWu0h41I0GYK7PpG59IsYkXIZG
	kKU1aDQdmLtdXyo186/W/5F0BDFVuMMuO0n4b3tOkR0AN4Er4m6G+hI8
X-Gm-Gg: ATEYQzwLR9sTda3Jx2bDrhstutu41mfF5O2o5u+gZnqJusfjk5cmIqArRkVsj25JIue
	q4qlgL94VObeNv8kSq3cWaqLqrW+Ml6YfHdvTfApw4B/Zi3CB/CnrW6njrRKQkCyx3RlSXXU4FN
	60dcfFnGcwNW3bDGaoDFbQAIUSscxugRNjVo1iWXE7LEeYaSCX7xwj7EFnLphHkxgP2S/B4OD4F
	ybiNtR8HceetOhwa8olIwfTGM1DCSwokxrMavrq4uqtx26tqBuoeEzfQF/zeI4EcZB2qVQkVKaQ
	tIZLikVKYOwWc5rtXrhN3CB4k0MO8gWpQiVm/vaPuREXN+Log53h7kAWTY7z80jzuYPFUnptA56
	yg0ujNgzdcMaxJBHnG6Es1LHWIE0xrpCuNC6EKFAp8g+4zY9IJ9a8bG5+VeyFNjhG2L5i1xexDi
	d7i7oFAbysqluZmwKbqj/OFsw94EiJcUmxGoF1MX1R3nPT87PIUdgVf0ZlTm8GfSzGPZUEklJFF
	xTxXDNbi6zUQHd6SL23y6sbxA==
X-Received: by 2002:a05:600c:45c5:b0:485:3f41:e113 with SMTP id 5b1f17b1804b1-486febb5d16mr127573655e9.1.1774187350439;
        Sun, 22 Mar 2026 06:49:10 -0700 (PDT)
Received: from DA4-DEB.fritz.box (p200300de871aef00290206c667fbb9b3.dip0.t-ipconnect.de. [2003:de:871a:ef00:2902:6c6:67fb:b9b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm268260335e9.4.2026.03.22.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:49:09 -0700 (PDT)
From: Malte Schababerle <m.schababerle@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Malte Schababerle <m.schababerle@gmail.com>
Subject: [PATCH 0/2] ath10k: WCN3990 firmware workarounds for WLAN.HL.3.2
Date: Sun, 22 Mar 2026 13:48:20 +0100
Message-ID: <20260322124822.230492-1-m.schababerle@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33665-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschababerle@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 370452E9822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two firmware workarounds for WCN3990 (QCA6174 integrated variant on
Qualcomm SM8150/SDM845 platforms) running WLAN.HL.3.2 firmware.

Both issues are firmware bugs where WCN3990 advertises capabilities it
cannot handle correctly. Tested on OnePlus 7T (SM8150) with
WLAN.HL.3.2.0.c2-00006 and WLAN.HL.3.2.0.c2-00011.

Patch 1 fixes a deterministic firmware crash caused by the quiet mode
WMI command. The existing guard from commit 53884577fbcef relied on
THERM_THROT not being advertised, but HL3.2 now advertises it despite
still crashing on the command.

Patch 2 works around a bug where active scan does not tune the radio
on 5GHz non-DFS channels, making 5GHz networks invisible. Forcing
passive scan mode restores 5GHz discovery.

Malte Schababerle (2):
  ath10k: skip quiet mode for WCN3990 to prevent firmware crash
  ath10k: force passive scan on 5GHz for WCN3990

 drivers/net/wireless/ath/ath10k/mac.c     |  8 ++++++++
 drivers/net/wireless/ath/ath10k/thermal.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
2.47.3


