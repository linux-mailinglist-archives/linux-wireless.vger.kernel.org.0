Return-Path: <linux-wireless+bounces-6466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E708A8ECB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E556F1F21BDF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F9651B1;
	Wed, 17 Apr 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY5wTv4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC41482E9
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713392188; cv=none; b=pYqInj0pcjrqUsmbxdJHpu28SAQeJkiDCgChG5vjTfZfJponmYehR+OQdyrfESLfI1YsB7fcFw0deQS22tP0Xg+Fj+m2KQtFfrxPhxEMWYgroCS0ZZ/SoPSB883g4I8FHuz2YkEPBsJjwaPisAYiayCDwE7SqCL9Eh8MSB/Cxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713392188; c=relaxed/simple;
	bh=Pu28jjiANXCpDZnU1m/60zaCgdFgfUxR+UwElO8CBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHjZrznB3cVQM3mkms2DinzSa19A6KcFvBgdKh0e96Zzsdwo5Ss0ItlmOiA4JpejAdoAiQCN9oA8f7KXw0fpVXB2F+znnfdpChngilBBOzeSCzIFQLfFSZm0Qa+V4mItZgo7qpStVJDY8ZSQiKYXkH7eGsA4ciw1u62iOl3l4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY5wTv4g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187c47405aso1800885e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713392185; x=1713996985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnBP981zlKCMfXAtDdV49/2pSh+VCTo0LDG6hb5JePI=;
        b=HY5wTv4g9k7LZfBRXjNuYn7fmRQJ/hxldx7O1RPzJDRHBLQFwp1t9rMvl7ZWTJsDsV
         HWyY+EIr4Sl0VCrVGqHi3Dl/tKmt+ITqwk16snIB8OY+zBHfbCr7KuivE75TRhmyVrAI
         H9ZQempPvum6FVbpnpFDiOt/xb3z2k11GR7EW5kwoOM/MdjQ67jeJ0hKwJrbXOfEZwOT
         YWUXdQhqnV1gwLghw0c7xtHcopX0sCzQWJx2V53d9rdG4wxW9rP8t+TWbLBxICQc99N0
         +o0ISf332GlZMvh5MlCDSfZm5i5wtTjX4kYAccxtiXORMmu0EQXUIdP0x26h48VThlhI
         5MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713392185; x=1713996985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnBP981zlKCMfXAtDdV49/2pSh+VCTo0LDG6hb5JePI=;
        b=HJUy2EWQIc/Hhuj/nVoTnq/IYvnanigIT+ZENhwItFEAA7I+IovcO4Lou0v8KQQ8dy
         ALRFpSYqTdQLp2EXLbCVttwDuUAT5shbubhcHD5WgoFMulfjpx5oM5v2Gbl2PTV072ZX
         nN5H8zWS/7fMdOLXJ9H8IDOY2B+wGWW86KY8F4Mkwt+bWuCJx8vyW5skzdKXCcPJMupM
         IM0LTdlphglUR8eCsiO69W8zjlr2cq4MfSzlfu3ZXC43ywkwy0SPxmly303WmJslZTnJ
         /E5R8h7fMWFghkrp8tpOZqjftSU8HxNcdwlbrdKAx3fngTm+wj1z+5ZDurAiWWup9/EQ
         BdNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7jVslgm9ONcnxaOujAhJDPlviPL8LtQTEhV3r1odyMYpRJ5z2QfItKJXdXnU0d9wtVctWZhiCQZmwv+dbEDUN3WlaNe2xdXO9dUgZmOs=
X-Gm-Message-State: AOJu0YxwPNbPFr6j470ZmYgxc6kzHbtFikUFdn8SNO8gctGUjIJoEmac
	apyadLwa591W/DUmTVOie1jnn9PQdIZb74sF5uo9c9pdc7sChjDl
X-Google-Smtp-Source: AGHT+IFMKDAPICcrdHrN1MgO8xa1NO8Cvjf4fuyg5DSTPhejTi8fZi2X5zgL0KDeTwdTjv4Cl9nM+g==
X-Received: by 2002:a05:600c:4686:b0:413:f80f:9f9 with SMTP id p6-20020a05600c468600b00413f80f09f9mr645891wmo.25.1713392184596;
        Wed, 17 Apr 2024 15:16:24 -0700 (PDT)
Received: from lewis-nuc.. (b.8.a.4.4.d.a.2.f.1.2.6.a.d.6.5.2.5.b.3.a.b.d.1.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:1dba:3b52:56da:621f:2ad4:4a8b])
        by smtp.googlemail.com with ESMTPSA id s9-20020a05600c45c900b004163703fd6asm5726575wmo.1.2024.04.17.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 15:16:24 -0700 (PDT)
From: Lewis Robbins <lewis.robbins2@gmail.com>
To: pkshih@realtek.com
Cc: lewis.robbins2@gmail.com,
	linux-wireless@vger.kernel.org
Subject: RE: [PATCH] wifi: rtw88: suppress messages of failed to flush queue
Date: Wed, 17 Apr 2024 23:14:52 +0100
Message-ID: <20240417221451.43964-2-lewis.robbins2@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417014036.11234-1-pkshih@realtek.com>
References: <20240417014036.11234-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I tested it for 30 minutes and didn't receive any superfluous warning message. Only thing I could find was the comment above not reflecting the (new) debug print (but very nit-picky from me).

Acked-by: Lewis Robbins <lewis.robbins2@gmail.com>

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 9038e2311596..3d1a886262d8 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1026,7 +1026,7 @@ static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
 		msleep(20);
 	}
 
-	/* priority queue is still not empty, throw a warning,
+	/* priority queue is still not empty, throw a debug message
 	 *
 	 * Note that if we want to flush the tx queue when having a lot of
 	 * traffic (ex, 100Mbps up), some of the packets could be dropped.

