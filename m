Return-Path: <linux-wireless+bounces-24037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9540AD692F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB417C930
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E31F5435;
	Thu, 12 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ZoJd1Rof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E720103A;
	Thu, 12 Jun 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713731; cv=none; b=h2BPbXlRRZS98vMmZppgligQxde9cmYAalnNuO54MTdNsj0Lv10wfnXJIrACKRDicAX8TJ5yc9MN0Dutaa3/M+GufOJdFzQXT8ialB4819XDjyley0UVIxNhg2LguEz9/xFAQL6y15lDxQR8CHH6H5FOw5jwjg4yoAH9NQhTtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713731; c=relaxed/simple;
	bh=x3cQxvge1b3pgTXY/P74zyHhUe8/1LHEazQ2unbyP9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOCQSe+0S070JQyCGESJV/w8xDdJfkl3OEvPUZJiOpPv5A77JjnOdn2F3Ts8JChcvAVtAS0KOauss04wA1JtSKrMG/HGf4bjOJ2ssoCkvc/TQA3wBGF7g8xtVAnIN+Rv1425HinAqvxoSgCuVugeLJccRKG7BKBHNwshAgFhDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ZoJd1Rof; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1749713264; bh=x3cQxvge1b3pgTXY/P74zyHhUe8/1LHEazQ2unbyP9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZoJd1RofjBG3c2KRN9APXC7yxH3qNKPgwDg9QDflTXn2UCDBMYdeHUlTnQkMRhgax
	 HuzjkJQSAq9Qvs2q8Q/YutgomAfDQk4nC6GtPBRvppz43JKq9/2InUl2sQ9HhHHzqi
	 cdZfrEzrSLzDaHWpFZkaPUkhr8WE3C4IX6q5it8UJ76/lcT+O0JcPM/5oCL/kKmwUZ
	 XtMRVhnSul7lBuW1QOysqlimnKwXlmOW4I1Suuu1cZ2mqyh1v4k7ogGAsI8B9zzeK7
	 GPYQtmFJSep4xl2hOH80kBONORtLHt1HIqzf3yHPHyk5XJEUItIxTkyFXiX+ctoiqY
	 H0wuxYVu3o4pw==
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Johnson
 <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 2/5] wifi: ath9k: Add missing include of export.h
In-Reply-To: <20250611-ath-unused-export-v1-2-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
 <20250611-ath-unused-export-v1-2-c36819df7e7b@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 09:27:43 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h60lbes0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> Commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=3D1") introduced a new check that is producing
> the following warnings:
>
> drivers/net/wireless/ath/ath9k/common-beacon.c: warning: EXPORT_SYMBOL() =
is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/common-debug.c: warning: EXPORT_SYMBOL() i=
s used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/common-init.c: warning: EXPORT_SYMBOL() is=
 used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/common-spectral.c: warning: EXPORT_SYMBOL(=
) is used, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/common.c: warning: EXPORT_SYMBOL() is used=
, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/dynack.c: warning: EXPORT_SYMBOL() is used=
, but #include <linux/export.h> is missing
> drivers/net/wireless/ath/ath9k/hw.c: warning: EXPORT_SYMBOL() is used, bu=
t #include <linux/export.h> is missing
>
> Add the missing #include to satisfy the check.
>
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

