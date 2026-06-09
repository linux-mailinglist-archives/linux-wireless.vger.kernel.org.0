Return-Path: <linux-wireless+bounces-37559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xKMPOsPEJ2pZ1wIAu9opvQ
	(envelope-from <linux-wireless+bounces-37559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:46:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7E65D59B
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:46:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=Yq5Y3d81;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37559-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37559-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B51630362F2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080973E5EE1;
	Tue,  9 Jun 2026 07:46:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C23E6385;
	Tue,  9 Jun 2026 07:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991160; cv=none; b=OkyeucNWkcxSABADqTgAPinof3mTuylMX0/5n3p5tYyzpRVMNaYYbVjzc7MJO8/3lVNGlETGjGUQ9MUqTAJ730TUmtZJn8wCN0wl8dbSB2xlFxDb0PghgSz59NTVWpp6Dr8b2N3YXsBLQHw/J/Z3wc/YJO2/GRtCHIPNjMDqtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991160; c=relaxed/simple;
	bh=WE+YQ0C30hG+7vy69TJLHtaaVUfA+rJYhiQlx8JUZ3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkqRvyeVPAgNLymZjT0Oai9Ly4Y6GjoM85LL71f0upwO4USpBZ8Nq21ZgDiT+I/ILgulNU9mMz4oO2a9fTreiP7RfS8aD7+6C/VYQ9Vrxzg7haibv0SKiMWv6FJxE/N6gSmlNb0OTwrVDU95ohcBMS2/Mgxe300MRTmVFIvpyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Yq5Y3d81; arc=none smtp.client-ip=45.254.49.197
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41a5c047f;
	Tue, 9 Jun 2026 15:40:44 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: dawei.feng@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Tue,  9 Jun 2026 15:40:44 +0800
Message-Id: <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
References: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eab539c6703a2kunm7c282238123d27
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTklCVhhJSU4aGk4dHh9KT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Yq5Y3d81c0z0sCX/9LwTZ1gQzHAuvu46A9Xe15V6waoUyOPYfWn0hz5+TZ1/mS/inHiE2S/YxOJw+k2khc+pucWydbM3AaF5kGVDF4v9J/dIFftDrXa6pPERx24aaHnfQyV+uroDsidfYY1AGeyVdRfzIibaLjlYcpIXl9YQr2o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=4Rswhi/jEIlKnxolWs7LEsvRJE3VIBM5ijSO/Y68FHo=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:dawei.feng@seu.edu.cn,m:jianhao.xu@seu.edu.cn,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37559-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0C7E65D59B

Hi Jeff,

Thanks for your time and the review.

On Mon, Jun 8, 2026 at 10:24 AM, Jeff Johnson wrote:
> > Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> 
> why is this SOB here?
> 
> > Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> 
> this is the posted author of the patch, and this patch hasn't been posted
> previously, so it is unclear why there is an additional S-o-b

Zilin is the discoverer of this bug. We are in the same research group,
and he actively participated in reviewing this patch. 

To better align with the kernel submission guidelines, I will add a
"Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
contributions. Would this be acceptable?

> I'm wondering if it would be more logical to have another label at the same
> place, i.e. fail_band, since it is illogical to goto fail_wiphy_register when
> you aren't performing the wiphy_register function

Thanks for the suggestion. I will add a new label fail_band and send out
the v2 patch soon.

Thanks,
Dawei

