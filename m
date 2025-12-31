Return-Path: <linux-wireless+bounces-30246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D99CEC870
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 709323009856
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 20:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C2232785;
	Wed, 31 Dec 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkIkJql4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308272046BA
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767211989; cv=none; b=H8vAwFi4NKrShQX1eSLug2Gj8iEPtAVQxcI98Lk2g6MpWsA4DYWEIk2BTK6VMNyySLKAbo3DERo7w4954Rx68HGbNIWIrvI4VPbixX6M4yaoQpUmQ4T0UpVc7sKZ2Omdp0MSEl9LWqmnqzrP2qxELAzNkfCk9kbaGAbAiLwlpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767211989; c=relaxed/simple;
	bh=VsMmsjULczenxpMYCebUbiZhoHlkwzGJJhQaJAbMaHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vi3IJKOSxaEyZjmXY5PmNU3Ndeeo8FL3EZ7ExKH7HprMwK0F9K3108LYIHjOUuDhwh9ykPqs0kvvfaMB/Qrk3h5dQSWAfO9OmZE38pGKf3YXZs6o/I5BSsQgamf2GRAaUcwDMLYH6JKTZOjLyb6532gksZ6Kjalv/gJfF9wg2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkIkJql4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso14106390a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767211987; x=1767816787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsMmsjULczenxpMYCebUbiZhoHlkwzGJJhQaJAbMaHs=;
        b=KkIkJql4xD1grdRuOPc6+rFKUe/+XBLtwn6s0VRu8C/EdSpWFKXn0ilL7IXSkiGF7B
         SVT6QsVdRvKBJ2OJXB83J5s7uZgqC062da0Nq3n2ROPUHvoCll+K2K9waA3CymI2mAHr
         0mnJapAVLKE/p3FiVQKyMsaPCQu2MpL12IWIawWuLXa4Aa1c+EdG0PJb2njlIMx+Weti
         meJIyWcNCDMJ1Tgr2tehuFeyYBFoq+g9cOEhW0MJQ6qldtweljc6uYGoEH7nISxMWyc1
         ucToQ/g6yqcQNVFFCRPCeFI8dFzlT+Bx/okRSdUlRDrUe0PMCal0AZHnnLDk6WOGkcWm
         6lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767211987; x=1767816787;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsMmsjULczenxpMYCebUbiZhoHlkwzGJJhQaJAbMaHs=;
        b=lC7CIMUtrjd2A1dTq68sWinFgsmE7vqUk5acz6CtZQw77xGxTADeAJL5Wz6NN5vBsS
         AtwIqYQnTHtaP0Hss7x0F4jTIakL19IfcDvz/0ZJd/fOyeZYPF7Bi81Oq9heFDl6k64D
         GMUxLr3RXFEB/E26TMMmkiv5yX1aCvRQvsRwvCjL1b9oDv+hI8c/VXXl2tDCnobuLndv
         R8Rk/WNFmM8SxwdWYi9BG9VG9uB+wJ3YDqu249Msk7O7rLiXa+EdBOD/AQEU9iPQ6snG
         EuG9GXtgR84SJdWi3p7r3dKHhqQa9i1tM3JjFcSxWDoJIC9QKF5/vD3MuAHMiFXDZYvm
         4VbQ==
X-Gm-Message-State: AOJu0YyN3SgpPs3HiE5ufb4mXHlZtQ17a8eCEr4QIcyCX6fbhM01CphU
	Z02osDn+e6vXlcecjuy2dOkgFPD33epIPSKre3RZwlmRGBanZ8qECi3s6knBrglbtOZ6J8cz0jh
	SB4OEsgzHUsJ9me4/KCyOmOzlUf7gvfcy5f0=
X-Gm-Gg: AY/fxX7yQJWQ6GWMeHx+z1ElDZCFZJBCYqWCYi4ZUwE2l7jJxYOaNNAm/6KfmLx/I4B
	h/HMYug3Picp1pr5qw3MEF3ZnFnth8Z67X/vcSrNdAiVhLf0VPaL6OUcbfg4+OX+p3Ngbd5NJWF
	nUujDwGyumzvTydhTAsccBO4oERATTZ48n7oiB9s7nhpkp16Hlu1//qzTAfOWPTefr6vflSDGLB
	FHOWe0WRj6+bdcYjCadxi2jlZid4v7SkbUCD1TqqAQ3NTwvVmK6qNsO3zkszQzy5U4wYFOv/EJ3
	EVROF/JVC/5M4WU7yjgzAsw2APwCJGQkdfmwGt0tWWrZzeOXhLWprZuYcP3MUIdj1BUCQtxKlP1
	LIVxq95xH007e
X-Google-Smtp-Source: AGHT+IGZVkrI1bkAGjHBjP1/6f0/vOPsrDZ0YHXv/ZpJ17I8pKin0GPgfbTc/m+KQ9dbV6U8et2gTojfzRhFws5I1PU=
X-Received: by 2002:a17:90b:37c3:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-34e921222e4mr31708602a91.8.1767211987137; Wed, 31 Dec 2025
 12:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Andrews <steveandrews2@gmail.com>
Date: Wed, 31 Dec 2025 14:12:31 -0600
X-Gm-Features: AQt7F2o7sA7olUEyiptoZj3CFYJr15DdfjNMI0Nx7bLgI9wRZNPPaXGbzfAGgRU
Message-ID: <CAD2w9es40oF2u_fZwgg2E5M26d4QkxrX2LEnFL+v81Hrz3ZsNg@mail.gmail.com>
Subject: [REGRESSION/REQUEST] MT7927 Wi-Fi 7 Support status on Kernel 6.18+
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

I am running a MediaTek MT7927 (PCI ID [14c3:7927]) on Kernel
6.18.2-3-cachyos. The MT7925 is supported, but the 7927 remains
non-functional. Is there a timeline for the 320MHz AFC validation or
firmware release? I am an experienced Linux user (Arch/CachyOS) and I
am available to test experimental driver branches or firmware blobs if
you need validation data.

Regards,
Steve Andrews

