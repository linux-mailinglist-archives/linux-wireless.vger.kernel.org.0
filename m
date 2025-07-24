Return-Path: <linux-wireless+bounces-26005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4BB11251
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 22:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6DF7BC207
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BC273D6B;
	Thu, 24 Jul 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rt//R2Y5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C197273D70
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388836; cv=none; b=TG9NvcyWSd/VEhXratAu6xB+sjqW8SCWqa/CD6pLu0xl/6Uzr0wUda9LYKZ4eqSzPMfdUD/1sLvl+K+o2L3R5O8Dweilg5AZs5ezihZYs/NNTphBSeEoaQrG1jHvLVUEbRu5glft0zLkrnQoFt4yhD0OuUBpNvC+TOXGPfXWgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388836; c=relaxed/simple;
	bh=i/UOdzdTSqeN2oGSPrKhrqnKO/DS9twWCLG07a/J1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPoBc0vAoeAxmWrVkeqQHL7I8krJXAjCqAARrt15IK2BU3wZuQdUDyudzxxlciMf05yGVfiRW428Y7nH6w2745V268x9S/ppLDedTMRY9wHPccIBDPHxWJ0ZqsSzL7GjqnqwPCQa1wt4TImk8UpO5F1Wgl54mV+6m/5bPeNnKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Rt//R2Y5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so2813396a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753388833; x=1753993633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBUq2a7pWFvPMS6PbJMoLCTS0Jcdxjqi0JwxCpR8gGs=;
        b=Rt//R2Y56mQBPPyQy2poGfMHBrTFejM/lrRHBcqyBFGAcP7VhvddfrfXF5oQaM2ppz
         Fcu/U2GpVYXwYM9NKk+oQk+hVTt2FdgADyZd3ay7Jb6fikGRg4LD6Pqa3hsoqg86c2ih
         4Jk2mXGF0fdaRY8/TL7m8hibFvRbChwCPfUWFEvA6+7PukP7RgQ5WoWG29B8fFm2c+kw
         AZ8ioY9ruSHHwP/hdTHnqiF0MhPIta5ECiYTh/5BYTGLj5vZZfqEySHdnDrJOeuhF8wm
         WNLe/o5R2TiZYwTtkkKA8/XARS3fs2tCHo0oNOGfn62MHiS1d9ZNFdZIfMeBdUiVSNn9
         JPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388833; x=1753993633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBUq2a7pWFvPMS6PbJMoLCTS0Jcdxjqi0JwxCpR8gGs=;
        b=jOcBt2ICPFbQ2FAkdqvUwHNxgHfF338VBcLW1lAnVsGePhlOEeOw+FnTKGPjeSU5UC
         FUILAS/Ou2VRpS2iJsccAbTVEl90rtBpTUlUvDNvLjNwWxPjN8JoxiVmBUdI4eBAF6JT
         1BL7668t5xPLt5zVUitkjdzl2fuNR109gNpaYtiE1U/+ckUpCMoTLIupDCdUn5lrjJyw
         wGX5pwOWivgvVk09z8PXKWV4M6Hr5oAxWmuwrWmxvStjL1VIm9C3mI6cV/AC1socoFHe
         +iOJhoM7grQ7Sr5lQqJ2Ie9/veu93273rgJedyroYmu1ZjMzkTbAJcUBTj/D0uRpxJFl
         GceA==
X-Gm-Message-State: AOJu0Yz4+PJQy+1LTeJ6gAI3OZfVbAz2YE0AKR4QwWQ6sff4gGfplBHg
	wJvyidKgUadT+d+rk3OailsKboTyljDBvuD+6XbzfEemUQZAu4xotB2j
X-Gm-Gg: ASbGncv3d+uSDeqGUpJxtcRLyNplcXVK70zn+9axwUfRHFcRw8WxeGIruDktpmcz5yH
	a3UPJmfbblHvhm5Hwm0Q8r+gsGQXxDfRjc+emX2eflrIxJru7RUbcr5X/un70ni3XiiAxiJvTi3
	d+1YLiTnX4r8AnGyIcGo2H9b4vMbjSXUjCAfpYwd2RQHU9jVq3ynFkf/6X0jmh4s+akNfig+wis
	+kF5x3+NdIY6sWmy8CrJjKBZjr9mNsyCvNZzKKthjY30erapWsAu6b78z6dG0MHK8ceX7uQLqF4
	yvRdxIi9IvRTxTdfSFMLohwEJoETPZ5LdkNXGd1sa7MnKiEUpHAtyiI8ZsHh6Pr3R0qqfrideZk
	pCJ12bw8LvNHzdMvoWq6MtOcDwhvCMubDWnLdPlQDFBc5WNFO64DsNbyXt1QINcO2cDsIuHu+we
	CBmdOTj00I8oUJ55Djs4m9+ixQ4tmWJYKv0ned6bqqBlF9zGndog==
X-Google-Smtp-Source: AGHT+IG5yuSOjU3jiDTAmuaZgH3h22/S82N6a7PO1C6JI2M2ZET0UEPPtIp5R2UL7IRCeeh+NdIzqw==
X-Received: by 2002:a05:6402:3492:b0:613:1167:ad58 with SMTP id 4fb4d7f45d1cf-6149b59d261mr8373611a12.28.1753388832980;
        Thu, 24 Jul 2025 13:27:12 -0700 (PDT)
Received: from blackbox (dynamic-2a02-3100-a563-9e00-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a563:9e00:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-614cd2fd3b1sm1230708a12.40.2025.07.24.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:27:11 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	piotr.oniszczuk@gmail.com,
	rtl8821cerfe2@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device registers before power-on
Date: Thu, 24 Jul 2025 22:26:43 +0200
Message-ID: <20250724202643.2060505-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724004815.7043-1-pkshih@realtek.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register REG_SYS_CFG1 is used to determine chip basic information
> as arguments of following flows, such as download firmware and load PHY
> parameters, so driver read the value early (before power-on).
> 
> However, the direct IO is disallowed before power-on, or it causes wrong
> values, which driver recognizes a chip as a wrong type RF_1T1R, but
> actually RF_2T2R, causing driver warns:
> 
>   rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
> 
> Fix it by using indirect IO before power-on.
> 
> Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for finding and fixing this!
The fix looks correct since indirect access (according to the vendor
driver) is needed for both reads and writes (which is what the
approach from this patch achives).

