Return-Path: <linux-wireless+bounces-15598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38E9D5EA5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 13:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68853282E35
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919F1BC091;
	Fri, 22 Nov 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYvS/doG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65217BB1E;
	Fri, 22 Nov 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277776; cv=none; b=WDfUYwtE/iIzvl0f5Y7mrkULmCVUxNST1gPYE9zr8gHHm3yPI2DiWXLfRK+IjtxyG/aBtlBAwSWSBn7idYbjDRC9CMRpGkQmADoNZ5kV/WLXCyHRArn4THGwXGEJNknqxoSBnhTRtCM/yGrF4Bcv8tA7F10xhAx3ESJ1xJ3G4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277776; c=relaxed/simple;
	bh=1cflV98fpYB8xd/R5BOqnnBFLifW9rz4McpZgrW+eFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwWbCmuagNOscP60xPE5pMIHohXu2/mxmSW91mrH55n1vM+TDJkiYvTrOgZxDYqeCYQRjiuMuYE4iJYI2HTO1n56xjG0qp1GbgP0T/hWfWVcLgxA3uEwnlUpI8wzFtzEWvrP/rMCs+fPqQm7Nz4ipAeg7sHokM7looROz2ckw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYvS/doG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e52582cf8so1530280b3a.2;
        Fri, 22 Nov 2024 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732277774; x=1732882574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqXOl/PSXyglI0oDidHV6t6fKE3phqIkCC9fHoLh0YQ=;
        b=XYvS/doGhFVXTtMstfynFeCxjy64moSqbSUEnAAex9juGYwx7HmQpgnOQyDj2LGS/a
         i78NA/NZTOticU+Lv56O6Ij3TjgJ3rgTiRnMlqw21B2PHd7JYOMjSBpiOFbdYRlaUbNb
         aZZLk5KaQHDQvdm9HTrsPFIsbzy5wmOrAibbE3CxxMf3DCrRFUtOFglz5CoBX0PrZDYn
         RwyP9htjZCEOpuyV3TzuOXabIFW+2Xq9XnxUxxd7y9EVdaSiYHa/WCQSz785ob/iqv6Y
         xbOXvtOVjOTUxf5q3VZqhBcTHUkYKP5aoFq0AqbqzWSuCViBkKxSHzGy0mIJRxIdDbmf
         Ik3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732277774; x=1732882574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqXOl/PSXyglI0oDidHV6t6fKE3phqIkCC9fHoLh0YQ=;
        b=R6EHGnsMWULpt6+xnwxC5CnO6+9C2w2P3Ure0tMnFJu4/43IgIDfD5llzcMLyW+HGV
         87DBleFuFPeHzS2VOyzdw4a0WyzmDZgjaxJcuvB0PRacKV9TNVIlmgr9G15OvgbcbyFd
         xZVt1ncIgPmQ6vxh7GptSjERFBS9XfofBkvJMscxQMbLIwBEFPg6x9k+15mxD5AhVcfS
         8nMgIOmN+lUlt419YOLKtEtpsfOgtWsm3BhEAVjYk4CegRE9kaJbQzCUFIWLkYfEo5Hk
         bT5X20enXVg9ZW5bLvg4AP7obq08P1tWAevSEJkhqBpaponxGOiJdWv73J9XmEDNek/A
         g1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVHXQidflK/8urVY9+jKFZuVwCc7OkDbRbODDMYg0vFXEB+Q7PYBHQ2CMowg6ywBmZ7K6sViJNhSw1irJw=@vger.kernel.org, AJvYcCWIMJbtU3j3gBSIty3eE8YzyEFAnqfCmUZCPj+lu8WLFSEGZIxh4/S6aYLVQuJt72hQ+hadb+Sh626nfPrC+L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2M9CMK4SG9TCHtNGhcaZ222FNx5bQ9FGDhmpAXzzt5QQS7yI
	Cio6bTQt68bwIdLuT6k2mYp4JzL5VUTXUGT/qVQtVvzO6lvy88NO
X-Gm-Gg: ASbGncvxCAOpVV59RhwG9haOUdHA8moklOSTzsrebqvj+LYiYyabjETel91sLNxl/4f
	Lin7K7T/bFJd/al+wbyVrH/RyU0Fvovg0i0GbZMr6ggqZzJozNhtUTnUnkMWgxE+XqCm56st465
	2/Aoh9lylkDlubBrl3dC0t/2PoJl4q18y3fUl5EsQxQHzrC6u70S3gLc9KvtiP4pp/mliiuKDuv
	KElG7Hm2qOXtWLEs+j7Po+vRmgWARP+4m3LMu/eT9+/5Gpthib/tn4=
X-Google-Smtp-Source: AGHT+IHsel+VwvXElFGnOc1q576P4SVtlcB5yqj8Z5+V23oqwFAmikG1t0CJ7Q3rBcvYyBSS0S4dOA==
X-Received: by 2002:a17:903:18b:b0:212:37e:3fcd with SMTP id d9443c01a7336-2129f290e12mr32197255ad.56.1732277774510;
        Fri, 22 Nov 2024 04:16:14 -0800 (PST)
Received: from HOME-PC ([223.185.134.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfb2fdsm14805865ad.156.2024.11.22.04.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 04:16:14 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH wireless-next] wifi: rtw88: Fix an unreachable code issue
Date: Fri, 22 Nov 2024 17:44:59 +0530
Message-Id: <20241122121459.134107-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling in rtw8821a_iqk_tx_vdf_true() contained unreachable
code due to tx_fail being explicitly set to false before the error check.
This prevented proper handling of failures and resulted in dead code.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index db242c9ad68f..c06ba7d615df 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -221,8 +221,6 @@ static void rtw8821a_iqk_tx_vdf_true(struct rtw_dev *rtwdev, u32 cal,
 				/* Originally: if (~tx_fail) {
 				 * It looks like a typo, so make it more explicit.
 				 */
-				tx_fail = false;
-
 				if (!tx_fail) {
 					rtw_write32(rtwdev, REG_RFECTL_A,
 						    0x02000000);
-- 
2.34.1


