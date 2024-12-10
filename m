Return-Path: <linux-wireless+bounces-16157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A19EB055
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 13:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0ED283665
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53AE19D899;
	Tue, 10 Dec 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZSvx0mu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2623DEBA;
	Tue, 10 Dec 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832047; cv=none; b=HGtM0Bzn6KYG+6VxOA1m76DH5nh7/iWvujhzK8ZVKoECQJ9DuvjWL7ez7lkpMzmFghMPIIhCJhrdeqkxUaj6XSVzjlXOS9Zmn2HcEKE6HrDQ4WCqrq1+S5uqSsViEBdyesij5sWFHTRZ/7q69r3yKcPCPkLG8w1yuZ7EMdMVx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832047; c=relaxed/simple;
	bh=u44ZzZ9eJTAT0sf5MXYiGMa0FE/s7isOKW9Y0ZPiuK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va870A+u7w04s+NI4nwcToncA5agbZ9lqAA3VoIDRVgczeEocBxdcL3jHWdsQ5SW6ZNIGvw/0jpA1ivyaBB5UqF0aN1bNPyeno9Vo3L1C8URJEiYrwwULEj8UGasiy75UCoe3rBwpnWaRBukfTf9faB8Tqz5kDv8+RKLqrM7WXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZSvx0mu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fe7ff65e6so516104fac.0;
        Tue, 10 Dec 2024 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832045; x=1734436845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CeuXANmGOguSDViAcZD5/L/A/tELl/y8XnKm6SR/fLw=;
        b=JZSvx0muV136GY3sm1j5FkND4oYU8GmwyEgPi92Tq8ElPMxeWZ5uRg+jqIYfritsje
         sdrFFra5dmrivXzXy0M0izb7iwdGdDjDKjWARoGl4cyh35QX72QiGkHKl5kJzv8ST6Z8
         5eI3h1HGNqeO2OoNOF53+W+CTaVTh3M7+dHbUQ6ez5+15bx+6NDhfk4eK3BUDL4IpR6r
         cZnzLr04XdqYu6N5m00m/vg2MDqhNktje1AD6dxaPKzC/SQlX6N/YSd5bBQThUn/LDZ5
         lwSTF71oajQ3KiMogokaznCWVAo/FFWQGCf77pn+Gn10BWDgUJ9j9fhQ+UQpwNBtrTMt
         YCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832045; x=1734436845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeuXANmGOguSDViAcZD5/L/A/tELl/y8XnKm6SR/fLw=;
        b=trIkVXroRHNLSi0TFo/pGHl4z9B8nSg/7fTBR67HPrWOVd8/Pev36n42aYNMzY7ZIE
         MEBvmul+Q7ku6Uo1/PFnzQI+Kf/JgEoIk/Ty/pvumPC7klzqcz0ZSyiy4lDEAOWjJRGn
         9CHGGhkyvimS1paWkqr5h6t/dtqsn7k5JcIfCnTT5aT2zI4Jdqc0957WdHBHSelyXMii
         88Vrlg+fYxAjZuzIwHX/KBv9MgVUkz1dLLZ1puxVCpMq9fGplJ4rmU+TvxWIZGt5XTpE
         YzHSk0+lR7/87GBielfPzT/BqRTg2et34SHSZhnZZjh9L0bnN4J3dPwIMPH8X75MxgbC
         D2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2WPBclxH7tbNBTT/Jh4uvgvSPp1kw401udw3PK4hocWDehackviqmKFevT7YbTSMP1jMItI6LhR2QY1YSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrbjx3+84v0bNwuPpNwhma1ZVrhNNtGxa7XpMrDDs0sCStgWB9
	7yt8NfxrdcW74CEbLiy/BhWR0jtuQhfwTko9IGe+RQaWwPRrucuvcGoKpuiBrePEJtSLQtMt/zw
	5hVShHn4JV2QoJmLHvek2jiws4LU=
X-Gm-Gg: ASbGncswKdUzoQKrqxsnuolaBzYfluMvU2phSVFqlrRQ1HdM4uhB4MhySqHIDH+BDrG
	iH/9DJzaA8iVJ6u3dmXijotUQRiBzypi7eqz4EE6qAdRa3beSwHbdaphs//6q+GPALA==
X-Google-Smtp-Source: AGHT+IEGTQ41KcjLQ4BiabwNoGuT16egEOvqFz0KXrZneZuslSGeftUpiWoAQbExXvvxlryZDrqPOZEnnOsfqz+325A=
X-Received: by 2002:a05:6870:64a7:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-29fee50a8cdmr2406739fac.7.1733832044955; Tue, 10 Dec 2024
 04:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-5-donald.hunter@gmail.com> <20241203180714.45a2af81@kernel.org>
 <CAD4GDZyXDpbEoVFBzU-ExYcd_Gf-hHocPUFWAXBXJOcmMRrnSg@mail.gmail.com>
In-Reply-To: <CAD4GDZyXDpbEoVFBzU-ExYcd_Gf-hHocPUFWAXBXJOcmMRrnSg@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 10 Dec 2024 12:00:33 +0000
Message-ID: <CAD4GDZwwjZvc1YXogJFdmqAA-1W66DdjYpxAKucmVQFDzbyY6w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/7] tools/net/ynl: accept IP string inputs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 13:37, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> On Wed, 4 Dec 2024 at 02:07, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > > +        if display_hint in ['ipv4', 'ipv6']:
> > > +            ip = ipaddress.ip_address(string)
> > > +            if type == 'binary':
> > > +                raw = ip.packed
> > > +            else:
> > > +                raw = int(ip)
> > > +        else:
> >
> > I wonder if we should raise in this case?
> > Especially if type is binary passing the string back will just blow up
> > later, right? We could instead rise with a nice clear error message
> > here.
>
> It's actually a bit misleading that the attr is called 'string'
> because it could be a binary input if it was supplied from python
> code, i.e. not parsed from JSON on the command-line.

I was wrong, the binary input is handled already by the caller, so
this should just raise an exception.

