Return-Path: <linux-wireless+bounces-27178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF858B4AB6C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 13:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7025A6801B7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED2341AA8;
	Tue,  9 Sep 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3aQ1E/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97653341644;
	Tue,  9 Sep 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416147; cv=none; b=twrNlAKeS6mOCRyn42Cvik0yUAswtLflzKxJfL/LK8B/jj3wfQrGpzOWV8ggek8wjMxM92GcBiq1CiwEKziKmsYJhNd9dRQgI+Zjs8V+Ys9QT82Fvfro7KZGHs6e7kItvxJc+g6wkebiBR/y6RH5/F2bojRJBDU7ig3vLH9+XGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416147; c=relaxed/simple;
	bh=k6VG5O7q00a/a+YkOEVzLXHlH/LdT+cKIq2dw6clWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLqh6P8AGEXHF47kb9tXVuF2KvwqJzeSI1tdSQUKgcMbFGZpADzWEJp6I9kZVV0WsGQKSua+7svGZ7P+9XwZBwC4C6ZYEzWsNnmN2ZZvHxJFt3Jylt11447wmyLr95746ChhyVebukIwGwYa1GYeaFYChic+BM+NIWCr06Vwwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3aQ1E/G; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-329b760080fso5348563a91.1;
        Tue, 09 Sep 2025 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757416145; x=1758020945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kqIBpGmaqjfdWv2U553qBzw0kO4MEkC0nT25ifs4mA=;
        b=X3aQ1E/GL9DBY5K8u5OkjInMPPjswUq6u1KE9oP7mldhRL6m1PD4FTqFeStQwBu92G
         6Z++2HQ22Kl4VU3bRvIK4MED2i6d9dPASndRAo95VWpSN3ncy5wpZEIbSfbDVBJNhg6I
         EQpO2Ei3Sn9lUsTn0nfI7uyJmxTDbDlqVmSK/Lx0KgNYNEUbkmS1sQGTHMHbUAN6sjDM
         3MNjtoDkHip45/htElz7VvmUXZ9P34Kbc9FfJa5tRorE8nwSVwCaLzMrJ1YumUf3cvix
         SkAMqEh/hg84YqLMfvzoNOr2fxm4IRzegkUeZ0N7ZQ6HUD0/ZmBqbG+3wrXJosqMqMCY
         7SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416145; x=1758020945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kqIBpGmaqjfdWv2U553qBzw0kO4MEkC0nT25ifs4mA=;
        b=xA71gvmwb6BTsatmjycywzyGuYifZ9pYwwFFhVDCMRd5BvxhtT0/fqr/0ARMBQIWRB
         +K22I7JJcf0qtH7s97FzpZZ2BLzSEJY4BQA8Tz0PnP4aqLGxSP2XCe3TF8Mzc+YIA3EE
         PBzRHxnuYNzOjVvpzMWt1ggCf9tWiDqh6EC+rPfYon4lRUGVTZtWzMjAMFxruZ1xNPaf
         5EX7BTIgY/mdOIDitMs2wTIfgt63eSCBm3ImGDbqgqFC4H/cPhh/C0alr9Z3dkQkVO/H
         BHcIVai000K0mBh5qsAi4cuPbyRT8h7EdOh79Es4k1FvgNJDXIRZRu7/D2r6CQj0uz4z
         EISg==
X-Forwarded-Encrypted: i=1; AJvYcCWwwnINcwuvgtCJIWe9qBlkypGD0apXR5On2jm82EObve9wk+qLOhxVhmUgmbjndTHeUiCflm+2ej3Rj04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJcbnb6MjkQQDq0/GueAfDEYTaaaPH0JXnGWpjv6nivkT5qVP
	Hoev2zoq/GrWM1ydsNepYZKlhuHid8G8EY8zcW0kQPI84sSseAUV9gK3A+y0S5IT
X-Gm-Gg: ASbGnctcf/RaD4n0S1yudViM6pvs8xLmjjLzZBY9jEd5Brdq8HDhnDaoaxwgIOyU5SA
	27TghLG7Tn4MpxwaejZMUordw/Z/GKzM+MBJx0KgpWtS37tPqUzKF0ItGK8G2nYYWdEhIV80GeD
	E6Gi4gcgZqBUVjXmph9oGnt1z6OlHrcvOpBATn1Ad9bm+C5NHJsECzMCFa881o/RdgyvB5G8bgb
	z1+SOkne2eP77yp4+obOcrhmp3cV2fKjPRjLNRVJoLsHcPqkNraVGzcKRNmnhLRCzKaO/UH93U8
	0c86AYjvS5gOLss720KmCt+0OB7sEYp9c2U+WJkSdRX6sFNhRshzcO18RSTwRBgYvVh2poIwp3D
	m7mMajjg7mjM+0DhBb7DyveyhIa2SBBe+vI5+Kz58QYM4Q/g=
X-Google-Smtp-Source: AGHT+IF+RlXuj41RmCzuMtvcig7RTTgQYCSvnSceofYj588/JUlAWiHFZtQEhiGnX1uyJzV23IXvsg==
X-Received: by 2002:a17:90b:38cb:b0:32b:df0e:928f with SMTP id 98e67ed59e1d1-32d43f936ccmr15732556a91.37.1757416144774;
        Tue, 09 Sep 2025 04:09:04 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e9fd022dsm21342608a91.3.2025.09.09.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:09:04 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] wireless/ti/wl1251: Replace strncpy with strscpy in fw_version
Date: Tue,  9 Sep 2025 16:38:41 +0530
Message-ID: <20250909110841.2904546-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy is deprecated for use on NUL-terminated strings, as documented in
Documentation/process/deprecated.rst. It NUL-pads the destination buffer
and does not guarantee NUL termination if the source string is longer
than the copy length

This patch replaces the existing strncpy() and manual NUL termination with
strscpy(), which ensures safe copying and automatic NUL termination.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/net/wireless/ti/wl1251/acx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/acx.c b/drivers/net/wireless/ti/wl1251/acx.c
index f78fc3880423..73232f7e92d1 100644
--- a/drivers/net/wireless/ti/wl1251/acx.c
+++ b/drivers/net/wireless/ti/wl1251/acx.c
@@ -149,15 +149,8 @@ int wl1251_acx_fw_version(struct wl1251 *wl, char *buf, size_t len)
 		goto out;
 	}
 
-	/* be careful with the buffer sizes */
-	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
-
-	/*
-	 * if the firmware version string is exactly
-	 * sizeof(rev->fw_version) long or fw_len is less than
-	 * sizeof(rev->fw_version) it won't be null terminated
-	 */
-	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
+	/* copy firmware version safely, strscpy ensures NUL termination */
+	strscpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
 
 out:
 	kfree(rev);
-- 
2.43.0


