Return-Path: <linux-wireless+bounces-33362-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uSQHBg7NuWm6NwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33362-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:52:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330882B2DF2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BD730743D3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06483002B6;
	Tue, 17 Mar 2026 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="McNzcTmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378332D7393
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784329; cv=none; b=Y5rnCuGnMvuRUIilzMicGuMB7FILWw2JhtqwuZTqPTEENyEbc9ND/vEmUcNEC9wJsAc+o2Zn6pvZ9uZyJPTOUBPC+0/7YwtCGtH5FOGCb7XA10X3TWgv0Ie23DYuVW2qR4XTzrJveNK4otiJvCR42SASRjxnd0TR4N4Wx7Dbtdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784329; c=relaxed/simple;
	bh=b97wXvolFR+e8uTxUV44AIrk4klW4uv/w8rxmuRBTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXviXKQ73mdwqcasRfTpiFC8tlRgND0JMJ9p4LB/fR5M0kSfHoFSc7ltk+Jr0SefGzwPyNvSCzup64ctzcWPLxe9qrVHu3SCDUJ+bGmiV3w0TGE7K7GcqKYvj4qcKxGCbD0xPcGHQe2U05xsgGYarH6VBYCan++yiiFFf9KzS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=McNzcTmJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773784324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b97wXvolFR+e8uTxUV44AIrk4klW4uv/w8rxmuRBTvM=;
	b=McNzcTmJC/2il2UOCI/lu+tEQ/UnzmIk/CqheZbms3XrfXVudpE2Sqp1z2HIv5bVLqwZb4
	SJhalPo3N3PXezbvWJ3XLI2z8fAuvTpyJNRO3iJRcXdB5SYKMQ+ICd82QhaPJIzGuSaBUx
	f0R5GIaoRWO51l69I3uR1RZSknF8vtv14benj6MKNUR/9ML6i2Pkr4jDCfUtI7g+WMMOfs
	OeN6b9tzCB286cOHGF3wIz/md6LNP3rmjwWuvWVaI4ZB5qQ4ON0S8cGVjn9meD6IPsPYCL
	wYiSYjMv79B/FxMt5xwg+oV5kSD5KUoB1Lr7Hl7csz/3dQT8oCy7iGm6EgA4Pg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@kernel.org,
	lorenzo@kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Tue, 17 Mar 2026 14:51:58 -0700
Message-ID: <20260317215158.152921-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260317173016.136975-2-lucid_duck@justthetip.ca>
References: <20260317173016.136975-2-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33362-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 330882B2DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I missed adding the stable tag. This bug has been present since the
mt7921 driver was introduced, so it should be backported to maintained
stable kernels:

Cc: stable@vger.kernel.org
Fixes: 1c099ab44727 ("mt76: mt7921: add MAC support")

Sorry for the oversight.

Lucid Duck

