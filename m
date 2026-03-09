Return-Path: <linux-wireless+bounces-32778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI//KKtBr2mYSwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:54:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDF241F4C
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4EC9302978E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B90368946;
	Mon,  9 Mar 2026 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="rz74WY5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653A36C0BA
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093129; cv=none; b=sdlEKLUFi5/NDa+wBtIosfBYvdSNF9BcQR4vjjkxyRCVdjLiN8WffyLtOarkpBbJ4noZE6Kvj38UqSFyFvoTXGYbMHI9MAjQDSCE+HvMKMPG/APSOJvYBg9VIBiOuDn9yprFXm+TxCf7SuWvSb0av+iQ++mwfYFrvmz791bFu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093129; c=relaxed/simple;
	bh=qpckWEEKlVNkpIP0ly/4oPBISbOps66Ca/3FdKZTbh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze/nZFRkHJjO2ox6hFzN5XwQLPlrm7Ipm74JK6kf/soYZ3rq4+Pfwd9SvOWSFPgAI6R8bNyGuochXyVbtVeNZD6uR+MaAfxDxPJkb5Y/J6CmnctoHYDb0LGDupTy9WCvPLOfqJFOZ0FljCSvygPtyg6NM9oAkjLIXwdO5c8zmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=rz74WY5D; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773093125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpckWEEKlVNkpIP0ly/4oPBISbOps66Ca/3FdKZTbh8=;
	b=rz74WY5DIsd8ZZjL0p/IsBF9iT64dQikRAnvPoRkHuqV5uASOEQ93uEsySk9jMvFad+SLc
	aSI++WCcaW85bVcdrayokHzQ10lMBIVMOiBeknkCnBV60umKxJzMmdcS9KMlExydxqgeh/
	teeSzdib97uX/IR1AzrhwFiLVFz8l6TdpBmVLRwmEn6C0EijYNeTCjbifrRmmVVhdm03Y4
	skP6/XznGUytNRPNBKYJUIl0MgynsAjmJ8bjl4ykWaFDUPZCqkAPfQHfeQBvs5KXRpge/Q
	W1/jYRVsRe2kpjLLVJS2X865WH/ZhgorD9rQFGEvKPGgxWNNtdDWS/ZG6OyKKA==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
Date: Mon,  9 Mar 2026 14:50:11 -0700
Message-ID: <20260309215011.96403-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260130215458.52886-1-lucid_duck@justthetip.ca>
References: <20260130215458.52886-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E6BDF241F4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32778-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,justthetip.ca:dkim,justthetip.ca:mid]
X-Rspamd-Action: no action

Hi Felix,

Friendly ping on this v2 from January 30. Life got in the way of
following up sooner -- apologies for the delay.

Since submitting, Nick (morrownr, USB-WiFi maintainer) has tested and
confirmed the fix works on his MT7921U adapter -- 33 dBm on 2.4 GHz
and 24 dBm on 5 GHz, both matching regulatory limits as expected.

I noticed Bryam Vargas recently submitted a competing fix that updates
txpower_cur in mt76_connac_mcu_set_rate_txpower(). That function is
only called from mt7921_set_sar_specs(), so it wouldn't fire during
normal AP association or channel changes. My v2 hooks
bss_info_changed() on BSS_CHANGED_TXPOWER, which covers the common
case.

Happy to rework if you'd prefer a different approach -- just wanted to
make sure this wasn't lost in the shuffle.

Thanks,
Lucid Duck

