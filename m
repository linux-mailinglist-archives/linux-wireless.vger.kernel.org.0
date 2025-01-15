Return-Path: <linux-wireless+bounces-17541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFD2A11A29
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 07:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985103A29BB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528020CCDB;
	Wed, 15 Jan 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdXJf7XT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1B4C6C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924099; cv=none; b=QJGTO4KZ5YMcikYbDOhdyswUEzogHhtrjijtk+kpYV8CBUwfpcBxOf+yYpW7ONvm8DJXIpx7fPLPojPELRTAvGd6xpiqUS2rNTq465417EVA33v/ZgwQ/qhrZ8TGXg/PSS+h1e+qsfB7Q4FdLA47aRByFALQ255OoiM9XsIn67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924099; c=relaxed/simple;
	bh=2hqRIoY/uCa1uHU7XkHKh0fl4illlMY9ijCtuFlFpQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f4e7/jrQtqwQuoqmaqPLgdNRGEla7J+6+ZjIkOLR30NtZvO1vyKc3Yp2c+0Z8vTfJFag03By/Ep6XYBNxMIYW+ljzqsqRX7bKwVSb6cdnmOSt80W00VGxnNp2uCD2QKFenLlfAOkA9pCcDPSCGHyfMOjuwCKalUnQv0DlIo01Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdXJf7XT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso12251549a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736924096; x=1737528896; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A14TTUSHGw4Tfxp9OI9Y9Uf9engfooD8uv0pvFJOHmU=;
        b=KdXJf7XT7BseuGPvWDbmh5GorsEQkgP6+xi3a3D21B1X2+K40LifMHhuDZaLhLZ6UL
         V6msnLDV4F3kfhjnlgX6sr8fEBEW579ToaqOR1nJN1/qKqZDzU4eCHwSw0qik/MHainD
         QzixbconOl2MYl0wxesurzI+w51LgLxnWSfeYFmh9MbSLmkTE4nykeQPZujnn+6CPPpI
         6gBGh1fVEs/k2+a/UqLm9pDIiIXWmu/LX5dhkRCJEskfg0/X7Y6QzKXetoTxZ9bmwdzK
         82tBECi+vJ6NOV48Sw/iZxXvHHyRnWoHNZQpuOWjLGgCt6InyLc2IacGwNBnsHR3kebc
         PHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924096; x=1737528896;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A14TTUSHGw4Tfxp9OI9Y9Uf9engfooD8uv0pvFJOHmU=;
        b=WuDJ/W2klxTKvlisJk30Fbfo1tNTWYHF5ijZYroUz1rVi4QKvADYZ8Ofa6Ctt0wVo7
         y5sxxBexdT0TH1DYVpB5IVPGpXwK97JPcvylPcOKnKIJTwT29LsZevPFE0CrwRj9tvvA
         z/ysiDEwCZUGbV4tS4UZznMteFBMf8c6gLYzpmkAjk/NZyUrvg01q4B8aYiw+I5wfV5S
         n/U2KKgP2RrVtLIw+qirJ+SC8cZ+pyuzlrzy5XAOUdibOHu3mQRIIH/76teyabexwETE
         sJpMh73FIJj/mc8POCtUpF3m1TXijDukj5SKNvCy54w708Yn612n6+PdAdiKa80Hjl0X
         4DYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yJ09VU2tqxRWN7ayiQBtNSEjPKMGnmz+D4UzGYEZgXP+gk59i8MXEt0Rko86AWmagggR0ODvZnaMgDq5nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcr/xtMez3XA73aF8g31X8t7CYWcgaMSaNiirtu23S3njcfHmw
	3ctpoVmOb9BgVLI/XtQLIke3y7PFRJaATkiDl5cqjsWXACximOISueZ8DeprenE=
X-Gm-Gg: ASbGnctLtnNpNTgIun0TSVsWZPckF4Fn7b/AV9z/qEgHahqLpVymDJJOlL0QHCYzhXo
	GV0n+BU07HfWisJ5ky5WjhF2vPizfV9NjdWS6zR4m8jsjB+is4uXvSe9ASINjrIEvshR1PmRhED
	xsYO344WgGe0uCbQBraOkX7W60GIKx63J00UubPtE4sLLTyZKlbuv6Qm5lrG9n4YoewqR+Zc7tt
	rwGGHowVt6rb2lz6xvbQs/aDmBjMuoHZRKuoltQpkWO6N2fk/BuyaD+DhAy3g==
X-Google-Smtp-Source: AGHT+IFmiPuMZjPhxJLXqB5h+XMs4bPD14TM+r5B+xxJIUUnoehpVx/Zz1fbrRY62nYEzYYJ1Ozb5A==
X-Received: by 2002:a05:6402:2105:b0:5d0:bf27:ef8a with SMTP id 4fb4d7f45d1cf-5d972e4eeb6mr25432395a12.26.1736924096059;
        Tue, 14 Jan 2025 22:54:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046a195sm6811700a12.57.2025.01.14.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:54:55 -0800 (PST)
Date: Wed, 15 Jan 2025 09:54:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilan Peer <ilan.peer@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mac80211: fix memory leak in
 ieee80211_mgd_assoc_ml_reconf()
Message-ID: <7ad826a7-7651-48e7-9589-7d2dc17417c2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Free the "data" allocation before returning on this error path.

Fixes: 36e05b0b8390 ("wifi: mac80211: Support dynamic link addition and removal")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0d3f64eb573e..f8d52b3b0d0e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10273,8 +10273,10 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * on which the request was received.
 	 */
 	skb = ieee80211_build_ml_reconf_req(sdata, data, rem_links);
-	if (!skb)
-		return -ENOMEM;
+	if (!skb) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 
 	if (rem_links) {
 		u16 new_dormant_links = sdata->vif.dormant_links & ~rem_links;
-- 
2.45.2


