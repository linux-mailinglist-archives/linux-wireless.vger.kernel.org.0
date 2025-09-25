Return-Path: <linux-wireless+bounces-27645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F796B9D699
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 06:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD96F1BC1C7D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5859B2DEA94;
	Thu, 25 Sep 2025 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIrchR3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3D35950
	for <linux-wireless@vger.kernel.org>; Thu, 25 Sep 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758776277; cv=none; b=aqdnmqzCqWS+2B1EcPjcqsnTDyq99D4mF7WsKGGMSGx7yG5R6lgQq/6Hovg4SaBbawwoUk/XLwL1+8pyraDYxLdiAbVRFiyJckGxWC96oQPmWAK3LiIsNL3tgp5rzM+vLgB4ozaob5lEyfiXOrGA4vZNo0QL1YJE6W1du852CKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758776277; c=relaxed/simple;
	bh=kPzxEfe/YqVDgMWOwGmf5DpkjVmJd2Ha6+d5aCqeKDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWe+kP6OwmeYInrOWRotzZT9b7cexji8XaMpUHSghJgAmsBgXgLyGZ6rHTBH+Xs45p/GXgorqpruk8upzG/MHN9i3PWKtFpeU2BUWPWNzvIXL70TDTzWtw2VxNvVyaMxi4kjV2z6rYWZ2ijoOxA41fyl7Rn4K1pV4dPgEs7dDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIrchR3u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7800ff158d5so419000b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758776275; x=1759381075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWG5UfuLfU/6okMWpcwd8oWIgSQHkPLDSZpFhqy7ksQ=;
        b=VIrchR3uzufvtqAAfTEWhg/OOPHwM7oJgoRlVzPbnWmMU2xMloLrqG2s8k/P4wSPeB
         ba7TPxwrM8b75XVEmtmqNFXjMt8JjCOSSn5F7OkBwG78SLUhBeRtDbg+SCoUdzVl5tKn
         oGYSNiJbMnKJkUdPmwEZOvybrPafbDDZ5HmgybJsEEgmMCsePIDPAjMcmK6rkh1uFMc/
         Zoc9VOjUh+aOU2SThGFUS/PvrEJ6zXsMjl3tdq5sM9hzL2ZKfxqhMB10wnGjCLJ3rBF6
         hbkwPhzRNG+a5umt8iD6z8dkJkY9BLslO/UCUARK/N3drOvXzRBpEMznrH9FLL/oSEnd
         Ww2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758776275; x=1759381075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWG5UfuLfU/6okMWpcwd8oWIgSQHkPLDSZpFhqy7ksQ=;
        b=cApxPlYN8rLZD1nhj9SOkS1ehO6ob/+pE8GrDB9yfhbumb2PD4CC5WRPdaPdHE9vJV
         NVJ57onf7KPfpvJ+OqMuoAqlKcRiN3ncPOP3aQ+ST3i4P8kq7Hp5VDcnbaglyRlO+RlD
         cthcionmKO7FjMfjhxDZ72g+oQbMzThcuq0iu0vwAyM00g3FXFtm/aymtzscfEFy1uKj
         fNHUBeYaBYacZHTISbwFzXDdM9u4ffBBFy0KBqp1Uwj3pP85M2wR7f7sachA3Ayxt3ez
         aBhU4rNupniwUMEnH/FY2dpHby7w4Exq5bTSHzyT4WYXA0iJ8MDhh6SLvRB25jozD223
         Bkjw==
X-Gm-Message-State: AOJu0Yz9NpSC7vdqYF9Vh/+rg0QGtnJLv0vSfl/xpUeUTeiD+9I/VBIw
	kS3+qHSh4JV8+3SskZtlFuK5COi0zbsePq8JflxTRiq0jLzf3f2xeRhD
X-Gm-Gg: ASbGnctua5EePyKrnujBPqBwlhVB17iDuYsDqDJtf6ud8/zvgZEkQpRdHCVy/6k5ujm
	P86JAuqEalituDIrsDtGTvcYevtgaPuIOr1DEqCvz7+yv32FCJLhAopyWkkIwiZ2rZ9qX0PDeA2
	VWxzLl6bWgETLLnZU8Ucm0AFfpn7yjUgg+C9Vhrho14AkOWNxBp6xuaTOGSL9ggb6n/MFUBn8wZ
	d3IW6Wy950JCmw2JODomB0rS1h6By2ErDU9JWJ+2Kdxw76f3gJmHqDyWgly+MIMdWCanaorErlq
	XwUGSFmvPXLpvitqwVrAYCPo4jhxBgA67KVLBoc78tvP5orpR34/PvPIms6sQ7Gt6tXrw5lyH28
	QnqJG1dumEHmFnIGRfllgb0MwCdU6mApn9xGHtr21nDDF/WlKdg==
X-Google-Smtp-Source: AGHT+IHE0hCkhuBmmUoBQffjMXTlW6TG7kVeaCmRhK+UDQsUnhS7aMf4l0Fb5LPcRfVZ10wDV1Wdkg==
X-Received: by 2002:a05:6a00:2341:b0:77f:67e8:fd with SMTP id d2e1a72fcca58-780fcdfd789mr2323162b3a.3.1758776274966;
        Wed, 24 Sep 2025 21:57:54 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c07696sm708827b3a.74.2025.09.24.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 21:57:54 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:57:51 +0800
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
Message-ID: <aNTLz+SO4AAUeo96@visitorckw-System-Product-Name>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
 <51518b935e7649e3b5413e3a119d549b@realtek.com>
 <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
 <0990f8ee74574a30a585f2e0e3831837@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0990f8ee74574a30a585f2e0e3831837@realtek.com>

On Thu, Sep 25, 2025 at 04:28:40AM +0000, Ping-Ke Shih wrote:
> Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > On Wed, Sep 24, 2025 at 12:43:56AM +0000, Ping-Ke Shih wrote:
> > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > On Mon, Sep 22, 2025 at 05:50:50AM +0000, Ping-Ke Shih wrote:
> > > > > Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> > > > > > Replace hardcoded strings with 'str_on_off()', 'str_enable_disable()',
> > > > > > and 'str_read_write()'.
> > > > > >
> > > > > > The change improves readability and enables potential string deduplication
> > > > > > by the linker, which may slightly reduce binary size.
> > > > >
> > > > > Have you measured the change of binary size? Maybe you can share the result
> > > > > here.
> > > > >
> > > >
> > > > I tested the patch and did not observe any measurable change in the binary size.
> > > > The commit message was refers to the description in string-choice.h:
> > > >
> > > > "3) Deduping by the linker, which results in a smaller binary file."
> > >
> > > It might rely on LTO (link-time optimization).
> > >
> > 
> > I re-tested with 'LTO_CLANG=y', and the code size remains unchanged before
> > and after the patch. I will remove the statement
> > ("may slightly reduce binary size") from the v2 commit message.
> > 
> 
> What is the .o you checked? Have you also checked size of .ko?
> I guess (sorry I'm not familiar with LTO) that LTO only takes effect
> at least doing partial link. 
> 
> As the changes of your patch, maybe you can check rtw89_8851b.o or
> rtw89_8851b.ko.
>

I built all related files directly into the kernel, so my measurement was
on the size of the entire vmlinux, not individual .o files or modules.


