Return-Path: <linux-wireless+bounces-28857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EDDC4F708
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32D13AE728
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D67C274B28;
	Tue, 11 Nov 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs2XsxAq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657F3AA194
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885761; cv=none; b=fJ1KfC0/jUdNZ2Hm8Mspuy9tCfFBPbHYfp87qb+KPrHue41uUY1y/Y+t0TjyNXV9aSGPoxhbLcexg1phpBKWXrtg9V1mAZGIeRr5n0Dg0QRJnVLuUM3yHd6CoGSlmAIdcrPJmXhu5PEAYBrcFJvvd57JnwAsrxTmad3V7+d5uQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885761; c=relaxed/simple;
	bh=yyjKttti8LUD7ojC20WHyCuree+qSlftOHV1FAeKyVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUZkNjG+5+k8QxMLNfeRvTyljJrrRXWp/IBj+l9yyUDh4K9K2XPbPzq5dQSZzuq1oUTPG4eQ6fmP7K20RKyX3T0loCHWz0R4N7h4b/skW0Ew3S4bF9U6b81UML4JkXCocYbcru7GaO9G6tdWcAaMMFswuOsfliKaJiyAwBSqIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs2XsxAq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso1984b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762885759; x=1763490559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYLC74BmRstgF3ZNP+ON4FPUdIu8+29iUYCK2S3MgGc=;
        b=Gs2XsxAqoem5pNq+qqD4IuDkHSOH9xoKaEXpHZha8gD85dXqA4/nOyZm+lXbM+DLKd
         OI6guysWaxwjai/+g1u12MLdEOU7zxmZvGZjfVcQdLexXbDGI4iVQ4ur3MuGdkSR6yws
         O6NsLGrsXRuSDXEUzxufGiozMAtlFsgjgDL0/Gpqthb40SrEZbi5L+dqzldAWzaU1xOI
         0kUK7PO4MDqHeAJlDDl29AJUbW46ns4o3uJVt6xG4m/G4lH9BgTDJ1UT/8rvJimr70fO
         mYrOqRGP2y6CacTbXtZ2pJcPcV20aC3KdU5VDTimbg9sXywa3pWnUhbPMXSrdfm4Y/Ch
         O8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885759; x=1763490559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYLC74BmRstgF3ZNP+ON4FPUdIu8+29iUYCK2S3MgGc=;
        b=LS6tDweDwjFX66zC4KuuEVJSRdoQ2r0pdMhIpELHffawy2wKdZILTs7ZVSsPJKscjh
         cE7azFdEPiENDIeNJInMBRyXkMr3g3HMOf9wwBj4CLXggMgMB8fM3VpBY7M/kGv/CdLT
         LabqxWCf8rFWlqcokVLVONlK6mPHmgh4zOOMiJStrQ2idQJW4xHsx3Inkx83f11jzzDd
         ZzXQkmwgCm8TLDFUDLJBj0xzJd682ZrE/5h63tnFBUtcAn+PWtbeYNwjZoHYFod5gqvY
         VJSYfcX8vceNYyM9nmFu7+xDOMYDngIsw1drTS0jPFpCCoGSQ0bCvY0UUosAUwObZoaS
         uq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaEtOZj2Tfj5lXu5zkX4a6Q1jjuS6vdr5n12VZTqpPIYBzLvfRFAB45mJFTkGi4vfQCQbMz5QULOjS6AXL4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HZt72blc4mojrnisByulloUDiniFyJKiIr5x5Q2ATK4JhkST
	HlGB+39WEuQTa8MrROlg9Ybo+/2/JT0i7fBILUQ+nYCoK4hDQGMZLi4LiyYBiwX9
X-Gm-Gg: ASbGncsERZ3/G1+X0HAqqW5Nk8VEQK+IhvZxLaWv5SGZlmXFOqfYnY1DdnUYZPRwcxw
	32NRteweJyg2AX2mnc/5W5e4HCtyuzOaTkpHC9rr2gc+C/pJnE5qkrOZ5ZIAAz0T1hNF47e7pM5
	ViX77HbXKkCIh+5THeeAoJAu7xP/CA/oosHzFpTXiV6LENOA0EQ9hRUb/lMndv6LT+YiO0IN+c0
	zmVaOAv0UUJTV8rDe1V4f+Ttf7R9dZu2TNGHgxSOSBbJ66ls/yO0r2T95iHVy5exr+eSXYaYYa8
	uBIkcYqR1+tfzs0hWgvFRadipa0jCeuP7QcaDMMjYbg1n0F3ni+qBQNOxuvCr1/mMOXil4Wn7oP
	3nXiNRHiDXrRphsGWvgyhYqMTvT9Bccm9Qho4ECLhPUMMB9kUJBULah2lTreUXGr9qT5w8AqPij
	RT12cMvvvJ93bzIZInMeZVcXcrTqV/EhQoGqMHGwqSLQTaKb0BN3jQ
X-Google-Smtp-Source: AGHT+IGoGOUQM16zfvCuyco5c6sDrGrLlf3lYUHSXllVYJllzDG7UdRaYlDMTupwDUXMaYQG/fdPMQ==
X-Received: by 2002:a05:6a00:c88:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-7b61b4987e9mr3019530b3a.2.1762885759164;
        Tue, 11 Nov 2025 10:29:19 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:b44b:35e1:6571:ff4b:b5ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc868fdbsm15670157b3a.55.2025.11.11.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:29:18 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: johannes@sipsolutions.net
Cc: dave.taht@bufferbloat.net,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	skhan@linuxfoundation.org,
	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com
Subject: Re: [PATCH v2] wifi: cfg80211: Fix uninitialized header access in cfg80211_classify8021d
Date: Tue, 11 Nov 2025 23:59:07 +0530
Message-ID: <20251111182907.6042-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f3a9797eb23d9c26007652798f14b76330aa1933.camel@sipsolutions.net>
References: <f3a9797eb23d9c26007652798f14b76330aa1933.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MPLS seems to not have this problem.
  MPLS avoids this issue beacuse  skb_header_pointer() is used with the proper
offset.

> And maybe there's a similar issue for the VLAN tag?
  yes we may need to consider this(header+vlan)

I'll update the fix by using the skb_header_pointer simillar to MPLS.
Thanks for the feedback.
--ranganath

