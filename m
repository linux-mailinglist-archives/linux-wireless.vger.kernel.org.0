Return-Path: <linux-wireless+bounces-15313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC509CD68F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 06:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E277D1F22512
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599C17B50B;
	Fri, 15 Nov 2024 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvnKjlrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3301791ED
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648344; cv=none; b=rwDmsKwiXAGJZXbqulgtVRPv6MKxOqCdH/esFCUOCzutxM6mendF6e66lfLb07YTplqaleK7ePelMSF+4diZX8IsojzA8nFy+9+X7qbilIJFPkUKY/FNAOq799XSKsegWw0Ue9qfmPbx5Ub8vIuxTaTGbPMRZU8MWBO1tGjKvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648344; c=relaxed/simple;
	bh=44GjHQ7/wxSVbrCmifeIkoisPPoAte7203j958yaN78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/47K1jIaoE7asgUCUmL0s7ExOwQwBMyUacdPeftG8dvjeXAKX3+06M+Ge9TYDwaXjZxoBoVgn96yE/1T1EmBvqZUYwfk6JzlckvRH9uYkB+tUteO4HDA01zmDFL9lzkY5PeGoQsj8jRrfv4AL6pQ+R/z+mB0N6+TbN+BWxTnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvnKjlrU; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7b1539faa0bso23512485a.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 21:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731648342; x=1732253142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/zjmsTv/XxdN9d9e3D3UgI+HvTm7OUMiCcRsZPfE/k=;
        b=ZvnKjlrUMZp6OixLUiVZjwnuLYLaVWNY+aipeSE3zCsCZBdySf6yjB2U5ek6m4SWl8
         aJ3l8gE4ulkk/FwTUg7BhMEYbIg8OMgLupehWMAUNZQ0mfpZDDMVvh83VJ4z05ghPdEe
         OzOElVqiT7bfstBwlEyFnnVfbzM4iSGc4QMxnD3IAO0tuk/wg5dk7qs18rnmC0jEnU+1
         S58OSeq/qnQbEBeZR6JIaXy/bQYetzK4Kfu2Z4jFDDagi51KQgeb42vq0+PAc8HC6KnA
         LUh5F/2E8S6nhXvSHbBeSlHHYbvooni0f2QIMtWOuKhUmex4Qnw4UOE2TR1ZxzNBf1f8
         5efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731648342; x=1732253142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/zjmsTv/XxdN9d9e3D3UgI+HvTm7OUMiCcRsZPfE/k=;
        b=d1UKcOoLQ+0fb+INX4Ja6fnnIZMMRHON8frAiYCeuGtmHfk87D4grAbQRqbExbs0Rz
         2ZOtoXcJnJyxxBKusdotInUVrYk1DbiVNHEkrGQJ91NnFnWY/4vpk+mKSplB5Un7ybrp
         KWIcNJspbL7tOT/0pY9EUabpufc5Ubvprt8w+5rAYffnT/gxug0L/osWMhooKP4OLt/a
         zPCOBmH/Hq5xrdNiDZpHZuleYWy01zIOGzAidWSi/8Me1NwLnoqoEu4v3wbeljLh1Cl2
         qJNzMRFgnofVgJ5UU3yHVxC55wXHZlN1vk5bVXHUcmKbFJ+XFM/G+cFc5zvQgvSZXvHs
         m3jA==
X-Gm-Message-State: AOJu0YzVEkx/Q4Pp9IYNGvvsEXxi/3rfgerRtVnMZrsfgSPYx8LK+fff
	ljg7wWyLvmjYxvjf6CGoFn+ivsLwgIKwPFNSsGqYHbDh9uH8dC3a
X-Google-Smtp-Source: AGHT+IG7Ss1LTz2bm7ok/tpgjbakACnZ7q0/OhozDYI/Ik1pRC9AK7j235N0wIuUkCcTZFKxYhrACQ==
X-Received: by 2002:a05:620a:2a05:b0:7b1:127c:6234 with SMTP id af79cd13be357-7b362308f98mr135526285a.34.1731648341927;
        Thu, 14 Nov 2024 21:25:41 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9a1cb9sm125268885a.32.2024.11.14.21.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 21:25:41 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] wifi: cfg80211: Fix potential NULL dereference in test_cfg80211_parse_colocated_ap()
Date: Thu, 14 Nov 2024 23:25:26 -0600
Message-Id: <20241115052525.14554-1-zichenxie0106@gmail.com>
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


