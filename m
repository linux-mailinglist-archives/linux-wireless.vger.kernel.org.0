Return-Path: <linux-wireless+bounces-2392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A458395E2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EFA1C21F25
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4602B8120A;
	Tue, 23 Jan 2024 17:05:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091F811E2;
	Tue, 23 Jan 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029506; cv=none; b=DAFjCi2UiMDimgFo2jBfeH/X3L5DYlw3zobZU2/OJy4IezgyDpSNLUbZkJzE2/VBok5d3jZSbkWqJqplWnqX9nBy6arFV4WtS5WBmWB3CQf1VCB8s8nKZbG9sxXLISHWDim46Z3tv3VHAVrERu4W9bxrsltiXC10JkvgrN697pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029506; c=relaxed/simple;
	bh=QIEah4FOv9bksPKqzM9tyNMnwQCDbVHt81ZN6r+F21w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwvFo4dmBVS9cbpUcYN+R9PBYpGHJ/Hqz3kffQe2SQqAR4fAkGrhE7P+kcwM83oPZk1tnao1hQAWUSrRPBRrJGK1X0TTzSDLT8Mbt86p7SffRKiRjiZEmlwI0WymPaq/ja/Gfwj0fFTRF6Or/an4M18/EkfuIn9mXZ7eRM2x8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3106f5aac8so1775766b.0;
        Tue, 23 Jan 2024 09:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706029503; x=1706634303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+QIB8QvNYUgfdIz2Y/2WnxrNr1jO/SplT5ODZ8UKwU=;
        b=VPZIrXLH3LPlsCk97aoE5cwOiuiUFHMKIXEEP8ThxB22RAV6j6OcTq+N+ai2jJTrFd
         gMV5WyyvtyxoQl74vUdCIQwbV/tkRWONszWcyJlphmpvV1LplILU8WairyTgxqEPgrXM
         mUhqrajcklvDV3qtqcaMqiCgadCYndPrq/aVl9R5nJfc1rtSRCc9sSUD/R/uVTrK0L/0
         cHMJl7kHAG2dtu7KRy2JZ7ZmsVkBGf7pcvSx+4VzRshrRa06D95+spIig73d7sdz5nAW
         AoknEH0vnA0s7s3ETOzwa7vxoyNm4C/LAC0Gauxmabp11Uf0v63GbrGqWZd2PivvP4ls
         JJ1g==
X-Gm-Message-State: AOJu0YwWEqfhzwrcJpipaEXVKq7x1HCxz+hfBvkSy1B7m1cVcYurhZKi
	kczRGxuNjY3Huyesrmf/0ZmUgtLUgUtSqKMnzS9bllsA0rxMrhQz
X-Google-Smtp-Source: AGHT+IFxQLSfmQMt0gNEG71Vt1WSacnBK7+fHp4kMtb2zn6e8WsXB/QrPzeI8ue1y+DhSkCV/IFYcA==
X-Received: by 2002:a17:906:899:b0:a2c:2437:101c with SMTP id n25-20020a170906089900b00a2c2437101cmr111882eje.13.1706029502526;
        Tue, 23 Jan 2024 09:05:02 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b00a2bf375ceebsm14478873ejs.208.2024.01.23.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:05:02 -0800 (PST)
Date: Tue, 23 Jan 2024 09:05:00 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, abeni@redhat.com, edumazet@google.com,
	dsahern@kernel.org, weiwan@google.com,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] Fix MODULE_DESCRIPTION() for net (p2)
Message-ID: <Za/xvBX4Tp+JV8c6@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122105708.52d33fa0@kernel.org>
 <Za/oeIjnMoqqp4Tt@gmail.com>
 <20240123083517.2982c483@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123083517.2982c483@kernel.org>

On Tue, Jan 23, 2024 at 08:35:17AM -0800, Jakub Kicinski wrote:
> On Tue, 23 Jan 2024 08:25:28 -0800 Breno Leitao wrote:
> > > When you repost:
> > >  - please send these 3 to linux-wireless as a separate series
> > >  - make sure mailing lists are CCed on the cover letter
> > >    (yes, get_maintainer is embarrassingly bad at its job)
> > >  - please send 10 at-a-time, it's probably a good tradeoff
> > >    between series size and reposting risk
> > >  - please target net, I hope I convinced Paolo that it's okay :)  
> > 
> > Sure. I will split this series in 3 and target `net`.
> 
> The wireless ones need to target wireless, just to be clear.
> The rest should fit into 2 series.
> 
> > I suppose it is OK to send the patchsets in parallel, instead of waiting
> > for the first patchset to be reviewed/accepted before sending the second
> > part. Is this correct?
> 
> The rate limit is to avoid having to give the same feedback to multiple
> series, among other things. it'd be better to send one part at a time..
> it won't take that long :)

Sure. Thanks for the clarifications!

