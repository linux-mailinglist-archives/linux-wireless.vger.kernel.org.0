Return-Path: <linux-wireless+bounces-14136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC109A1B73
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0111C21DF9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE01779AE;
	Thu, 17 Oct 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfwsbvS1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39536146A69;
	Thu, 17 Oct 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149198; cv=none; b=LC5L9+4MbA6QF8Wv1dY+1qHufek/YGC4rbeWhAHkVRaleBNlqruuZG/8lPWqjT9rXvu7+ad1L9GwH4kW4VS5Uju2jW1m5u3QxDas4bzLfyj8vhevCmGZqMN55bZBbJXOQg6lA05Ozn7nNVfHjKsUERNggyXY1tvfkkSbzXy1PXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149198; c=relaxed/simple;
	bh=ipyZo6UKYHezokUH7iiV3RNsr2G7jtQ77Dt9+CzFxyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KytxyiK0ypgnE69jmuQJxZmK8X1xCAr0SWmqXwoo1Y+TQfE+nGSM/IuBqEWmFfVXxOlzJeLGiRHxLhSjqIdf4Wmfxiz4f6+Vjpg2T8pVoSLNhie6nBdbmCrmLWa51N2aH06ZW48IKPq6HfVf8I2MHUZGNAnSuDoKeGxDt5+5tmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfwsbvS1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so441327b3a.1;
        Thu, 17 Oct 2024 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729149195; x=1729753995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5yobkPUNCA4J8cZaWaHfv1b6AD/BVcjG9MZFqh6cjo=;
        b=DfwsbvS1V1dTVPPR3bXayJQf1pmZKUNMMcqcFN7EogiMHxJ0a2MUyE8OdFDReDm3P8
         HCNrixht1yPHt4IAeEk16SkHFoyvsGhLh9t9m5TScuBPQnwENALhwBX+dVCGSoQo0SR9
         wAr7BV90/wOPlLNuFbdOxqTbyTPW79aHL5BfgeGn0acdzxXNeUTm79w/euS+OvUv2dDb
         Dypob1VarRIn3eOswYOvWIdlLBBOFMjV4KZJvBeGggvp45zNvngno38fzzfK3auhrO3Z
         YIUkXWANi/bJVziz3klJWwdotlzeygpla6jo2GQr40c/sVFFNHv9nulM0jfHi5yGP2ey
         m6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729149195; x=1729753995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5yobkPUNCA4J8cZaWaHfv1b6AD/BVcjG9MZFqh6cjo=;
        b=Ti+gR+dsJXda+VDKtEKZncaFk1jj0lyBNe7Vzb+4XxXUdN5EypFC2jlIJ9Web2g2kn
         5c3ITURBNgJO3677G+cPXUpxJCFUtltQ4Bg8xG6Vzn3RLEd+zVTypzvtDRxxn9Lfz1Zb
         wlF/NndM4eF0gSBAxFNyQ7AE3Hrxpi0qjYQj1eHGUA6QIIGsTQxTOY+3ldj6Rwuo3XU9
         qrt/gFM7Eb7W+U9dchG/r3c3qz7JMfjEUgvue1oZYb0surc7iPie4yLVB1ScvCW8Juf0
         2WGJNIzFjnmxXyz2wRcwHB6HggtLGEv36JGuno6voJG41RP2zwIZwKdqQWZ9xCegMk1p
         /9FA==
X-Forwarded-Encrypted: i=1; AJvYcCU+6eXzbUZRZl9ggNDDobYtvC03WOqokUbAN9GcSzy95eKq9Brxa01hGrFMFLhGEM5PFAjOQB1bZgyz1d3w7rE=@vger.kernel.org, AJvYcCVhtG02WMxMvgx9FdR3Oqpr/UpslPcqXIDnrfJskrnU/BYuLL10PBnn/Le45zAgo+TD7T4xfnwWUSc3uzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgTehzuaiwAB0aBIRsReZXwKnEkYcS1u9213v8EhlesnoqeMb
	CvVj+NLIltBNnTcUy/JwpONtYLFgT8flnEPQ6hgkWFcoOtmyPK7E
X-Google-Smtp-Source: AGHT+IEjtNVFwC77YhTW11wejj6XGR9tsFBNBb6fy3IhT6+jEHfJ57O07dw78MKh+9xpOqXAAb2uCw==
X-Received: by 2002:a05:6a00:188f:b0:71e:667c:8384 with SMTP id d2e1a72fcca58-71e8fd8c630mr3607247b3a.9.1729149195342;
        Thu, 17 Oct 2024 00:13:15 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e774a2b42sm4132370b3a.110.2024.10.17.00.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:13:14 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: pkshih@realtek.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pvmohammedanees2003@gmail.com
Subject: Re: [PATCH] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Date: Thu, 17 Oct 2024 12:42:39 +0530
Message-ID: <20241017071239.6505-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <e25e1e06fbe549dc9e9b48719f66653b@realtek.com>
References: <e25e1e06fbe549dc9e9b48719f66653b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your feedback! I appreciate your perspective on this,
I'll stick to if-else then and remove the unnecessary else and 
send over the patch.

Thanks!

