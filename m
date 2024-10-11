Return-Path: <linux-wireless+bounces-13875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C89998A9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 03:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABEE7B21204
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE64810F9;
	Fri, 11 Oct 2024 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXqgTIsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE2539A
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608840; cv=none; b=DbG7o7Do7BWNdZ4MBEH3r3zG3KIdZU6vaqCNuVPEFwh/jjpIdgMVbr1cIpAq7hvdLcHMKHnizWb0su5QcmevmU7+Wjq6WGYQ9lBAxG/39Ot1rKR4qBpkQXL/vhAIYHsqR6FSZV0Bi2jehWQeM3JwcTaHe9FDPQnjckJIKir86oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608840; c=relaxed/simple;
	bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+nPNWwi3apS7DlZ8xazQAViBUs+rZl1P0MkK1c7rDTPRd3E39McF1VcjzbKp95CMWZbMSGU0IAcVCwBuPXPkTBtR9160YDjWCkSLq9n6xtRRm/rbADMPtSfojEISQVdxm8rDssP8Z5OwNbZGSfgb4AuR7qTXkGSn8tM2gK9yPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXqgTIsl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so12171186d6.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 18:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728608836; x=1729213636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=PXqgTIslYScV0ZcWCj2+O24EIoOIyJUQ5LLMyrmvswrhZNcDT5fcqdJ4vkO+wON7in
         bYq0FA0fWCpi1Lo7Y5CnUwKX1D/ZaJd579/p/GfZvynWq0Ee/bD+Rm0vlS4GFCz8Vd//
         xzx2gk21NnpVmnwy5o1nk3jGmQwMs+iqCcET+uu50GOyKZVJZ9mciidvfrp5juFxbG+N
         eOu+8VN/7RZEYzU52QfGy9wmu/igpUP/nOMiXzEq6HJSgzNjzyxR196YDLK0klok07uO
         4bqGT7Qqu5VmSxb70JvfRlDmG/aG/laD5eVV0VYcxXfnIioJAQtv8JX3gxgQut0ZBZ5g
         1D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728608836; x=1729213636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLtfco7CYTSkruhDHn9AtchkZ7x9E9bb03vUF9ZRl8c=;
        b=kaVyNV+2eZnRf2cVKM7Xoh23P+TgAzLM/G4NaAOm2AVR0fc/ZX0J0l2eVqvt7Ji+nO
         ALRiHjmpGkE6oo7iiByjwYAMGhc+IBHTlO67wUbbPHoi4f/b1wReH+YP0iAOsyYU4WbZ
         UXa/4MrjLCwFxEvFqslYOMFwmTjkJywzqe9lfEnwgKXRpWNNOS2FZlDd+cl3lQD2EpyU
         pXkudpJQBorvM8yR1Vcrps6c9rOY0AHmucmvgxDoOdECTZNTPJZXlBaIHUDBr/nXmiaJ
         TFH+ppvPx/BwW+ru+oobXhcDF9i+W0gtCnU68/CFgFdm8lYzz+4Z9TMwnKKQNfCSU2+E
         2m1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqk+2VivyX3IHj+eXlukYivoBI2H+FiwXlvWC/L0geZy6p1MfBx4rNDx9fQqBn5M4XrhXZX5HbzHEJP2j8Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+CuSAtUVqVvGZ7BGCSVb8Qt6CDuwRZWfScw8f3I10Epx503M
	tPDCCpAEmUhDJ5I4Zvuk1pz6wTQhdOhPArGNOD0r6oR+kkkHQdCtbDLM/4OkVnolGtYHpUBTsqP
	PNuK9EPOhzQwGNyPp6Fpw09G4gvOyU/AeJjPt
X-Google-Smtp-Source: AGHT+IG1IPgTRgTS0BIIfpBkCfsfGiVu8O8/Lby/bdx0N0082xjwhFiPhAr2iQsuMORy4Ja0+DTJ5k0TZRJKu03WKA8=
X-Received: by 2002:a05:6214:8f3:b0:6cb:e997:6717 with SMTP id
 6a1803df08f44-6cbf00139b7mr13861936d6.38.1728608836406; Thu, 10 Oct 2024
 18:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008022246.1010-1-quic_kangyang@quicinc.com>
In-Reply-To: <20241008022246.1010-1-quic_kangyang@quicinc.com>
From: David Ruth <druth@google.com>
Date: Thu, 10 Oct 2024 21:06:37 -0400
Message-ID: <CAKHmtrQVMLOo=UFamTFNK3ofLVuLdrfFAyfF1syFdA4+4w4Uog@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath10k: avoid NULL pointer error during sdio remove
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>

