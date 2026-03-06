Return-Path: <linux-wireless+bounces-32623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPaJHgitqmlTVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:31:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66021EC4B
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F7530480A8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A837BE8B;
	Fri,  6 Mar 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNwTMYE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA637BE77
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792887; cv=none; b=jX/K17xQknsl+WgktRFp/azxQbVXA8ppHnuGXy60EqVKgEZt7zFzTZYaYalB6QBhfYGNr3csZl2Ilx2GlCOfU4XyPEP8AlC3u0mCJwWl8s5C5DpkvZclkPnZAB05tv6V75t3zDEJ5Ky0m/dWQ0GOEzFvcSdjM51OX/5m3zyUwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792887; c=relaxed/simple;
	bh=xyoECdBTPkHphTz09uglf5Fw6arG6VEmkxyNX6In6MM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pf7BJfeNJ0hXlE/OXIp9noN3D5fPPMlR/AbIZIg30zPooOTMakBZ9gJrtgVXFhbqSRBbTszXApdl4wYQHqe8lR+kGAtIFwYMLzb8oe+G6vAFYkm6v1IXPLmzhau87x6p0/qnnp5b4WhHH1clE7BajpavOSVSbIdZCBZHQpw+saE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNwTMYE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DCCC4CEF7;
	Fri,  6 Mar 2026 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792886;
	bh=xyoECdBTPkHphTz09uglf5Fw6arG6VEmkxyNX6In6MM=;
	h=From:Subject:Date:To:Cc:From;
	b=uNwTMYE1DoKL3rUtZKyGsvrXvWLZnbTJMsk8I4pOEvWfvhWdENhFUy9KEBQUn0Nga
	 dZNrWxois0UL7wprBmeNXcTjiAMVnR79fPXdgGzP0lAIWYKW9c8Fw9BxtRFxO7qPdG
	 DOsI0lYnWj9eZQUfN6+dePTHT2QvhpYyNFayJpmiUue5b7kuzBiqXu8VgEsKLagQ9o
	 +rWf5j3MMdp2PgBM2qDzXQg48Sx/yh31sxUdlc51+ugn6UB79Ikeumd6P+K0IEZLvD
	 hajtjApUZNtjWmZlNKgg5nCVwGQy5BMRDGWv8xkgg+Zkm6jDXGjTIfkWW/mVseggYF
	 3dHrvQrBCaGOA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/4] wifi: mt76: mt7996: Some MLO link reconfiguration
 fixes
Date: Fri, 06 Mar 2026 11:27:51 +0100
Message-Id: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X23IVExaq/UjwU92kXNZFEpSD+u
 8HbzGXmpIigiNRmJwUcGtW7JPaVUf/7uhGskpxyk1emMCUv27tpKhYMs7qJZ++nfeWHAxZ/gG0
 vYlAWgtpS6qwBg/6fx6e7rhtMaEUDcwAAAA==
X-Change-ID: 20260304-mt7996-deflink-lookup-link-remove-1cdd0e43de81
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 0C66021EC4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32623-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

This is a preliminary series to properly support R1 link reconfiguration
on AP side.

---
Lorenzo Bianconi (4):
      wifi: mt76: mt7996: Remove link pointer dependency in mt7996_mac_sta_remove_links()
      wifi: mt76: mt7996: Fix deflink lookup removing links
      wifi: mt76: mt7996: Fix deflink lookup adding links
      wifi: mt76: mt7996: Remove unnecessary phy filed in mt7996_vif_link struct

 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    | 14 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 82 ++++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 74 +++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 -
 5 files changed, 116 insertions(+), 63 deletions(-)
---
base-commit: 030eea77accf40477be540445fc5a5be52d810a3
change-id: 20260304-mt7996-deflink-lookup-link-remove-1cdd0e43de81

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


