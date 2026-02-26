Return-Path: <linux-wireless+bounces-32223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOnnJ5icoGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:18:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1781AE448
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC46301BCE3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF961355F52;
	Thu, 26 Feb 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsq1LBNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC993C2D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133103; cv=none; b=MmXxPcIgqztD+pyCgLtPN/awrjj0rrCOFwIXpdFzIfi8+Z/ed7tOCgEfOU9E6QJGwnpUnTNE0FUrBqfT/7L9SkUB/PqL6u3jOfYFM9WPbZZ4jD9mB4ldu/kybl3V26iwGYPrpCuqIGsrji1dKX8Nb+hRTa5w1XXxw7xERrqsq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133103; c=relaxed/simple;
	bh=Xvc/uex8GcERGA559dxvK49CKwAjLVlFT4RI0I/QFHA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WR1pJ6CcSR+D3//shEr5mU6MxplJFQATvSh0bRlgLuxF52drQ4S6z+2cQ33igf6WArf+yI+XYbARgNzMI7uFAUpcFSxJSNrieX8GDXlXpdpgKjX+M6678aCxSgK9oZzX17MhqPFpW5XVOlLEkkOx3FPkuYYx6jETdM3QBVBBz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsq1LBNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB37C116C6;
	Thu, 26 Feb 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772133103;
	bh=Xvc/uex8GcERGA559dxvK49CKwAjLVlFT4RI0I/QFHA=;
	h=From:Subject:Date:To:Cc:From;
	b=lsq1LBNlkafKUl/8E9voZBtBjfkOixZ5Whl3tPt7vQATYnt56l1DDTkQcUOFbyXMJ
	 zJh6A8WCPisgq6noIzUpR2JT/87FazF+cu1UNrIdG26UN59Ybmeg39ZMQf+NYawRjC
	 hHFJuKpW5/xFFRbnKFXIhwG6zrObNUVv7NbB8ezIfSSAYCJLDVe8Rq7uD6k/rH4Hf/
	 ZgQwP1onCjsfZDPjaUX2Cqn++FNylBUlnLqWVucSJw31GgwB5Gr32rPAMS+CG8HNPr
	 UglMOzzjXWpBnDtftBxvS9SBwJzasueXXcJ2iJKVuD47rycwnHtBSDEQiQVfyUayEk
	 3whfnr0oX5RCg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless 0/3] wifi: mt76: Fix possible out-of-bound
 accesses in mt76 driver
Date: Thu, 26 Feb 2026 20:11:13 +0100
Message-Id: <20260226-mt76-addba-req-oob-access-v1-0-b0f6d1ad4850@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QqDMAwAf0XybKAG6ep+ZfhQ27gFpt0S2Qbiv
 6/4eHB3OxirsMG12UH5IyZlrdC1DaRHXO+MkisDOfKOyOOyXTzGnKeIym8sZcKYEpth6AMFN5A
 LXQ+1fynP8jvfN/iK8rNaMB7HHwOzEMp1AAAA
X-Change-ID: 20260226-mt76-addba-req-oob-access-848280920814
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 MeiChia Chiu <meichia.chiu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>, 
 Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hao Zhang <hao.zhang@mediatek.com>, 
 Nelson Yu <nelson.yu@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32223-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC1781AE448
X-Rspamd-Action: no action

Check mgmt frame length before accessing header fields in order to avoid
a possible oob access for injected frames.

---
Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7925: Fix possible oob access in mt7925_mac_write_txwi_80211()
      wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()

 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c      | 1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260226-mt76-addba-req-oob-access-848280920814

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


