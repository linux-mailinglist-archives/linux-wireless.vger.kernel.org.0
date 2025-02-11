Return-Path: <linux-wireless+bounces-18764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E25A30B08
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D816789F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB11FAC3B;
	Tue, 11 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmAVMfCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6A211472;
	Tue, 11 Feb 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275310; cv=none; b=Sl1RFDH3P8jSJZIjni9ZLZhBAEkg7dVFNnKHUosHoYlSygoEU6SpuD7VdA2v84jc8H7zSCd1XinJao6tAiWbJMGRnhTyy9na7d469NwxSco5gCD6aoE5ibdwukq/U8DRrxFHQs9juqhnj/BwM3EN8zuzRn+G9p+QqvCbcFa8t1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275310; c=relaxed/simple;
	bh=mqg6oVlWZ9lRgDBEDIBhvqT0sf/xJPxaAUpGR6KqHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaPANHFnnRBpywLdzSMbc56uw32U0GzCyKoeWfBj8ATgqqM69P76M8BTIIAs4ha2VviQ1IPtFQtEfR6MlV9s53pHKoiGD5YQuzaWXF3Us7YqfWrOvb+awtI2BFlJyuemV54FMmSWmJPnOOD0eW/fmRP12hg6BFNRc7cAmGKpRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmAVMfCT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso37753415e9.3;
        Tue, 11 Feb 2025 04:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275307; x=1739880107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J3x9ECyGCGYGUhtbd3ZOh/doI+iGAkp8K9XPCCmug4=;
        b=LmAVMfCTVfShh6cGkH5XTwKz5t+TKA+rdMqTPw9a8/vwKAF964NnDLLWaLG36cYDLw
         GiTwwkQmtHR8POTDYRMiZDPzmMObEVt4nYkKbOhqkmRMbcArTCgavotWIgp4SoX6/c/G
         0qdVav238ldWXzAGG3jB/8n06GnepRkkAkR8pwHssa1mUIVxk8woyuUHIynxgDxUAxhs
         SwXXLXt9PvvR1P4xoG2C1LXepdco5F6IRxJ9MDUm/jXWumfyb3yo3Q+Q7T7VpwNkBTv/
         cTWqrfjDwLZOb8NJ9OTwAeMeYKPVS3dbr9mRJ5bO8jG01kxzWOHM49DIuSpFzbfm6KQl
         kfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275307; x=1739880107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J3x9ECyGCGYGUhtbd3ZOh/doI+iGAkp8K9XPCCmug4=;
        b=VCk4j5hOsfItzpLmzktPj9hEpapiiG9ExFjzOy9aoIXInYj4eSmE7zAdQU5KPidlcs
         i4qrWcZfqOoH2BbNxapoY+lYrgspNraxpHN5vEaGecq/BwWtZHR3J3lo6ZiJEftzLDW3
         7rcqor+WZuXWZZuRPz8T11JEyijEbkOnn2LMahEpYAd4sKeSGOQBu1VpXVHp0P+vcyA+
         XAeVGkyKVzxwjdHgjkBebk4AHWUmanEAh5Ua+CO7kwW86pkusEVjt/JP/GR/dpZtrTSU
         zchgsAxYktGfL6UiVvou473VNwnCg+ausYf2oJiG6ih6JnJFv47bN3IznEJem4Rzf9UF
         /BUg==
X-Forwarded-Encrypted: i=1; AJvYcCV87n9SlXBlIAiT9wejL/YfLx1xM2/Ll8v8WtAGneS1n7WOtBOmwTgrzgGlD9iN0lIS5MTSARV9mMhpDmZEyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8j5bo4xFazC0/+QtO/LKEndRIztXoXIsdfGMrTtKYEJKOaHn
	tk6gsgpp2DY2Z6Gbi/CHeeycjjMtOkYtg4A11ADEuSRxbH4nbaXI3U3BHQ==
X-Gm-Gg: ASbGnct0lblg26RACCUVnQq5glKqJsau+3K0Ie/0MtfqucF3HUw9WGze/ffpnxnRLwb
	VwFU23oIQvVm4IKdBHURZMEtJDc3M0HdBIytVn4g9VVaiRIYE0JoUhG9EDEmZVmVspBDCWtZJ1P
	MSQCNi3Kce841donatRZILQSnOiIwjPpwPjl2yVdgqWQ5mi7w0ord3MrmGEJGuRRhMvET35KF33
	gNYEbW7uRazO8NpcCQWekIw5YyvmwWHB1uTgaY5XS4BBY23LfI47/uf0T9XVm48rK4Wz9G/AA7R
	qtmnQyHOmzRdjbDf6OdcHmQ1Rm9RcYW/4Q==
X-Google-Smtp-Source: AGHT+IF5ED8LUt8ksZHcsMG+E4ylaFj53X2mAYHM8w/ij6R7iGPxS0orLl7Yc80u7oxaEdy2AmDDEg==
X-Received: by 2002:a05:600c:a0d:b0:439:4355:2f69 with SMTP id 5b1f17b1804b1-4394355322dmr77987615e9.6.1739275306586;
        Tue, 11 Feb 2025 04:01:46 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 06/10] tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
Date: Tue, 11 Feb 2025 12:01:23 +0000
Message-ID: <20250211120127.84858-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn attribute names with leading digits into valid C names by
prepending an underscore, e.g. 5ghz -> _5ghz

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index d8fdee24ce25..62a6d8c93765 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -74,6 +74,8 @@ class Type(SpecAttr):
         self.c_name = c_lower(self.name)
         if self.c_name in _C_KW:
             self.c_name += '_'
+        if self.c_name[0].isdigit():
+            self.c_name = '_' + self.c_name
 
         # Added by resolve():
         self.enum_name = None
-- 
2.48.1


