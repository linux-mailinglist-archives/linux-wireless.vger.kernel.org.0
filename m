Return-Path: <linux-wireless+bounces-25397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95456B0469D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5341A62EA9
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07AA265CDF;
	Mon, 14 Jul 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMlohXLO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C496258CEC;
	Mon, 14 Jul 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514588; cv=none; b=ORT7p6rBJwMWGQjlhwtMjROJjvh0Wj/1K1yoB2YXtQN/rSG3wq1TTtD9tX8RRi7x5OdKX0Xjt0er82ydBGO/5cAI/lr7Vyp3EMT5yjtKlK0uFZnKuJAdIsRRZZXZGKTsKtNqC8Elp5UUA5GYnigUm6OVl7yiYYIPD357w93RaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514588; c=relaxed/simple;
	bh=R6k+PA8mFAfajrct1qTMJVxBz3bbNDHAZienwy/KAqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1703c4na7DbgyE4cecQTPsoCBblMTyiL6Cykv1TkslQInDLXxix0WjxGRKA9bXaaxf2C/JYqI4beG2+K1JkhKJgWFbiF7c56eHFjqaJErEeIjVJElyy/Ui56dA/9h450Wr1Ve8XvAVTT/tY+a4DlppuaJJP8yqlpsuc1r5WfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMlohXLO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d3f72391so45310285e9.3;
        Mon, 14 Jul 2025 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752514585; x=1753119385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87+Ndx4tU3Bc/RBm9y43dq54vArNIkAlt17RzyhLMK4=;
        b=ZMlohXLOOFYpEcjF6jeX09WaUr8aUpkOhFhP355lvcqDXB3h8rJEpp1Emixqb7Qnu/
         wRVcPzrGnsNHYb5seAcysVZxUsoXOebCgxEZT5qfp4BnYenUpqqGSqLLCV0SIfhZs+BU
         vpDzO/OmUJYbzC0KIQV95QRoVZfY/+DHgGxEaEsLLC7qH5Sy9Zyu9XsPCDxcoYGF4FE0
         Fke9EnK09Hqg9LZOEvmmsDuP1CqAbyfYEqIXZV1T23dFWTpjBjXer7FX6fVvUFAgJBD3
         mU8MDZpT56bSz9wrDDO8f77LGx1+h6W8JLwvi1J01/EyTES/9JMtwMmbORZHOqIJG7BU
         SbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514585; x=1753119385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87+Ndx4tU3Bc/RBm9y43dq54vArNIkAlt17RzyhLMK4=;
        b=nuCARqDskFjJBmRatKeVLaniMtOXKxYU5h2MsntNSpNGcAjslUcNX150X3FRVXfqeK
         Yb/Qq8F8pLfjIypVWBbN410f+N/xYJBy+9xKv4q/7JZjOGld/7fSOuyrbjzFKz5QVY0H
         AxGvqgHNHNYIy9FaFqNXyA99WFXMLdMYt9c6cgwDL2DkkCotjA784bWov687nVeXoOzW
         OL1520YEwckAvMkw14F7mQbjZbzKVAm6iZURfdHuLKxIAfRdV2yCgqKvAd2frbuAQv2E
         vLGzT4DggIQlljgXRqvlekIlgk4vb7y12yqEW6hWAjc9MDzPl7u9ppO4rN4IfvHFa6s5
         lYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUB/bHNPJZAZeQ789avnZ4E4XRPVcYg3ooT95WdJbXDIWwXP1Vx/sO0G+eAtrP+9/inADv6+2txHQdAeEVRYc+66tZqUw==@vger.kernel.org, AJvYcCV7K5YufMol2meRHGc3f9NY9uzHJACEl2L963qSv6/u1Cvf///wt7U5SevJGeK9ObNbZ47icCRNJFQc@vger.kernel.org, AJvYcCVWiwmqH0ExRWsqOqJuYcwxMd3PHJfFn0bf8N33T34p9YKC/rF1hNlD5tU39d/+gRxbfY3GCLTVgK+OaRpW4Mw=@vger.kernel.org, AJvYcCVfq6pgT4HBoSkZcZj1tQs2Kz11SVcoxA1IZhDilMRv6DeRTikhpaG2x1JFWv4032w3raPsLtEfsjM55J7lzQ==@vger.kernel.org, AJvYcCWzoDwZWz75g+EDhCJM00Mteg+Q3fYgLTPV+GUL9PzY5rEaWLsNQpo5pAjghDzwN82P79tFK4H1Wvha0tYV@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVw8PXwMDmA3RtBHDE361C0loWDXiIwdFTxTLlVKetBRVgZCu
	Fb3xJejmIEzdqLxEZQAd3uQSQOYbxgU9B6Qt1XPbBZp3RwN+7GqoGf1y
