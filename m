Return-Path: <linux-wireless+bounces-7390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B083E8C0EA5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07901C20D57
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B07912F582;
	Thu,  9 May 2024 11:03:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1A12DDA4;
	Thu,  9 May 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252619; cv=none; b=k55fGrzGT5l1b2nx1L23lCN+zBVbWUEK8zT0co7rjzV3fBQEjztluFOkviExdTTTB75NUUoHaHrQRd70icMEAnkpzBmD13MG1dUe9aW/h9M64c6KA58IRdbKs17tb6fpDoNmIJmjZx0T3mEBRrZ3BAKbqY7xRtM4ut6974RHG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252619; c=relaxed/simple;
	bh=rua+diEN5sL6SO/p/mtTZe+IwtIJYVTKAfL0Mp1QCFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUxRQF7H8rez5IIEpYoVNNx4uHVRrbPFwzB0AcBQqXNJO6gffwSz8xWiSHDUunz6Bs5mQFsnQZBo3iU+pBKsIg/QU48zuFje3h+aA0U6ZzuqMk9Ag2aNp36VwnaG/opGDj2Ioq0g8E/CKw41c5xRrYtz0xyIjZcpd5lofQPSO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b58fe083so168399166b.0;
        Thu, 09 May 2024 04:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252616; x=1715857416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKebFJ18t60poXhmMMuBdvkuAAodcc+MwDuQlCxXoFA=;
        b=NzimClQmVWBQCXALIsWbg8odM6DxDIaZtQ+9HQDNCWnT0Vs199ez2l7W1y/A2T8N6C
         AXd94jfmbFo47JSVXFCviic7Z03vpMhqfZS7EZYIJLFdEbw59XRKZDIX5D9zBLots0bj
         yTNoOAGJuLfw1WE2smpopkLYkQMF1Hlm7+c11QKHfOKSKl6e9b3aYjnC403ORB8MActW
         NNm6qQOs+6nHWzAm4bDdRTPwFCKVaUIhvbzPy1dG7YDrjGSOcGwWSzNPRHrfBapm0yZI
         mmkoD5CFbCPZwthvK0RAGtQ4CaVoBkqN8bPEcR5RjvxDde0Jyhq4MIJlDwi69sxvlfFL
         bREQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz1a0ccNABkwhqXueSoT83JOlrJ4dJYQI/ofvfmIMwfJCbSo3rLSaObVyxbLcRkOpw/vW+VD32HtsY4tw7EJvj2hADSH2rtzKfCS8hPnPehcGECxgelb/xjPe1WfXDuEFBgz6YG+hU32rtAgo=
X-Gm-Message-State: AOJu0YxJyryjIOefKkMGbBiNwDtbNKX6hSLJTixvvl7s6qoSSa4UESYQ
	sJr8HNvjGmc6cIBVQ0bfTW6FdFQkb26h2VR3dNpZLtD+ClIKzlYKmvWysQ==
X-Google-Smtp-Source: AGHT+IEzpa/y0uip0hSe2TewkU0bZTORS2xGnxtSZxpSK1OK0EWtSTWi2Ax0Eea8OFO5MZSHBf4upQ==
X-Received: by 2002:a50:9ec1:0:b0:572:a7a6:8ecd with SMTP id 4fb4d7f45d1cf-5731d9b76f6mr3351104a12.8.1715252615756;
        Thu, 09 May 2024 04:03:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed0af0sm578276a12.49.2024.05.09.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:03:35 -0700 (PDT)
Date: Thu, 9 May 2024 04:03:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, "leit@meta.com" <leit@meta.com>,
	"open list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Message-ID: <ZjythfKzpK82LN5n@gmail.com>
References: <20240424182351.3936556-1-leitao@debian.org>
 <f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
 <87ttjqgf2r.fsf@kernel.org>
 <87mspigex0.fsf@kernel.org>
 <acda4194c8d44690b05b83adccb3aa22@realtek.com>
 <Zjx/sKB++v8FJMXx@gmail.com>
 <acf2f82e7f424776835ffbc1f52ba996@realtek.com>
 <87o79fl3iy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o79fl3iy.fsf@kernel.org>

On Thu, May 09, 2024 at 12:48:21PM +0300, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> >> Out of curiosity, why don't you rebase your tree to net-next/linux-next
> >> frequently?
> >
> > My tree goes to wireless-next, so I think it should be always based on
> > wireless-next. Once wirelss-next rebase (ff-merge) net-next, my tree will
> > have them also. 
> 
> The simple answer about updating to net-next frequently: it's
> complicated :)
> 
> The long answer is that the guidance from Linus is to avoid making
> unnecessary merges so we fast forward wireless-next only after it's
> pulled to net-next. And we can't rebase wireless-next due to downstream
> trees Ping's rtw tree, besides rebasing public git trees is evil anyway.

Thanks for the explanation!


