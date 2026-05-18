Return-Path: <linux-wireless+bounces-36614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ0YN0aDC2oZIwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 23:23:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91B573C59
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54D4303204C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38211393DCD;
	Mon, 18 May 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="PzAJ5wX4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-outbound6.duck.com (smtp-outbound6.duck.com [20.67.221.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF77328610
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.221.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139359; cv=none; b=sVQvXHwfmJD3Ul3Cd5XC2VH7am2h3D9nenAfmHrtl+dlDDIfbq1VoxHqGcWABxSleG6RFmmX7sWdncmqm7NWhvhnJCF5byYLq/Yb4+dqH5q9wVbh1bw86fz688yCqUK8jIc35YryVFHCVz6ql+IvllACoObJUDq3VZplaWvNaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139359; c=relaxed/simple;
	bh=rhVa450vGrOFu4g87S5Qjposw4xxoq/4klTa9ePu5f8=;
	h=Subject:References:MIME-Version:To:Cc:Message-ID:Date:From; b=NbYaJcVPK1fWR57VYFfuFoDQeQoFtVVqnNsPJVI0meViOWUrmDagAyUy9S12r614Kc8GhlRTAzR/HCuKFWQIVIx9rpCsFAwTGRs0nF5NfiCAP6ApngvR0UaYiyd8El9lyy3Rgn7CJVOGcopaLKq+UxzpotYetKnUEqdRSSEyld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=PzAJ5wX4; arc=none smtp.client-ip=20.67.221.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Brunei Darussalam (BN) for 2022
References: <CAGb2v67NMBPs5bbNfoPNjK1mum-y5FsqAa_HVTq_P3e48Dnh3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Received: by smtp-inbound1.duck.com; Mon, 18 May 2026 17:22:35 -0400
Message-ID: <D84E63B2-78FB-4CCD-94B0-2AA54F281D19.1@smtp-inbound1.duck.com>
Date: Mon, 18 May 2026 17:22:35 -0400
From: hfzz7@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1779139356; bh=sBrGlY1lYCCIxEza2kotgft47xX7trkb8h8NhPnQecE=;
 b=PzAJ5wX4Oaf6idvP2r9DpVRe0A2FGTgXaJFrNs44w5tZQEmHL/6Gzm70LR8ngKl4xvgEgX5HJ
 ig+j1faE3FD9jrp8dpmM1CWql3fMfj85JavFp2zs+U0T2YfWF46NcXB8rPba2YCq/msre19YHLN
 laB7OJEWRdPlUbMxSIoQ/DI=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[duck.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[duck.com:s=postal-KpyQVw];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-36614-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[duck.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hfzz7@duck.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,duck.com:dkim,smtp-inbound1.duck.com:mid]
X-Rspamd-Queue-Id: 6D91B573C59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 Yes, that's fine!
 
 Thanks!

