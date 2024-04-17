Return-Path: <linux-wireless+bounces-6421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182748A7D3E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A841C2091B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B816A337;
	Wed, 17 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuxFGUMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCE184D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339628; cv=none; b=LntZlyPNZW/S4nF7EClNjyWAa+qF8O4OecB7yNNbP50GSQM/lhDrusH5orjcoCFFr6AJOmy8GU6Y3iVG4MGBwsUhYDUpCGNJDTLMUUl1Fism24Mj/NTD/ueIsrzK9VWNWO3AU5njL7t8TNNYEXufzVSfWy1EIsoCgQTkJ6hD3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339628; c=relaxed/simple;
	bh=Ej/9tGKXfohLCUd3pAUPmaT+IACvcFEpWzwOgq/KGlA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GurxWPFDKMeTImPJRj9LdM1xCJiOY/VZ6X4UIsNQLAi1BuaLyk0RVjLaKY7OGzER/y+XGcRYgbiCDdu0f3blP2tEcEoKIkHoQzEwyl7y9FqOfwjtOeIN5XxQCUfGKfy7SRcbrwqUVrf/Y66PvpYOwodYDEcyjI2i5zOTlOMQAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuxFGUMS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b137d666so42954365ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713339626; x=1713944426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+guUUXUYVHcIXnwUbYKrvJSCmcCc3XEnrBerFXq43KQ=;
        b=cuxFGUMSRT1h3xL/p3RZ/M4fSMfEfoKfoB9Yo+aQtUtKdkrwK9gUzhI261CtcLA+WG
         rgjBFD/6jBwQnt6aHoHy31NzLPXg3byDw2WAM9xlaO2U/2fCi7ZywGX5Bh+xM2aDA8yV
         pmm6FuJReB3Sf3eS+oXULz2d3L1Ye5EHrB8Hx2tXiTtD5RUXzHwXvoCWvCrfsUX+5ciF
         /WdSh3JtNDYYDRs1IydKE5dYPI5IyoeEbexfEe/etDckFm3zO38kHLDnRBTLZ/UFJ9Eb
         AVOjuNTAITmoj3blCiJmVZ6h/mR8lvc35oaSYqb3ZmP3tvtwzVnI0teZQi+WIN48HSKQ
         AwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339626; x=1713944426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+guUUXUYVHcIXnwUbYKrvJSCmcCc3XEnrBerFXq43KQ=;
        b=Fs8fhILlHkiuO113egEGcuJakvNb2E+aQKCJF/M1pL4UHnu40kXYhv0MwB4smGBnhR
         hH6+yX5xoFI3CjgciEeYAQ1IF8b7uN99gA1lSFsYN7xvpMEhFN+k8ze2Oar1iqqKKsKJ
         sH2JjzKd3x+kn7wTFJqFQrmUGvJ22BsXOLPkq0ioGJnv2mCglgwhQmod3asSu62FvKDW
         U/QIe22Aq3TxA+UKbghIEfwF2XUr4bCr/AuBkjLhZ6qMuOoHvxlP2QvEblx6E7m9A4aJ
         wdHWYVUJmDlJQmFjYXt7D211160O0DFVvnRqmTEkAd2NHBSPVpDW0TT2T76AqT5w4QxF
         HyGQ==
X-Gm-Message-State: AOJu0YwEWVorQKKqquHdW5z+XfXN1Iw7GdjDgkX+jEqw8OHXPDnExaTo
	zAUn3axv1AOIf2ggJ/P9JE9njjD1lPnIFUTe0Hvpm35QmYUI80Skl9LE8PYA
X-Google-Smtp-Source: AGHT+IGExm0h8RbZnRbp3BcMh9/BKtsBkU1CVXFl2bLUo0bs1eAUu5roypeBkzTQa7hIEZKIrKEi4g==
X-Received: by 2002:a17:902:e841:b0:1e4:c75e:aae2 with SMTP id t1-20020a170902e84100b001e4c75eaae2mr20835926plg.59.1713339626355;
        Wed, 17 Apr 2024 00:40:26 -0700 (PDT)
Received: from smtp.gmail.com ([49.205.251.18])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001ddddc8c41fsm10916524plf.157.2024.04.17.00.40.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:40:26 -0700 (PDT)
From: Chaitanya Tata <chaitanya.mgit@gmail.com>
X-Google-Original-From: Chaitanya Tata <Chaitanya.Tk17@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: mac80211_hwsim: Use wider regulatory for custom for 6GHz tests
Date: Wed, 17 Apr 2024 13:10:22 +0530
Message-Id: <20240417074022.423432-1-Chaitanya.Tk17@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a custom regulatory is being used, use the 6GHz regulatory for
testing 6GHz channels.

Signed-off-by: Chaitanya Tata <Chaitanya.Tk17@gmail.com>
---
v2:
 Fix the author
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4399eb1d9f46..f5aed44ec80a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6761,11 +6761,11 @@ static int __init init_mac80211_hwsim(void)
 				param.regd = &hwsim_world_regdom_custom_01;
 			break;
 		case HWSIM_REGTEST_CUSTOM_WORLD:
-			param.regd = &hwsim_world_regdom_custom_01;
+			param.regd = &hwsim_world_regdom_custom_03;
 			break;
 		case HWSIM_REGTEST_CUSTOM_WORLD_2:
 			if (i == 0)
-				param.regd = &hwsim_world_regdom_custom_01;
+				param.regd = &hwsim_world_regdom_custom_03;
 			else if (i == 1)
 				param.regd = &hwsim_world_regdom_custom_02;
 			break;
-- 
2.34.1


