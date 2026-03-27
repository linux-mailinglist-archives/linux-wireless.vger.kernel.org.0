Return-Path: <linux-wireless+bounces-34026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COlZKNvpxWlTDQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 03:22:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2233E44A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 03:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37FD330FF3C6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABA33262F;
	Fri, 27 Mar 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="bOXSPqDt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F6330324
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577744; cv=none; b=oa0Y0YVc7qmUVv2oPLUP6YYR1Ha/q042ZNMSj7BkWAeJ1020apdT7kO54AY0zEmdnEJoc5PLsVSbj7bEYotY6fo/DZR7/MxL1LIoOekfXm6HDQ8sXt7wo258J5/kjTJz0hMfQjftl6G0K5oYLfafTuLxcl6YBmT8QIRHz9cDnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577744; c=relaxed/simple;
	bh=N9m3Nih2RqlMlyGQ/e0IZFCsIhVlIhon/WuM1Kpp60c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsKBnaYWwUlSxYcL7RUBgjoazfPF6toY3OGlCq7kguV4sMZQKhMolERT6U8x8TlQdzNBWPvQN8VqJ6kXCGH3p1JY3CZEbvP3P/ALeYo1L+LQeVv3fVo+ceqQKh4BPYNoipZkchRmTxih3bcU06BT9neFZtTKNNCNMi/T6AK4hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=bOXSPqDt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774577741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnYQyy4CIDZ+UDVBQhtZGfTVFPQdwxplb2xmifQE3/g=;
	b=bOXSPqDth8FGuuXnKq5tSaxICd3jwuC3C2geHyQtNrDzSmma3dMyd2jIDaA8gyT31dcvZ1
	AcXDR1D/D+EwNt/S1boyJYxrQpKBBQRBLtmAZP0Maeg+ILJQbpT+yPvSbteMfmvLzQw+AZ
	fS77tDcNctUG5fOlxfBYA05U37Qo2nr3+5w7lzQQwjxO8oqCWUBcqB6LvZtGEdsuRnSbrp
	EH6yl3j1C2mNPxxRef7QvEZwzIkRR6oY9Uz5eoWOGJ1eXf+MSFXR7c3kc1jvMgffeuqTze
	a46fpgFF8HH/VYFNM+PfBRccjWHZAM9C9u/YtU3WqQV+kzbDXWUFJz91wBbN9w==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: sean.wang@kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	satadru@gmail.com
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
Date: Thu, 26 Mar 2026 19:15:34 -0700
Message-ID: <20260327021534.448552-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260325043318.13298-1-sean.wang@kernel.org>
References: <20260325043318.13298-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34026-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3A2233E44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding Tested-by from Satadru Pramanik, who tested the full 3-patch
series on MT7925U with kernel 7.0-rc5 (US regdomain):

Before patch (5 GHz ch 36, 80 MHz):  txpower 3.00 dBm
After patch  (5 GHz ch 36, 80 MHz):  txpower 23.00 dBm

Tested-by: Satadru Pramanik <satadru@gmail.com>

