Return-Path: <linux-wireless+bounces-509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE38079D9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 21:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69121F218F3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47441868;
	Wed,  6 Dec 2023 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpdQQ+fm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDAAA
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 12:55:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d06d4d685aso1448655ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Dec 2023 12:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896102; x=1702500902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNhyFZvgFU5pptzAoScDKDcqRFNRihHR3+C5yAvq3i8=;
        b=dpdQQ+fmm01yl31ISyJHQGHrbxrvNM8dLD2TJp9+8FcVryQ9r3QrrMZns4koWWr4UV
         qBWkgzupTEp+3a5ZzvxsmwrwRlkfh2fq6fEx4JyiNcZCCqrqS4KmXEmYiOAcmkEsya45
         LMsGsJPaOftS54Sfooe+Jf4U2Of2/b1YurXbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896102; x=1702500902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNhyFZvgFU5pptzAoScDKDcqRFNRihHR3+C5yAvq3i8=;
        b=cE8I+rfqCZDgmHdLYPPTdHYKEsaoskGbqRhnVGfDOOVgRQ3FStsfuLaXOjmaOvvGNi
         dSASY3Lqdl0ORNYlaTFWIoGKtsYlN4jA9fp1KYf6lus6hDQVK9+aIUAhCnkqTfsfUje2
         073XcbqCqiyjrhn87MD+Trwh9wqdFsckuBj9lR0RwhDkaKS3rj8ALO7lquYNaqNdIKvQ
         jMdjxtEE0DW1QozSydGNv04Dc5ktvN2wedou3CkJ0baxoq455zvrCb2zbXeWj3g/aRyI
         0dmf7dCJS8TzVwoN9388tx5JuxNq3oKZlH1v1yl8uPlPKK/UqAF6dAG8LbteUy36sTGc
         eehA==
X-Gm-Message-State: AOJu0Yyz2A91dDsUDihBvk3ab6jtwpFI0yaTL6jR+hQQuYeS6aqd5qaz
	mzoZkD3TsfIxu8fo9nNNvlf/RjSTNb9Zy7S6FZs=
X-Google-Smtp-Source: AGHT+IESvAmw3QtseZWIPzrCzbkkkb/Z+GYXQ98I6b/gn42T97kIpEWeyyjO6ixFA/04YDmDNFb3lw==
X-Received: by 2002:a17:903:110c:b0:1cf:b4ac:633e with SMTP id n12-20020a170903110c00b001cfb4ac633emr1371958plh.51.1701896102054;
        Wed, 06 Dec 2023 12:55:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b001cfc618d76csm248569plp.70.2023.12.06.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:55:01 -0800 (PST)
Date: Wed, 6 Dec 2023 12:55:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
Message-ID: <202312061254.085B4755@keescook>
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>

On Tue, Dec 05, 2023 at 01:00:17PM -0800, Jeff Johnson wrote:
> Transform the zero-length ath11k_htc_record::credit_report array into
> a proper flexible array. Since this is the only array in
> ath11k_htc_record, remove the unnecessary union.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Heh, looks good. I wonder why this was a union to begin with?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

