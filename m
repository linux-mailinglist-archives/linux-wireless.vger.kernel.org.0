Return-Path: <linux-wireless+bounces-15320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B069CD72E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 07:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8928362F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA583185B5B;
	Fri, 15 Nov 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjmqcGvF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D9645
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652731; cv=none; b=AvtPSkcDjZqtkY4pOmJZUb8ZTtkF7lGfWIwydVwR4F9oxbkSfmdWiB2iID21VMFCDU2t2uFQHkBRGpVHuH75g168qOS/Q3q8cxDdCVU0KcFLuXMvbW4ZW9FJABmNRKZGlkYBS0LTQDWk9Aama3vMpP8zO4tJrKMjBe+lavxqnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652731; c=relaxed/simple;
	bh=nRXS4RaYHXxM3flrsQxx8TOJfnJCBYhUrsQR3SJbi+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MTlkilngDBpiSJztJNrnbLMTGu5KjWvb6Q/Td/K1C9M/Q5ttgwJNQfo4PO1H3KJ0B+5o+27m3VOczMGAILsAgSKME9PI7JSVutNIB1h9Shh6y/6sQT3CYdOARoBS4m9+yEy6q0v0v7xaW+QJhjfmN8tQSJJDmnkFbwEpp7OckTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjmqcGvF; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-46097806aaeso8984441cf.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731652729; x=1732257529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ+3K60W1Qv50jFG2SXvfKFhBtZ4SogwNs/SwPKwrlc=;
        b=BjmqcGvFoe2pTKsNq1tmrnWoE4h8m9jVoKOTXvHZtcdrf5VUZrLqn/2E6VT3dWnauv
         isrY+Kio51ixWNSKgP3nL64KORcBzf8PJmci2jhkhHJH73PEtq9boSQHBWxiJej9f5M1
         NBlPyb9iW24dBhAuMAL3qO3ZQdK8UWBQx/goY50K2PPe+ONS0i7hlxQMVt1ZepXfH2Y6
         WukIVgoTt8BFMSlKSQkCUjXebEHPJRFCEkS6f6YNVAoipdou9/F07MRSzU52tr2Gir1W
         Z/0ZOiVACNhpPVH7EaTs0XeKcKGH5D8Iys7msiaBkHQX6NZcPrtbuL3OH+3UtjsZdyDk
         iyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731652729; x=1732257529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJ+3K60W1Qv50jFG2SXvfKFhBtZ4SogwNs/SwPKwrlc=;
        b=eEpldY+QUOYzO8tbkWMBaeFtE7UchszIcwY3+/M6Uq2xETuoW689b5kfKrhfFenuq3
         4/ZsFiuDBJvROzwf3dczrYvLycoKRpbTOEmWCOKZpvv0up3Q1xyWeQmkQtFUcH0MUofq
         JgVCoaFZBZ5n/9MI+bFN3edWXYgQuOSzELP+NIe/N8todBlBoHeZ5IFT/QrzT+kLGKlW
         RAnvADeYcSAyfUUWboe2kZDGAFMhxc+Bl9wAr1Y1EYQzGSZEuMMChgbRGrbbTwyggKU4
         97FZjGxE/SFwfmqQMzJcdeHX6eg2TICuKUVVuv0NwL5CByMejWZjnAszg8zm88UldGfK
         JLfg==
X-Gm-Message-State: AOJu0Ywh8riyM5WvlpbwML3rAwi4GvOLCBHcRymJgohxIeWcq32N2x0b
	shVlvMpvwrfiAhpZPgQuXWsiR+LO+ejntL6cf0selEMk4nx3pxZ/Y86iBCSopQc=
X-Google-Smtp-Source: AGHT+IFGuxQ19+y9GOvhegBnrlYVycR7AIbIxENruLk89sqhw9kAHNJAAYoLBwx9WL+yo/inPOWXxw==
X-Received: by 2002:a05:622a:260e:b0:45e:f2df:2ed3 with SMTP id d75a77b69052e-46363e2e8ebmr22419561cf.32.1731652728920;
        Thu, 14 Nov 2024 22:38:48 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9ad6dcsm130075385a.68.2024.11.14.22.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:38:48 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH v2] wifi: cfg80211: tests: Fix potential NULL dereference in test_cfg80211_parse_colocated_ap()
Date: Fri, 15 Nov 2024 00:38:36 -0600
Message-Id: <20241115063835.5888-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

kunit_kzalloc() may return NULL, dereferencing it without NULL check may
lead to NULL dereference.
Add a NULL check for ies.

Fixes: 45d43937a44c ("wifi: cfg80211: add a kunit test for 6 GHz colocated AP parsing")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
v2: Adjust subject.
---
 net/wireless/tests/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
index 9f458be71659..79a99cf5e892 100644
--- a/net/wireless/tests/scan.c
+++ b/net/wireless/tests/scan.c
@@ -810,6 +810,8 @@ static void test_cfg80211_parse_colocated_ap(struct kunit *test)
 		skb_put_data(input, "123", 3);
 
 	ies = kunit_kzalloc(test, struct_size(ies, data, input->len), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ies);
+
 	ies->len = input->len;
 	memcpy(ies->data, input->data, input->len);
 
-- 
2.34.1


