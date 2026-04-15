Return-Path: <linux-wireless+bounces-34765-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN3eNNhz32mFTAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34765-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:17:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A03403AAC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8713015C8E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67F366575;
	Wed, 15 Apr 2026 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAsO7Mee"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB42367F23
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251637; cv=none; b=f4o0viDdN4nYz+jP65DyIbEgq1LUve6Q70uIdy8+DNx3gmOsLc4Lh/B95+kH5oRBQ3bfcjW2+JBuO2v14kaSHZwq0TRcvYQNyckFmjCrC3SpP8Vf8KKUhXuw3jotUMsKvllfWpipCaldmWNfwcXPtcCN6SBEg4CC0FAqSTe7QHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251637; c=relaxed/simple;
	bh=dy4wkkhXv4bsUtA/u0OPZxF1lQyfau0EumGslG9Fl1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA+lSI9COD6PDPio3soNxCSYJjhDp61Wx9BAr0+NbX3SX3heeYAJ8eavutaeyJslOu54p9dFgWZ0oS2S1k84kprMgCHoj7D2a0Ul+0XWlKs0cUG8Gmq8FN3xCmax9XGOUaxIoMQGuvKSKWqRoHLXDtfX/ayWbeok0MWFHXN73g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAsO7Mee; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488971db0fdso66006325e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251635; x=1776856435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftwnJ4t6FsoldVazgB075ASjN9AOKQcVGQ0JpGej0m8=;
        b=oAsO7MeeZQZLoMitIDw/7STRqqx7fsXhcg9Qos+JZ/bA6MDQXzMzl+48CXowHAXL+Q
         xK5PVx9KQyrc0TeBwdWqEMZKDTz/6gfQdoj0oOq7tv66gp+m+ft8ZZBEpQeRLD3E1t01
         FMpHFQFS8DMpWHJWnfuDH8GXX5UJ/9y0BU5XJUwS6/tFA2XYajJF5eX/JtDzQQk8UQHg
         p7SxzXriP15RD5tzpWL6xnjmEznim4+EO3GBPHUmdixS50rndXb5cdp8/PIAY5JBrNdW
         hvPuBFvPJL5OAZEm9hvMrUV7gFMawrInvYTn+FQfoNU6Sfb7s+LNkeDK5P7svguGpJwt
         84KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251635; x=1776856435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftwnJ4t6FsoldVazgB075ASjN9AOKQcVGQ0JpGej0m8=;
        b=CwWjN0o6ltfCnZw8EVnibJKgR5ysTXxNuyfJf85vdBkJxL2oKma0XDbK5x4ids5O/q
         R8udftYiMQ5PbSapWERAF4IJ7yzGtcZTJVDs8rNDzyY1O90+qA9Nzfc/5g+wHsinVybb
         b+jmOJqJucdgeNncJc1fSOo4Jct2QZJFt27wr6W+onHfGFb5maZJs6fMeCKGqHpn/rxW
         s6WGhNi5WW9foOqdPVztaiIGQb2P8ZsntNPzG24vx+imA8Ts55aaEVRPV1V70UvWausO
         hYV50+sz9VIzNyzRzlvWESJALlnx54EAhHL+PIBZYvVLX4h7nxO1nj+SyuyRpvi+zVd2
         VBPQ==
X-Gm-Message-State: AOJu0Yxudq5mAnFTTWVyEJ14De25xVOmo23RmcGTfuUSEZ0dORn/5C3d
	r+FqSEJpGh7A9gdRfZuXjXeiPe7r3h4biknMRK2DokEbLVnULQipM5kd
X-Gm-Gg: AeBDievr2v/POLsoCsZSKKJkHcfJHphiSM2+bkXZLVm21qFwzRUVC5Lel4ePNP/xNmA
	78YxqlsG4tWNgBavFLP/8n3quFoVDGEw60cQLvz8tWRnl5OHuu7KWtwwxvG8oTPZWUWFK10MbL7
	7XYtyGEqKiIoN4JAyCVFXUDnOouR0ksH7LUHUFp3p1G53cBAJDghBcrHhkRB+W4iSp/hWJKR0Gh
	aaHZoXHPpAzwCSZEG9dSa2S3dnGqYMQf813+biBzRnY7LnT98Thtn8ucH7Wx74eexL5R8YfmGrH
	OAB9RnplwX8YCYXc4P5omZF+5upM95l2krVgh6A8nkaGAtj0VeSYqUxq6ifLRUgF3rMAVGA/6+1
	kEiZwuI/FaLwj6QSKSTGhdWA4mwtisIwGKN8Gw67wEhVqBuiG2ufLvrR3j6WecHoizrLwcqI8O4
	072LXnptsqU91341BOW89evld0/NO3A3sTkDvblX1MLbO8Yo3gFsyTcStLoG7yXHvw7Bs3
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr282387305e9.13.1776251634708;
        Wed, 15 Apr 2026 04:13:54 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm17995625e9.28.2026.04.15.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:13:54 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	Louis Kotze <loukot@gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: phy: increase RF calibration timeouts for USB transport
Date: Wed, 15 Apr 2026 13:13:38 +0200
Message-ID: <20260415111339.453602-2-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c722d16dd57041c8ae1b0b3b386b5cbb@realtek.com>
References: <20260410080017.82946-1-loukot@gmail.com> <20260410080017.82946-2-loukot@gmail.com> <c722d16dd57041c8ae1b0b3b386b5cbb@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34765-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20A03403AAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 06:32:35 +0000, Ping-Ke Shih wrote:
> Looks good to me. But please change comment style.
>
> > +	/* USB transport adds latency to H2C/C2H round-trips, so RF
> > +	 * calibrations take longer than on PCIe. Apply a 4x multiplier
> > +	 * to avoid spurious timeouts.
> > +	 */
>
> For now, we don't apply networking specific comment style. Keep first line '/*'.

Will fix in v2 — thanks for the review.

Louis

