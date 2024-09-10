Return-Path: <linux-wireless+bounces-12767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE484973CEE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E151B1C2265E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A65199FCC;
	Tue, 10 Sep 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cV6MXG08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5D1917D7
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984342; cv=none; b=Osy85HI+0RpsMsjMjB83kFRHmb4HzxclgY4wgx1FZynUHuxnj4mj0KQj2Zzv7cq9xm+dFfFUWmaOwb389irGc/Bj/2kqCA12m5VEE9kBzfTJDC1PIFUz58J0ryowkBuJDr9Z0UEvsSMYIXCo31+dbntqq5sy2u1La8UzZUv0tzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984342; c=relaxed/simple;
	bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4vYWYy2SO812/T03jkz580z/DLTCN/Iy0mpFUTRk9nFKogBWsnEZQK3hVAbru9gKDdQKJtHBU+yaknyyrNAw5UD9EBfuNs192bCEa6au4bmseFp2NyLyp10lHO8WnL9f7ULwI5qTKbT06m034h82tIMPKLOOC8f+Cumc5VfNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cV6MXG08; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c35a23b378so38188286d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725984340; x=1726589140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=cV6MXG08bp47NywLNrY03oqEbVXs1Lr/9FdSyNzlIkvKA3ydKYv37bu2uljAFTmVsu
         tqbJXygiD5Bezqh/J6ogWvwky4LNRFaNXAhh0bFqS/J4viMm578eoCailB7c299xBSHZ
         gJ/YPjgZJR2BX22VXRDtjD9v+a2wpJni2oNsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984340; x=1726589140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=SI1zpgCOgybo+zEQlsmYscQUxEaCmB5LVVgYaDFKfMqRncKSBsrbmR08wK8PSrFAZk
         2ZcJiD1lt1h8gnLRlq+cYNRI01qIZbgpV8c1QsYwQQmNIpfppjI961DIrZXN7qEJqWAi
         bR+KN9S7Dl5JSqni2gaGQ4EhXj7pQ9Bjz4EQmTb0uONV+iYghsCuSSiWOWyZ1xNcQzi4
         dXq40SiLq0EZ7BbaB2p05RuyCZfy4+xWJe02PKq7RMxDfPaVumHZhvXPE6b3eOTLLQol
         QotdQojP3oU0TBt5I5tG21Hagz2b9TutExWCJiE9KeLlBqEUnGm6VHo2FoBd/jSaBBEp
         oeig==
X-Forwarded-Encrypted: i=1; AJvYcCVG7xDRv9Z/DIN3dDSf9PkFefT96Vv/1OPBj/PSaWNmgrO5k7YEU06zYYYhx2Q/K8vR87LaZFVYIANWX5+WTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVKPaUh+O53L30hbYNgfF9LEeROCvUWEnJ/MPm7OEDVdF2NTy
	BUqI0efXm6pIO45V0nopvvg8TaE1DX9Wc2Mk18eq4eLpmm27Ix3dxhZLKKbCAxIAiZTzYVaNpF9
	MUX2w
X-Google-Smtp-Source: AGHT+IHXI+r/jxVc0MaMHsQHmSfB1QWCHj0ORPAzywi+oGBwGmVTxcDMeNQVM4izu1q4cntyRy52wQ==
X-Received: by 2002:a05:6214:2dc2:b0:6c5:53b8:c8b1 with SMTP id 6a1803df08f44-6c553b8c8e3mr62886206d6.13.1725984339521;
        Tue, 10 Sep 2024 09:05:39 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d79esm30966736d6.103.2024.09.10.09.05.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:05:39 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9b049251eso213229185a.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 09:05:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUO4CMyaaNLBOlpC9ByhYtSBRKCSyJ/xaX/e4TDqVZnY9IMy5IREmuQ+9dpd0xoAgSoT/g6Bdef6ioo7jiHTw==@vger.kernel.org
X-Received: by 2002:a05:6214:2e4a:b0:6c3:5e2f:b43b with SMTP id
 6a1803df08f44-6c532aeab88mr169354396d6.25.1725983889900; Tue, 10 Sep 2024
 08:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com>
In-Reply-To: <1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com>
From: David Ruth <druth@chromium.org>
Date: Tue, 10 Sep 2024 11:57:32 -0400
X-Gmail-Original-Message-ID: <CAKHmtrQFv5S0Z+mEy01haFLu=pi8XuAUDs-UZxR9CjNtBYOzTg@mail.gmail.com>
Message-ID: <CAKHmtrQFv5S0Z+mEy01haFLu=pi8XuAUDs-UZxR9CjNtBYOzTg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix a potential scan no APs
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, KM Lin <km.lin@mediatek.com>, 
	Posh Sun <posh.sun@mediatek.com>, Shengxi Xu <shengxi.xu@mediatek.com>, 
	Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, 
	Robin Chiu <robin.chiu@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>

