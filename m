Return-Path: <linux-wireless+bounces-26728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD2B396A6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39DD7C4FC7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF92C11F2;
	Thu, 28 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo52Ygiv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A933EC;
	Thu, 28 Aug 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369024; cv=none; b=BRI3pGOm2LIvD0Y/hiydmeTZXJr20dEXdD/MIeR2zlIAsIdiNqjV46gW6hp1Gibn1wqpUMFZm8Z3vpyO2AYB8j+JrYfa9O4rPNRBg1+WllVowZLRpPT6SoE0PeQGf+ottBVxEQECH9Fh1FRy18uzj2Qme4VpV+fThCY0cswN8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369024; c=relaxed/simple;
	bh=md0fuo3Xq/Ahb18PZXxjPaMuI/v/41g6yZBBe+Tg6jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/G1myd8NLDPw/BIqgnk9dCXb7oymNtMyQlS1zWTuH+d2nXvIXujZsU/NwQyVI6943Ba5XJ+kh7UmFFz6o+jvXhlezDzDBlCav1i/2jZvhNc7WHvhAysko+RHVRIsIC2u2KHxMdLUeFevCDASlWhjOZFDKoIbiH2tXwrm4lGFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo52Ygiv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so572563b3a.1;
        Thu, 28 Aug 2025 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369022; x=1756973822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zylwBWDPXVKWmm6Hb1xihjAItLPLFQXPFZ/9sdXRA+4=;
        b=Bo52YgivMrH+vPEeHFw+U6Z6dTtTzj85RoS7IpC8VnazG5b2zC+qXqslIYTH1OFw7g
         wMsPjWH5gk+qv2bB4dRqBnr/vSzEov/3Kq8SZaw+zc+7FWy1iYtIMW6kvRQqPI/p6Hos
         tcmjbgx0Ln7OMUuJopZJfz4ym0uEg+EmWT+3ZsI+8WA+Ua+EIURlegyD0ztUuLEQfdfm
         xIF2vkG26oDbALfSED9UqrDmILVn1vCfQB8RM/nKXUYrKuR0ie34nKxZHqqBg9ANq/lp
         FKbOghGzwrHHTuCAurL424aDsDac+mGmp42y1JIWEz45VHAg81/2RFdQyveZakCxXdSs
         YafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369022; x=1756973822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zylwBWDPXVKWmm6Hb1xihjAItLPLFQXPFZ/9sdXRA+4=;
        b=mWWoK4DiDczlUUQP7kVS8AbbYIcSJfpZCiIwUfh7C8mdaCzkOlLDVBPvfLheZ9i6rN
         nfUqd6O9k7B7PSc5DVDrfmTm+zC2/TwwRmiqM7l6beLAAmz6h7zHN+V7QmBZIoDleCu4
         IDwCE7krnH5x/mp0LjnQDE1PPpjzsa4u02dZkQp5IRD8eShP0UWx9AMF5FSY3sbNde6d
         YsmeN0HKtuc2fInL/BTjzUevD1qwy+8S4aR7+PAzQIk9M0M3ilnW3sbLgcWWJ7uszONC
         +DgWLR53qNdkQWmMcfJcVJceTnPxDa10B+dpgUG/0qSTd9YLi0ej6NhJlv1C5n7Gw5Il
         a+5w==
X-Forwarded-Encrypted: i=1; AJvYcCUzplebu6acHJHb9zH6keqYTW6Poig+8+1/vdH57JBaRNpSs9wVWhA5z0SGBTItOMvl5Zuz7LE6idDDod6G3Q==@vger.kernel.org, AJvYcCVCqmJ3FVYlg2mvkAJppAMob3+btmXQXY/CV+dqIeO81PSUgg7iYfiFfI32Fckmx5nEPwgpBOO4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Bv+qJg7E95EY9g0JhpBShSOOs3RmEjC7t3rbv4MuBNfNB1fC
	uaEbnjGHYkgzeLaPzTmmZNdcv1tpsOyJ5oP3Q3xz/xwUXfAS/+QxMhIffd6AKqru9mCPgA==
X-Gm-Gg: ASbGncuFv9ONBwve/Zt3PZEvSzK+7FmyL4XKxBxhcGwBARU65M9lJUONl9Aq4fZQzf7
	YqP8sWBUC5TvQyZatb/JKdldLceQ6vwi3ywL4YaCEqWKK0qkErrhSiG3HCriTXQwishb0woVkSs
	XCXkJpo/S9wEl/YVylVxi2zxW/CL02t+odUueZlutFZNBb8j72YJqvfNRt5llI+QCNJmjQoJX3x
	gUDilzNBYGDYAd/k6bLYKKcjIzvqgPI9t1oWu2ryXAJcTzStyHNb0kvNV2wyDD5zLZbcqtWsQLA
	GQxNMc91+Xi7xjb0UDycaW7jSKtu54YoCtBgHnrC2GJab9gpvt1Zjwmz7FTxaXAmGpEPCT0WB9T
	r1nUnD7JCatdoqD5hbHhvupEHGWuwfpJkhg==
X-Google-Smtp-Source: AGHT+IFU/oUYYFEJNl7dghU/fGn3FtJeONFm7grPU9wi3QdtaKQSDTq9heigSyGvapWGGtwDUc07dg==
X-Received: by 2002:a05:6a00:14c4:b0:76e:7ab9:a239 with SMTP id d2e1a72fcca58-771fc292df8mr10407594b3a.16.1756369022395;
        Thu, 28 Aug 2025 01:17:02 -0700 (PDT)
Received: from localhost.localdomain ([154.16.27.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77213559a3csm2280789b3a.63.2025.08.28.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:17:02 -0700 (PDT)
From: lifangxu <lifangxu22@gmail.com>
X-Google-Original-From: lifangxu <lifangxu@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: Alexander@wetzel-home.de,
	johannes.berg@intel.com,
	johannes@sipsolutions.net,
	lifangxu@kylinos.cn,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Withdraw [PATCH 5.4.y] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac
Date: Thu, 28 Aug 2025 16:16:34 +0800
Message-ID: <20250828081634.2192-1-lifangxu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025082749-strength-baffling-eb44@gregkh>
References: <2025082749-strength-baffling-eb44@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your feedback,

After reevaluate, I found that this CVE-2025-38643 fixed warning occurs in
wdev_chandef(net/wireless/chan.c:1552), which is not added in
cfg80211_check_and_end_cac before kernel 6.12-rc1. 

So, 5.4.y appears unaffected, despite introducing commit (26ec17a1dc5e).
I'm withdrawing this backport.

Thanks,

lifangxu

