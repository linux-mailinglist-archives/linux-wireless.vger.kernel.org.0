Return-Path: <linux-wireless+bounces-21554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCBEA8A1DD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502891900A9B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59E1B0434;
	Tue, 15 Apr 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LROeOJTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9365EEA9;
	Tue, 15 Apr 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728629; cv=none; b=aw5C3fJUHN8Rt1LrDk6YPNE+IuqwsuFmA5pGo3NB9+tZpNve/sfHHpvlLfm9/kYAq2rVlI3CBJUXWsqdT+1sE1x9XTEynXRH8OFvi5qB2NJRmxfRY13NlEPN1BK+L92hGEPoYFwEdcdeO68vDRfiNAmbepzSk6f4iPj7MeqPQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728629; c=relaxed/simple;
	bh=TgVnK1mfcJDMMm/R6mEsvkmzd0WapfMrWxTP12UUUOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=UQPYt8HDS6cAVHN4jgdLzjshfFrlco8LfWh4VXSLTEh0UL4ZataCJJqmKfIoydprAAd3uhCXbPkJcoRVC4XGyDAB2HbjKlmWUMAZwFBQLh9KAZ2PTEcjHHjm4kDDNPqfIl04aMhpH3iKwnlBPD/abXUIc11Olg32VopW4/sob+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LROeOJTe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5577351b3a.2;
        Tue, 15 Apr 2025 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744728626; x=1745333426; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgVnK1mfcJDMMm/R6mEsvkmzd0WapfMrWxTP12UUUOw=;
        b=LROeOJTe7976OCDmbfKm0ZCbxPwecVo2XWkc7EVES0k1zS/l2ESRFEzuVRQvvos85K
         RU4EmxfbhIVD+8zxAaUZcBzRY2I6Z3PlD5oohaLcFXONlVq+jCXF9uQydqjBLVh20TCw
         kHn2Ata4lD5uYfAFUZ3NaweaKdKgOznc4pYQD2kD2N5mP3eUOoGpE3IGp4bxfWHI1F+L
         9IBIkdmTqXE6VaSz0bX44qFT+Ql5onXPF4LEAIa2TWrk/9FbqtIYRRCYVc7vNsrUFmNp
         lA3HT7BvI86K7vvTawdK9wkHAUmqJy/ibrrMbVYc3j2OpEIJssdWaP4sxGkeweSJDI5A
         j68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728626; x=1745333426;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TgVnK1mfcJDMMm/R6mEsvkmzd0WapfMrWxTP12UUUOw=;
        b=HF1a3msYC1+DQE0TdqOwpekgx82vCuHYbFEgMGSUFzlj3755RkqsbQYsbTqHpxpnDa
         FAu9krxven70HNTkz8kbg1eJ0CCu8U8/Qzm4VHo3SAXVgZpGaaVzqRo+kdrvkiEoX5Mm
         +nSmO8C6nqWxNXwVPitv4MuAnO4WILkx1PeZ5qOkoo8o6hYAONKyleJ+OL2887C4AeoC
         GeRUC/6hhCfIVWPkzNb4KXSAO5EwuhzbUrUCmVwa8ay7Vh/0x9XH+7OVuoh86M4fFyZG
         5xHZXgSiHMge9hQdb/4/YIhIYG5o3E5Bthx1oW0ga8P8RF3JmtB/mByzMw+mQ3SfomF/
         V/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWBNIMnpYjggEXhr0j5eJKVqMG7f1bUcKHyr5stFYXTFMTMb733h8S8x/vcufGWrCC7hqAPaUobeZURT/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/76UmU0eXJBJx/KtMbBetEb97s5/GzZBd7XclJPvet79h271
	mmg5TQO9p4xwT4YoMSuMjU+IlB5YbvEjDSzwsRrt2KZyfTHE2ePM
X-Gm-Gg: ASbGnctV783cKmCqVQ69S2RJEr5myu8kzxK6atfzXgZavU4pJfZO4N3Gz/W9q/lLvKD
	FbvwjsumwpIPrFXbPD7oguOO1EPJDKgVhlxt74URXf0WSTbhlLuk0pJXWtE8YpXPbXQMFDuST9V
	VERhHXyhYn30NtUfJOU8H0BHB1CNM1pHNFifsOhSY2W7rB68I7LJKXqedSZIz4/nZFo93ybahlL
	kXvS80yaKBLjXFxz8inL2BJGTTg8S6ByG97nWe5OxJG8FIgTQJffph6gy4GkYSXBBP3ddCvboVc
	WNh1qpNXLRl+dIhPyNqIVG9T80/8CFOuKg==
X-Google-Smtp-Source: AGHT+IF9/LIfGrQ54PzKU58/NNVjQCJGGAC3bvO5/IgMe8qIjhSBWovSWhdeTI6GWgiIziHLtNdu1g==
X-Received: by 2002:a05:6a00:1907:b0:736:a82a:58ad with SMTP id d2e1a72fcca58-73bd126b882mr17248346b3a.15.1744728626000;
        Tue, 15 Apr 2025 07:50:26 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198926sm8578584b3a.20.2025.04.15.07.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 07:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 11:50:23 -0300
Message-Id: <D97AOGEOKCRX.2LAIZUEPNX2E@gmail.com>
Subject: Re: [PATCH] wifi: iwlwifi: Fix iwl_pci_probe() regression
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>, "Johannes Berg"
 <johannes.berg@intel.com>, "Emmanuel Grumbach"
 <emmanuel.grumbach@intel.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250329-wifi-fix-v1-1-d6360e78f091@gmail.com>
In-Reply-To: <20250329-wifi-fix-v1-1-d6360e78f091@gmail.com>

On Sat Mar 29, 2025 at 1:48 AM -03, Kurt Borja wrote:
> Fix the following probing error:
>
> iwlwifi: No config found for PCI dev 2725/1674, rev=3D0x420, rfid=3D0x10d=
000
> iwlwifi 0000:3b:00.0: probe with driver iwlwifi failed with error -22
>
> Which happens, as the comment suggests, due to an extra `!` when
> comparing the device bandwidth with the no_160 subsystem flag.
>
> Fixes: 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
>
> After compiling and testing the latest commit on Linus's tree, I found
> that my wifi wasn't working. After bisecting I found:
>
> first bad commit: [75a3313f52b7e08e7e73746f69a68c2b7c28bb2b] wifi: iwlwif=
i: make no_160 more generic
>
> And the culprit was an extra `!` when getting the device info.
>
> This patch is based on the latest commit of Linus's tree.

Hi all,

Any updates on this?

--=20
 ~ Kurt

