Return-Path: <linux-wireless+bounces-35697-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ID2Cg4U82llxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35697-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:34:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B568449F47B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8922C3024537
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63C3FE371;
	Thu, 30 Apr 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqMMfLgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352F3FBEA9;
	Thu, 30 Apr 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538034; cv=none; b=ciuqVfS2FXwuW9RQoERKFWu2AJJx20B9EQ68cM0hJrXUpspE9sSivI8evZq/qYORUBSJDN33dMy3IUBhw6XkrzTL3QBPsK7w+uS4qlZbfCNUVqACqKvyHp+W/2Jf0VDmBj83YC4GGW0ZUHJ6unvmYUqE0f3tm4bezrmk5wtNJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538034; c=relaxed/simple;
	bh=7cebm5YPv+mGucLf4Q5+XECkTCK2rT5d7w8TTk15MGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qY2c4ktIrtOwAUww0Y430pXWSEYCq2ddE67bnfGeqmRBSypSkybx5EB671iriHz7bzB5jqg9prHChJaQk12VEmtdujBk0kVVA8VCaTX9U9upmPS2T+MSfj01GRSTJfx9tnQcqfcBnVVTCGllTcf8X2j9q4lXFu9Vfx/J4n2KYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqMMfLgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BF5C2BCB4;
	Thu, 30 Apr 2026 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777538033;
	bh=7cebm5YPv+mGucLf4Q5+XECkTCK2rT5d7w8TTk15MGI=;
	h=From:To:Cc:Subject:Date:From;
	b=tqMMfLgn6fBcdopY5vSnOXlkgLZ4ZHed0koAx3pejdErGPtM9ZH6aLszqOW28rpQ4
	 zni7Mh9Ee/mI9MqiqDbhC36vzo9IO2QWtjx+uvw9C3eRh6C88+d3EA5FqPHXTSBfsk
	 tWqMEXwTlwkgzTaIRUy7fRwEsET6Z2RUCHDd3PGmu7nqx4dx5lgif0kgQ1w0fEHxEf
	 TMb51kC7cFJHHqRyoEMSAHPi0RXT/G1VPXd9fG1x4WRL4auxOlE+3RzRj2x/SY669U
	 aZzOnvXFo0xuh7m9c1291UiatOhoG10saFi7APAK1DHTH6iJJT/pkqtTHYBU0yWBpN
	 lUd/Y8oB+zKpA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIMqF-00000000u08-1fCH;
	Thu, 30 Apr 2026 10:33:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 RESEND 0/5] wifi: mediatek: drop redundant USB device references
Date: Thu, 30 Apr 2026 10:33:30 +0200
Message-ID: <20260430083335.215239-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B568449F47B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35697-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

[ This is a resend (with trimmed CC) of the five Mediatek patches which
  still haven't been picked up from [1]. ]

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop redundant device references to reduce cargo culting, make it easier
to spot drivers where an extra reference is needed, and reduce the risk
of memory leaks when drivers fail to release them.

Johan

[1] https://lore.kernel.org/all/20260306085144.12064-1-johan@kernel.org/


Johan Hovold (5):
  wifi: mt76: drop redundant device reference
  wifi: mt76x0u: drop redundant device reference
  wifi: mt76x2u: drop redundant device reference
  wifi: mt76: mt792xu: drop redundant device reference
  wifi: mt7601u: drop redundant device reference

 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 3 ---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 3 ---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c | 1 -
 drivers/net/wireless/mediatek/mt7601u/usb.c     | 3 ---
 7 files changed, 18 deletions(-)

-- 
2.53.0


