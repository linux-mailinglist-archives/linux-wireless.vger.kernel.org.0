Return-Path: <linux-wireless+bounces-31245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FuwCqwUeWl3vAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 20:40:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B04149A0BC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 20:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D5FD3008D45
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0873570B3;
	Tue, 27 Jan 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="so/rZLBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F536E483
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542824; cv=none; b=oK630R1Ti4M44RDeO+MAvy2sliiVvFguIJdo89Q/6RkrGbTabV8qcps3DG1BI2eoux0STYsSu7EBTtn/dPoBjhXTJlaii4s906/eXihVHBMypDfWc8vV3s1MJ/GJbbgoF44WUP7pfKNKFNvvi2JdYu+EnlsrJvcdqGJkHar63Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542824; c=relaxed/simple;
	bh=ImppLOPqqjlDaYYkLfDWAC54sQ/Kqeg9Abj3MzKGX3g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gP59wUujF8kKdl7VQx43aqOndJ41Semkc7Cd9GDE/nzdq+QfQxNLyYBmWrEnKQGdVm9gFDtx2ugxdjqZkYRJV/EPzJ0pkLSdnoAbQMs9Nrg0nLQFWZFIShNOFVxY7/DmXAOw5YnmW6txKpo6mamdkIvoN7SeUyou2Vm+6rIi+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=so/rZLBI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b3bdd35-b831-4274-8b91-7ab90f6d4eec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769542819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ImppLOPqqjlDaYYkLfDWAC54sQ/Kqeg9Abj3MzKGX3g=;
	b=so/rZLBIW062BEmXc0L0pDyS8tSGQV6/T6NaWEAA66Zv8TXIAtTw+haolRcSmiR6YN4iga
	KVHIsZZdH4NYKhsqTTRbY2XqU8ss45gP6l1Vn8Vk+kzX2O4JuAfpmvjMr95XP7U17xJV0V
	M2ZyizRLZCol/vOGpxGKyEoM/8d5CO0=
Date: Tue, 27 Jan 2026 11:40:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Clarification on the usage of NL80211_SCAN_FLAG_FLUSH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31245-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B04149A0BC
X-Rspamd-Action: no action

Hello,

I had a quick question about the proper usage of NL80211_SCAN_FLAG_FLUSH. I'm looking into a bug while using iwd where rapidly switching between a 2.4GHz network and a 5GHz network can have spurious connection failures. After debugging the issue, it looks like iwd is flushing all BSS entries by using NL80211_SCAN_FLAG_FLUSH for both full scans and partial-channel scans (i.e. only 2.4GHz, only 5GHz), and if this happens during the network connection process it causes the failures.

The observed behavior is:

1. iwd issues a 2.4GHz-only quick scan with FLUSH
2. User initiates connection to a 5GHz BSS from a previous scan
3. Scan completes, kernel flushes all BSS entries
4. Connection fails because the target BSS is no longer in cache

Is this intended behavior of NL80211_SCAN_FLAG_FLUSH where it clears all BSS entries regardless of which channels were scanned, or should NL80211_SCAN_FLAG_FLUSH be limited to channels that were scanned in the request which triggered them? The uAPI definition for it is simply "flush cache before scanning", but this seems open to interpretation as to whether it means the entire cache or just the cache on scanned channels.

If this is working as designed then I will look at submitting a fix to iwd, but if limiting the flush during partial scans is a viable option I could look at fixing that on the kernel side.

Thanks,
Matt

