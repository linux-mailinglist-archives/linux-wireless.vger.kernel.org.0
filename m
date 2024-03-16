Return-Path: <linux-wireless+bounces-4798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72ED87D77F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 01:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782D31F22D18
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942E10FD;
	Sat, 16 Mar 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WKxefe94"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BF36C
	for <linux-wireless@vger.kernel.org>; Sat, 16 Mar 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547669; cv=none; b=NfKk3U1WwFjboBBBkYwfKBYk6HxA7nLlaJaZqf0nqwj5HLA3UA3W6zGLG+qpqq9wjkGTkuNsNCjBOaQET+anLGGvdF3ZyPhgRcT9YEFWHxnvaZnStBABvDg3RNUStdLoOa2SCXzCGTB7MscCeOlZObAL2IvRSxpryHpbRi0UHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547669; c=relaxed/simple;
	bh=2VHOyHwiO3IqN1ZMy/5OKtjFBfVBCcGaEGJXKOazJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkKxXMMKinKCO2eI96FSFnWy3n1POmHGkL7+M48A6mxlYKQrkbNybkKRTR3gTFvzTjjznvavCN/KoA7Vi+OkxKZd1SNLTOCM0u0EoP6sw9Dy7ErCNZkwkA1y9J/zusVzq2QAPdNnV/qrGngxyg+1Pe+xfmKRxUTZGS9qOPC2MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WKxefe94; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so1962115b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547665; x=1711152465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2HVASpHp+GIKK8RtHmHX1zQq58DsTDGxV82bTx6n6U=;
        b=WKxefe94vt1804tD7yepQTT33KFHemfGBB9pL31onCFE+C8E1szJjENFWvW/1ezi2o
         PMKdLWgCURoAB/6/8qGeRf2ghRTyJ3azqzSz/5rHUgV4PysR/T58bXCdkUqcap3pWGhY
         +990jJcxdKvcexXweGgFHrCDwbgjKbwktZZjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547665; x=1711152465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2HVASpHp+GIKK8RtHmHX1zQq58DsTDGxV82bTx6n6U=;
        b=Vi8z7ZVP6BNwTBIirMYIFzHtltO6werNtcIx6rRAlAvKIb3erXtb5CUwqIUWezF9mp
         FKf8LSMhyh+N6+SvkAIt1fhwyZmgpbv+ju24GafafLanRbK31o0rREy+VDxQf3I2d6gG
         fTFHwGzJjgy9PP7S549DdPDpRxMtemGFXfFUC+plxvV5BZjATyQhw5hBLUA3lEgC2Sly
         /ZHcZ7aNqw/jjyJhIJJzf0+28/UjpMXlpFOn4LtmskDeDRBW+QaNHo3DkSCCJHjDoqrT
         g8sRs73sHJCkD5+xO8UPzvQOZWYeuO3n76YSXjk4Y+8p6k4gxyqstcD+ORcmKNgzIzVU
         gb3w==
X-Gm-Message-State: AOJu0YyUA6UniaF680edS2HdLQEtAHQzf4uB3ov7SkCbAdxugfeLNUoW
	7ZRrgJnYERAr4TcMN/FrlO8JL8X06MBKjzLvBnZS04btxgl0sUMe1eJ8Rd9w9A==
X-Google-Smtp-Source: AGHT+IE7Z210BXtfLpfT51MyCCNq9TCgiSY6ujqewEFWRsKRNEsbTJEhk1YcVLjYISgtCzMMBEDqdA==
X-Received: by 2002:a05:6a21:3396:b0:1a3:5402:d5bd with SMTP id yy22-20020a056a21339600b001a35402d5bdmr1724429pzb.1.1710547664806;
        Fri, 15 Mar 2024 17:07:44 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id p19-20020a62ab13000000b006e6c0f8ce1bsm3993733pff.47.2024.03.15.17.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:07:44 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:07:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZfTiz_fhzPwRk4Xb@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020053.18054-1-yu-hao.lin@nxp.com>

On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> With host mlme:
> Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD
> Without host mlme:
> Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD
> 
> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.
> To enable WPA3, a firmware with corresponding V2 Key API support is
> required.
> The feature is currently only enabled on NXP IW416 (SD8978), and it
> was internally validated by NXP QA team. Other NXP Wi-Fi chips
> supported in current mwifiex are not affected by this change.

Thank you for all the evoluation in this series. This looks much better
than it did at the start, and I appreciate the additional explanation of
featureset (HW and FW versions). I'm not sure if this has been
asked/answered before, but are the MLME/WPA3 limitations exclusively
tied to the firmware support ("V2 Key API")? Or are there hardware
limitations on top (e.g., some firmware might get "V2 Key API" but still
be unsupported on a given chip family)? Could other chips chips
theoretically get this feature-set in the future?

In absence of a clear answer on this, it's definitely a good idea to do
things like you have in this series now -- that you have a short-list
(of 1) of HW where where it's validated, and additionally a FW
feature/revision check to ensure it's running appropriate firmware. But
I just wonder what the feasibility would be for adding to the shortlist
(or providing users/developers the option of doing so) in the future, if
people are so inclined.

To be clear, this is mostly an informational curiosity and
forward-looking question -- not a request to change the implementation
in this series.

Thanks,
Brian

