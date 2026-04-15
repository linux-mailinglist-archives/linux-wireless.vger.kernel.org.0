Return-Path: <linux-wireless+bounces-34766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D9UGglz32mFTAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:14:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C654A403A0C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAB8C30A36B2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74293366822;
	Wed, 15 Apr 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCecPgnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F9368275
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251640; cv=none; b=ENwjSiz+7ld6o0lPKZ7TQdPbsmj4bo/x65+RVjar2XhCHr0H0MPhYOq8hVGv8g1cjbq416vSbXCeJUTVouTvDm+T6t2ENaZXdMQ4VWGInJk6N1jcygd5I+ejnUIhBAJKhvQ9Dr/GbODzj3XVQd/yEjRz4Jkppu6v9cqpJbppRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251640; c=relaxed/simple;
	bh=Nzfye6tHH6Yocnt3whTFhpZ9gV+CeQ1OOIiEW1XvhTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuYf/YFhVHISp6lL+zafDzKf/HwUYBy2fIS1Xg6dbA0DPWY9wR8JRBRuqvFUKT6F24jjvcbe5367uqBBYZoItQMVtSpZIBg54bret5Ue6dWruKPVHRR9h5VmX0D3yd1UgpPN6a8zsnktXdky0fDnx580TSjV9FpwFERlKJRB9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCecPgnF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso36942875e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251637; x=1776856437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzfye6tHH6Yocnt3whTFhpZ9gV+CeQ1OOIiEW1XvhTw=;
        b=jCecPgnFK8JzQlsvSZji2Vlgik3ba40i1kJGn2GBLSw/3sY1AthGOX5It26JEFKHYg
         YqjzAwE+zuEMFfI7hhq9LwsbTqV99SAzB9DpL6/7PIcw1idDxvHl2NMOyqijlqeS/9RM
         6hm61C87DSzn39mVkYDiKxoYXPJJ7c95o0rRip3oX6FtOe0Mjn4VSNW90U4vgpnCwo3Z
         r5b0wDMmDvdDy8TDW0IcpMXRrFzQ1EvLXyTD6rbRANMG0FFYiZbsQgAdTENHZmcG3/c1
         7YE1qhS3v/w8YgnBaFEHu+8ig0Nkk5GaOUNzHv9RGP5cloQZnch+7xft+ycsSYFqsKcA
         L3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251637; x=1776856437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nzfye6tHH6Yocnt3whTFhpZ9gV+CeQ1OOIiEW1XvhTw=;
        b=psEQMgy3GW2tz7DUwWFrYLGPkA22TbnSK0VhA9Pve95/F28NaDRtljpbXXJ2OUQKoq
         oYim6qGfiLk19Qrqk6zmXY/MXZKPwS5lBhC0uEmICy/y5/3odr1HuH9ecPW4VxZ2ukiQ
         XHFzWeFqt3WPz2OfDccclFksjXFyQLdlzjHt/RA0+hBRVI0HrXcxM/pz+DqQu/4DlCUr
         7sf2Q927SFv26ajAtzflkit/MwA+mRjtSXfxWAVjXN61teWE//t9mAW+R9qsfoARnZ7i
         C3c9g5yY9YW8bF1fiKTkjvcnHHyBLywjJkeBenqkG/tpZDMT2tU76dD3VDIH3IX3Ide1
         fb9A==
X-Gm-Message-State: AOJu0Yyv/tPFrhXsVs+hZZWAtsfRErIhAhAsYZnGj6RTLuzqrOzjaRCo
	mLtHgn8fIOW19OyoI1dHlFNI12+bWtG9E4QihXO0l7uSaM10I/IL17rz
X-Gm-Gg: AeBDieuc5nO4eS0Yu6Adtj/shzQq+SBisSAaI22+b90CkVfPPV5hSdbuLOwzzOogTEr
	VzHeu0tZKu7CN40tY/wmntt0ePAUzTexBsysu6msLClYew3BqS2dOjyj/aXvXQT9ByUc8Xebmtx
	0dlezodWpqh8rpYbl8LTi+BAQ6U+N2t8zKz1NwWAXdCS6b1G3WQJZbkeqpgU5R7JVs1oBr5X98S
	ufhB1KGmo5qmsntoLQ1r9HJ6KiALAaTWqS6tmh8UlBp12M1mJjBSaXSklJxVFOux7OQ9mzac9wc
	fBvJH6st6HnGEgPw2dmEeE5lSXA7ZgCQzc+IYjIrjqpyvBWnnt/S+RsuR61jIpmZCHoj79w8OPJ
	3WeDr8wupdjOAINVQ2Uf9ZsO8gCtmd9LR6uESkThEvnX7+BxMxtACvMgB17TMC5U5vvBOZyReaH
	mSvU2cj8u1iwg760WhnWYeI/o/trFTARcppUsgls3bfArHX2CvObpbxwiGTDjfYqjbP4F5
X-Received: by 2002:a05:600c:45c9:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488d689d277mr289294075e9.30.1776251637396;
        Wed, 15 Apr 2026 04:13:57 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm17995625e9.28.2026.04.15.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:13:56 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	Louis Kotze <loukot@gmail.com>
Subject: Re: [PATCH 2/2] wifi: rtw89: phy: make RF calibration timeouts non-fatal on USB
Date: Wed, 15 Apr 2026 13:13:39 +0200
Message-ID: <20260415111339.453602-3-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9f43a228419b44b1a55ee3d8c31abcbd@realtek.com>
References: <20260410080017.82946-1-loukot@gmail.com> <20260410080017.82946-3-loukot@gmail.com> <9f43a228419b44b1a55ee3d8c31abcbd@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34766-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C654A403A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 06:39 +0000, Ping-Ke Shih wrote:
> If calibration timeouts, the performance might be bad. How about just
> to enlarge timeout time in 1/2 patch?
> [...]
> It seems like we don't actually handle the return code for now.
> Could you point out the path you encountered?

You're right on both points — dropping this patch in v2.

On the return code: it is indeed discarded by all 8922a callers of
rtw89_phy_rfk_*_and_wait() (11 call sites). My original "connection
failure" report was the host dropping the link after repeated
"failed to wait RF DACK" kernel warnings, not a return-code cascade.
The 4x multiplier in 1/2 already fixes the observable symptom.

Also, on 8922d rtw8922d_rfk_tssi() does check the return and uses
the failure to fall back by clearing is_tssi_mode — making the call
non-fatal on USB would silently break that fallback. Not something
I should ship, even for hardware I don't own.

On enlarging 1/2 only: re-verified the 4x multiplier under stress-ng
(CPU, memory, combined). DACK peaks at 71ms on 5GHz in every
scenario, including baseline idle — the calibrations are I/O bound
on the USB H2C/C2H round-trip, not CPU/memory bound, so host stress
doesn't move the numbers. 4x leaves ~3.3x headroom on the worst case.
Full matrix is in the v2 1/2 commit message.

v2 keeps only 1/2, with the comment-style fix. Sending shortly.

Louis

