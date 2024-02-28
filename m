Return-Path: <linux-wireless+bounces-4190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF986B03E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160DF1C22438
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A214AD3A;
	Wed, 28 Feb 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="c6vivi/K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9261E493
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126838; cv=none; b=DgAEOoNEXeYGC/Il+BL3D0QGemIr7+S93P9ghfS4489Fp8dhoLEUBMRmLduRrqAn11/XhlLr1yze2nLYJsGsLx2l688hcYLpZKEOTXZQ3VinzpxXfC+igdoRA4HC7O3KYSRqHPaXqoUc5wOrf8co/YjFtQdYysFalor5W9z/wJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126838; c=relaxed/simple;
	bh=k9bVZ3kA4rB+0h80Tss2U3ZJwcaltyNaL7Y9uPcN1rU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sa6C7/k6M3zFGpc81kMvA6GFK3QQfS5TrC4pgoV8SQQ8YpDmuUfatVKVCJfv8DX8suGK1un5Nahd+fYgRmtOwHI/9vvFNV7d3VL7sMW/XRDXmO0CfAa311S/wSVCuTKJ8IAI/n4WLAJrcumLC8j/Bbbjb7OAww3N+KEU08SIbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=c6vivi/K; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a441d7c6125so31109566b.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 05:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709126834; x=1709731634; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfMmWTgZMkFzOQ84rBI1O8Mjtlt3aSPIt7WclmK5EyM=;
        b=c6vivi/KuY4M3RKLKwqOvqirl3ya74m/SPZlSsX5p3mB7YKAtzePZfo4Ssk3071CJQ
         oPE0WP3C9n3OSmgp0SLhiC5n30RgJhj+ZSbEbI6QfgZu6lSkVwFj+oHGDjf/hcZwGL+8
         Ey8jShvoU6jzyU7fypVLvaDjRJC9KOKtCojBX+pegVhxBOco54xMCdXYz2km1/MX7iO3
         0l9Ql6Mo9X9RAeeVzrpRh2CuYtv42tbwUtFrUIWAnqNXNP3uive1clOfDnxoOjVqKulT
         RxutPo0KUnoj9EnHzHOU21vyqA7o/hem4IOTywWEhAHQQGO7hdM7prZUWdj6e3FKTvOB
         p/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126834; x=1709731634;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfMmWTgZMkFzOQ84rBI1O8Mjtlt3aSPIt7WclmK5EyM=;
        b=E/URgPYm9TikH6eSAxgedP6FWfA6RUIn5lKUKBbIbR8gTZQrJmIRzxyTPbnnLyvQRF
         2/p6mGVm5B5m7bCseHUcF2sIqpUTAZBBhpEEmo+k3d4cZSw97jGXFjk32Fodt8kTEH/l
         5Xu+d7xZSgJDc0AfNU0rwFQiphBo6mbk8mEniR+NS2Gf0tnhM5WxdztwZMKuMbPxfpdG
         A157sT2mDyJHwEo/eY/Rcp8zrWk4H6ixqeKNcMCMG4yz1D1AlxG2r0IrycidYjHeFsDm
         DOCdYF5MjChMqLsDjsZeC3Y+dP8XHBJ4Y+4/fns7pYYfikt5/1eTd1Pkn1ZPr4O7z4Tq
         uOeg==
X-Gm-Message-State: AOJu0YyRobOFdTPpnClrbcO54tP81CHGkiiGyFgHzKcXxt4RNO5GYS5M
	jabEld0i/j6SbrFUgkvG0LwEsQfnb7hbESZvzpQ7UnGQoidem7Ou9RJ+rHrQmAA=
X-Google-Smtp-Source: AGHT+IFDAu3EqnpC63S4kTkkbsELa25krrM0BKosxQQt0xC7xm7jBDJI38i+X1Tmt5nQTnzNOCutdA==
X-Received: by 2002:a17:906:4f0a:b0:a44:1be1:66f0 with SMTP id t10-20020a1709064f0a00b00a441be166f0mr348811eju.57.1709126834471;
        Wed, 28 Feb 2024 05:27:14 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b00a42e4b5ab00sm1839417ejf.41.2024.02.28.05.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:27:14 -0800 (PST)
Message-ID: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
Date: Wed, 28 Feb 2024 14:22:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>
From: Marc Gonzalez <mgonzalez@freebox.fr>
Subject: [PATCH 0/2] Work around missing MSA_READY indicator from ath10k FW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Work around missing MSA_READY indicator from ath10k FW

Marc Gonzalez (1):
  dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop

Pierre-Hugues Husson (1):
  wifi: ath10k: work around missing MSA ready indicator

 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 8 ++++++++
 drivers/net/wireless/ath/ath10k/qmi.c                           | 5 +++++
 drivers/net/wireless/ath/ath10k/qmi.h                           | 1 +
 3 files changed, 14 insertions(+)

-- 
2.34.1

