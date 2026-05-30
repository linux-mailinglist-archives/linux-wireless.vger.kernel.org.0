Return-Path: <linux-wireless+bounces-37176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7saLOlcHG2pJ+ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:50:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D060DD52
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A354F300EFA2
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFD2F8E90;
	Sat, 30 May 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMr8yceG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4472DF717
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156245; cv=none; b=QGUN0mkS2mN+VIqu8GzF+OMSDioNFbFS1Br09UAZRhZ0JtHZupMRcWCJqx8pvxBD5pH54EjQoanCH6sfg32N5fO2Eo0NT0kyD0GGOJCwjFh7sTtIQM39tREFGjuiUpPfHni6qrD3bk7PTlo6fS8NQ73dyPsYKJxf7l5MVEQWDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156245; c=relaxed/simple;
	bh=GAHghzxPKF+WximIRHE+LY2lb0G9N+ECqFFXSMCPImA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pKJ0WGz9WBrSzYJ2//llOCfk5wQ0KWqxbn0p7j8qOa4ztwLa9FaXTBsgiVs7c0Mu6cb/IPFuyQL3f86treAir8WDgwRx7hKNpT405Wcnk+kXemXhdubxlTo+srfW2GMDzwV6IUIL8Y8dlfBYty9SrWEqmK/bZEPYMKco796G5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMr8yceG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F341F00893;
	Sat, 30 May 2026 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156244;
	bh=IHt8WfPSjmtJ2S0sN85x1AXyUupNjyKLbTDlbAC8Btw=;
	h=Date:From:To:Subject;
	b=MMr8yceGUtDak7w0ES4FaMK+JxyuB12d+JAuEG7zNwTJJ66oLlv7QPysqb7Y2oa8O
	 O9SrX92CuPM7lsDoTm0TnoZEqgV/QN69e9uVFaQ1xfzSrJajazpJ1L6oFj1ievgim/
	 zjYTXXJCJOX7dYnWSkUSIXNrv32kVCWTb5xl60ZvgtKLulKiomanRnDg+XURA4rcDL
	 a2Yk7U8rj6HbkUFiiyTwKyrsnT9kELfSwhQ8bMpkDTftOZYutYCNfTzAktpZ0HHzJf
	 D2mDvyMFFlfQF/76YNrUIJVEBjjiMTCdn4WH7piqIZDT5ZQgv5szJc2hXaJ+FGYmu7
	 Xg9g5Ka+LCirw==
Received: by wens.tw (Postfix, from userid 1000)
	id 1BB705FBF7; Sat, 30 May 2026 23:50:41 +0800 (CST)
Date: Sat, 30 May 2026 23:50:41 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2026-05-30
Message-ID: <ahsHUWTgbt1OeDRw@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37176-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wens.tw:mid]
X-Rspamd-Queue-Id: 335D060DD52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A new release of wireless-regdb (master-2026-05-30) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2026.05.30.tar.xz

The short log of changes since the master-2026-03-18 release is below.

--

Chen-Yu Tsai (1):
      wireless-regdb: update regulatory database based on preceding changes

Hafiz Zafran (1):
      wireless-regdb: Update regulatory info for Brunei Darussalam (BN) for 2022

K900 (1):
      wireless-regdb: allow 320MHz channel width for Russia

Louis Kotze (5):
      wireless-regdb: Update 6 GHz rules for Hong Kong (HK)
      wireless-regdb: Update 5/6 GHz power rules for Russia (RU)
      wireless-regdb: Fix 60 GHz power unit for Ukraine (UA)
      wireless-regdb: Update 6 GHz rules for South Africa (ZA)
      wireless-regdb: Update 6 GHz rules for South Korea (KR)

Mohamed Aashif (1):
      wireless-regdb: Update regulatory rules for Sri Lanka (LK)

Ping-Ke Shih (1):
      wireless-regdb: Add regulatory info for CEPT countries FO, GI, IM, SM and VA listed by WiFi Alliance

