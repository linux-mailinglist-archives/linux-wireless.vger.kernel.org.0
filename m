Return-Path: <linux-wireless+bounces-28153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23EBF8CC8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BA4F1B81
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF3E27F4C7;
	Tue, 21 Oct 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZKr41es"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC626FA60
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079895; cv=none; b=dB+FTmMGIadXlN9KupwQWSDrLlKq866OtGW61DGXxh3H1KbR50iTa5uH69IxvYp1+2Aw+8CAKj0j9jcIMcZDJiL/Z43m3lSZ4a6hjnJ6Xe3Md9kST47PePKxvi+VWuyyN6P9TvR7bv4jOB1fFHZqSMC/rS0zwy6Ce3r0K6pQaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079895; c=relaxed/simple;
	bh=hGOoKoNVTOW1YAQ23TcPbattFNEOGys+peL80o4wjno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXfkbVIZYrbsxNadlTH3VS3gkzB8VdqABG4YtH9uYHxB98Wf9AG0Gna6QHOCwQKc/O3KFNh+91Jf4J4oWxaA2ctUraRzR7H8qoF5+k9Dq1uIngRvNDBJIKLkJhcTJCOm47McrzKhD97Cm9HjktwRatnkzj3mpOWijEsV2M1yCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZKr41es; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so5232491a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079893; x=1761684693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aND1WBYr1CRE6IvHbMXsbKd4Y40zZjrhWpBDu/cAQsg=;
        b=PZKr41es1EEk8ysU8lHfB2FSAOIT0ppYBJcFLZ+ahfAJj5+BPHeFr9pwVQ+D1wIlAC
         AuwaLzIHdt/AP3s6BzePqEfLyCS+nm73YULdCIwhoHZxmXXm2qcsu+6HjsPuzqcWYraE
         c94/Kvnuplhtb5bdg+QUV5PQXdenZJCnIKeTMW/dV07K5k5QXg8tLl8z+bsqi0oqZA6W
         x150OTEaFNhMUfaoHXAIONbe5VCZ52oJC3SroNaC3OLXMhlr8YFkXtzGPdz3b0qnm42i
         hyZ8lqU9wOKHV6oBycHS+YBP5LV6pXO6GW58OzLmp4S2mNe9001h3G2o5anVVKzZpqZq
         pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079893; x=1761684693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aND1WBYr1CRE6IvHbMXsbKd4Y40zZjrhWpBDu/cAQsg=;
        b=nJbFz8nMyuhlj2839sMEPK4KFYoK2sm1ZXv2sdJjAngQeUqmgM/6eZfUntTGbh0C4d
         YM7kZiJmDpwK4DFCDGvEasBQFalZZvvyTO8N8NuoOLs9lZczHDtyr3LKodK46eLJ2n/r
         gXnOmyLaPCDYUw1d7MlN0hYfPW6LB7GLSLm3UDE8ZmK7dL14ZCMw8ZnfOGafSH1kvEKk
         0AjEv+6LKIluzAu9LjKXPBpj29JL9bXSFQtTCWd6IYHJ93TXqsIQtjxeJGodP53pbexE
         vKjqz58YqCFoGpfcxmJYO8KJnvDfz42ZxcsTpwQ1OilP2SUwNz4ZyHcR8xr4XErN7Yw/
         w1Fg==
X-Gm-Message-State: AOJu0YwgCCBtpNIUbKuXSOn8EaiUzPSj3C1nKCQmv8VZ0SUWGP8gjaBy
	CytOC8QdUmjZ0124iR1fdRGE/E9BXYVTrB6+vW4C+xT73+fZWq/q2xo3sJAVIJszXQhUWw==
X-Gm-Gg: ASbGncsYIjQ/tZztXJhDMcELHOflYnYaZd5HaliNLU8OTlovULPH4MGK/Zm6FRn8SCS
	Ltgbxef37NKh89poAug93mcgjif3WhTizqfy4+nCzHbGpZNMl6qqgMcU3KCYkzUPSK8/aJnDsbB
	MdDG2gkJtz46i97UrPAAOeVF73H/9D33+kXk1dCZlzRdvTc7gy6n+JzWBj2kmt3cMh3yltanEnz
	tFxY3pNK8fs1AvEi8IgirQgxjBfjjxodi/LCOfBcYAPk8EUKpmZwwJAFgaNCcjOVqf7ZLBGCgzo
	YCyFTpW0zh/3ZWziC36BO1bVz6C0uTCEIaJa0xzkOfQ8p/aAqeEJrTPE5hb84YYxz7ULtDozt7r
	sYimODW0vGBaFq3LOZWd+G5YG90EtkUc7l0t2CP478v3jkxuUPREzGFeACLPMPUatDKd0M2U3JU
	8Zqg==
X-Google-Smtp-Source: AGHT+IFiz6JVFNjBfcCoWvWwU1zq16wtIjJD8bjeNOjLDWeHZVY7aaCqf6ep2tUUfMTbTr2KjbLEDA==
X-Received: by 2002:a17:90b:4a50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-33bcf90e727mr27710604a91.33.1761079893386;
        Tue, 21 Oct 2025 13:51:33 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6bf3ebf68fsm7754339a12.6.2025.10.21.13.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:32 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 0/4] wifi: mac80211_hwsim: code cleanup patches
Date: Tue, 21 Oct 2025 20:50:22 +0000
Message-ID: <cover.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all open checkpatch errors for the mac80211_hwsim module.
Patches can be applied in any sequence.

Amol Dhamale (4):
  wifi: mac80211_hwsim: remove explicit initialization of statics to
    false
  wifi: mac80211_hwsim: fix coding style issue by adding whitespaces
  wifi: mac80211_hwsim: add sufficient parantheses to complex macro
  wifi: mac80211_hwsim: use more restrictive permissions on debugfs
    files

 drivers/net/wireless/virtual/mac80211_hwsim.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0


