Return-Path: <linux-wireless+bounces-3840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF585D246
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD452856F7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E53BB26;
	Wed, 21 Feb 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8hBAxYa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6023C6A6;
	Wed, 21 Feb 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503190; cv=none; b=H/vKxrmEUyzQ3bALIuIhqR8OxhMlnnQL8A1tbQe4OwmrtMQ7FLgS8dlIX1uVrFDHDhxr9TqPcAW+JBEf69sp4zA7eSumnlXofjJ02ErXSnO6K0xp5zW0kXowN5oGEhgGxzOs6qRK79CaooJFDsw/JI5/9d6prZHemGiT2QkESOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503190; c=relaxed/simple;
	bh=6z67RUfRUOi4Z6G49qLe9mM2AhVwVasTkIShUsafPWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=do0aJxZNw88mRH0qduEDncaX15JvDcrPMVWcjmsuKR8bL8gtO+qnwjYN9zDs1QMCxCr7gu01GpXxNdwdp1bDLole1l/kUim9gLDpXlQ58BpWBbs2vT3eEbnTt4UzalyTDfMuxWfvz1NT/i+panUEAKNxmqAbP+BwjMdihRR+22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8hBAxYa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b42b6697so3647127e87.1;
        Wed, 21 Feb 2024 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708503177; x=1709107977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eWTzORbbiIpz3VaWvIplgyLsTQizBCwhJdtvKmGP+A=;
        b=E8hBAxYa4KPSlPIJjri91+Yc/lWvNYjxta4N9LEe8jK28QcD3ojDGJMzB+gqzY0Zz7
         +gRnkth8sXMkcyjr2p7sbTBqqRI7Plf9XIxb1A8mSSEAedF4CpSrK7XvU7DAu0d50gFK
         K3ZMrOT20UAnD1IwbFkj7N5NYSGBXwsHTaAoCrrr+RBOoTs9Q1Tu3AFYKOvRcMR+YlnO
         Ap+pMeXLkmi7l9j8qI0gd/Ci/G9It00YB8ZTSroBhGHXtWqVAfXEdNOUjRHlqARV1aKI
         HnDt6CLL12hOR1QbWURkbWfTsMO2afVh2tQ1W3AswyACXWfrMN41a/KaUI5OMVzAi1ri
         8QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708503177; x=1709107977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eWTzORbbiIpz3VaWvIplgyLsTQizBCwhJdtvKmGP+A=;
        b=UyJYFsdG1LxOZs1o/qhiZ067SheBvmklytVhXQ5MoltZ3PztlkoqQM5Wn0clkxRcfV
         WMjJJsMbNip0ppORy7u40khBAwx0FdpwxnNn7qMEgeF+1ypZdgqTlg8jiQ4/eL/Is8tn
         NyOGi6TeW3ukOiShtoD68DUhXO7dmO32LuUDJVGBCg0x6gCBHbmZvUppECMeREEdDjG2
         MUQDBSPcUnNTooLu9R/jUsw3AgrGVkmE/7NovHzjIHxUCMzN+5lXOgv7Tr0h3M6kqLXL
         Z2acn9A/91TceUYEqtLQNK5MI4zYHH9ZdVh8HqOm9EscGqEwGO9HxPx6XFPGXrQrurLj
         C+YA==
X-Forwarded-Encrypted: i=1; AJvYcCVwmE/5YWMFt+P3zWABHgIfP+UEJ1UmErp2WSeJsq0iGLcWzdwt+pJAqTG0PxwUt4X7Hnk9MtX/NNHh/F33GIntXFoptBjwL7hQ1h1nHLPmprn03HAlnVM9jyoDT804DUuFfwUhFD/OmMH1E3AeJvFgq38ziYS6ASLgZUYDjlRR69mi
X-Gm-Message-State: AOJu0Ywo33T3xqW9U0255idcxIcN6JqSJMQZ/RmjpTRLH8I6wrLkLeyX
	KjaSsn6JgIKOV0jMOK7QCOcGumJSuXYoKwRa1SvS9Yl8JgH8a5w7
X-Google-Smtp-Source: AGHT+IGyQ9GZtCJkvm9sABHTesHxad3BmSuXezswVyaQVUsfQ8lWVuh6nqCARxX2kR0Q88GbH2OUqw==
X-Received: by 2002:a05:6512:3409:b0:512:b3bf:b803 with SMTP id i9-20020a056512340900b00512b3bfb803mr5927236lfr.39.1708503177210;
        Wed, 21 Feb 2024 00:12:57 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id r8-20020ac25f88000000b0051144c7cf9esm1562692lfe.265.2024.02.21.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:12:56 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH] dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981
Date: Wed, 21 Feb 2024 09:12:38 +0100
Message-Id: <20240221081238.24775-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 (Filogic 820) is a low cost version of MT7986 (Filogic 830) with
a similar wireless controller that also supports four interrupts.

Cc: Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 0c6835db397f..eabceb849537 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -226,6 +226,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt7981-wmac
               - mediatek,mt7986-wmac
     then:
       properties:
-- 
2.35.3


