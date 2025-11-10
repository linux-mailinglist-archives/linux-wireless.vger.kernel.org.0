Return-Path: <linux-wireless+bounces-28715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC3C45077
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 06:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA23B1869
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034C1C6FE1;
	Mon, 10 Nov 2025 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWMu+wVw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E4883F
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752948; cv=none; b=jCeZiO2qzCeIs/7bm/TJbCokn8DEzLPmiFPScvCLBT2NGf/ee8+S6rItFPArs12/k4gdmWmFDNnN0YX9GgUOKoAkKGRWx8fWrSElnwIO4O+NAq7vN6WIV3GRVLiC1YOPL1sa4NoXeiHmdi7l3MlxRI+VhG0QBmg1zX0FWxFbHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752948; c=relaxed/simple;
	bh=rYJgqhZIOBvKJVWqUmqJI1wlrcUfx/aVWtAbOVWPzJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlAH1ZuOJGXLF7RhoDp2Z9Yt9mIIT+qwCg9avUUTsnLd33jnVFT/EmlvFDAK/Z9giqP4jXwxYDo2utgPTrj9cGbBv4Z4hdg5wfEVgHLfacwBYoYlQ6rXp2rbxUXGNo+0jlpLC2wu5k9Z0jYdMCwMAojMp2+zU63818uCl6t1fX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWMu+wVw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso2027408a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 09 Nov 2025 21:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762752946; x=1763357746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYJgqhZIOBvKJVWqUmqJI1wlrcUfx/aVWtAbOVWPzJg=;
        b=FWMu+wVw0EuQe2znqTdryaN/PHSF/lMPFQcWMa7Xqx3PtMdMHm4cQmkt8RLs4Mt9Xk
         WZWLNpsHZKVNTYyec6CE/p6UgXOidvitjeqrUfgGvjlJDJQbjfvr9tcM1TDWtifGstAu
         h+zBXgFcgBCDuGaK9VQbK0sbUs65Gvm79kwoQ5rCd9DRbF166ecyNPNiqckZUnMlHsLj
         kAj00ExNOTZg8jTXqBCArtUt8BUwdfOWyghAgBJXVuhtcPuYmH7QOvl1nY0WpegniGIP
         mKrS9LKHMsL1qZiAa3usxQ18wiyCNSC+HcuSzsxMqUzTzwpcmW8MWyRK2WvXdgrcv59T
         ZFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752946; x=1763357746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYJgqhZIOBvKJVWqUmqJI1wlrcUfx/aVWtAbOVWPzJg=;
        b=OS/Brh4F8R8DeekO3VGmWg2FGr/x8sWt5bpHvCGda+ok+RqqqCyGjsHnMt1qhWpHvP
         IQB7LJ7k9fHsgNDWRHAL1G83n65rsglu/gqYOzDFNuxSfMvfRqsJq7Vr4ZyXsKj7MJEI
         WF6tog8uxpUJ9I7LqMzqyg0bn4o0ZKPhZ1nkDPB0996hkTFE71Bc8GTnGWs+mcvcm9MW
         cvpP6tcnL97oVYBTQgMwEwAgnuYURX3fNKwEqxZtzSga9GXjCY9Q+31DHW1Xs7aBBowm
         KOGeV3Q5RKzhyBo61OObDyjx2CHtrLXE5BVhgdRVgZnfgh6QTMgElEMU3S5ZC2TXYWLN
         i9MA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5i6y1pO3di4Sd+zlEzTw+wOYFav35qQAVLRLEf06vmQNiEIce7s/r6EKlIVfBsWtz6RgEBYg9fy5d9MwpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRibW81KCEDQKA/pijJynYO3nitYmd1mM2xl8pRrotZUjhFPsZ
	Ammjr6LwYqeEtqaNmZY62FiVsOOO0uP+bFpNNwArjvVRgG9dHoybw/y5
X-Gm-Gg: ASbGncuH+jrzUmiznC7ewdfmxjTYEn2zdUvQ6eJl35l/uS3jz909SNfTIcr52uX3OUS
	QhZMgOIERqOTa1HoZYLrFAvhvCetwMJ0MzFnB/+UqlTc5n2x8j2iw7sjInHZ7WPIu9I58gKaOnN
	zUbqugpbHit4V/3C+u8RpTvr0dA22gyLN7LJfzb85fxXI8Ah2bdrT47GJHMonuNYuj5UqewlYSJ
	g3JsePk8dvksB+jZXfXsJrsUALg0ZR59yvwD4psHt0vIvRGIrkJHnoK7MSbGrWtEW9ua/oYOrQh
	FkIePnm0RumO5SLnqJKlICxIe0PRuFyViMl0hvqf9JT/tc6EE1uPWzfBpgtGO9s7XePAQrRi2jy
	YlGtXj2oABUoBunPcm2LeaC7GSPTty5y+cbnrzrxquA/OqmfKxmLYhj7bsEDYQvPf2tgFbANnzS
	uOZoCABjUQZOIE05Ta7IM8L4i+/Ut2yw==
X-Google-Smtp-Source: AGHT+IFniahBLvylrClav1dInmN/p9U4AlssrMq4ikykN++jHarUYZyEymmp959RhYEEeAJ2Q5rL9w==
X-Received: by 2002:a17:90b:2d10:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-3436caa6ba3mr9028250a91.0.1762752946048;
        Sun, 09 Nov 2025 21:35:46 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-341a699d6dfsm16397675a91.16.2025.11.09.21.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:35:45 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-firmware@kernel.org,
	linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH] rtw88: 8822b: Update firmware to v30.20.0
Date: Mon, 10 Nov 2025 13:35:36 +0800
Message-ID: <20251110053540.4557-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aa1a0c67256f416584c9099496cc2aff@realtek.com>
References: <aa1a0c67256f416584c9099496cc2aff@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping-Ke Shih <pkshih@realtek.com> 於 2025年11月10日 週一 上午11:03寫道：
>
> Zenm Chen <zenmchen@gmail.com> wrote:
> > Sent: Monday, November 10, 2025 7:03 AM
> > This firmware was extracted from the vendor driver for RTL88x2BU
> > v5.13.1-30-g37e60b26a.20220819_COEX20220812-18317b7b from
> > https://github.com/RinCat/RTL88x2BU-Linux-Driver
> >
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
>
> I confirmed the binary is identical as release version, so
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> > ---
> > Some people said this firmware fixed certain problems [1][2], so upstream it.
> > Only tested with RTL8822BU, NOT SURE IF RTL8822BE/RTL8822BS WORK FINE
> > WITH IT.
>
> I tested RTL8822BE and no obvious fault.
>
> Look back into vendor driver, all interfaces use the same firmware, so I
> think it will be fine.
>

Hi Ping-Ke,

Thank you for your testing and confirmation!

