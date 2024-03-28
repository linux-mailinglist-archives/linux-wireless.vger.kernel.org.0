Return-Path: <linux-wireless+bounces-5484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A4890753
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B791C29E3B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6912FF99;
	Thu, 28 Mar 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="2ksCpSdO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1502126F19
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647582; cv=none; b=MpJ5hn0CGNcw5DFBE+c1dPMPgvCf57WUlbGjbLkd4GQ1ytruPpfCdYRM9wnWB/PWVHv5BNmaCPkSsBDJRrqhSRFFWBg5U9PIzYftaimnmsThHZGWm4tbIX4bWNqMgQnVkcIUjfbZ5apb66dAA0XAFgkwxM1Xv+CBhaATTId9bpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647582; c=relaxed/simple;
	bh=n9AZLgNzUWhIouE9WldfNOkBR0VBSzrpKYlVGIWtLck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=soEvnXxRXJudCxX9E8/M3rCfhHDz/uiYkx4aYMAhwhEI0F56PxOVvqWpVxmJROM4BbMQ48mIhpheAbgV9LhatQIyj1ZM0EZpz2wrZjUzTzoQudeHkMFLJ1nx68AFnRzx9GKvNGHmVVkBB8NmZFet+MDN9hohsIuNPpQFvR0dTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=2ksCpSdO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4154614b47eso4713375e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711647579; x=1712252379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBEyfkaUFeTURJJG6e68DKf7jzMPW6cXTRuGJ56eTuE=;
        b=2ksCpSdOeWSy4yRcxR1JD6VmfV0+VVxya3AXsPU8+jn6Dp1ukEb7zaxlT4KSL2EZ+t
         u6LXizB5GK4T3yHScXDLN3fTPCvXdWSj5o8FK3yQNs5kiJi+3DueXtlPaHsA/mit9Oi1
         S2fX8Rd1L/3JqEqVWf5DPMWm/dTJR3NNSzisEmYnxPDVMD42yitwVUyNpgwC9DhqJBXg
         sfyUlJA686CWusVD2daRszqAMNZSTkfO2OP2ERffjlD81zs9xw8tMdDWl+FDLl6v/c+X
         /Bd0COoZUYvrk7hQ92owg8z5aoiALffysl4AtcHRcijgT3NuSitzqOuli6yiHWrYLDPQ
         1sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647579; x=1712252379;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBEyfkaUFeTURJJG6e68DKf7jzMPW6cXTRuGJ56eTuE=;
        b=pUcRHS93YeEhM0UnR9WzaWGMB2znRapprkn3TW9fjWp8y/RM7dCXxcYy2sHnmYgKjq
         WqIEOYlkLra0F7oa/Jhg3RyoQM77eye+VXgi+JbGI3yAmT0h0RBUkKNfoeuDLczUx31r
         KY5PDTEBJZDlnxT7hRS0cAzTjOtitL+/3TuFWq0xcYx9LsStNj3gD+yzIV5MiDMzP2Bz
         LkNQ3uODq5mtIhFeFoYZXB6TniEOJRxZ76hopJCXz5AAHkcAwOYYVby/pDbi2teEYabV
         ylB9IbcsoVsHmuScqK6I9HSaGldNorDsT1+RI6GnAexrfbDCA+zp+Gr4b1Llc8fJwefa
         Bz9w==
X-Gm-Message-State: AOJu0Yx1caUOOuxlqU+v57Y9KyhBvuqBQrD6LLs8Ljg3xbxjgYoHoe4A
	QfFXflpTDjgV3Sl3tYCKwOMjrykQAcxnBoICG2bH2Dl90pp6/Mwh0/zE/jDf6vw=
X-Google-Smtp-Source: AGHT+IH25UGpyUTZwfKMDNxOvtNvgGwcgB3GGZLR9PbX+P1XJKMoLJl5lW9dzk5XDs/O2Bg89Wim0A==
X-Received: by 2002:a05:600c:2285:b0:414:5e9d:ad31 with SMTP id 5-20020a05600c228500b004145e9dad31mr102964wmf.13.1711647579570;
        Thu, 28 Mar 2024 10:39:39 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm6066643wms.25.2024.03.28.10.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:39:39 -0700 (PDT)
Message-ID: <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
Date: Thu, 28 Mar 2024 18:39:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
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

cf. also
https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN

Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 026b6b97785b5..681a80f4dc9db 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3185,6 +3185,7 @@ wifi: wifi@18800000 {
 			iommus = <&anoc2_smmu 0x1900>,
 				 <&anoc2_smmu 0x1901>;
 			qcom,snoc-host-cap-8bit-quirk;
+			qcom,no-msa-ready-indicator;
 		};
 	};
 };
-- 
2.34.1


