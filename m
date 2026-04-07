Return-Path: <linux-wireless+bounces-34434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFaqKeSY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:40:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7E3AA055
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A107304225D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195F231832;
	Tue,  7 Apr 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHDuM2Ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350C175A7D
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540364; cv=none; b=GrmeAL+zjtdzBJyeh3iCNE1F2IGfecknB5LUplH/1HpzxUAcun4RZZh+61BGDHC9TCInVoYD3uXHezMxrh+oYXK2amI5/otTq1/76Lbv59mK0h4oR6tC8lo0dEy81veVVnq/gFL2O0J0s7juktIQaWzq5PcOSrftQHcTO2SCAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540364; c=relaxed/simple;
	bh=Ru/BnaQyZzVZzrYCIqqhLeRgm+Qndc4JoV2S0iCIdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkDdfwshWfuWSCqU0ArVwaqZNxyQi1e/xkx7Pz9gNom4ROALSTOCVKu1+MAtvtuiqjk/Xqt6O8LIVJiAjZG3+t90ZALtcjyS2eYzzCgn1cOqXwNRoWS2j4zNTsFEgn6gYI/KftkB5zkBp9yg4Ipo6d3BeC+w7vDHE4KAqcsbTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHDuM2Ip; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6500eae6d2fso4485994d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540362; x=1776145162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o6/M6Ncn32CVMSk11LRfMZ/sdQIlchfXgJf/aiIUmg=;
        b=ZHDuM2Ip831iQ2mUGfNeTwZq3NRfsSJ21PYt+AoPzkbQoOGOWVIKseBFurE8p47Ohk
         VNeKMDlbz9kf+9ZVdCLO+4BgrDH7X5KDoaqKm/4xEUB/BF3L7SN5gFeo4FCwlH0thmaM
         L5SYVbZ45qOcsQbEUGLbrt2iayzbgqKPdE55ZZaqA3v1hMhZEyLlPvxSORsdNV0C8MoZ
         PyknXB7oa+C7V86Q7TrWFgJrOU3DQTQQOSWfb2gff2PlIp85jrn1qeaMfYfLDCUdo/om
         aYfb/Iqxn1HmQ/tGrSHZmuGQ4MCSy3fKOtd5R2UeJVIZjr2gZ2x+aN80Y/h2RVhv6bdB
         wXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540362; x=1776145162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o6/M6Ncn32CVMSk11LRfMZ/sdQIlchfXgJf/aiIUmg=;
        b=UiPV4uTSE2G1c+QChOaJXlRFqhAzzuOfAwkn14PTCOT0OKmfSoV6C7fE+VGQXLlfq9
         kpG8mVq85h6O9LwGSDcCz6fbcRa2CqLmWHMI8cVDkKnlbL8T78WmvzZrYmCtsADpa4HR
         NHTBJwTeNXKLgUiceGoHimnVNpIVsbHe6VthVkY0dWmmPBuRoFBzCV0HewjJe2kjf8rq
         pBKONk9fs/Uzg7MSChJW+BG2AR9rU63a5zRq3i5CddOvXs5o+fUDLBbFPUy5w0HLJqea
         hTr9ptFYgcqIymsG3tx7t7kpC0tTjbzErtlV79Z16CrEx7CLqCI7+0jlwJrk8AuB5W2w
         Ofrw==
X-Gm-Message-State: AOJu0YzOWuspKJMKkW++6GgEYNyNRvlrYR9Si0ERqYMOeNmxXNqFC58r
	Hi+himnkb6BxaCUS+T/tODomc9xAIrZHfXELRYfgxOBxMdtXtdgn3IoE5ek0/Ww8
X-Gm-Gg: AeBDieuboWuogSmn3p2y1QJYujz3QojoJoSzQld8+0J5aqpwkofPVOgbM6Jl6+ALNxb
	+xHWu09xpfNtyTbsbT693kJ+LknVdiNEcc2Fei6ztF90Fizb2qa1dJS4UKnZp90PF6l7wDbjwAK
	9Zm8a8REpV9Qumaz5mee255FAvwKhowcf2klrgu+dAf79QqXpqM4TkY5BJad+VhVUvGn5JnRS3E
	RnLPlQFJajNr8lGxVLBXe/mFKmNBBcrOeAnjQbYC5NaU2bVHcB4/oWM2k4gaYG9gJSEGOIltQx+
	rzENo+FDDvPgxJm8jOKj3tFcg+WaX6hotMUqgH6KH30u3eGIzxJh0LlwpY7gWO9LzDt9Zmj/LFJ
	EiHYeb3tU48LwVSoIhS7JXwyGwMft1QC63+VBAjt2wLdbUJXswba+lMy7a3Tc2ukXnLsEBPMReM
	5YV1kVRtpMuqwqv+9/hiuScEJEKupPTtWZjeOtfgpXefmBxYR8uYGGlIZf7emf
X-Received: by 2002:a53:ac9d:0:b0:650:3bbc:536e with SMTP id 956f58d0204a3-6504889a766mr14761298d50.68.1775540361886;
        Mon, 06 Apr 2026 22:39:21 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm7217468d50.11.2026.04.06.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:21 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v3 0/3] wifi: mt76: clear cipher state on key removal for WED offload
Date: Tue,  7 Apr 2026 01:39:14 -0400
Message-ID: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34434-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07B7E3AA055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Clear stale BSS cipher on group key removal so WED-offloaded
plaintext traffic is not dropped after switching from encrypted
to open/no-encryption mode.

Changes since v2:
- New patch 1/3: initialize hw_key_idx2 to -1 in mt76_wcid_init()
  for consistent "no key" sentinel on both key index slots.
- Guard cipher clearing on both hw_key_idx == (u8)-1 AND
  hw_key_idx2 == (u8)-1, so that GTK rotation (new key installed
  before old removed) and BIGTK removal while another group key
  is active do not trigger a premature zero-cipher BSS update.

Changes since v1:
- Rebased on current wireless tree.

Joshua Klinesmith (3):
  wifi: mt76: initialize hw_key_idx2 in mt76_wcid_init
  wifi: mt76: mt7915: clear cipher state on key removal for WED offload
  wifi: mt76: mt7996: clear cipher state on key removal for WED offload

 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 13 +++++++++++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 23 ++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.43.0


