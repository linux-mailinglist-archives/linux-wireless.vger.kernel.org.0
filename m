Return-Path: <linux-wireless+bounces-5482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA1D890750
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1508B26338
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032412F5B1;
	Thu, 28 Mar 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="ekDE738L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DEE446A5
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647582; cv=none; b=TA41RIAsxGVPi1Ch7KzJlO9orzE3w5R33gRgIsbKmYoT191U9tZq8SKrWHEHW+An+VopUahFST+6w/VJlohIsT7xf+temdmgt3YsPn4l6t1H67yEgPJamYjv+SK+YDcWTGIm2LYkskbrejb8cTOy02/gbaVFTR2ABWrOB+tNLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647582; c=relaxed/simple;
	bh=cBrfrQiFvoFDuBlj4G0fb4q9qQbWu3wbg1FHrBsVYcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kQy4AeTw+PUWcQh+V+syD61DYqj7ChgJ4DBOzPNFEzhExKcCIldFZCvctCwqZTrLkaExf8ak4yPTLoI229EfWNFh1w0wSC1TJGHguec8WB+SeF88airmsbLeRVQ5TA00RBm2LFy56PmpW6WySRByhwDwPi7MSteMWYpnTyoUqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=ekDE738L; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d476d7972aso18997381fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711647578; x=1712252378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+f/pRvSBwUdMhwHshcL4qVDbpYUW3TaHUiQYZdgH3I=;
        b=ekDE738LvzLTzlbZBNxWEamtTP1HWEg8vpYfcFee6UYcav51y/ApzbGDlrvaCJ6Sx7
         8TtZ+8R2/uljKBoHQ0Q3QlOjVOQBivKTGPuW9ZIsek1asrqr/xnfYHpIXjkYg7y8ZyH1
         /NYAV94Hf1TsD5qEmwy7sw8fa2KbQlX3l5RB6CyGydkN5bzqvJZI4oTH3QuiqLGrBbMk
         VaAR6gmLfX8ekfHK9fDheLOd4dkOKsk5rteWHENZQMl5KvKyyCP6ibioXXlYJQG0RBW4
         BB1APMrF79N7NT7uVhfSgHFul5KNwxEWNhhNXIod4+q97JkFH7Fr6wuPXnsfRsDRs6UL
         BRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647578; x=1712252378;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+f/pRvSBwUdMhwHshcL4qVDbpYUW3TaHUiQYZdgH3I=;
        b=w1Tx+8UI/t4PBGVEnjtb5Agof/lN4fbByl0RTjBmC3bOAUn41ThXZ6v9P/SGw8D42Q
         A5VtYp+7aScJlKcHTKf2ZxF4p1Y43Bwltg/C9lkO9VnOlEjNb6BA5ojJB0ksd6+k6Cxg
         7q/lMxlZEypcHhVzgJulPWOLM0+lkKn3jFzpYgNHurMeRygni3iDK8EDRZ5YHFujO8TA
         vqNOZ6EB0zR0d/X25ij64uuiaMRxWudpbPu8h7gG6UdXWKJUBsSAc2yPbbXrxsSCPMtR
         qF/X7ANa1ujGvJIghHnI0wznWD+zuuouoBzWGAC0ShOZkZdgxlhRHaOLNe1J0shE2UKf
         JJ+Q==
X-Gm-Message-State: AOJu0YxDjP8+eRlncmQGUX3+eX1nBY9VLsChvo34pqGic9NrMthbZFTG
	OziTC6bDHcb/yyRjBFyeOuVTKNoRqyB22PjizkarUyxehWxT88U6x/ACllvpajk=
X-Google-Smtp-Source: AGHT+IFQBU18T0uIaawzs7r5eRFygg/fKL4VZsh6uLptoa/iScmPmWB9yGQE9bSbSrdNC/yyfCQCNQ==
X-Received: by 2002:a2e:960e:0:b0:2d6:e0a9:9981 with SMTP id v14-20020a2e960e000000b002d6e0a99981mr2780077ljh.9.1711647578125;
        Thu, 28 Mar 2024 10:39:38 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm6066643wms.25.2024.03.28.10.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:39:37 -0700 (PDT)
Message-ID: <84f20fb5-5d48-419c-8eff-d7044afb81c0@freebox.fr>
Date: Thu, 28 Mar 2024 18:36:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
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
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
In-Reply-To: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
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

Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 9b3ef4bc37325..1680604cd1b7e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -122,6 +122,13 @@ properties:
       Whether to skip executing an SCM call that reassigns the memory
       region ownership.
 
+  qcom,no-msa-ready-indicator:
+    type: boolean
+    description:
+      The driver waits for an MSA_READY indicator to complete init.
+      If the indicator is not received, interface remains unusable.
+      Pretending we received the indicator works around the issue.
+
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: State bits used by the AP to signal the WLAN Q6.
-- 
2.34.1

