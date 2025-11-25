Return-Path: <linux-wireless+bounces-29302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F9C83295
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1BF834A301
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13061DE894;
	Tue, 25 Nov 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Nm0V6YdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB41BBBE5
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039579; cv=none; b=rqKiRxO4vb/hDnQppYz2SuK0d/E13+rvU3fmgeIDWWc40OIZ5eXecxBpAJgxOE0zwdwYjysASuqwVj2rFG9Q8mNEw4jNNaxn0EZZVPnfVqwAW1GN/++bblkZJbe6uNqIuJ9u6ZNjUCEzDLF5fVTO86WLAJblXZNc24thSFgewOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039579; c=relaxed/simple;
	bh=vEgus/Ydk+oE2/e8w9heDO98Ql/2sVRhh2gSz+9LzRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGWFo1vrK0d2HIr8Xg+dN59SoWQ0bsDfDgfJDjWe2ZqgP7bBAx/4rtsxD688hs7klrpskSEjOKNwtBJvFOCQ/PnX0Zc4jKxTXI3AcELQJiNsfutd9hdefrq2ezs2kGEVoXrpQ2ZQg7L/VA2gFAqiuIW0IwznvscAZkw4Ie0JDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Nm0V6YdN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29806bd47b5so30482765ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 18:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764039577; x=1764644377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVWN5X2t2bWOuYmZxBLnfDFzNWOHtBTSTNiTDLVTE40=;
        b=Nm0V6YdNdOZET9clgD2govSgq+mHz/8/KUDSk/ZpSLKc5XMTE/ivgmT7BvXQhzKILa
         vEZKx98a8EX2VWEv9KXwaHd+ECpl7/KmdWV4oUCsawFNyHm8Yoiq1jKGhVTRQ8sqIbeW
         Bp5Zt7bVS3eWqfCrSZSb3sFgs5jzulrOMnC2RCFBwVMV8GgFGuG5KSorBhmMfE/MEY9b
         Z8vOCoRlGcAsnUGNprbtugQRuKA9BmLV4iGrJ3KpYOrASs5XeXyXCUgWhZO9Lizj1rNG
         Yo0qyRZIfshShORRXMNNFaCrJvqa4TI6DzEWkoNTNK4tnnSFd2YxKy5ZAUEADkUNooPD
         IwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039577; x=1764644377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVWN5X2t2bWOuYmZxBLnfDFzNWOHtBTSTNiTDLVTE40=;
        b=D3fkgcmnXWk+Jmz6DqQS7BlrONrCyt0RRskBdIpKtGxqq10DhPYZDauTf59gFoiQj4
         IH80Lti++X+CFaM5K61JaiYC3VNSRM47bVZ6Ok8iZBXk+XHCcbJ6VdwLPOEEVkHkLH8j
         mviNP1tE3lwnkMMRvSqn9t05LmN1CGx1Uo++e/v2ZH2/bQT3z7qXzdbpvkIyE6e/9N1y
         ZkjUtwzvoa2KDItC+KAMpu0NEDYYKZqnv9hE9Md//+3DlvUbksdzoyZ11lGg8jF8gbaO
         XU1CY0fhBPpR1XyFrWozLWTQzPUqpPP6C81/BWgDMuDQXN1T/1N7boLKt7i/necNSRTM
         ZcLw==
X-Gm-Message-State: AOJu0YzkY4NSwYQGIX/fv546sKlSGRblZQYiFQVtfmScUJhmb1saaGWV
	JLyRGIJ6gsatoUShshBH+sJ9eRN6LoRqtZWRvM49x66Dq+x8hWpnXvjGYLLz5S8X8q41XpBaZdN
	jHt5tEzQ=
X-Gm-Gg: ASbGncu8wFALLwI99DHdbSqgFmzkz5vGAyZITzU+/tBU3SvQkTj7ZwU3Iu3RjHoMIDA
	Pr/txP6jXYBFZ9gWaT86gk6UcUHY/BvPyIoPvdUqQeX2ZZEz9nPmPTDfw7v25qrIdpMEW2UOydH
	vgFnBf9Ko2cJNNUFImGhDs7hNdfEDRZrMi7tVdYlx16Y+vjC2H1MWn3EP+YuD5Hzt+R8AZFRCgi
	RyPZu5e8EI8OEsxHq/dIYoom4BshCkarb2aa9gYpnyFJIw2o3jiHqMHC8F8/+CJ8Vs5+JOf4wtG
	XcBHcbSwfl38ir+SXMIW/2e/oaSfyguQFYcvJF7EznxXpXTQjM6uDsBy7SLWJcvck8FGNieRFkH
	83oV10Umuu1xOW6a1IiIG9Da9PCNB9j2eoSKYCAYgD/mINbXf9jfz7pHc1XgQ0y5G+bd1V1p8yX
	NqJKc7bfZC23OCMo0tCunzTBjSIqN7gGOgNpJXKq1XjGuCJQy9ME1fVDsgEWlO5OYVFHhaKiupN
	7NPsuV4jjpH2fmh/LU=
X-Google-Smtp-Source: AGHT+IH10rYYhWuY3Kjx/zsBCVaR+sO3IJVcIbuq9Mmj17xqpd+y1ZD/sJOf2u3GqWyJGDikkGiOCA==
X-Received: by 2002:a17:903:3847:b0:295:24d7:3798 with SMTP id d9443c01a7336-29b6c3e3f31mr154169825ad.14.1764039577262;
        Mon, 24 Nov 2025 18:59:37 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e9b1239sm14549915a12.15.2025.11.24.18.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:37 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 0/3] wifi: misc S1G channel fixups/additions
Date: Tue, 25 Nov 2025 13:59:24 +1100
Message-ID: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some additional information specifically regarding the channel context
implementation can be found in [1]. For now it's very basic, we only support
sharing an identical channel context.

[1] https://lore.kernel.org/linux-wireless/b39b8cb5989fb1744b5c609d4d467b248f217de6.camel@sipsolutions.net/T/#m4cefcd7c644175261f540900defbc7127b3a6364

Lachlan Hodges (3):
  wifi: cfg80211: include s1g_primary_2mhz when sending chandef
  wifi: cfg80211: include s1g_primary_2mhz when comparing chandefs
  wifi: mac80211: allow sharing identical chanctx for S1G interfaces

 include/net/cfg80211.h |  3 ++-
 net/mac80211/chan.c    | 14 +++++++++++++-
 net/mac80211/mlme.c    |  9 +++++++--
 net/wireless/nl80211.c |  3 +++
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.43.0


