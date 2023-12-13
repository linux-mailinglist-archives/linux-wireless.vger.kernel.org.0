Return-Path: <linux-wireless+bounces-757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59947811E5E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10C1B211F8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55559E29;
	Wed, 13 Dec 2023 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KObCsxtQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A218DB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:13:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3818595a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494785; x=1703099585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bLQ7DFBgxbMxDjvYWNP8XEjt+7+EJYhkC4hdPmoZ5I=;
        b=KObCsxtQ1cAmUcxJcFiPl2+Hgp1HqS40KRgYEv02I+luzqC/IOyf37piWXHU9dmndl
         +UnUC2ryR970fxeaGXxIh7S88J6/3zyFnwATUyBC2cecbuBu7nO6mBpaG+CUw5yB3EYh
         UeoP1PzU6wnRtD/3fMquYi6ge1pMKRGf1A4LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494785; x=1703099585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bLQ7DFBgxbMxDjvYWNP8XEjt+7+EJYhkC4hdPmoZ5I=;
        b=ob5CxDNSxlP04cCN4HmnKcu+UNxiQN3JPDT3UrFiijKGxsiIUVwga4I8CppuYgrbTc
         O9lDdJjBaF2qrWjTLX7slyMvpd/g//7rM0PtZn2QJekxiIOeSrSF/Wv8J/Kf9HtxwroF
         u0se393DAk4DMyOYoaI55mdmxykIRuXgqCa3W6TBa/e+9XQvWGVHc3l9NR87Qcg8hna/
         BLds7uNQYAXZXUn1fG/TX7q3u3USDTtMy7CkxP2sRHcY3l+t+8OGaE2g+l7vbyW1s/NM
         /sgH692xgb0Yd1q5RyCqSAU/8lrLwwdsf9LQKA1h8LIP1MrjQVdLWOXPjhjk7FtrnfzO
         6jUA==
X-Gm-Message-State: AOJu0Yz1crR5ksEfMIMyiGTpSRFAqd6CP4PgG8kbsmB1sEVj+8vL3AHh
	JfC8KG8+gvjK5J2dQMf2wiX+vw==
X-Google-Smtp-Source: AGHT+IGL9MMpLeGyfBggOyjFOzc4MaMEeL6K7oxPe7D1N49hFYuaaCuEaNAiBmxymSDR4jyxBsYqmA==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:ae22 with SMTP id h12-20020a170902704c00b001d06ffdae22mr4435835plt.137.1702494784997;
        Wed, 13 Dec 2023 11:13:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d3485656afsm822977pld.183.2023.12.13.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:13:04 -0800 (PST)
Date: Wed, 13 Dec 2023 11:13:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] wifi: ath10k: use flexible array in struct
 wmi_tdls_peer_capabilities
Message-ID: <202312131112.F4A76DD3C@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:43AM -0800, Jeff Johnson wrote:
> Currently struct wmi_tdls_peer_capabilities defines:
> 	struct wmi_channel peer_chan_list[1];
> 
> Per the guidance in [1] this should be a flexible array, and at one
> point Gustavo was trying to fix this [2], but had questions about the
> correct behavior when the associated peer_chan_len is 0.
> 
> I have been unable to determine if firmware requires that at least one
> record be present even if peer_chan_len is 0. But since that is the
> current behavior, follow the example from [3] and replace the
> one-element array with a union that contains both a flexible array and
> a single instance of the array element. This results in a struct that
> has the same footprint as the original, so no other driver changes are
> required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> [3] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Again, good to keep the struct the same size.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

