Return-Path: <linux-wireless+bounces-36282-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ONLNYCWAmr/ugEAu9opvQ
	(envelope-from <linux-wireless+bounces-36282-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:54:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FD519106
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BD9B301D58B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1E5376BCA;
	Tue, 12 May 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="AYYUqi/U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDC3750CC
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554492; cv=none; b=pglqcBbxrpIBHDPrTQMX0WQCwCesEq5MTMMjen7RV+W//ZHJz8naFcHWfPxZ2jFXXf5qjsAVM8VwGDskBrte9ruZEkv8K3Pjs9IZ1VIoGxXsVb+YZJzchA6sYSf/ZfDZjWmPEyP+JM2EFRGciO4F1VzHr0f2nx5nwB2+8V6NmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554492; c=relaxed/simple;
	bh=e+ohW9JJLcaqUDrI3E8rlpqXJm/Tx08sW4dcfg0bFw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du64VCMfaPFnbaNqy+7Q7fwn+iVE9QDkWfx2sSAFt1oQE7v3T8X3c7qv4BJHjSoyLAyc2Yv9MWooEgjzCjU5z/9Xn/lzbvH9qyul2ABU9ejFGxHjZVT6QpMyAeXGKxRzVl2pydNoCiLa14jORu/xtbxqfCaWOKHNd53uvMXIMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=AYYUqi/U; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778554488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO2XMuMBi7gz+MqflU8/Nrh5rmVDN9Fq1fODQldLoHg=;
	b=AYYUqi/UnDUJo/ga+mgJDkuoM+9pO1Ins3ldUpaEgpqCyGE/z7Io54B5ZJskUkMMCKIVQx
	rGHWfM47ABUWGaZB0y6205azyRL1t2l5hq734qmleGsxMf3x2zDGSuvSkwb0pPe1VtlYvl
	m65IJbcyU26hLMt289TDrL/aOZyv9+MJq5exHBpq0MhHRGKz76nbYrbaFCQflhYuVzLy+s
	SGUQeNFJiO0YGlCR3mUYPz8/viHiE4Xf8NB3sKgv/nbfa8YGzf2IWalBkVbLYffw7+0viV
	B9ubXjZZVOFOM4sCQ8W3Ou2dsqAaz5G6mOeC3IjZwGCS0DcB8R9qKQ8Kx+VUtA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: rtl8821cerfe2@gmail.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Mon, 11 May 2026 19:54:44 -0700
Message-ID: <20260512025444.49247-1-lucid_duck@justthetip.ca>
In-Reply-To: <e3ae58133549411e9eeb88c7c6ffbfaa@realtek.com>
References: <e3ae58133549411e9eeb88c7c6ffbfaa@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 590FD519106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36282-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 01:35 +0000, Ping-Ke Shih wrote:
> As commit message, only RTL8832BU and RTL8832CU were tested, and WiFi 7
> was not neither. I'd give positive list instead.

Agreed. Tested chip set for this patch:

Bitterblue's bench (per the commit body):
  RTL8852B: RTL8832BU
  RTL8852C: RTL8832CU

My side (per the v2 cover letter matrix):
  RTL8852A: D-Link DWA-X1850 A1 (8852AU)
  RTL8852A: D-Link DWA-X1850 B1 (8852AU)
  RTL8852B: BrosTrend AX1L (8832BU)
  RTL8852B: BrosTrend AX4L (8832BU)
  RTL8852C: BrosTrend AX8L (8832CU)
  RTL8852C: EDUP AXE5400 (8832CU)

v3 will gate on RTL8852A / RTL8852B / RTL8852C. RTL8851B stays out
because no RTL8851B variant has USB 3 hardware (per the in-patch
comment), so there is nothing to switch to.

WiFi 7 in rtw89 appears to be exclusively BE-generation as far as
I am aware (RTL8922A, RTL8922D). v2's AX-gen code (R_AX_PAD_CTRL2
writes) would not execute for BE-gen chips, so no WiFi 7 chip
appears testable for this patch by construction.

Devin