X-Gm-Gg: ASbGncv0HrGJashs0nGr9JF7OAnOaNVNMHDgDdpBpIZL0On1ZnOm0843gGTj6t0K6N7
	afL1l7FIfJJziTtQNqvHJ9+vqa3jgcJ7WE311kWOPgn7bqe+k0NNCPSoLuA13GVJrXemp9gSfBY
	5YHuUWaYJDeHPwMNu2SzpzTDCHUdJYlLaiEdcTqNLePFWVzGM2wqYi9Y5XUdkv3vugj/vmHyZJH
	25ZUsSoFUV/iuv5szl965ZHoObtf9Fr3c+Z0NWXG3HZou2xhzFcHifDii0ATeyCE1433vnt/25m
	LlDQYNnY/xfIxZMwGVJTbDn7nCqBf13hSS3Ntg8ccat3p7l+mTKXbp3NsM4qcbhYiWaDHYWKYNr
	wG/dQRX55BTRytoEuiGsUbi5VbF4ZCpNDhAkvtA83TG6RAA==
X-Google-Smtp-Source: AGHT+IHwE5k8y6WgeeHHGTBoqTHW3b9d3pXfevxQkkUzEV8uufq6SNg+JFLfpZe/W1mCrWg4+Y19GA==
X-Received: by 2002:a5d:5f49:0:b0:3a3:6e85:a529 with SMTP id ffacd0b85a97d-3b5f18f80c5mr11655696f8f.51.1752514584561;
        Mon, 14 Jul 2025 10:36:24 -0700 (PDT)
Received: from alarm (92.40.201.95.threembb.co.uk. [92.40.201.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm13152531f8f.60.2025.07.14.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:36:24 -0700 (PDT)
From: Dale Whinham <daleyo@gmail.com>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	freedreno@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>,
	Dale Whinham <daleyo@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/9] Microsoft Surface Pro 11 support
Date: Mon, 14 Jul 2025 18:35:36 +0100
Message-ID: <20250714173554.14223-1-daleyo@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series brings support for the X1E80100/X1P64100-based Microsoft
Surface Pro 11.

Patches 7 to 9 are included as RFC as we are unsure of how best to
achieve the required functionality, however the implementation is
functional.

Dale Whinham (6):
  dt-bindings: display: panel: samsung,atna30dw01: document ATNA30DW01
  firmware: qcom: scm: allow QSEECOM on Surface Pro 11
  platform/surface: aggregator_registry: Add Surface Pro 11
  arm64: dts: qcom: Add support for Surface Pro 11
  wifi: ath12k: Add support for disabling rfkill via devicetree
  arm64: dts: qcom: x1e80100-denali: Disable rfkill for wifi0

Jérôme de Bretagne (3):
  dt-bindings: arm: qcom: Document Microsoft Surface Pro 11
  drm/msm/dp: Work around bogus maximum link rate
  dt-bindings: wireless: ath12k: Add disable-rfkill property

 .../devicetree/bindings/arm/qcom.yaml         |    1 +
 .../display/panel/samsung,atna33xc20.yaml     |    2 +
 .../bindings/net/wireless/qcom,ath12k.yaml    |    3 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../dts/qcom/x1e80100-microsoft-denali.dts    | 1341 +++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              |    1 +
 drivers/gpu/drm/msm/dp/dp_panel.c             |   13 +
 drivers/net/wireless/ath/ath12k/core.c        |    3 +
 .../surface/surface_aggregator_registry.c     |   18 +
 9 files changed, 1383 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-microsoft-denali.dts

-- 
2.50.1


