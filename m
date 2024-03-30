Return-Path: <linux-wireless+bounces-5636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD9892967
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 05:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504D0283064
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 04:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44886FBE;
	Sat, 30 Mar 2024 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4jRuRhl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D04C8C
	for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711774128; cv=none; b=Xs8u32VXG3psf9mRQ0W2ALmMdBVKr7A64o58MKOHL9AM1byNXomvFm+EPKbB7DbZk2q0tzO07G9ftF9sZw6LTGIyLUaVLPOW01gyn0msQqmeRa9HFn3h66EPxRqEaSSagwCrC3UoUVJSLHdDZkcsHoy36ZinMrrPj0Xu/JiJUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711774128; c=relaxed/simple;
	bh=o+nKkZe94VWx8t6q3SdvuRVkmQRBhP7zPZY3k1IAtk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVRk8cB8mLtizgovFrcV0GJabNPmfF/+wICwHQo1SmJCS5c2Zl/QHTLGNxas6pheUstftcrRF2hx/B6C4XVcdM47bqnhG/ICsAa9uEl40KyVFwk/kvTKcIU4H/5PdeEMlPQfeHTGmxq2ysYlTgSb8oTTRzlPuThMvJXauPHPuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4jRuRhl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2100137276.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 21:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711774126; x=1712378926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqKtRTcCfUHDOcX0tKilt4xKnfEps6Hgq5SW6oavRVg=;
        b=n4jRuRhlhbzlg0jnOUyUtpQJkaBYJcBHxJICscOFXlB4D3gDdtgunZB1JsSdj1xeZO
         gbz/nBHhqhAXZzfEIHWADkro/x9kl1FXqqimgF4JNSkyTeif4pwUNfYdFNv7QytwI1As
         H4/n3MzHXfSgln5vbNwg9+zIZ+F/3yAbvxQEJdRVsTlG1mkU1hp3jSkKAfCK0mKE5yBB
         3cqRXCE/+BsaYGYAnoiqzmtSzhVSLCAnuLIzrRHmZwLC3xmCUlFSHChOyOn62m4jOr7+
         AnJMoYFHFTfjTxU1yn3JvkzTVCdtgRq776WsQV5Lxj8RVsS9OyWAgHKBHoxa1NmlotvI
         UGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711774126; x=1712378926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqKtRTcCfUHDOcX0tKilt4xKnfEps6Hgq5SW6oavRVg=;
        b=OCXY8YB/RyFGwlfbBHWRbYXTeEtyTBBBwrRNkGsbuVedbkfWZyugyfdvWroG1L3hVQ
         LHaZDPF/n3yURneWhpxFJMbbl6EpGe5MYsuI6rZD6W1Xoa8CPDAVtEcdCCTMfsWmN3bT
         w4an1/vVdsnSmcZn2b7zjJ9+7ACFLyUHqsAnMnD0ZHPnEZTOEj8cGXPhVkpASATxxmHS
         Qhg/qlZYE6/WxoZIPMQlYDu6M4cmXdrRY6MK+xw4GJZs6sxwzSk/xYTGjFhxFxQiEpCh
         Ns8Hvq6xOuuWW52zMYq4Thkk9ljf7PRhgPlEhVdOayVL5LMdUCVa7zP+EAB8ySKhOGmj
         ksnw==
X-Forwarded-Encrypted: i=1; AJvYcCWkOmcO2qC0Oib5j2cbIB6of6XxMzX+WkuM4itA/7PUCl6MRSr2zaIYJYAlgWW9icDyy3+PG9pok+3BBfUxDXPheEw0E6Wva9ygoZeoc+w=
X-Gm-Message-State: AOJu0YwQI29TXyJJopGpA417Y8xQXSvaZ45q6gXnfe1r46u31wyYWqX1
	Xq2Kk/avhqFbS77gAIugzOIjMg9/jMbJ+Q5E00icDVRfa40inBKnQFOvCV7dULYem/kDnqHLMWs
	wuxH0OpnToXFohVF0nDXYLHcJ5lk84bTELegO1Q==
X-Google-Smtp-Source: AGHT+IFWNUW2zHPnWC7CSZVJWYNfuXeyZlox9i9KNp7LapLl16BvX4i/tRfOuabu6Hn2towKb2gtcAyZRB8/FIQKbH4=
X-Received: by 2002:a25:bec1:0:b0:dcf:56c1:5a12 with SMTP id
 k1-20020a25bec1000000b00dcf56c15a12mr3656604ybm.38.1711774126160; Fri, 29 Mar
 2024 21:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
In-Reply-To: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Mar 2024 06:48:35 +0200
Message-ID: <CAA8EJprsjs8SWZmpTisyQcAZ9VC8g3_GEEc1hhp8bMZrm-hyaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] wifi: ath10k: fix board file loading for wcn3990 devices
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 08:47, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The ath10k driver fails to properly handle fallback from board-2.bin to
> board.bin for WCN3990 cards. This happens because the
> ath10k_hw_params_list doesn't include .fw.board* parameters for the
> WCN3990 platform.
>
> Add board data configuration for WCN3990. While we are at it, merge
> common pieces of BDF support: drop .board and .eboard names from struct
> ath10k_hw_params_fw and use the common name instead.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (3):
>       wifi: ath10k: populate board data for WCN3990
>       wifi: ath10k: drop chip-specific board data file name
>       wifi: ath10k: drop fw.eboard file name
>
>  drivers/net/wireless/ath/ath10k/core.c      | 32 ++++-------------------------
>  drivers/net/wireless/ath/ath10k/hw.h        | 14 ++-----------
>  drivers/net/wireless/ath/ath10k/pci.c       | 10 ++++-----
>  drivers/net/wireless/ath/ath10k/targaddrs.h |  3 +++
>  4 files changed, 14 insertions(+), 45 deletions(-)
> ---
> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> change-id: 20240129-wcn3990-board-fw-a2d97507a712

Kalle, Jeff, is there anything pending on me on this series?

-- 
With best wishes
Dmitry

