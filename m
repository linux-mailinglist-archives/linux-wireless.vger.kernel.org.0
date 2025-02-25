Return-Path: <linux-wireless+bounces-19418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F24A4390C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B48D7ADF31
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D27269CFD;
	Tue, 25 Feb 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4Joi3Xe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D226989E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474355; cv=none; b=MNe7r24PI56F0Ze8AyTpvbGDrqMxA4F0TwaY3mFbLFfPYBMl+v7NlzBjiCxtuPHc30RfFqq4antWyydTFju/nhurfN6SAFO+8Ca+19R6EX2HcGZ56t0kF0IpT7wxdwser7yWT5gEescMTqh3eeKWVgA8TmQL4LXwMFgSPXJoqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474355; c=relaxed/simple;
	bh=6hubkaofZnp2cNd0Rhz1Eeg6I+8WlSTKZLkOz9iuFt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2erd8jIu850MeQeZAbqHN4Kasv/kZs7NIT9VmLxxA9MFgeUVIrN86X5/gW+WX+iLQnEzeUSfe4hzSF8/kT29AswHb3Vt1FsSXYlHIFLP/HJF8550oXoGE3y9QgyOoQSPK2Sjf3+s4vkIv2Lz/P9iHQ/fEu2maHgoXnBFjLCIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4Joi3Xe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7dd005cb0so76896466b.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474352; x=1741079152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06mNrTcXCt7RZqY/vp9hneEG+/6i/TGPCj+Z/hxHYlA=;
        b=H4Joi3XeBkOxEok8md9mK7FjSUBEeRHNCBzlY7aqub6tOmrr3IXvkqZCqGIBmauhNc
         bgGVlj/bmd7SX0UcJV2d4myCC5Qhgp36VA+UK9kWY4FnhJIpbluKO/ln7REEYrqti0zV
         M2a95iPxTt2YPjZTMtj3gDwXp3DX8LHJlFo0Q3/rbKM4/qcNAe1Ir+Tc4EvfwFXCVje7
         QVaQrzqIUp8q8Pw+0blbjnkQgVhq0eXXL6XGUjmkfQOIv2fGbbvekprhwv1RGZmYqk9f
         6c2lA9JwJBxij0ZrhTgPXsVogyr5/OaUeBsPQ/N/npjadPXI4JrENlkp/z/Xr2hp6Mxw
         MMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474352; x=1741079152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06mNrTcXCt7RZqY/vp9hneEG+/6i/TGPCj+Z/hxHYlA=;
        b=iPFTYSl+QONTrvtDjjdIBbM5VNpnXUz8hQqMx3lCxrHvPBoIDmCBenrHNw0qbjO6Fx
         6w7ZAWLjTPj+Jx2uhFA3CR/lk7TJJLaxtHIhiOFc1X/kjt8BXxp+gmIZydLmKrqF5p0A
         Pe3f+cc49TWG8YT11xkrgNVrnzvGCwHJd7x5yLhWaFmQp6LeULsTaFv3qdE0eMr8q/4H
         8f+QLKJD18lSR8G90LmFJkNw9CM2sz0Tr/h9XJXBiyOVt4tnDiweVu12+Js/TsuVvLzC
         DKU7Vzd/qULMj9g/sOWKwrzhecV4kjZ3g4YscKY63Vv6GMNsApyuylLSO5Pjd7nmozv1
         EpTg==
X-Gm-Message-State: AOJu0YzAzWc0WGMnkU4H3qAdY/OZe0XcuXIXbHJA1fqorbLrAJJYj+Mn
	iUdQVJeIdRGSmIb7/QmtjkyiF0w5fG+iczTtT8EbDsSwzS9bDps+DAvWtcsjHq12Aggj54j5nUD
	grU8=
