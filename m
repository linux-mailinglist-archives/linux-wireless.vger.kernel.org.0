Return-Path: <linux-wireless+bounces-5481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4A89074C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3AB1C29F4B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8512DDAF;
	Thu, 28 Mar 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="KzcEKxKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DF3BBCA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647580; cv=none; b=r/ejJ0pHIC/g7nZqmYBldjiJVpOcUPq1Zp2rD3aMfRlEDAmYv2yErN20pBEZByNNp19iRb4JvUAyezjT0ks44ou63CQAA/MTZG8B2S/vbIB685pBxRUfDo28rAsywcLy0PSqhrDomvoSTixBCZ2YAGCosxHY0BNN9h1VTCoPDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647580; c=relaxed/simple;
	bh=HUfLuJq7Vv3/kr56j1Wsr8g4/mnND1Cjuax1rB3BIgo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OKbfHfXBs5G/QiFOUEklib/q/tIjl8jMra0PqO2UJ5v7FCAB7Ovhhwfin00aUXPN7lPBtkxmAI2BBaiicWj6GZtRSxWzHd4o9xWycU4GwMCYM6IEVnqgDmROGNkJqadkYGweaFLR0aYjcl6+HmyBlPTukKIUmB3j1M8MZpYLHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=KzcEKxKA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41494c0405eso7558015e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711647577; x=1712252377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8/9/ORbkcGjwuLtgTysJpP/mF9hJShjkEPYJiCnwv4=;
        b=KzcEKxKAx55g++uaojncanD7d7Ku7Z43adw4FFoorvY3dQcU2z8s+FGf3tPCzu7/5t
         s9jOJuE5njNVHaEPc6+vaMIckY1wtZ599ZK9NRJumtJCa4TIJZyGTBazsX29FjYAjYfo
         CpDPnWtySANOkHomCITPnK+p6xfvtd7fMUmpxZg/OJE+4rJI2uIs1zQT7u7BNb7A+86u
         wWgeZ71a+dUXPJQStoZtln4WofmOkC0OeFTgva+Lu0RhFc16CUoc+PqHF4TVCJ5wpqbB
         2wxTAFSuBh9s3eIkLtK8tvAjNIL7OFhjX/5EJ45woiHzEGDvL19wnI4jYdQ9eMEwNLDI
         pGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647577; x=1712252377;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8/9/ORbkcGjwuLtgTysJpP/mF9hJShjkEPYJiCnwv4=;
        b=U8OUW6oS8kN7BYDE1LExcGUokI0GponppTeUqAzYTOt2jUBpTZxDpE6aqD1FhAmKBJ
         CaiZ/Niie/Z6wZjDujDmv4Pi9nnIHAwKywb26Arsr9xVNOql+y83etONjZf3Bl+tjxpL
         ga89lixEW5BDpBXHd5IQruR7SEX+FABqz9ym9gO9cuvLhZONTF1RzVi5mzyRgsHdB8Og
         SveD5WmsQPck6fYee6QGhYOo/EwtRgErKeQalQEED0G/Kr99FkXDDgzaeDG4EnJzesw6
         Jvs98yvB/HaJD2qGPGbj6ht1rFfaJvM8rnJk1mp+ycLlbGOtW/E9e7vGh2aNfx3f5WKY
         ce1A==
X-Gm-Message-State: AOJu0YwIXP52oUqDaF6yS4LatOIt7jDFPnl7JFq9yJDhdXgqBhVNNX9T
	Rfwd93sFDena/jnMZZ/O3fEtrNrzYLnQk2CesbxQcK2TEYYNN9D+LWnwaWq9K58=
X-Google-Smtp-Source: AGHT+IGvoMWzHn9okxdnQDLNaRMhHYZ9/nC1JZKhOkus/dY7+YF0Qq7teVla0WlaFLqBT1sV9U3c6A==
X-Received: by 2002:a05:600c:4e8b:b0:414:8d7:8292 with SMTP id f11-20020a05600c4e8b00b0041408d78292mr50222wmq.0.1711647577365;
        Thu, 28 Mar 2024 10:39:37 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm6066643wms.25.2024.03.28.10.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:39:37 -0700 (PDT)
Message-ID: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
Date: Thu, 28 Mar 2024 18:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marc Gonzalez <mgonzalez@freebox.fr>
Subject: [PATCH v2 0/3] Work around missing MSA_READY indicator for msm8998
 devices
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
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Work around missing MSA_READY indicator in ath10k driver
(apply work-around for all msm8998 devices)

Marc Gonzalez (3):
  dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
  wifi: ath10k: fake missing MSA_READY indicator
  arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator for wifi

 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 8 ++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi                           | 1 +
 drivers/net/wireless/ath/ath10k/qmi.c                           | 7 +++++++
 drivers/net/wireless/ath/ath10k/qmi.h                           | 1 +
 4 files changed, 17 insertions(+)

