Return-Path: <linux-wireless+bounces-25005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E4AFDC48
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D75158706C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135911A285;
	Wed,  9 Jul 2025 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVRdACHw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC55111A8;
	Wed,  9 Jul 2025 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020563; cv=none; b=Jy5MEpGeP2yndoyx4/ZhDhUWoxXRun5hV84EywU9npBIjwoCAsSZQE82KKl9QpKR60hS2Y9viImGjB3L+PkVN2sSvivWmLa+GFAPXKNUvP+jcnZZdJnpkYzsFbF4+iMx6QUF558Qr6uL8Rci6jHSAUenVFP4e7IgvTkemw3XEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020563; c=relaxed/simple;
	bh=KTdKSqfZQpOooexv+tZoAIyveRopdv0w/LkpFI9U9x4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjXTj/22rmvy2Wh3BHx3ibnxvIRc4nG3cZAHMxHJ3Va8DAVSxd+reLK2fQbn4u1jRr2bn12QRcZ0CgALvAmIxk2dAx1IaG6x2cahUssXBz/EKDLZa3iOQqOy0qXKL7h2Z7B8XO0qgwgtRq+uf/nE6Ge4A2m4XXOhcgJOsK0I4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVRdACHw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74ce477af25so3022521b3a.3;
        Tue, 08 Jul 2025 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752020561; x=1752625361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcwWePkZ+61+GRHS7T5VOVYWhMHoHSzeV/UXG3AzxcI=;
        b=VVRdACHw4LEBiONboMF5cnLf6bb6MWLgUe/ALCIQJiYV2AcESKyddQK7huQBvNO9sW
         L/d3ZBoPcb/W+VWk1gVKAnTJsZrl6McOEbnVQAD9PymQkX80oSVR0zF4pQHEuUoAQ8V6
         yKiimtSQmv4/J1Nj0dPM0FVlnDxV11EI/XlQixlAndhw0FALaiX9lvEkAnVOXf4aplib
         m1Kt+3hv83Np+FX6qNypl+zPO2mRshQdgYuxnFQli92FfjE2ee8J2QjSZ7KHGEY4RJdf
         oZgQuqCAcXFhqb7A31jBibVsb417UktT0Owyy2SrP4oduyP0ZJVJlLqXmFNPE7AZ0WUD
         0zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752020561; x=1752625361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcwWePkZ+61+GRHS7T5VOVYWhMHoHSzeV/UXG3AzxcI=;
        b=ORFZTERQseKf14H4NU8fIs6l+aA/JRPEYejUHkeNlrghD44fsEFREUGCFr/GBUXKHo
         EcY08IxTcJev3h8u/9/EMV6geOIT0OOZa/nkRSRVVGJ5Xj7y/jNjMatvqjYkTq3/2Q1z
         ma0quGDyrsjTPlLCZ0IN2qWKshQt5WSUc1JmDoPMJ1vStR/4NFcx6G9m42Pso+kLqtuC
         6ercyGE7kcUWBojbT98WyYoi5/XbLaxfaJMeAWr0zpStywc36nGfzSaHtLf5DlwrEzC0
         km+x6FU2RADGyfRR98bg/qUahym0MZ+pQZfAYzvcycO8Zn2hgKRGXr1Km9JzV/H1QsG0
         HqPg==
X-Forwarded-Encrypted: i=1; AJvYcCUuGZ/6JstRbucAyuPYraCzynqWCmRyYbiKE5Inchpqh3BoTOmLDGEyEOj1Xn02B2bVUrUN9DYiY3wv0Dcd@vger.kernel.org, AJvYcCVKk7W6MYLS4aKbFIkGnfiu35VJVKMErMA1iRBVWQrNBaiMUjgSm7CQO0/vC44fKmt5TZ4Tdun2/hEg@vger.kernel.org, AJvYcCVd1Gbm/BdfHIDd+XfmdryoBmmR90Q3K5OcK5f6ydpH48xzJ/dOIqRG1/VpsxzS/DLc2TAbl/fi3XaRbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNqArO0tqYuL3HYHnrIeQ7VMOLt0OpeW4lvXBVTVUc9Z1/ix1
	+pqDEQjcxtnQXvfMQsGFgXgBkTssq2mES0FeUk3Z5XmJTluwjsoUBvtDpajcBqkuKrQ=
X-Gm-Gg: ASbGnct1kTS0sp/ON51tZHXA7urFHM8HgRKD/zy/rJCvL1P2PCnW+sh4obCZKzJvH+N
	PAg8Y62mjuxbLZrq0OtVtBodUvpOhHAeuXPG0hOnz36FCTAc7l8j+AIOzWxAYsMK3UkB9eqet8P
	zOA2Lwz4GfInLWrbCMINCQuy3Bg/hfUuLAP7Xkg0+Psg05pEh1yFsGtQH24anGk2e+Lnj5cFFPt
	9bk7RPcX78ky3phSwSLK1CO9tYYJl3GjXV/1y25DTAPUhG/0QFqsqerGxT3hueX04pJvayzJCTU
	pV6joHMbcgJ3qb99gtiqQBojZ6kWW71Xe7F6CGj52w8=
X-Google-Smtp-Source: AGHT+IEoBA4HHBIBWKsPCT2mLl7+qyWKOlyAaO+l5jgMStBRBhSbtVujXmRrrApyjtT9L32hT9oqWQ==
X-Received: by 2002:a05:6a20:734d:b0:220:33e9:15da with SMTP id adf61e73a8af0-22cd68be5f5mr777221637.2.1752020560598;
        Tue, 08 Jul 2025 17:22:40 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3924868c3dsm4910400a12.23.2025.07.08.17.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 17:22:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Rosen Penev <rosenp@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH wireless-next] wifi: ath9k: ahb: add OF dependency
Date: Tue,  8 Jul 2025 17:22:38 -0700
Message-ID: <20250709002238.5988-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to OF missed adding a Kconfig dependency.

Fixes: 2fa490c0d7 ("wifi: ath9k: ahb: replace id_table with of")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 Since this is for something that hasn't hit master yet, I assume
 wireless-next is the proper place for it.
 drivers/net/wireless/ath/ath9k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index 0c47be06c153..47d570a5ca6a 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -47,7 +47,7 @@ config ATH9K_PCI
 
 config ATH9K_AHB
 	bool "Atheros ath9k AHB bus support"
-	depends on ATH9K
+	depends on ATH9K && OF
 	default n
 	help
 	  This option enables the AHB bus support in ath9k.
-- 
2.50.0


