Return-Path: <linux-wireless+bounces-756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09258811E59
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96869282BB1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBA2421A;
	Wed, 13 Dec 2023 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AZ2+DJn7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144EE8
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:12:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28b0016d989so320570a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494755; x=1703099555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V74jI7dOUcDVvYykBcDKtAteY2dp8oIdyGSlYSnP1uU=;
        b=AZ2+DJn7sgIAoSCkFpEvapHmYH04IaPL1KewtAdrBd0MPLLCVWEINOAcDKTZTNQdlM
         gd3exLiZnIiZzFiSOj9Uf416tAMwEso5l4hbB9IbKLYD2mYRW/lpgFrTYn4Vo50u8sbW
         tuTXYEHMv2UPlRJ+gTwJT//ZNq6/9V+ChgoLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494755; x=1703099555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V74jI7dOUcDVvYykBcDKtAteY2dp8oIdyGSlYSnP1uU=;
        b=d2r8HvBE8Yzpk5UTg/+T7PX4XAhdxUBh5guqEnCcZ8bD8raLsDNoXOKrPT25iU/imd
         RqDtn0UTKoNqW2ieXtwGhUTYmiofRgJTjcu0MSivc7bFp1MDZ49u6tsZUeDaDU40D817
         OuV0398q3wdTGZ3z0wKjoA7PeoQjvvQ8ilKIfuPSAX1UvpPGlwJGKgd3IItOrDyKG7pa
         He3f7a/IT/Hw7Y66DLTwP1Vv4cUTr4ZMUCiDfU6RehHcGw7GnxJzJxYu5j3aDRnai8uS
         QMznRNFL5NRG9DQApgcUDvvPvrI5aIKz4YQ5V5KkX1YNuUC3T5vJopdKgPEH9JDdFIJ+
         hu1Q==
X-Gm-Message-State: AOJu0YyXkqJNHnX3ph4UqFRcut5GAP7G8UmNidGlOaXnhHVzsT/1QztO
	BZi9wBTWp6fYL5h/pTcyO8+W9A==
X-Google-Smtp-Source: AGHT+IFpUDQBDy51uN88O/QlSvlZf2zSMRpN7Czjjq82c+ckbqm3K2i2HUnGehJ1UEqg9grnoEyN+w==
X-Received: by 2002:a17:90a:6fc5:b0:28a:f2cc:e008 with SMTP id e63-20020a17090a6fc500b0028af2cce008mr635500pjk.54.1702494754801;
        Wed, 13 Dec 2023 11:12:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ik2-20020a170902ab0200b001c74df14e6fsm11170761plb.284.2023.12.13.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:12:34 -0800 (PST)
Date: Wed, 13 Dec 2023 11:12:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] wifi: ath10k: remove unused template structs
Message-ID: <202312131112.F29944F613@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:42AM -0800, Jeff Johnson wrote:
> Currently both the wmi_bcn_tmpl_cmd and wmi_prb_tmpl_cmd structs
> define:
> 	  u8 data[1];
> 
> Per the guidance in [1] both instances of this should be flexible
> arrays. However during conversion it was discovered that neither of
> these structs are actually used, so just remove them.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Unused! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

