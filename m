Return-Path: <linux-wireless+bounces-755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA478811E56
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5661F218CB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6224A04;
	Wed, 13 Dec 2023 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3tKl2v5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E0185
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:12:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2887c3b6581so5460705a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494726; x=1703099526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCfe0ZWGgKzRVbzzblrUJytzWn+QlPVSI/o4NKBNpNY=;
        b=K3tKl2v5NjRUIbGpRze9LudGxC5nyQ02GOBYGbxPanOi/HgOy6pduBZbkUeWZULBhS
         dD6YVKu/R0h347ZHWHVReuwT2IUYqU/MQJbFfjNl1C3P8yz9FMASBPnlzjyVEhP4nmW8
         frNCI56AY+XSdrFGM8/n/OUUXjnBBK9bzzX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494726; x=1703099526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCfe0ZWGgKzRVbzzblrUJytzWn+QlPVSI/o4NKBNpNY=;
        b=itFz7Zb9C8qdfPID/Yma3Rz9E4bPw8GHhANRQ10NttXNuIsA1SANKSjkIX4MATLPzn
         Se9YHkV5Wj0e++HhiG+VHxUp0/xV0+Ygv/6jORBtwqPauhVo744UTncSk+Kv9kQVEEen
         jINVsySXz6YPbVSl7GW8oBdV0AWoJw38JgPWr5NzMo+TMqNDF+mxAvLnntZFb1rlPU57
         qjPLBmX4uBKYdonWB3AroseTGxpfvK/Hwoi7D6gFJcnH9oBw1NBaNzaNVURtk+MOgtQN
         8crNI9vw97qZJXhTW4fXneIOLzH24Rp9Ltb8k9pGhQDj9QcCSogwsbH0ZwzhKzj/Kb+M
         xReA==
X-Gm-Message-State: AOJu0YzjhB7PBd0CqZhxiVoe/+LRrtNQyB6cnfEmCasvavIxShPrH9un
	Ji1acx39FT2sR1R8WLaVy8xLqg==
X-Google-Smtp-Source: AGHT+IFcFdO4Yi25NiYYgSY1pHflwWXW48z97I9Nc7iqIJzPnx+Qyma6RencgmBrM/Eo3+BnjT73qg==
X-Received: by 2002:a17:90a:72ca:b0:28b:131:ced8 with SMTP id l10-20020a17090a72ca00b0028b0131ced8mr276703pjk.32.1702494726005;
        Wed, 13 Dec 2023 11:12:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pm17-20020a17090b3c5100b002866c96fc71sm11629572pjb.38.2023.12.13.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:12:05 -0800 (PST)
Date: Wed, 13 Dec 2023 11:12:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] wifi: ath10k: remove struct
 wmi_pdev_chanlist_update_event
Message-ID: <202312131111.53F3E2EF51@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-3-92922d92fa2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-3-92922d92fa2c@quicinc.com>

On Wed, Dec 13, 2023 at 09:06:41AM -0800, Jeff Johnson wrote:
> Currently struct wmi_pdev_chanlist_update_event defines:
> 	  struct wmi_channel channel_list[1];
> 
> Per the guidance in [1] this should be a flexible array. However
> during conversion it was discovered that this struct is not used, so
> just remove the entire struct.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Removal of unused structs is good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

