Return-Path: <linux-wireless+bounces-4191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB486B03F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFBB1C2355D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DB14C58E;
	Wed, 28 Feb 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="C2utC4WR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8A14AD24
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126838; cv=none; b=pZks5sn4BrrMbDwPAU1PfaU62zmecCT4lAZV7hNSrCTmD8oqOIXlmX8lyPcBFf+GdZzxzVQ4m0hSeyqS6G0um31YO83XJU8HNqLsL2Xmgpz8EjYYgcbAgWQcZW9QN8obCMSpFuO7sMQFu1slkcjgqwQ4J/M+uyMCKEh2HjKEw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126838; c=relaxed/simple;
	bh=6qkae6OUAl8jFEPYN6gLtzuHKLd7G9FT70ngn60ogBI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lVlzOXG1G3MmzDJjUf0gI/4MQB4TcoylKoDjSn74PAaFhRBk4WtguSiUTDz/pnOTRFR5LuQPmyG+7yy0ife9GspBOFM98nR6Be/iCWeiP8H/OM7Xe/wopLpo7IsaAokxGXHdAQOHU4TgQ45uIfd4rnd6sCFfqPKe6LYNwaa9Bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=C2utC4WR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so539913566b.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709126835; x=1709731635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlBHlzSiEBPWtuxmFn9XxBU1Hq+/oIayqPmB/zamnCU=;
        b=C2utC4WR8Pr7u23rVYKPKQ7UIqZu6rXd6UcqMe0oyElZmmHGIJbt55G0fhe35nw0bF
         HKlLjQwRu+gA9aqumMUXWeHaFj/B+5ObAQqe4u9lHaesMi1bJVOLRCh4plbu1uPUuxUu
         5fukNOPfu4JXUG9TabxVVjpFe6bsYN/DE5U7PQmsPdvTKq3u/f0acZm2I818zk3zNRsn
         0pXftFmqJN5G7+Rk9Up5CdOKXvZBCmQjeTFF5ZXil0NLhezZisp2f526+YQish4wHrfd
         d3+BEwamaZUyeav9lLEdpTGboU1kYkF1xu9ALaNxWXdTTeM1ls7JRL2epNLOiAxRbdGb
         PUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126835; x=1709731635;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlBHlzSiEBPWtuxmFn9XxBU1Hq+/oIayqPmB/zamnCU=;
        b=Kp3NNU4Nt2lwatU7V5K73ULgAOdKVN0+byTbZZPuu3m6fMm5l9avbn3tIlS5AvwIgh
         Ev2HE8WuFn+ktZNXE8yzgQOu9iE2hGTds8UoztHp7z3OIqcDg2GmIubtPmCBNCAD/Gtb
         amUNVRUvgl3U40OmXz/rFjxBIFN/FZOHJLWXM69CPOZesmdsjatIqZXPX72l3eHmImMi
         pliRjL6x944fSDHuPAZ1RDGUdl9SXq37OJ9pawjFXGYbjhkve6ek8V3zZkOqwIvOp1Nc
         21qocD7AFcGSUllDlOICWeGzyzwzhSgFhnkFLYM8VamYhL+z293myncRuOsZgtR89qD/
         yygQ==
X-Gm-Message-State: AOJu0YwUFc3R99698nHWNv1yV2u646GRX3RsuNQ+Osgaqy3GmmRp4Kc5
	SnZDtZxd3cR9ywPh4RP0bmUKdn/YLO2frfbXAn4oauj6a0zPIIzKqSDP1oFfUX4=
X-Google-Smtp-Source: AGHT+IF4ieAz5emSpqpP0jXkK0dEP3gJWfciU/k+bcViFKx5CN5o4HyJySr/DIl9xf+wQmFbTG+lzw==
X-Received: by 2002:a17:906:fac5:b0:a43:a7:c67b with SMTP id lu5-20020a170906fac500b00a4300a7c67bmr7566322ejb.28.1709126835143;
        Wed, 28 Feb 2024 05:27:15 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b00a42e4b5ab00sm1839417ejf.41.2024.02.28.05.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:27:14 -0800 (PST)
Message-ID: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
Date: Wed, 28 Feb 2024 14:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
In-Reply-To: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The driver waits for this indicator before proceeding,
yet some WCNSS firmwares apparently do not send it.
On those devices, it seems safe to ignore the indicator,
and continue loading the firmware.

Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 7758a55dd3286..145fa1a3c1c6a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -121,6 +121,14 @@ properties:
       Whether to skip executing an SCM call that reassigns the memory
       region ownership.
 
+  qcom,no-msa-ready-indicator:
+    type: boolean
+    description:
+      The driver waits for this indicator before proceeding,
+      yet some WCNSS firmwares apparently do not send it.
+      On those devices, it seems safe to ignore the indicator,
+      and continue loading the firmware.
+
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: State bits used by the AP to signal the WLAN Q6.
-- 
2.34.1


