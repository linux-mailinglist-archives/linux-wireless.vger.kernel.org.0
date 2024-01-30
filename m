Return-Path: <linux-wireless+bounces-2832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36A842999
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D028BE78
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CDE12BF19;
	Tue, 30 Jan 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svoCdNqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719F1272B0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632725; cv=none; b=c+3r6830hfc6lPfsS8h/YIGD+aPBdaWQ7YmXJs7uBpqQIycpETNI1Drf4MmWHlit49BF+2lvhSsmtLuJtekBTYYWZnxOthIxqX7sfcqSOPWLLB9x/b0EjZPD1bkVaS0idvgbFmYmK9OvC5Fuh7WAjvlbkZ8ZHBufRIhzYzuiirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632725; c=relaxed/simple;
	bh=joeNalrvSUjxzcfitaywNQDHhfJkpn+IjrWfLA33KYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpFtkLVVTRWcEFESRa+YvfJRe2bMtEg7LrIH8Ad3KV9/jJXGskzla9rwdkQVL8TLcfhJk1+COksxvdlxkgai6odheicQVobcuZhaHxs50OAhu9WoR/ioeVtHp8xUxY+naFFmrtxQB93UD0ynIIaY1VE3B7glsczxMth2mAZrDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=svoCdNqi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso50619351fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706632721; x=1707237521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkBWOdO+qvsAeOVOitSdzMYitKjft4jo1MuVN9iIs+o=;
        b=svoCdNqiyQZayuSbKof7xb5UT8WZg8sBIoIAtB0yPi5lmhEp02slXRIG45GY+e6NxZ
         YBn5GYVRTp+1grxGM5I9Ij9dGXYrLWVlmnR0pxKZNGiXO00lv2ChrGO08iORb+mTzqtG
         CxAxinPbu28E7f+yWmA7XnFtvbaDl2hYeyez9elRJ3a8TZpYlaxCwtSzH6F6x0+VYV5e
         WeJFyLdwjXY3koKleUmjr4xzKWpoiO/NyG/ar7+DCk3s4sn6ZuiWeN1WKpXKEVSbj5MA
         AzvJ0yfghtYOm6TPgY9FAKcU3UNEV6JqFb8kf9QfrRBiv8WAgG1yUflRbltmRuZSZeww
         TaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632721; x=1707237521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkBWOdO+qvsAeOVOitSdzMYitKjft4jo1MuVN9iIs+o=;
        b=gwgjq5Z1aaXvoQGxounwfSf+O+AVwZPm0KjmEKIIP1Mxzkq2LC40VY62rqulEBhbVD
         6qrXAaZtJ/ypMnxdpFpgRrNQmos7Qyy8AThip4bEIFoZ61cFykrskzOShhxY9H0Lf1+V
         qqfqsEmWkgBdJIx6gJYLwBHHWPdP6r2JWhYPfxFpKoEXw36ZtCfPa6/qt5y+ixvBZw4X
         LHPaqtj41Lj1qbKk50MnswtkxP8tU2YJ3OMVI+uPuOs97GSgbjGSA5K7WJwYrI53nqCU
         IUEQa4mNTGODBgWjyCA9GaAVmvlUMj1BC/9+DZsiI54mScSG8G/eEs45cWk34oKwVDrr
         or7A==
X-Gm-Message-State: AOJu0Yy2LU2FFMlkZ1JI22yToaayAxIalNhI13ZF7PKKauvz9hvLDJs2
	FpuZ5+QPifCtIn10MwMN/VHqixG9kObjWEarrUo+c+xK8gf5iWQStxg2tc9vG6k=
X-Google-Smtp-Source: AGHT+IHcR/INXyMQm7cdRP5o+9K7B+ied00nBC4Mz80JeX54GoUA4psIYuBL7binxxZcxZZAfrB9cg==
X-Received: by 2002:a05:651c:b0c:b0:2d0:5fdc:84d1 with SMTP id b12-20020a05651c0b0c00b002d05fdc84d1mr1290249ljr.44.1706632720882;
        Tue, 30 Jan 2024 08:38:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2tk9lqy3/Osz6GkoXbmkKRKU79W3kyQt7xKU24VjtYesQV8jOsU7nwsvCoKPzTnfJtemTDTwKyr5opJ6cYvMIr/zcy8+VpoQeqJHmNfCHLJRSlnHgA+GwR7xJSgGakIarvma+3zBwAGtHjoFI0jTZTkyOxFxIyG5J5W1n+zkbsxfQcdaJDc4k77OnFdMLWB7c86yVHLY53/LNnNFaeq2zaNjW4GDOFBGoPrfW7uJDYElelKbPlQNOB+3Gy3uUFPXnQn9b6mmE6VZoRVgFdGygNotyYERVw7yo3sHgPNSEfdVRNfxIO0+x+8T75TKsVL9h4GfQlm4PkOZfQMDJxcxr4FMA200BTWCbaJQKQoCbqsQ3N1PUxLeIBdYpjbOELZ7John63NG/0bAxmvoq724tY31KWGQih0fG6o/o+yUmahpp9VAIgy781t9+3bAWelLXKbAKv8vpN3wg0/+x1jTVJXlGaQ4q079jQicyedCTfQ+tjHldfvdK/VM6nDlE2sdvaHkqdF4=
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id y8-20020a2e9788000000b002d05e8bd84fsm219639lji.31.2024.01.30.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:38:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jan 2024 18:38:37 +0200
Subject: [PATCH RFC 1/4] dt-bindings: net: wireless: ath10k: describe
 firmware-name property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-wcn3990-firmware-path-v1-1-826b93202964@linaro.org>
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
In-Reply-To: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=joeNalrvSUjxzcfitaywNQDHhfJkpn+IjrWfLA33KYo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluSYOCdILkzqsMfLapfo+/MAwxlC+pnmkooirH
 Yhd8TeS1XKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZbkmDgAKCRCLPIo+Aiko
 1V+mCACrGM7TycyL1KFXPHVZL5m0Q5zw/LB7sV5JJ/fmGxdeiew65D+nDORGLxPcRdDJOR9UtdZ
 +8uP8B0Iq+r6cSuLQc38hsyTN2SV6H5565TRaO1s7m1gYHzLCMvpPu/oJZE8UuKkXYT346BEd4d
 6feUydYenZ/v+UiIlewcTPuRwM+bnBJztIV3x2p0fzZ87ZY9AmwZCwQpL+ucGSlJjrTug2Fiw5E
 jYavB1j35o6RGIDo7smxNCutkppRBzjIQt+sTmx1PTWbrs1bM3uOlly0M4Ved/gYHhZmFq/H1Jp
 HfNW/erZEnp92AvTkAYKMrRUMog7HA/HPxSWNkedfa7bMGTj
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

For WCN3990 platforms we need to look for the platform / board specific
firmware-N.mbn file which corresponds to the wlanmdsp.mbn loaded to the
modem DSP via the TQFTPserv. Add firmware-name property describing this
classifier.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 7758a55dd328..d978d850ce93 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -72,6 +72,12 @@ properties:
       - sky85703-11
       - sky85803
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup firmware
+      files for the device.
+
   wifi-firmware:
     type: object
     additionalProperties: false

-- 
2.39.2


