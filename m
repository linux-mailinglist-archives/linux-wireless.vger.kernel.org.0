Return-Path: <linux-wireless+bounces-23509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E9AC974B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 23:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F639A40EF6
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A6824A069;
	Fri, 30 May 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gavj9th2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80B40BF5
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748641744; cv=none; b=ff6AjAXFa9XE1uZ5DAOUIKttafE3wrOkS97r4mVWPgNgDBnRoICTbN1B5k6EiyqRKrKiAcMTUX2JDh1l2hcBrRlJ0qwDEpzB/K0GT2rMjBiEkqPxQm8Cvjyc/W52exA5DJul6rHx3A7ru3pWjYam02+L2/dgAqQ35dUsLFPpiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748641744; c=relaxed/simple;
	bh=zqMKiyJJReHl0zm1LWfJC6bfrlL/JGqZD0aLMmEOVzY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UmeQYqYQvslIPZr9fceD873GGJ1wZFNpiAodQx743ilspx/S3Po4edTczonILjQqtHlSFmxIX5RoSp9pbwutT2x6KNLNYI5HU636NtMh8v6RdEx3Dxnx50i7FuZrZ8z+swJoYoEUgiLPDYG+Mit/NzWPdkWbR4m6u6/NCkb0F5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gavj9th2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450df5d7b9fso1146705e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748641741; x=1749246541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zqMKiyJJReHl0zm1LWfJC6bfrlL/JGqZD0aLMmEOVzY=;
        b=Gavj9th2LxAVYBZOOsNnT304898eJ9voQNNmmgmytOu7rVdsMUQP54qkUkvtO9Ylsc
         egwZuqtmxqHkyk2tFM/LvLZ8P2rdLnZDKqzAKyUAXyKIaZd7qSvMVlY8Mc8PwNgoZikJ
         Siqi90+NyyDtAeMR7bms7l0H5SDLtveYYHTEw9xE/8nXbEfejW5LcGCnVBJMww3Ppvui
         gWFKOnkPc654VEzJmGMZPOELo/DJ7YBxMndwS1lNW/n0U2Bl0ItykzMTQrTVRKfe0/4+
         tjxIlJBJQVXI2WjXFOPU9uRhdFZcMHqxceCSp0G6z2qnN5H8W777d3NhHB+ioCbr9yIw
         NABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748641741; x=1749246541;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqMKiyJJReHl0zm1LWfJC6bfrlL/JGqZD0aLMmEOVzY=;
        b=JWGA7Hsu2Bcc1DNj+BDxzkrLMTWdDJZYo/Hly+FtNedkY7ZVRKvvnMpj98YRcIq1ne
         O76Mtm4VrXBlIyeSjl+bheCT0ZCTz8L4uZ8FVT9QJhXKzf/4/TJpxhmIr+a4z3kmMRYi
         2PTfxCr7Gmlj9Q5rg9jeNPFLC38WAPsvcrrZ3wb5aNf26qv+dZlImdRYQ8ju31cxLXqq
         IifkkS/qIpHi8BH19INJDC1Mec8BAu/jzuhPEoqCLxZ+2pB9J7xzZuVo33iLzdWehPVr
         yBXcAGTXQKtZUWJbGA6by9RvKDBVv56Oqe7eTqZ7zAmGSEdFPzzK2f3nOSKqnXEhbeMy
         lcGg==
X-Forwarded-Encrypted: i=1; AJvYcCVT/hexoH5soaHhJATEmAJwkWbNB3+zP4OblVMJLKPkr0+9DT4oRUsheaqyQvixIt4HZ6DDJhV9KxNfa5gL3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwgbzgB0jBdHTBnBoKAII7AoIhfrSx2BtA3pZxMbnN6fSr0vH
	r9PpOGsLPycoC33+aL3lXWKvWS/7wMmLxbaMcrd6YC/2vZugESod8CWL6Y/wZYHZuwu+dCWnmQb
	4MdLPBM13i3GQ4QwT090D+T5osmfJRS1m+zlC
X-Gm-Gg: ASbGncuPbSrT/L1mwfJATl4Qi9VO6BfuN5SXX4c/Kk9JOTerayLBgV1BxHxf6bFe81j
	OWeH4+miGb+0zzNrve2rhdhfplJfqlgGpeiiNp54rgiI21aM+641N9+kuXwJq0mq8uXD3PveMvv
	Xt1OI2dRIJwwWWLE4apqxfpqU3U76/xeA=
X-Google-Smtp-Source: AGHT+IESdQbbYhpqGkdj6AB6cOwb+bHGclyeTnV+a8RTS/8ln7fZSxeW9a2GXkrs77GrMkzScUB7GrzkK5IrCpVcCuI=
X-Received: by 2002:a05:600c:1d1a:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-450d6ba777bmr43011605e9.10.1748641740877; Fri, 30 May 2025
 14:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Walt Holman <waltholman09@gmail.com>
Date: Fri, 30 May 2025 16:48:50 -0500
X-Gm-Features: AX0GCFvMjUSFsVul_8LV_bReS_sBchY5qMln8pofijRWJZJJY0T19gs6kHpTT_Y
Message-ID: <CAMb39_mQB4h_NMsVW+_HrgSHGrFoKTTSqzqeBAtbc_xunX92eg@mail.gmail.com>
Subject: Re:[PATCH ath-next 0/2] wifi: ath12k: Fix station association with
 Non-TX BSS
To: rameshkumar.sundaram@oss.qualcomm.com
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, linux-wireless@vger.kernel.org, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

Hello, just wanted to let you know that this patch series has fixed my
inability to connect to my 6Ghz networks utilizing an ASUS BE30000 3
node mesh system. I've worked on this for months literally, so this is
exciting! Any chance this might be considered stable material for a
backport to 6.15 mainline? Thanks for your work,

-Walt

