Return-Path: <linux-wireless+bounces-15861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7D9E2225
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C192829E7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545061F757D;
	Tue,  3 Dec 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Leqn7NoZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9821F7550;
	Tue,  3 Dec 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239266; cv=none; b=bXAHLGjT5LQCSkjqKqHlSnLHWeceRDNHL1UVbXZqaP7kiKx2jjzvi2clMUp1fKA8i+ILt5ZISsxer3mfBksOVmPoAEOsw4X2pd6VUKkVu6MSsdIhEXAjHU66KrbKnJ+A9xQ5XFfzI/quslh/0FhUHetn1u+UTBjx8dtBiysdmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239266; c=relaxed/simple;
	bh=ZOVJrKZpqP/qN6d0VanJ/N+xrDibb3SB3TcMyv/HC0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cgb+hieTMvAKvIyZoyVqydRShB5wr2By3XjXqD0GNZ+dkNMOlstwR0/SpL0q9TlRLNmPn7IRO5npnG7Q+4PJvr3MankLf8wiGydZTGM1ECPq/RknP7vAzV1Qsg5H4e+y4AHQ70lrr+lbM4Pu1f2IQ8hMmXJ2kT6Vu45urmcQIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Leqn7NoZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215c54e5f24so6687065ad.2;
        Tue, 03 Dec 2024 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733239264; x=1733844064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxUB0u3+R5bx7OygSfFY/wa3IquwZ32J6yrPPJN5bDg=;
        b=Leqn7NoZrhfSJGfxheWVyNDc7DBCW5dpOyuVVS2CsCDv7qdtRLuJvC9xwPZ/z0EDlN
         3qxM6b8PwjAseWiKyETAqJhimaZOuUVMHDBbOS+2Gcr/Jcg1GdNLZnN6f814FFqJtyvP
         /lZtQEazQmD52T5HNqUaK04upSyrAkxbnsqYZsBSsFG5dKNbdpEiN65mZgrPd8Nyr0kY
         Ghgq1gl6hLDbxWeBZp8DL5dldMmNWMZKIVC2B3thfv5kRpytIYdn0DEcmaizImpYbdne
         RBVD6Uc2eW2lHxiRnMxVFUWv9iLwAq2GO8Y/h9rZoSqW16bxZtc99RBSYfxjJ76h6TAL
         LGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239264; x=1733844064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxUB0u3+R5bx7OygSfFY/wa3IquwZ32J6yrPPJN5bDg=;
        b=lBdcNLZtq3n5zx3ACknvw4DbXkIu27ynsyLLCuOi4ErJnOeZRNaCyyWmuq/d7qpriu
         6FKqM2Bw2oE9YmjpRnPv3BFKFiDwL4KTGcVeXHXeSPGsvBjKKoBQFG7AGuVHYUKi4ZhL
         0W7vucvhJ4D30hE5cSry1MdygAKHUvHIwkFrx5xalxaXFVhqKxxGBWVnaG/sBWTR4339
         ivY5bQTGfjryAkfTHjYXfoCkvWBaYtNpiPgtaOUOwaFCxVzzSVtvQsXyhkHavpO8WvSB
         4rIFptSM14H0Ok7TfXSL1Zlj/yPa9GVCmG1crRAARxdpOW1lM9AIRPRZh/2NHkkyQV7x
         kKlA==
X-Forwarded-Encrypted: i=1; AJvYcCVJVzPHGMTtHnqLLbCv2YzQxFYnXKhJP169LcNuHVY2AcJFGLL439behu2xGVHr6VX5pDFON199@vger.kernel.org, AJvYcCWLR6UjNZo1GjUtkd2+Ocw2wF1CDV+LPCJjcxArqb++ubYasCAOAWMwDPXHmoQY7Ba5avVB8cVVZAIRUIo2@vger.kernel.org, AJvYcCWdJ8SqqEFWo5NaCzs5HQsBdS3RCWW7O9bB0RVsTzfMTRGsl5eMw8QHiFhoikVw73KDmYKwNeLNeNwFXiC/Z44=@vger.kernel.org, AJvYcCXTAGSidZD15qz5UNKcOKvZqbkjrJxUx2EgnSJOXV/d32V45m61e1uyfaleGMn79GJSxQFW7eEzWJKOPB6zmVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhRWxJxfUd1mqrKbs7JEgGiTgc+UzvLu+Hn+8ypB0TOJZJHV0
	zTSrsb1MnqVUNzyYYA7trQu8+aEo1aN4lpteyqgNVOo2JSaLBema
X-Gm-Gg: ASbGnctj4miFdNRyW1UV5Gb46Knbdj/83dkHBBmdAtBnyYm79MYA8piOBgORtwVaWtl
	4luoKwRhWoraYkW3m4uwojb0cMRy3gHcBQlquo10oJt7rmlWItHz8pV7vj59m2+4Lw3TIZAH2dw
	Wk9En55yNPOxzpNUHc0+rrr18vpLVUqT9jAo+BWuyEEVu7ITGeRbBLOJZ30I1yj/KDBXxsuX1y3
	k/9DXEsLeXWJUPXfTXvf405GTC5CfBOL9oW/js7hnvAFlEEADKE6w==
X-Google-Smtp-Source: AGHT+IFP28tEUaXc+jsg6TNlhSwrUvGZ1LuMMkn2qz87wLbIGrbxwtznFrY+h1Z0IdtybAtEFt8roQ==
X-Received: by 2002:a17:902:e5ca:b0:215:9f5a:a236 with SMTP id d9443c01a7336-215bcfbcebbmr37415365ad.6.1733239263473;
        Tue, 03 Dec 2024 07:21:03 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21561b30f26sm60095605ad.274.2024.12.03.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:21:03 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	stable@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Subject: [PATCH] net: wireless: sme: Initialize n_channels before accessing channels in cfg80211_conn_scan
Date: Tue,  3 Dec 2024 23:20:49 +0800
Message-Id: <20241203152049.348806-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new __counted_by annocation in cfg80211_scan_request struct,
the "n_channels" struct member must be set before accessing the
"channels" array. Failing to do so will trigger a runtime warning
when enabling CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")

Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
---
 net/wireless/sme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 431da30817a6..268171600087 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -83,6 +83,7 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	if (!request)
 		return -ENOMEM;
 
+	request->n_channels = n_channels;
 	if (wdev->conn->params.channel) {
 		enum nl80211_band band = wdev->conn->params.channel->band;
 		struct ieee80211_supported_band *sband =
-- 
2.34.1


