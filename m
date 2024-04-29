Return-Path: <linux-wireless+bounces-6989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8098B5AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF62B258AB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39567BB07;
	Mon, 29 Apr 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="XnZoY7Ur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC08768EA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399704; cv=none; b=EGbgRIBz3QkD56ZCp2uMhKveQK+ziT0x0yV1ZMyo7t9w+Xs8MdyWKtzgQHf+Vaya4+MxzwKoj4QbPYCVmT/uZqpTmPZChzGBRcDrprwvepc6IMlmhdXnoXB194jOEdKHmXyL6ZMoP6SchXr0JBPe8n8bYYnpMR5xDn3lhDnF1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399704; c=relaxed/simple;
	bh=U0UEVvgtP+Df0Luov+wIMPnlM4UAENUSvdQsvkRwh3U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TMkxcuZs0qoPHiAcCyE49ALdRRdc1nkJn/dKNAiMjspfndvL3xPnlxYK7zytnsSHLtTITaI1oGTaocFHWWWc3x4JP5MST7q17tj3bXtZYl0OtaSSYTN8XO9pyVVEtVUxqqG0rLX1OJ3H4op4sbgV1odN+7F49pOjs5oTYujXbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=XnZoY7Ur; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso58925551fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714399701; x=1715004501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oBy2kmpzdw0iu+shQSoNx7bJmznd+L61sp+luHwDb1k=;
        b=XnZoY7UrfY7IKb6dUZV1MTTYhYs6cAmzgnK3BP6aZ728GejOm392qZcXamjVbp4bND
         u1Au1ap9//OWnKQljLwOTwBXfmzbfkiUPxjzuCSG4eqSgdrXtM8GxmyLLczb0x/6doop
         rHG4CLLGNUVIzPyLyD9AlBTckuGeKPt87FTIPVm7bJ5q0sBQ9+wTaiIfk2Y4Dx3UflMB
         Z9wt4jSKq8IXnB9iTsabSHVLPYERdXpb8GNYKJDe7iieQQPfHKNo3JJ8kxoZY8f+aQYf
         SYJsMYVL7gStU4yfM4oNobQ4JEewkVJ5yXCi6CkumSm5pdUsKVUhYZp4lbikzliIqP37
         9egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399701; x=1715004501;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBy2kmpzdw0iu+shQSoNx7bJmznd+L61sp+luHwDb1k=;
        b=UbZlX/JfZuKMToAzwEaM4DUgs6OUc1X7anhNF0ZuOxNua4oZFPOfshYWXbuOdH/j+E
         y1IZdorciHndDMzIwK3D1dZlYge+2ibUXrNdUSxl+OpA3dXvxG1uztFs6+X//Vhz9mbU
         9eTLUFE7+T3KDnx+CuIvnGNkdQENk6C7VuxMl2TMDV9oPS0wNP7q7aJncXu+QkCzc7kU
         hYaPkoPBvd33ks2YRFuT+CT1NKuDqiNCu1q4kvbgsyOQA+L5yujY82es3hAoe3juCM8f
         ccWbgcvO7BEc0MP4ask7LBEjeiRi5X/laUZ1VxwKD1uCcj4KGfVeo8GSiGB3Gg/xMJ3q
         1jpQ==
X-Gm-Message-State: AOJu0Yycbp9oB2RjXp+PMDTyoagZGII0QNWxFV7YdtYwcvMl2hr+bW/V
	olXrp1o9f4DcRhUzC28k3R+/3TTwT2KjRaSFe3Tw/W++eM+yJF9iJfztuERATqU=
X-Google-Smtp-Source: AGHT+IGx5tX+xy8iJXA69SZQR1U/gQ2YxMQre7YD8YVUOem41NsX4VFYFSkbO1iHvPCmEz4H+9316w==
X-Received: by 2002:a2e:9b41:0:b0:2dc:bf5c:9648 with SMTP id o1-20020a2e9b41000000b002dcbf5c9648mr7245557ljj.19.1714399701145;
        Mon, 29 Apr 2024 07:08:21 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d6881000000b0034615862c64sm29585477wru.110.2024.04.29.07.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:08:20 -0700 (PDT)
Message-ID: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
Date: Mon, 29 Apr 2024 16:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
From: Marc Gonzalez <mgonzalez@freebox.fr>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
Content-Language: en-US
In-Reply-To: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The ath10k driver waits for an "MSA_READY" indicator
to complete initialization. If the indicator is not
received, then the device remains unusable.

cf. ath10k_qmi_driver_event_work()

Several msm8998-based devices are affected by this issue.
Oddly, it seems safe to NOT wait for the indicator, and
proceed immediately when QMI_EVENT_SERVER_ARRIVE.

Jeff Johnson wrote:

  The feedback I received was "it might be ok to change all ath10k qmi
  to skip waiting for msa_ready", and it was pointed out that ath11k
  (and ath12k) do not wait for it.

  However with so many deployed devices, "might be ok" isn't a strong
  argument for changing the default behavior.

Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
work-around in the driver. However, firmware-5.bin is parsed too late.
So we are stuck with a DT property.

Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 9b3ef4bc37325..9070a41f7fc07 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -122,6 +122,11 @@ properties:
       Whether to skip executing an SCM call that reassigns the memory
       region ownership.
 
+  qcom,no-msa-ready-indicator:
+    type: boolean
+    description:
+      Don't wait for MSA_READY indicator to complete init.
+
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: State bits used by the AP to signal the WLAN Q6.
-- 
2.34.1