X-Gm-Gg: ASbGncuOT45hGbRhDQJGXNxltt8MItc/rlvRViBFsCEydOtdl7o4DwdrwHgYWnoTclL
	/rNwoqtYrQZV2rQDX9rOREAAZt5aBqavipp8LanZZE083yQfpmZsvSatnGvFhk7Is/ZidllfHnw
	7cu7sSe5TvTw3w/WYpgCZOpg7jisDYyX9HekoqLeSDkbPW+ImAhY9LEjX9d2hMDg13SoxlsVqEi
	aHKWn3FoscoABWs7MudS53NQp3SlDkPjs/MdK+6/hSXm/UDa0aXdzXPNSMSc/dDJTB3fh4qwbTj
	g4tId/IXGZvgDMPhZxk9oFXltCeX9Bo9qFVGeHXnmf8FlXGb5CzfNkxMto1UT+mnfAtNAsiipy0
	N
X-Google-Smtp-Source: AGHT+IEDtxGszf6g/Wz9H8n07kdbiLAguC+HTfb+C9KwF25d/EzVT9csBJyf0u8/TD2ag29O9+6D5Q==
X-Received: by 2002:a17:907:2ce3:b0:ab7:cb76:1b0f with SMTP id a640c23a62f3a-abc09c13ac8mr618915866b.12.1740474351979;
        Tue, 25 Feb 2025 01:05:51 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:05:36 +0100
Subject: [PATCH 5/5] wifi: ath11k: Deprecate
 qcom,ath11k-calibration-variant properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-5-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6hubkaofZnp2cNd0Rhz1Eeg6I+8WlSTKZLkOz9iuFt0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfkV8bTTIfHJhKZH87D8t+BgcreXLJCy72sZ
 kr5biFJ0H+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H5AAKCRDBN2bmhouD
 131xD/sHjN99Ymfgrof7h6Xr6tnzgJnCZgaEhjGTTNv3i80kqqMuWrb08dI1DUXY22yHravlpaC
 ZUCtjjHxy439Kos2aTAQFFLQlcjAS5Q5vyMm1C9yBba+euWva3DciwUtfp9zpCUF3din7QQDrTw
 hgqBZU9BGee9SB6ZtEAgjBbJK3ue3/zS3sBIauPN1SAnVUFW5dJvQ8lMoHYXoSVLjzyzwO1R5qU
 8858f3uRrjAfQ0oKz07UPp00NnYA6VW/UnYJkL49kKLyezNTaE/BknhTCcJ3Fphl+dGxAxtYhmD
 fkVk1cfLYOIHpAwByhlwV4GF2CM4//LpLbIFkXwYgOfWWcWWrF0qZOtg83QgTwlprop/6MU33E+
 4gm42ueJZB53b8fxQwGrKsVs3UQuB/tn9V2ob5NxCZVzT9YW7QUwNR0KPz0iBalpSKT6HnqHlPt
 tYo174NQtWATN6pPGOtdfzq+mmrSQURPu9kLUpf4TqL2w9qgUxDItvNwDozEm92nNDEKKM5KmEL
 6yqQ6r46sz8w/PLQKov5hhd0t6CqL4kOQPDZlh2LroRVS4ymjXPpJgF2Yk69RL1O13q4k7ONrnT
 1JkELXUU8ds388D2EdpyLq5ddBmUjV8L4/wRtqqn1pAt9qQJglSaO6SmFxTFBfo/1VYcmu74vI2
 vGjcKg39xJpbpmw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add support for calibration-like properties without 'ath11k' prefix,
while still keeping everything backwards compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 65bba0ae69a9a8e869e72b7e6d915577c8fb27d1..3d39ff85ba94ad7229764045e7e6dcab99dd51d5 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1175,8 +1175,11 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 	if (!node)
 		return -ENOENT;
 
-	of_property_read_string(node, "qcom,ath11k-calibration-variant",
+	of_property_read_string(node, "qcom,calibration-variant",
 				&variant);
+	if (!variant)
+		of_property_read_string(node, "qcom,ath11k-calibration-variant",
+					&variant);
 	if (!variant)
 		return -ENODATA;
 

-- 
2.43.0


