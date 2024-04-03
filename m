Return-Path: <linux-wireless+bounces-5839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E508977F1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB397285857
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7F1534EB;
	Wed,  3 Apr 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="uEGRsZqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA0152DE8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168170; cv=none; b=piXc7TxcWkz8AxvKRckkDGRtO7rEtmAzHhNNyTQikvKx/ki7CAl0Gnr0w/lE4omNHCdH3o95l31Y7h9IIL1MUI6ueGWp0AVKvXr2HRFYjiGYFi2RPqxxLcKDnwd7efq1D1snO9BBCsfhl5kq/hcXUqytlCBQBp0ZIPEe32NSoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168170; c=relaxed/simple;
	bh=a9E2mGfmVxcJ7x2M2sf17xeANHcNSUBMmGhTG7nDg+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5IJ9AShoHPFd6NoR1PxPPSsTrc1slRjUTIXFM9ZrKD0LkX09VjyIIx0yVDGlgBlCAA9A1x0JOTJn1O5dehLysJ35SrzIsc4CH0KINrhY9bfUnJsySysmcyV3dNuffI3plk3lTpjCo0NJVYBTdwLuOS9kIoqldRUMgpITTcu4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=uEGRsZqx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3436b096690so989448f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Apr 2024 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1712168166; x=1712772966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMk/LPFqs7VskBV22jyb1Tdh2P4ZoSSQNrYCMOikFmQ=;
        b=uEGRsZqxt+GOjRB5J5PpXP7ZWa4Ht1abkW1eOQsIyRJr59DE8s2vIVZnkr4nz0JhPs
         SpM/bQRkYB2hVEOLFioBdnA53+W+/0dm5bHzNltzFVoWgisdadiznKVdHh7nwF0K5Upf
         J5XwvHQpDMCLz+CK+VTBO2hEc8nQ37wIxFhJgj6nudCYnC6uAXubuB91RekmkJMr4Y85
         JJUtxqGzbT5mc0KN6Ji6vybIvbOLTvSYMEwD4DBLr0rO2IcR6WNFkGQ69Hqyzc1B1YXO
         9IZg3Gp9sFoxHFwoPowZpqr2Rw1PicP6pRnltje7TLCHRLwB3g4E1wXE53DmGKgCXii0
         prXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168166; x=1712772966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMk/LPFqs7VskBV22jyb1Tdh2P4ZoSSQNrYCMOikFmQ=;
        b=IW6ZSqa6tzn9JsqZNFMo/2F0H7rOem3HsDf/ekEEdSogJXUaW0TDRE6BzZhzp3cfDg
         HbjPCRfF0l4GqAS5FvQOl2DrJ4BWjVxDwZdW0qWaBQiHuBG6SuBBCfV60/wJK1Cq2TUU
         7IwMbf++WJkYy5W+/Uwzo7fBmZGzMIqiZDA+jGcEmMYnphdSyR1WlI/KgKftzAwGOXVK
         LLe5n6iaGDk3Xyd60Dt4cPDM2t6bEiBLR5op4SSbF+gap6JPcpIZjRaeOaj77JnhgU9F
         ooNBuRGNF3oef9BnKIDl0q4My8vQ4arb1oddUzOTepLj2lnq1NtqOTcCayKbVgu471ON
         dMxA==
X-Forwarded-Encrypted: i=1; AJvYcCX0+xTuhleU4Y7ithA5OvOvpOYBpVmnHYIkQyFqoeukl6JYX0OZ+zxHcEIWAEq6r4SMiHh50xQvTm5rhoZ0MVYieL8llSRxE+bSZIBNL/k=
X-Gm-Message-State: AOJu0YyQ4AKhYrWCFksA8S6f4ZvwsL0V7p3KH7l5x0LmSCwZPKTvpWJu
	gw+8kgawGe5JjZM9dsqW4reuBuRXt6jwkzXHVS4IRvcgznh3Ms3RVeuuf3C5RIo=
X-Google-Smtp-Source: AGHT+IGo6IK4jzvPBeq+2C/SXoVrcSjTLf8DS+QLbHtNh0mgQm3NoGkkSkE8i74VGzKZ5Xv8eEXnFQ==
X-Received: by 2002:a5d:690d:0:b0:343:8485:4edd with SMTP id t13-20020a5d690d000000b0034384854eddmr3336441wru.23.1712168165964;
        Wed, 03 Apr 2024 11:16:05 -0700 (PDT)
Received: from ?IPV6:2a02:8428:2a4:1a01:79e6:9288:5142:9623? ([2a02:8428:2a4:1a01:79e6:9288:5142:9623])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004161b59e230sm6352480wmo.41.2024.04.03.11.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 11:16:05 -0700 (PDT)
Message-ID: <43e18846-cc4f-4b30-8019-4617359ddaa0@freebox.fr>
Date: Wed, 3 Apr 2024 20:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <91031ed0-104a-4752-8b1e-0dbe15ebf201@freebox.fr>
 <CAA8EJpooJLbV+nVWedru=r6fascd8ZxKumiMm_iyzzJwyQ-tig@mail.gmail.com>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <CAA8EJpooJLbV+nVWedru=r6fascd8ZxKumiMm_iyzzJwyQ-tig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 16:12, Dmitry Baryshkov wrote:

> From [Jeff's] message it looks like we are expected to get MSA READY even on msm8998.

This is the code we're using:

https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/caf_migration/kernel.lnx.4.4.r38-rel/drivers/net/wireless/ath/ath10k/qmi.c

When ATH10K_SNOC_DRIVER_EVENT_SERVER_ARRIVE,
driver registers an "indicator handler"
ath10k_snoc_qmi_wlfw_clnt_ind()

It handles QMI_WLFW_FW_READY_IND_V01 by posting
ATH10K_SNOC_DRIVER_EVENT_FW_READY_IND
which is handled in the
ath10k_snoc_driver_event_work() work queue.

But QMI_WLFW_MSA_READY_IND_V01 only triggers
a debug log and setting qmi_cfg->msa_ready = true;

$ git grep '\<msa_ready\>'
drivers/net/wireless/ath/ath10k/qmi.c:          qmi_cfg->msa_ready = true;
drivers/net/wireless/ath/ath10k/qmi.c:  qmi_cfg->msa_ready = false;
drivers/net/wireless/ath/ath10k/qmi.h: * msa_ready: wlan firmware msa memory ready for board data download
drivers/net/wireless/ath/ath10k/qmi.h:  bool msa_ready;

So basically, the vendor ath10k driver ignores QMI_WLFW_MSA_READY_IND_V01.


I will test the following patch which aligns the behavior
of mainline driver to that of vendor driver:

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..0e1ab5aca663b 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,7 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 		switch (event->type) {
 		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
 			ath10k_qmi_event_server_arrive(qmi);
+			ath10k_qmi_event_msa_ready(qmi);
 			break;
 		case ATH10K_QMI_EVENT_SERVER_EXIT:
 			ath10k_qmi_event_server_exit(qmi);
@@ -1048,7 +1049,7 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 			ath10k_qmi_event_fw_ready_ind(qmi);
 			break;
 		case ATH10K_QMI_EVENT_MSA_READY_IND:
-			ath10k_qmi_event_msa_ready(qmi);
+			printk(KERN_WARNING "IGNORING MSA_READY INDICATOR");
 			break;
 		default:
 			ath10k_warn(ar, "invalid event type: %d", event->type);


Dmitry Baryshkov reported:
Works on sm8150, sdm845, qrb2210

Regards


