Return-Path: <linux-wireless+bounces-23348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E3AC1D11
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF4A248DE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9D1F0E39;
	Fri, 23 May 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/jLTllH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5D22F778;
	Fri, 23 May 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981945; cv=none; b=f3eyaeTYSI+7gSb3LMRFvqb5QWHfuNYyYD/Oru6LYjGNGTQp5P1lfj2w6x3WSIpuUI6Nat9eUU1D3oNx+ilzNIGiXyjvFDjcrYKo00TrSWsrilu05yPxsPeGdjUC1UpfF3A4wh4Y5kwsRuKoCQ5TWw0VlkIJHNidlwkvSSiVH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981945; c=relaxed/simple;
	bh=LAVh7geJL1PD75mFZMVsyKCNDPWBKX7Jf3cyBhahb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovkcCxQmMQG4kFAn1JMV27OKNYznXO6cQnDqnfmmvujRBYedAKr/+0yEh5ccp+C1sfA8wPcBfAMF6O/BxKccD7uyisd9T3NoTw4xwnS2uadfcbYTIxYWZGuxUbuZMMRv/vS9g8Nn/b8vf6nONel84PSFM8zaohETakMMUiTwfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/jLTllH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47692b9d059so121584361cf.3;
        Thu, 22 May 2025 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981942; x=1748586742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=i/jLTllHhm2e9wZwBOV5OWG1nLq3YvD+ftqDBujYePxUc+mXlBAVfdC4d3+t1Sn7k4
         pqZdOrQF5ZjG3bUGBCVxhVK/z+sPfPQEmUBVrRkjl0f1ajL3oFdefp1PNADc7AH6W3j2
         TqV0sfhntgMf86uXJO13zNDpN10HHGglnQUpx/y4lyFIa0MxgYuUyt7xcQIdMHtt5K2A
         2K6gizyDEZvyEYFp+YvaidWW9e+4LWkswAP8cCdHq0FLPJESDAOdXk5hwY1P/ojQC4qE
         yJT/Oz0xYlvx19tm2DMGImebicTW4/384j9ni7Bs9u0Adpg0ls5sIi3epBoi8UcA4WnZ
         ioJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981942; x=1748586742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nQsjeWRBpWxFf7RQtRpXio5qVfPNye6yh/BzrdVEeY=;
        b=e7vBfPHH4PDzoZYJohAZwVmcIIb0ZHLDjjRop2lrsRMh6L+n/wRkVUExsP6yr4F86d
         LFP76h94gefQCYL8XlL52y8GT8DJ6utrXECc3fRTBCX3jEalB4YvfP0G9IgFjyrJae9r
         6p5G7zQSdxoLr3O+dda0FJYoFe0CflSazXWFR5iqz7ptEResdSLh3L03oOw1pn50RuBm
         MmBRYN2CKJhBEfG9+r9xX+ovziFl9ghoCNM6EVBVS8IN/FxQjJPrVTZJ4aC4CeTtUcSH
         XCq20Qy1w46yp5JWTuYZZUZssY4wA/NTmojhQAcpODFe7vVYGScd/gsyxRo74AjSl8Qo
         335g==
X-Forwarded-Encrypted: i=1; AJvYcCVytr3BB21e945E4SwplvdQ4Td7HnQRAmYxSJXh22lIxpPTjqrLxTeTlB8FT97r7U2g77sXdNvS37ny@vger.kernel.org, AJvYcCWXe9S4FHNrKbq/tz+OUO7TKPwFAm1kvY9to0KMJ1lz2dZJicXK/XxpzEDHqXYuGq+Wj4OLQFwaFnX1UEgC@vger.kernel.org, AJvYcCWp3H3KzJrH5Kn9ByrcPlsJ5/1i1uvZ++Xrds5Ee7e2DZqgCgeh/05TQIvdxnw0512CzuUYLNodlhU0wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyoP1xLe2ZoBfsf+mSZs5gEayGu7E5Xw3ia9whkFdkQroTawX8
	rDJrZxWdr+1jpWWL9VGl3NFh5UAqQb5/ffRPRgix2cWtHedVEb3gy8crYh1tIg==
X-Gm-Gg: ASbGncv9LC5hmOJggJALLLtUJENeubndGb7KqQd9jWy/VLudtQiLNdl5cMKgSl7nbsy
	uyECKvOKMRJdK0qAbIi2PfRlZjYnm1y+3p3Z3JZ63SGxEtNsIzgfe0ZfwzlqnOPHQmuJMdpKLeV
	IqfIBsgQzWRMkp3fbAh/GEg4t12FIA2wdqdYN32o+bX5spQlagxfD4eFctuJABuLl1K6xM6j6rX
	d8Gl6Onu7Eqn+YW2rLpiJpHeLXK7//BtdO1ZGHuI/Qt8PjNTrExkNp/GkF54vFj58f/sfJl34Ea
	KIOeChmZA+d4f26AVb7JCDNdbtE=
X-Google-Smtp-Source: AGHT+IEvbmka0GSHTPog5KIT03MKqtOZEgept/g5Yrg4Hm2wxexnZXf0TDfAsEvItRkiKqIlh4Q3/w==
X-Received: by 2002:a05:6a00:9168:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-742acce71d9mr36634915b3a.14.1747981931112;
        Thu, 22 May 2025 23:32:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 1/5] wifi: ath9k: ahb: reorder declarations
Date: Thu, 22 May 2025 23:32:03 -0700
Message-ID: <20250523063207.10040-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523063207.10040-1-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Easier to look at. Follows netdev style.

Also remove ret assignment. Because of all of these devm conversions,
ret = 0 is a path that never gets hit. The first time it does it when
request_irq fails, but that ends up reassigning it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 49b7ab26c477..d2a97e74f451 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -71,14 +71,14 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	void __iomem *mem;
-	struct ath_softc *sc;
-	struct ieee80211_hw *hw;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	int irq;
-	int ret = 0;
+	struct ieee80211_hw *hw;
+	struct ath_softc *sc;
 	struct ath_hw *ah;
+	void __iomem *mem;
 	char hw_name[64];
+	int irq;
+	int ret;
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data specified\n");
-- 
2.49.0


