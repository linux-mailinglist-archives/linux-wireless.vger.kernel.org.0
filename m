Return-Path: <linux-wireless+bounces-28693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECBC433AB
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 20:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E13AFDFB
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA422A80D;
	Sat,  8 Nov 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfeqGNsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1054654
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629809; cv=none; b=Zps0A1n7h/QTUqUynBkeR/hJKESgpCUk+vajB4HfSA60KAGfg7aW7YZtvhJQVbzHTv9J5f5sZleFRaUMM7siYUQJUnu8U0KlaWqG8g8DZtsR55onTzvZZrp9Y28lWeYPHwKkVKzo8c9W0ykwyY2RJ7WGjAyal52zz3EGVtigHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629809; c=relaxed/simple;
	bh=jhuR6KqhWSDFS6cOgea0NixXAwxzdFrLbefm+eJnnmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ugt+sb5ljLJH5OW2zKKzroCET02Y4xlATraR4iMg0y7VwCFS7cuziI5oFKWP9/e7kL69E+qkv9KqJlhICED/zsajsr0f2j5LbsaS8PP0Odz0Ma7IOfLhZkNozcXvMAQP169w+/FJLhGwxN8AVMU7z/bnlbturLQzYl9C4Nl546k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfeqGNsr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2758018a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 08 Nov 2025 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629806; x=1763234606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiNkx/PGsLsTPGkMXI7y0SekpJxv2rq9gMbNcD5aMAk=;
        b=lfeqGNsrEym1+1dDVK9rV4wcwrUkBik+c/ChUzXQgVWaRVzEaB/lLCM98SqVa+I7UQ
         Rfhi43bF/vli74AtfdLeuF7fYMO8UM90XcbuQsbzKNKJrKEijjyk2NNFebv9wLoYznyC
         Z4t9IfDWPSNt+HoFT4W0KfuX7xgC6Qd+Rf12Fpro2DcPVJlvwwGtBRmytZSF/8sE+aqu
         hBLmxWtHcsL+SzBmdbeWqczCXNgYgR7d/8Y+7EQ/Um42SUWchAtSV9JGW+mfHALDYoPW
         Yp1hL1LgTeQd2wwTL7M50Zm4Ug3L/qNjdL3Mb73g4EXf3WO3Odttgmmo+s3FCGxzLN90
         gCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629806; x=1763234606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiNkx/PGsLsTPGkMXI7y0SekpJxv2rq9gMbNcD5aMAk=;
        b=PVH6woRiN1zctntJnmCh0EP+5ZEjC6JzaIazykPlH90comytLnwP/7EYy77Tv9A/Z5
         Py0dSuj4IJ3rOPeK0AxlsXoBoNAmC2A4XmXeNVNww2il6ihBjHXUlwPH9Mxc5dzfwvt4
         ASgxM2TkYm8CXTeUF2UHFnSLcH5HSQbFI7fo9kxKB7O8AKCkrldbYeWJofNLGaHzjOLr
         ggywCVCIJZdl66yrrcCdti6MEyTSqOL8Z7j2fcrTAcBil3NPuYuYpqBv1RkGb77CdfGk
         rKoA85Gt8cu+K8PKNhAuy1ZggBZPLufKT+PiB640Xauirzzq6kGfN+ECzo1xfQ7GCogC
         66fQ==
X-Gm-Message-State: AOJu0YysjIbz/2GzRts0gaqvtdxDoGpCIuC1NzdGfqDF8vAWOIIdaaRT
	bLqjAnBaltmieTFhoN4vbPsNPYOe8rOxW0KrC7OA28eadMOQhiuKE4fKwaDvBQ==
X-Gm-Gg: ASbGncutR0CoVFDsXdEKBVPGRa28kMsQcOyFyqK1bYy9dr6GIocnZFF8vlOsVEpjwfR
	xOYEnlJYFWawSMf3abWfI9/XxlkPX0U0Kevk0zkjQnC9lsyetuh/+zW8CMUfvjNbmB2T7VwdJiY
	wAeB903YDjD0bA/l1/bN/kF8zxG7p9IcKxMVGVp0TkCzukA7FYrXAZZtdPgV5PudiQzF2piXfOw
	aLmhvf0BOejcZ7WqKsffifKEXLsXPQBDmds8XDBTn5McsPtDuJYnWZq4JY9QCfRMIzSjSsELgIE
	m6avwdgc9DJqx2XaVZNoJvECGUl5Nhv8KDBFmAN+ZmOZSyS6boHRmKVQ7JVuwmABOqRVA0RICC7
	z/4BJpB5ZyzzCtfkk52xOjJ/Zn4dh8gvIOtSWkJEk/di532OWGstf/DN5uZxginjCg30ZPa0rsb
	3H6NMlqL8INEYkGq56QMYFiyabNZxyecJd4+YRHCsTs6cHv3tm98nZcfidB4k=
X-Google-Smtp-Source: AGHT+IGIfV7UXjq/Ne6PCGC9LoJA+DSGlRygYhmOmeUALMnxS4rMJJWaHcV13YBbVqLwdphIoXfZqw==
X-Received: by 2002:a05:6402:3258:10b0:640:b643:f3c5 with SMTP id 4fb4d7f45d1cf-6415e6e1c24mr2232802a12.16.1762629805435;
        Sat, 08 Nov 2025 11:23:25 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm7284377a12.33.2025.11.08.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:23:25 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 1/4] wifi: cfg80211: fix background CAC cancellation
Date: Sat,  8 Nov 2025 20:22:36 +0100
Message-ID: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes missing CAC_ABORTED event when background
radar canceled.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..65ea469d2d77 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1187,21 +1187,16 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(chandef))
 		return;
 
-	if (!rdev->background_radar_wdev)
-		return;
-
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
 		break;
-- 
2.43.0


