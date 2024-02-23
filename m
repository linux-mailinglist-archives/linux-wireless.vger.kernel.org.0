Return-Path: <linux-wireless+bounces-3948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855D860D71
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CB0B227F6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00118C36;
	Fri, 23 Feb 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Yeg6aFkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2C18E0C
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678923; cv=none; b=p37Jb/fAtRzspUTrfqv6nPtx6bM8QlxWfg1497dNytEOkyP70bNZyGfO5U6oRBrjZinv+EJryFQfMsjftpHCn41IFlWoSCEsGcKKjBAnumZOgdcp75/gmmCxRuQXJjNrM1bqx+Yj/qt4KBVwmzI+6fBS01GjL0wFqcxKBzHLMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678923; c=relaxed/simple;
	bh=sqKbhMJzhsihxTtTEJ5J7MQ3m/Ho0hYEiMaMKAIFa2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXjlYjVtUM7XLnpClv0yKHoBIaFEWP5BYdIPTEIL40JiqTxHqVELA/T8Qt9i2z2XXZowZMa7vdD1fxwwE6DR9+o3lXQ1S5dEh8JinAPQuqUdlz3JBbeYghTwWyUbjzZB3BsythjmKo//twkBl3GF5YDL6S3Zda62KwNt3AbiiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Yeg6aFkP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=NFnawQLqckakB5qhJof+/PNCBcsfRpomgyB1w5DcmpI=; t=1708678921; x=1709888521; 
	b=Yeg6aFkPwhSZHOm6ER0xA2HA6SfAioUg5xW82S65tfjcAX6IDJJGhQSOtpvX0m82juRr0l/E10B
	fa1qlLd2nHQ+kjoXwJOO/TPtMAZD9J74KySSt4KK/5NHHfPRGQ0beUcADEP9/MJCcAV/TpvP4VcY2
	IEyQhW7Tc1t5EvgTPYoyh1eX/NB5yFFRna4KdNFoZ3hnzJSvweDbU4XmZm0EL0d3dwoxR9xrHEU0P
	UldDhQPg2o6DKXpxaaH2G/phplUyT65unbMBTXQnn5M1U1x3RKzR5mXSWEei/6GLyomal9mI9bi+q
	qYP5VoR7h2+jxOa4OUXCiWLJqDR5wiDPiZYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdRRG-00000004yKf-17gB;
	Fri, 23 Feb 2024 10:01:50 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath11k@lists.infradead.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] bitfield: suppress "dubious: x & !y" sparse warning
Date: Fri, 23 Feb 2024 10:01:46 +0100
Message-ID: <20240223100146.d243b6b1a9a1.I033828b1187c6bccf086e31400f7e933bb8373e7@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a somewhat common pattern of using FIELD_PREP()
even for single bits, e.g.

 cmd->info1 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP,
                          !!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP));

which might as well be written as

 if (params.flags & HAL_SRNG_FLAGS_MSI_SWAP)
   cmd->info1 |= HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP;

(since info1 is fully initialized to start with), but in
a long chain of FIELD_PREP() this really seems fine.

However, it triggers a sparse warning, in the check in
the macro for whether a constant value fits into the mask,
as this contains a "& (_val)". In this case, this really
is always intentional, so just suppress the warning by
adding "0+" to the expression, indicating explicitly that
this is correct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/bitfield.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ebfa12f69501..63928f173223 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -66,7 +66,8 @@
 				 _pfx "mask is not constant");		\
 		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
 		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
+				 ~((_mask) >> __bf_shf(_mask)) &	\
+					(0 + (_val)) : 0,		\
 				 _pfx "value too large for the field"); \
 		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
 				 __bf_cast_unsigned(_reg, ~0ull),	\
-- 
2.43.2


