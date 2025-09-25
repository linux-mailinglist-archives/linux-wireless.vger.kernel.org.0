Return-Path: <linux-wireless+bounces-27643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD6B9D58E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 05:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A097A1BC1B94
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4C2E03E6;
	Thu, 25 Sep 2025 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN0YdjDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100961BC9E2
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772772; cv=none; b=gpXsYvmAKqI1/ZTQudC1AGs71Szo45Vmvy3x9h+VInNjCZiLDWLMPLfZmpDhS7CnhZodHNoNxFPKAkuKYPHFkuERL9szbKIkk+A9w8ieWpg3fR/LUjWl/A91Q94TTgtquzsTga7dnvEd2W1ZEsrf5iCvk/0pBawfdMNwOpo9zLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772772; c=relaxed/simple;
	bh=HPv4vSzoBu8JThytGjdGbKxgJmi4vPkfPjeTQDWF6j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoG+/eZo5QpeEfQjFDI55rlfdYw7G2JQ4J7/DsMJ/QCo09erLoZpivVdPK1paMvxLlZvEoUu0jG2RLCKgUNUqNTV3C3eI7en9wIatqMQMXA2CkD67KH1uNQVhuiOKrNaurBul6rg0nLIqOq19761TbrKTWQARchSHqAHpnWWuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN0YdjDj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so456952a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758772770; x=1759377570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qo3Gw2aldDy8S+SFdy/VgsjaY7xrxXzEhcJKjVaEe5g=;
        b=FN0YdjDjNqJsVxyQ1SZFtaLffq+wDuxJGG0Uc02H0PPWmN6uxQIqIoDg8vpm4FX3yk
         VYT0IoMnZH3tX9a+IbhI22tnHzYlCluN8tv0Cvm0CiHjczLvb4/iqYnckz7Ar7uu3PxK
         XTUClRgXew8C2nhKKD047gPZbqvTdO8NOPyOMco3tAD4ymSAiSmrSqrc8xg/9zFKkBSy
         XSqPrFeW611uYlckDQS6LXEC3CAroodh0RKQrOfOt1bm2AxoDmNs948s9iKdBV2ITXId
         d8gURBh/GpH+IQqKi1lhs64ybe44I1jsQj87uUo3nqfU5YG5VxmkcLAzhQoIBPWgsAuG
         n1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758772770; x=1759377570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo3Gw2aldDy8S+SFdy/VgsjaY7xrxXzEhcJKjVaEe5g=;
        b=Q6897vIe+6wtRGvm5LxNrH34ymHwO/zrU8Iwi7YnZDPy79pcC3sK5AB72IJ11be0nU
         +J5buOd9dvNEb/lmreNGZn6sOBoiGWq8ssEdXx1T8pQKrmIFStqVQj62ezM3MksG9uFB
         hoVyzjCNEqoTIt63k/NhAsxstHQdcEuXlqFCnZqwiTw552IpQ9aU78VmgIq6OV/OQnbB
         cYZeS3gojxJkTgiNHiOOQDwftrIGR3va3WJ4zU6EwPj9QQ/KlEEE7DFmqhnmSjfYjokD
         bNQGewbIJhNTF8ArwYAv3bCSSj97s8M74pT0rP9asywZRzYHYgJqsKxTTruI3p0uEMUv
         +JAg==
X-Gm-Message-State: AOJu0YzoQVcqd6crUA1VMWNHH08jLsLwexnUYCWJoESlYB+asezKD8R2
	Ho5SPUuDRAQoloLCtPiX1Vf9V+xri2CR/QuyS8t9lNPIAq5O1sWKXwC2XaFrWQ==
X-Gm-Gg: ASbGncuzwxpf4C2bVRBYL2Cg5CU7qSEiXutBrcoZOWy4wQbqWr3zYBez1FV/Em4h7pw
	vPIQnhMgxdMBtQADBPzmzV7Y118I7yhE6lkkdhT7WEmAMI87hqtqCyhHNXNKWBLd3mHPl4Wq6z6
	rYLbCMeEX8FweVMCTuh+xBvgRr3Bc5urSEPwbO4jq6RnMVtzlJnQcOEuHHpJYOIdPE4UL3gGZ8A
	GRLVVzA+W2A4fBs+SEvGvJg3p30HRBaqC/QJtwLiDxDKfWt8OHSipm/ybo9dReD6e3jquWoxxti
	TcVIPraBqETJ4AywFCmOwqmsldqnW84t4SvAXv2x8tq5/WrbZrO0WeGQlKRpO3hrxBOcWWdYa4Z
	BkjPFaPc1oge+igcboDjdu5qJF938m91ZJAAeWr184oVOxhiPqg==
X-Google-Smtp-Source: AGHT+IGA8RsHIjBG0k1aXxxaNhSe1BGhPJx2qvJCYAhDLSPQSQC6J583+cbdCvov1XBpJdYbBe81Tw==
X-Received: by 2002:a17:90b:3849:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-3342a257810mr2866527a91.15.1758772770187;
        Wed, 24 Sep 2025 20:59:30 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b2fdsm695859a91.10.2025.09.24.20.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:59:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:59:26 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"visitorckw@gmail.com" <visitorckw@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Message-ID: <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
 <51518b935e7649e3b5413e3a119d549b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51518b935e7649e3b5413e3a119d549b@realtek.com>

On Wed, Sep 24, 2025 at 12:43:56AM +0000, Ping-Ke Shih wrote:
> Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > On Mon, Sep 22, 2025 at 05:50:50AM +0000, Ping-Ke Shih wrote:
> > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
> > > > and 'str_read_write()'.
> > > >
> > > > The change improves readability and enables potential string deduplication
> > > > by the linker, which may slightly reduce binary size.
> > >
> > > Have you measured the change of binary size? Maybe you can share the result
> > > here.
> > >
> > 
> > I tested the patch and did not observe any measurable change in the binary size.
> > The commit message was refers to the description in string-choice.h:
> > 
> > "3) Deduping by the linker, which results in a smaller binary file."
> 
> It might rely on LTO (link-time optimization). 
>

I re-tested with 'LTO_CLANG=y', and the code size remains unchanged before
and after the patch. I will remove the statement
("may slightly reduce binary size") from the v2 commit message.



