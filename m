Return-Path: <linux-wireless+bounces-37948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QiJ/KVXmN2qGVQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 273306AAE0F
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nhldWQSL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37948-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37948-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52DD9300360E
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F51DF73A;
	Sun, 21 Jun 2026 13:25:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377E41C72
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 13:25:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048336; cv=none; b=m4G9fk6b8xIiTDk0Bsb6Q6nzFubquE0YUkR5BkPE4a5wD/uA4xt8FdKbUgCDDUKSgNrwWfMu4DmmWd+H27Gzwudl0I6+QeP3aeNHLFUzYrAhXwkF8iNIKsYn8b86p/dp32ZIz1OHqXyhVKCr6uknA4cEDXCIZDP0fhBT+xoxeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048336; c=relaxed/simple;
	bh=soaQpzPC+BFfpJREfxLG1mpxCuW357oaMI2jdScrbWc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tBKmO1ZCFxWR7C74BBuJVDXvrU64O/+w+vLR/+4fmZJM+81XQwlF7g2tn/gIEzU6ZS/vRL68HPl3i8WYniOGlNe+PbV1tLXtwmkNcqTUAnqBEP3fRHU7mmrRW5uAgA3jU1ayKscQYTJzYdKgtnAMFlcVSfqCY4JLPUYE+ALNhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhldWQSL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291C81F000E9;
	Sun, 21 Jun 2026 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048335;
	bh=FA1iBggbrT8LtjvILqVYWNQjXH5A8BjeFWRRbEVadXk=;
	h=From:Subject:Date:To:Cc;
	b=nhldWQSLZHRj8Isy56hp+wAMAG6/5QOFTcB6NEfCjvYz7Ib0pniMgIVNtVxj9utHd
	 kfPxkP0v4ArYPQmPtAW0kjp1a8JKGMYZMulESaSbUBQl723oQEFxHHa4ZxL7Di4snd
	 nVwBqNfdPrhsD2+J59gCqtgNJtdtGtFEBzTquP6E04Q8jDE9lvVSJg3tfJGtZJlzXr
	 CwHrBI/mDjpqE9dFknfdHf83ga+B6sqiYduMWnimt8kIOa+kLPstr+gCkwhmasDzQ9
	 q/uRagMV5xOi2s0wuCGRRMxycyOM45epArv5iASGFIqDgwvH4p+Szwi4jhkicOXm32
	 DY8ggP7r+2a/w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 0/4] wifi: mt76: fix some possible NULL-pointer
 dereferences
Date: Sun, 21 Jun 2026 15:24:58 +0200
Message-Id: <20260621-mt76_connac_get_he_phy_cap-fix-v1-0-ed4ccf7a0363@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqEIBQAfyXeOcHcsOhXIh6mb/MdMlGJlujfk
 z3OHGZuyJSYMkzNDYlOznyECl3bgPUmbCTYVQYllZZadWIvg0Z7hGAsblTQE0b/Q2ui+PIl1Pq
 RenS9k0MPNRITVf0fzMvzvBe5kT1wAAAA
X-Change-ID: 20260621-mt76_connac_get_he_phy_cap-fix-2b3068d4d074
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leon Yen <leon.yen@mediatek.com>, Hao Zhang <hao.zhang@mediatek.com>, 
 Nelson Yu <nelson.yu@mediatek.com>, Rong Yan <rong.yan@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Quan Zhou <quan.zhou@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>, MeiChia Chiu <meichia.chiu@mediatek.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37948-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:leon.yen@mediatek.com,m:hao.zhang@mediatek.com,m:nelson.yu@mediatek.com,m:rong.yan@mediatek.com,m:Money.Wang@mediatek.com,m:Bo.Jiao@mediatek.com,m:StanleyYP.Wang@mediatek.com,m:howard-yh.hsu@mediatek.com,m:evelyn.tsai@mediatek.com,m:lorenzo@kernel.org,m:mingyen.hsieh@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:quan.zhou@mediatek.com,m:deren.wu@mediatek.com,m:meichia.chiu@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 273306AAE0F


---
Lorenzo Bianconi (4):
      wifi: mt76: connac: fix possible NULL-pointer deref in mt76_connac_mcu_uni_bss_he_tlv()
      wifi: mt76: mt7925: fix possible NULL-pointer deref in mt7925_mcu_bss_he_tlv()
      wifi: mt76: mt7996: check pointer returned by mt76_connac_get_he_phy_cap()
      wifi: mt76: mt7996: fix possible NULL-pointer deref in mt7996_mcu_sta_bfer_eht()

 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 18 +++++++++++++-----
 3 files changed, 17 insertions(+), 5 deletions(-)
---
base-commit: 50a7f9f9d48eb50c0e95bef53358acb5af5cb3c6
change-id: 20260621-mt76_connac_get_he_phy_cap-fix-2b3068d4d074

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


