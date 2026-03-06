Return-Path: <linux-wireless+bounces-32665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E3HGd9hq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB32289E8
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A0D30387E9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9625372B5A;
	Fri,  6 Mar 2026 23:23:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64088372B20
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839385; cv=none; b=XifwdbIIn4gaOWLQdfHVkRKDVJL1dakOeMinFRaA1UmX7ERoM/0NYpIx8DBocaXCfU1nZgrfYEhxqKVZA/gksSNHscZqoiEEzVS74LPPiseTaZeTnM3Cv3fy19sJh+qavU6rMv/zPVfNPCTscONnOowDvYrl+ePNoWwZ6fTJc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839385; c=relaxed/simple;
	bh=up4JaVCV5SzqrG29OlrUtN/q4mRF9QqMJA6j+MsBjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5afEL2QsnWQVXsk5K1VRlpWf7hPwmDFvAzlrUYlIKWqD/EuXSX5Ghtk0w0BoN8BMQ/KqdxMZ1goqHTnRYvOE/e+U16z2FPDZh6eFsfOF9ByA9F9aBZ/9EPnuLdKfAW3GL92nqPF+HPwkM26Lzr29cqJJsuZ7pcPWJ6NNpVeNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4043b909ed4so3401729fac.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839383; x=1773444183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSWMrYZtS1n25Dl0iRprlNJFhY2DHDNgNtXIVP/3MB8=;
        b=VzUvtQQd+ZJv621HbziMMvQOV+jt8T9/mM37fNPko8dxhF3YT0xQ0AXBhJG9FWt7SE
         c5bjunmCFoLkeaMvVhKI2Q9D0HonxGIHhzFKgPgxuUH48VERDO6YlydjSgfUJKpsaXZm
         5ByFH7YDpjOVn6/aIFW9t4GzZi/fvqrE1jQdYI/+OmDHd9N5lnqtUa6TI3v1S6Bpp1yZ
         Hsyb5MmjAe/SExcrTqASilqO7BIIMok0qYiLqS0d+EfSCmH31mFnleIX0qv6Dsjdx7/Z
         s3DMRf19abyMEc1vw/T/d1i49udIY4Gufv9ie9Y1OF0Yt4jZ5SMpFU5l7ILgf5iJ7PiG
         5SKw==
X-Gm-Message-State: AOJu0Yz+BXcYOC9+ji8U5H/XWwhhYit+ZG0q01qZEYb6DXgL8vTos4QD
	yLLkYr8PV5hKCK9iyk5WM9Ge9X/OXLhC3X01DvmkMue8/Po/dBJJSXK/
X-Gm-Gg: ATEYQzxF/VX+t50hjHpI6qX4oI80j5VJ7P7mDOf66d6HjvYsXoEE95bFUJG/R4STIG2
	uiXpZIsfF9fLOHapPXt7o0X0GvcA+1XMfedeoIBDlDXFIVlmqRXGfUzi9c9q49F51ETDi3hrtBD
	IQ+BJ4XQv6Lh+fIneFnZf24+Bw6gwIUAPO5dE42LQfMbBO/dTwZSHkzizOmNLpQbn/fvXDQvN5T
	eqXqylQTIXx6MX3/NwUY4u1hDLJDVNcn2LlaR1gybekq0E9iOAaubuoTU5VSdroh/DXmm/DpPV2
	1fcy+Ryxk7pz+7BULZRYt13ZKyz8OaiIedH02uicTzpEMaXz7AyuFqd3LKucpNwF0G2M5Yx1Q2q
	Zf+ny+iYWM5GUk8T8N0wHqHnCZV/bz8IN9XLRWJpSfgHNE7csoztQ4a1oBfMzpWlm83aFN1M3GK
	ljrs85msea1Lb9H+eonfd68nC1kdoz0Z+iDCGmpPHANUD7lBVS8prTJEvaiw==
X-Received: by 2002:a05:6871:6084:b0:404:16c6:40b3 with SMTP id 586e51a60fabf-416e4493925mr2449023fac.37.1772839383291;
        Fri, 06 Mar 2026 15:23:03 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:02 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 00/19] wifi: mt76: mt7925: fix up MLO link lifetime and error handling
Date: Fri,  6 Mar 2026 17:22:19 -0600
Message-ID: <20260306232238.2039675-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1FB32289E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32665-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.444];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Hi,

This series fix up MLO link STA lifetime and error handling in mt7925.

The current add path may expose partially initialized links and does
not reliably release host resources when firmware commands fail (e.g.
MCU timeouts). In addition, several helpers internally look up mlink,
creating implicit dependencies on driver state and making the code
harder to reason about and maintain.

Switch link STA handling to RCU lifetime, align WCID publish/teardown
ordering, pass mlink explicitly to helpers, and add host-side unwind
logic to release resources when link add fails.

	Sean

Sean Wang (19):
  wifi: mt76: mt7925: pass mlink to sta_amsdu_tlv()
  wifi: mt76: mt7925: pass WCID indices to bss_basic_tlv()
  wifi: mt76: mt7925: pass mlink and mconf to sta_mld_tlv()
  wifi: mt76: mt7925: pass mlink to mcu_sta_update()
  wifi: mt76: mt7925: resolve primary mlink via def_wcid
  wifi: mt76: mt7925: pass mlink to mac_link_sta_remove()
  wifi: mt76: mt7925: pass mlink to sta_hdr_trans_tlv()
  wifi: mt76: mt7925: validate mlink in sta_hdr_trans_tlv()
  wifi: mt76: mt7925: pass mlink to wtbl_update_hdr_trans()
  wifi: mt76: mt7925: pass mlink to set_link_key()
  wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
  wifi: mt76: mt7925: pass mconf and mlink to wtbl_update_hdr_trans()
  wifi: mt76: mt7925: make WCID cleanup unconditional in
    sta_remove_links()
  wifi: mt76: mt7925: unwind WCID setup on link STA add failure
  wifi: mt76: mt7925: drop WCID reinit after publish
  wifi: mt76: mt7925: move WCID teardown into link_sta_remove()
  wifi: mt76: mt7925: switch link STA allocation to RCU lifetime
  wifi: mt76: mt7925: publish msta->link after successful link add
  wifi: mt76: mt7925: host-only unwind published links on add failure

 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 221 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 180 +++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |   7 +
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   1 +
 6 files changed, 280 insertions(+), 140 deletions(-)

-- 
2.43.0


