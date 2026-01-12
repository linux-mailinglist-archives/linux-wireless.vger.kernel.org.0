Return-Path: <linux-wireless+bounces-30669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBDD1073B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 04:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874A6302920A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF730B52C;
	Mon, 12 Jan 2026 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU0CVX7w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794E25524C
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187993; cv=none; b=mXjba5ZWrbUFt1ZC9AyZAbB5i5D4cznoDm9wAdbZX4CbaGX0jdOj0GWq6MUrzeBvfmaCzBPLs0/yxRX1y38U/+cTk8EsZR0ETK7UUwfMiByuGgJs9Z5z2KGRIrMSxXcuOUOh8+11lmXsJhvunkW7zldNGDe7ylGRpdQzm+dEw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187993; c=relaxed/simple;
	bh=hDdNvhCOGfKt1gICcZOGjQRVC6w20HaxiLKGAUyQsyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKV5RZlVoODnLl5Ds8Ezo4oI6C6POOujfScoIdGwkM/paSFNXf4HFhMf4DWpP0uUL2vmBdmLekKDzSd1oaKKrzCgct340O993itMtYuFyvnEirkggCPZegNgZP1iQBX6nAiZvCxtwv49jYY8Kz76H62GgysNh4IfHweewH7/sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU0CVX7w; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f39438187so595555b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 19:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768187992; x=1768792792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+HVTAQ2ujNxJ4W6xjrPPsMSHJkWJkowwQG5TNST6NQ=;
        b=TU0CVX7wHjcSkx/ZFqK22A0ZY2A0XCOFlktdK0zXLYvuHkrAvnyqphbiLSWRtt7/H6
         y//cU5nsaVrO6HReamomMvkvvpPmgzWDkpR9nKAxZjCR9okWrOynZ0nfPZ7BfWJYQ0cM
         rzFFtLtZFyGtbQ9fFwSbqqB7zPmQDrcYkuWwIPhixOy8yykLg0IoX9lfcuCPpRJky3sK
         SGKFK3L8SCJGbA2ARlW2f4lSzfJaQXVJ9+EL+CLc31d54Rx0v/cfJqqwTFVioRwS3xqe
         jPtwm1KKUtqW0hisq4dVQVSWHhe3GMOxwHvG/RxvLZF+syyvtIb95xSMpmg4sn13qf2H
         VK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768187992; x=1768792792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+HVTAQ2ujNxJ4W6xjrPPsMSHJkWJkowwQG5TNST6NQ=;
        b=GzKIVdewKcWXBfvLxavPgcXBCp7xSAsN07sfAejiFlt0rxkgCEStvFmxN3bH92XYWE
         A40UnwErKqqiZJPCoQq5UUSGjCa9QXMhj35a70AgVdVF5+jkMzdLwdE0Z3bJGacoabBx
         T/qS4vUzcYxkk37QMBVKcO80j/xMbGByUeUHYhBCvkBsU7DmYY+YdWnk8/W3pOljRcQ+
         kIiF6yp4nPbjPesG3NclIYAEJ1x0bcQ6vrPCmagAPVqguoG4Z/SX7aE4ymaN2fv4EKX0
         6IxEjv37GsBECGSWY9p6LtP9w3vfMzILFg0Qr6pTowsOGQxDocfMhCFm0q05oRa1vNmC
         CiTQ==
X-Gm-Message-State: AOJu0YzAb/j/jPehWog9ZZlXuNJ4KXZ8izHStbilnmqcsynZYLnH4hhQ
	ea1++1KlVl0d96C1VcyxPEzpHgcojdaV9Qpt38DehT18TgoGLfDGMHJcW5WTXw==
X-Gm-Gg: AY/fxX6jy6AEjKnj2c9zj4oKj33PXwqFJjoK5rYEND+ZMz8MfRucshkhiV7TbJUoQn/
	qJDJed3rQpEdv537a+BVffS/O0ndU1Smz87nWgglN4Y61gc6p8cm9rGd9KWCG7CF5lWdBt7QhzY
	N03H5j2ZSsUie4X04PK+c9gxF2QNMWxanwOJG/WewPZwAg5RF53MHaWirQiZHQCLWGbi5dQK5Xc
	H3Dq6teS5347UdZAYWDH4/qekTwNwR5U9Km4chl9D8iQSDcR+ka7NU0mt9MIn+QVWfJN7S+WuIr
	AyEQy6GP7Fw/o2Xrzes48labKs+eDbxjidHBjhYWcO7R0vNWPW/R75bVgGWAvrm6TH12jFgipXn
	AkT3MZ6x8NaV46JXIgDz4DGyy7CXr7bidWQfwzxC2cJAANBYkYiYt24RbQQ==
X-Google-Smtp-Source: AGHT+IGzrsgwdmZCaX9Tt4mYpBs9MIr3RKDU0Zz/g0m/vZkhNkK2oQMEO0Vzm01mG/ZCyE0YxoD42Q==
X-Received: by 2002:a05:6a00:328f:b0:7fc:da5:f85c with SMTP id d2e1a72fcca58-81b7f7e299emr14492319b3a.38.1768187991637;
        Sun, 11 Jan 2026 19:19:51 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dd5a992f1sm8099649b3a.11.2026.01.11.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:19:50 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next 0/2] wifi: ath5k: add MAC address OF support
Date: Sun, 11 Jan 2026 19:19:32 -0800
Message-ID: <20260112031934.44839-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit is a small cleanup for ahb, which doesn't appear to be used
anywhere.

Second adds the ability to override MAC addresses through OF.

Rosen Penev (2):
  wifi: ath5k: ahb: use devm for ioremap
  wifi: ath5k: set MAC address through OF

 drivers/net/wireless/ath/ath5k/ahb.c  | 33 ++++++---------------------
 drivers/net/wireless/ath/ath5k/base.c | 18 +++++++++++++++
 2 files changed, 25 insertions(+), 26 deletions(-)

--
2.52.0


