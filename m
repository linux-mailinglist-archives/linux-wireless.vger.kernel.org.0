Return-Path: <linux-wireless+bounces-32064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAx8MCSTmGk5JwMAu9opvQ
	(envelope-from <linux-wireless+bounces-32064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:00:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67F1698BB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 045B03021BBB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8ED2877E5;
	Fri, 20 Feb 2026 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5gQBEkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2D22DFA5
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606816; cv=none; b=kYqOMAh1sHegsi4boW68MURU4R0ZHycajQTXM8vpkKNT0fAKDr+Iliezh4TMS/sbMSy3s0sOHo0SYDmoHYZGA6FhnQ4HHfV8vA7p1BSitZWakscc1/Xzpdl/FYNvKj/1RV+4P0h2+E6us92jQOYzQvz8nDNy/kncCNifDhhGD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606816; c=relaxed/simple;
	bh=2OxFsATCItBc+22+SD2qdAlW/PLhtqwfva1j4C1fMYg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KwWxc6Yoq+4HD2PrtYpTh5D25vt68Dxd3xe7eaOwdHmmT9rAB5qOGxM1gFghwJusM+tAi61fmSgHibNNhYYXBWQoxHdqpUFIyRjfoQEQsxoYwnbq4ZjPubFfHAjjP8yZSD/aBsY8FLBxWofa1yjlq594M+DaZgcmmPkGgOh4CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5gQBEkj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771606803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsz36afj9Yf9FxTFLOgJtL8vxZ6vXJj8n/cdSlWhQJ0=;
	b=C5gQBEkjQWWlrxSNARi1HEYNd77sdWyoA1+6kAibTVptY+obzOZtU3fMeCSBuQGE/pG5JX
	bkshYuXPJZ1sQGM0hD1doYfZn5Col9pf3hHXdAiRrYUV8AFKimCTY70/nATFGfUDyIVoUu
	ZBeseCsdGrmOgp6zMQqbWt4n0OyExG8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next] net: rfkill: Replace strcpy with memcpy to
 improve rfkill_alloc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <6983492c92a811b45c27bc36337e16fbd1abd94f.camel@sipsolutions.net>
Date: Fri, 20 Feb 2026 18:00:00 +0100
Cc: linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <86C8A63A-E72F-48C9-A1C0-4E65A91CA987@linux.dev>
References: <20251215122036.379322-2-thorsten.blum@linux.dev>
 <6983492c92a811b45c27bc36337e16fbd1abd94f.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32064-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B67F1698BB
X-Rspamd-Action: no action

On 8. Jan 2026, at 13:29, Johannes Berg wrote:
> On Mon, 2025-12-15 at 13:20 +0100, Thorsten Blum wrote:
>> strcpy() is deprecated [1] and uses an additional strlen() internally;
>> use memcpy() directly since we already know the length of 'name' and
>> that it is guaranteed to be NUL-terminated.
>> 
>> Use struct_size(), which provides additional compile-time checks for
>> structures with flexible array members (e.g., __must_be_array()), to
>> determine the allocation size for a new 'struct rfkill'.
> 
> TBH, I don't really see that this is a real _improvement_. I guess I'll
> take it if you sell it as "let's not use deprecated strcpy" instead,
> although even the documentation says "no new uses"...

Yes, this is primarily a refactoring to avoid deprecated strcpy(), and
to harden the code by using struct_size().

Thanks,
Thorsten


