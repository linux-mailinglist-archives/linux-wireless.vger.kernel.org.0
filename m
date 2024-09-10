Return-Path: <linux-wireless+bounces-12766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E281973CC8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CCC1C2123C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5318FC81;
	Tue, 10 Sep 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pO0fHujX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16414F12C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983784; cv=none; b=BCZDvyjZtQjZXGphgP6S/3D5W2krw6ElGAki+ZcYsQFaosVqC04c5aoTZy8ysUn08YLxeCIHXtT1aa/zfUTnqk0V1fdWOFa4cLrwlXe7zFsO7YV4ZIQNhfBDdIr+B1yedHsT7g12Fmj3Lf6xFg+j+lTBz1nL5lxntrQOD2vunjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983784; c=relaxed/simple;
	bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnIILJa3WPqiWXsnaugxG9I+BYsfo32sIFtOFroHEDsXaRx2GBe0K8lj5HpREC42RPQfQ6Rp0TE+Q1NfXb1/2Kwf95tINEOkUW3AferF9Tp9/SolRUa/yhHy/R0kcDTRKWkzvklxDH0vAeeL3OT20MnI8Q4yv7M3uuLVC5T/Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pO0fHujX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c524b4f8b9so30594076d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725983782; x=1726588582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=pO0fHujXZsEQDn2F0R/XLu37iMkQsV5S4l0mzSuVW0et/+2QJUa/j+p/II3Cu6zx/B
         xfFsFJF3fhp9mnjYiiRTQ8TLF0aW/gqWWeC2GC0k84so9EkpTJ912GDEpiJklFVKUGLK
         DyyOLtdV/ueZJVj7XLLnPV6hX4eXkv0r29KUk7hL7jVGWmnTq1zpBKbniVdRTvh8a02p
         nyQ+oZWomDAxwqqpz3a+yQDJqDcES5Pd+jxQRRRkHAWxAldJeApNtvzy+MVRUVjyPQoF
         KZ2WxUBR3KqfbuzDrcX1ddu3fGyhj5CSwbLqU6c8oKiPE05Em/69b7Ivvsj2OyX904HT
         bWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983782; x=1726588582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=oGHWYzJfmlzAUH7n2KQPS9M0Y03MXIXtxgvCmh8gCdluNUNk7HBQoUrFF4n5SWBUVG
         qp4tmeM/XNhKLupoWunh7p2++dJB31QUUbQKUVJTpnMSjP7zazR9nO0A9Y2aFEG6lvnY
         OmEDI41TXAK2attS6OZDER5BIMfwTppURUQJwAZKRDUAzgf5+/jyrCEN3aJ2CidjlyeV
         ZEJdjn2v1kj0KzqbsIxqY+9SjbvtZZYrLdcovc9iXSgaEzB5iQKwl0oJzaPGtlaaEx/m
         SRM7pvASh94IzicSV/FjqGS/5ebM8kALVmiOGXRNxxGNf9cg68V3OHgqzlgSj7qPYPzH
         REIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrnYiKlBwGBJyiGftvb6ylV9EQOyOd/5feoQRkufIfGOZtgO0t7yR7aUF1U1leokBMHm/4Fa8wvCO75oNpVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QNQifw+mz1f86Ab5UwrB23C1xVCrwxqbIf7Hb0i6dyo5Thv1
	jaLX3WmJVQpTTIQsp+J74J7IrwEEa97ETG5oQToMzrqq69IwpLUuVUpbf/bqsrRjDuB82GFkruh
	DOim7Vw6zymiCkLpQoWaEPmqfsVGnk0Un0/L6
X-Google-Smtp-Source: AGHT+IGjnS6T1YSBZQm5TgHbGqQbnZdjhAVyhHz/w/yZFD/IJRKBg9fxXjQPZwO4fmHS1elYcV9OtRw2gB9k6sok1Hs=
X-Received: by 2002:a05:6214:245:b0:6c3:7030:d28a with SMTP id
 6a1803df08f44-6c52850e5demr159245696d6.43.1725983781736; Tue, 10 Sep 2024
 08:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801024335.12981-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240801024335.12981-1-mingyen.hsieh@mediatek.com>
From: David Ruth <druth@google.com>
Date: Tue, 10 Sep 2024 11:55:42 -0400
Message-ID: <CAKHmtrQCvDO=0m6GC_dkcqbnCUhsCk2hemMsLmrpcFsQsuRHoA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix using incorrect group cipher
 after disconnection.
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, robin.chiu@mediatek.com, 
	ch.yeh@mediatek.com, posh.sun@mediatek.com, Quan.Zhou@mediatek.com, 
	Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Michael Lo <michael.lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>

