Return-Path: <linux-wireless+bounces-28328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A4C12A5F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 03:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02F0135406D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39D85C4A;
	Tue, 28 Oct 2025 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="FUqDUHNK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE6165F16
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617862; cv=none; b=F56LDTqAMwJIPxank3ykeSCosSAnoEcvJ2PICaGY7JCQRDQP1D6/W/pkPityOs2en/zHlBmnO2+voStAz2SHMhckj0fHhsMHxRHxdQKXnpsPGPZ//WsITz3rSuhDFojO1Z4qAgiwOoECAtHGu4gPeMfb4dSo7WS08/Q4pxavXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617862; c=relaxed/simple;
	bh=4RGsYqKh5COiPjR1AeIG3YJ/+d/ctZMmDvt4v+E7hRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU4iBKhu44mbj1/268AxvFi0x0ZyfI2ffzLFq13lSkYYR2jzOpvV/YRhyHTL0s6w0b4fso+67GaCiUxhU+pPlNtLpo1KBt9GEW+03M/dx4xLj1jNA3HbPRVre/FHYh8xyX/Xu266RGMQdv30y0WJAyUp1XgeAfpm1y8ckSc5oIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=FUqDUHNK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269640c2d4bso8867915ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761617856; x=1762222656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRasVuptSb2E4fyxHvpuoBQu98CkUiF1wClK1J/dHaA=;
        b=FUqDUHNKk4oSQBe/Wi+GMFqrL+BUT/504/NK5dM4b1oQsQFgrD/e2eA0TvHiRKXL8J
         1TXfSINyU/85ccSFbWk5Qqrm2TB+kzccvIDisX8bSnFizKCxuMq7gQ2QjkHt+XNeXtH4
         tCiTr/DaJNP1/51+KvJ0DAcPGg9KZgmkH4z+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761617856; x=1762222656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRasVuptSb2E4fyxHvpuoBQu98CkUiF1wClK1J/dHaA=;
        b=Md+wTFg+wJnC8XWdfYvclDl9ZBWfBnEmGoVUlg0rhHqstHkKWKJXIPch156mBIUXWH
         pv48ZPI6YkKPqQ29qqR9hsBGf3iZYbRByyGbxahcTFqbgyhREddZ6iiFx3TXXnTWQRUj
         YioHQEsjdbnkfGBM2c+KGE9gmqbvEYCra1ItSe1J/0oejEWQ8p0VfJhaYrFgBr3Lqlux
         f1NimBvKJ+FfMOit7nEnY6Y8P6UEzEJWPjviM2qZ5YmlUsVy9SR+7q235LFdahXdM4Zl
         ddD9NCAZlbcsm69IQ5WI4lPyPKnoseHOfCuCvhfwmjpFOWZqWVzulEUP3paL16eFBbeL
         +MDA==
X-Gm-Message-State: AOJu0Ywy+jchGMsT4MJtSXjpWoj/hNARb+41UC+m64RFMejdb1Y9k3Pv
	8b20/WDrLXjnou50QhvXrfQkmrWTUZfxoOwd4zaXxnV47HM0GKshCDF9vaWSDIsXhS2AngDL678
	hdQc=
X-Gm-Gg: ASbGncuoKYaeiuj9p7hI/IWTBfIFnXDsdXt4j4D503xKd1dqTjrhfq543k3oz/K/bNs
	gWWXPd4B/Zy9A35D9H2Qg3CUintJ1btV4RgggemYDVUDE1TyB68HRZ7pTkCxE1puzXztAwC2sF4
	9CFiVYl91WusfZE5n4ZpkHSdKcKSzHK5G+xYEv/vs1hHvTPY3cpYh3mp7Kp4a2HwgROx0ksFyZ2
	d74mNuZmc3KDU3SAoMdq5spZOoPJFVkE3Cv3crw3XNmb8gIVJ2Smd7DoyiY+aqSEs7Idtoa9zKN
	V+oTvN0L/31gR4WIYXtRdGrU3YR1Knrwy+KgPtCgtLhvE272LtTkM4+4+bmZICKbe518esxGPQK
	gTCX2mO8FxKrZkmfac5kmV2jb1PAdXUBozG5651LnWi0vFYbh7eDvIVGc8zyDqZI7tE/gz7qmLw
	OzwVqQ89JOrBYHI/C7K2vZ/oIrZ4ilixiD7EB9cW2Gn3hma1OGw1I7b9KW9P3EcQikCFOj3jr6t
	yxxpkwrVWhDgpdV
X-Google-Smtp-Source: AGHT+IGk+Wit2trGW8g8fX09WMk6GWWnCwQJjT+X3SY0eLq9QqZdoKZdreJc06GRHhdMrN/SRXXxDQ==
X-Received: by 2002:a17:903:240b:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-294cacb1186mr12847195ad.0.1761617856337;
        Mon, 27 Oct 2025 19:17:36 -0700 (PDT)
Received: from localhost.localdomain ([121.120.74.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40ac9sm98147485ad.71.2025.10.27.19.17.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 19:17:35 -0700 (PDT)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update broken link in regulatory.bin(5) manpage
Date: Tue, 28 Oct 2025 10:17:29 +0800
Message-ID: <20251028021729.45098-1-me@ndoo.sg>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 regulatory.bin.5 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/regulatory.bin.5 b/regulatory.bin.5
index b1862cd..5448aca 100644
--- a/regulatory.bin.5
+++ b/regulatory.bin.5
@@ -45,5 +45,5 @@ and
 .BR crda (8)
 .BR iw (8)
 
-.BR http://wireless.kernel.org/en/developers/Regulatory/
+.BR https://wireless.docs.kernel.org/en/latest/en/developers/regulatory.html
 
-- 
2.50.1 (Apple Git-155)


