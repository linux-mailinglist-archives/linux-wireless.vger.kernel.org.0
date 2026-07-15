Return-Path: <linux-wireless+bounces-39135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rVBeLmlMV2pXIwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:01:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C6475C275
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39135-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39135-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=jmu.edu.cn (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DB6A300E14A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE683DC4A4;
	Wed, 15 Jul 2026 09:00:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A037E5CB
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 09:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106049; cv=none; b=qUP3/h6EvHGLtdoLCRwNxhWBM7TZlUYDdbeV4ovS7hY7SaNnyaiZ5woMNiIeRV+8XdbL0HN4gOZFYbL8RsOqIPj8EBxFd9RNbmbwztbSWAm7kAvVx9nRYA2YKNhSp+sNB5F3Z9arltxjagyVHwPsPO8Dm6pylnB0DHv1Sf39zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106049; c=relaxed/simple;
	bh=5VtbUyXNZDuhV6bSABJhftrGxCknDqtWcOIQUqrvTi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YaUMMixiajNQ6DLIRbq4mGeGW4Yxw5Wwkgc4VIyyVKc1AwHRU/OEMpic8QkQl0Nc/J/sIYCmZKiHWSzzrC5EjkJ1pvWd6VOd6iNOuyTqHJZuuai8w0BLWiBhqq7lzI56bvt6NpBwKXrDViia3yK7NN618WOETRE62V5c0nkKgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Received: from Vostro-3710.lan (unknown [113.80.141.85])
	by smtp.qiye.163.com (Hmail) with ESMTP id 46448d459;
	Wed, 15 Jul 2026 17:00:36 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: lorenzo@kernel.org
Cc: Bo.Jiao@mediatek.com,
	amadeus@jmu.edu.cn,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	rex.lu@mediatek.com,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	sujuan.chen@mediatek.com
Subject: Re: [PATCH mt76 v5 16/16] wifi: mt76: mt7996: Add SW path for HW-RRO v3.1
Date: Wed, 15 Jul 2026 17:00:30 +0800
Message-Id: <20260715090030.1535098-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alc6xTe4uPIJHQy8@lore-desk>
References: <alc6xTe4uPIJHQy8@lore-desk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6501aadf03a2kunm7c2e8de7748cb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTRpOVh1ITEodQktKTx9CHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkhVQ0tVSk9KVUNOWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[jmu.edu.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-39135-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[amadeus@jmu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:Bo.Jiao@mediatek.com,m:amadeus@jmu.edu.cn,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:matthias.bgg@gmail.com,m:nbd@nbd.name,m:rex.lu@mediatek.com,m:ryder.lee@mediatek.com,m:sean.wang@mediatek.com,m:shayne.chen@mediatek.com,m:sujuan.chen@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[mediatek.com,jmu.edu.cn,collabora.com,lists.infradead.org,vger.kernel.org,gmail.com,nbd.name];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-wireless@vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amadeus@jmu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7C6475C275

Hi,

> IIRC WED is not supported for HW RRO3.1 at the moment

Okay, seeing this commit, I mistakenly thought it meant support:
net: mediatek: wed: Introduce MT7992 WED support to MT7988 SoC

Sorry for the noise.

Thanks,
Chukun

