Return-Path: <linux-wireless+bounces-34899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDcaICUn4Wl0pwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 20:15:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38A413A19
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DB23066297
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC43358B0;
	Thu, 16 Apr 2026 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="Ir+Nmd4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36392D5923
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363254; cv=none; b=Cpv2PPr/TcbVnQK4PD6EafayhHTLn8k8Ot42SRkq9zgpXfJsZCzBDM+ow6DwLAs6LsTU9FZ+fr3aFpJ5ELYMBDvZl92peysXWGTImMgt9zrAWXb7JHXAcbHmjI1vhApsT/EjHom0EK0yb7GkPXUZtxbM6nyk3hhVJi7lmOrocRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363254; c=relaxed/simple;
	bh=TzEkliqfP958vyxMkoiEL3VNQXY3u/AuZ1NOlVunW0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNNhwCgY3yDe66fXcxEQQRdOyEMo3ELMKm0d+nP5khhvydLEnP5EncQh+SsJjXZKqt/sw4h9Ut0JyATNjy9/b49sCWdZXVwGLlNyx46uFCPcM39EkYhR4CJB45ye6boijZRPhiBdlJVeo5zN+7Ft8F9VDuNHmbR6BlrVi81pXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=Ir+Nmd4y; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1776363250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzEkliqfP958vyxMkoiEL3VNQXY3u/AuZ1NOlVunW0Q=;
	b=Ir+Nmd4yAfqjc53A2HMLRUEkTSBb1/v4PM5c+QKHZNSTQVgumW6rBZRDIQ5ZtrIjUzVSur
	DIgkPZVZZKhIC0kan/1APJs7VdcFd1EeP/OBlnjcDomeCW2RMzrhtzmm4tZOYzt5iJsqm0
	XpwFD5+0mciGbug7kBpEtuYkUsxzpnvdleQzzo3i04Ei1i48+Wuy+3CkqCBVlmctu5btMv
	uuExLTwAbeDhvHoL5Jqo5myhrw3PaIOVYRVWUGMiUQUCmVrzlJ525RitumIaTEefJ/B9Dz
	KhAMH2alPonmPJDe94WRqA2cWvh1hzyh4PH74fYbYGveskcdX9Muq5KfFUzjzw==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Louis Kotze <loukot@gmail.com>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v3] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Thu, 16 Apr 2026 11:13:55 -0700
Message-ID: <20260416181355.24099-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260416045536.817930-1-loukot@gmail.com>
References: <20260416045536.817930-1-loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34899-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,realtek.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:dkim,justthetip.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A38A413A19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for driving this through three rounds, Louis. And thanks
to Ping-Ke and Bitterblue for the review cycle. With v3 applied
the DACK timeouts stop across every rtw89 USB chipset I had on
the bench.

--
Devin Wittmayer

