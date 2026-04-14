Return-Path: <linux-wireless+bounces-34724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBTwOEvF3WkpjAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:40:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715BB3F581E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB57302C309
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 04:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A03129B22F;
	Tue, 14 Apr 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Mz3aj62z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F527E049;
	Tue, 14 Apr 2026 04:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141581; cv=none; b=crQnOW/3cibcWayS4KDDY/kOewt4oZN4uZ6OK/lJQsGTxLm9PlkZpAFpjD/HjRvwga4QCIoyFwfqza9nkUtZi71qt807008ZkDv9QY0YxwtK98tW1cCQGGA4eJiW/fuK2m0H1nZXB8Y1c/EK2MuTie2YRu/PyMXjMRXgyZL6o08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141581; c=relaxed/simple;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aYp+PT7zmdG8KnS/liCJYVgl1d/2s9xbNFuKE4Up645fCYN1K1XofjZ0BYYSY5FqmQe8F7U61kh2T3WCLPejbI+d5sH8awXlgo8CvJPYMg2NcMkD57o5mAD/hFdeSO559L0Qq/im1JfPB/oQsYwywxjwwUVHugypuZgJfY3VEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Mz3aj62z; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail; t=1776141566; x=1776400766;
	bh=quadcf+F3w95Vv4EffkoWEgj0LG46W18oiyVW2rhqjk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Mz3aj62zCEj1YXAHW18Q0nT5KzG13NEbzyojDuj5xpANonu6BC+IZ8RB+axJMmTmR
	 ctG1wW5B1ReMljmW1kIXkpGopDmY9TFACTlxBLfFnDfT5XwShrEft+QwZZZnqQsJtX
	 dYoAOmjapvpyHYhOJfDkJFRDbRbUutrVWRSxwYpYhCFl13moPeVi0eoA15Try2RYXr
	 I758Tv9GjnAurx7Wcz5pTSNfqkkYBTyO8FjKYvAjT5C53qpXTVOleUrmWuP5BmHrBV
	 tgB7meivNDqPwhr6K9AmJjeoGc2q8NCbVHfqaMISmmTB47u/WexJjT2K60xb2bj867
	 o2XEDlTstuT3w==
Date: Tue, 14 Apr 2026 04:39:24 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Rio Liu <rio@r26.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "benjamin.berg@intel.com" <benjamin.berg@intel.com>
Subject: [PATCH] Skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode
Message-ID: <7h5kwW8K-FIgMb5P9VQ1BwuECi1JtpQP3RNBytb3F0k2g6DtBAnz65o1smDvWOr2ag9Kla-YpMSGyN1NsU7yYslLU-K9NCyTAxjyx-PEEF8=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: 5afd1e4c48b0cd47de51767ea5ec762a8f111317
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[r26.me,none];
	R_DKIM_ALLOW(-0.20)[r26.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34724-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[r26.me:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rio@r26.me,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[r26.me:dkim,r26.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 715BB3F581E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Empty Message

