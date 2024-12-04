Return-Path: <linux-wireless+bounces-15888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0D9E3B67
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A86F160330
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AD1DF748;
	Wed,  4 Dec 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2gIch1t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49531714B3;
	Wed,  4 Dec 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319469; cv=none; b=DpoirlhaN9YY6FBXDDNImlwJT8RVydvO2gXNrWU3lR2gjrfPLlRMi1NJ9JC+G1/pOlEtc8+/FTd1bno2vSP2rXng5IPxi2rsvEHSGdL2x/kbiPLkmYMS0q3pnaEUeO/JuppXAF7QZjUq1rBOfdWJNKKEAkjtfi0sSN0S4LRHq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319469; c=relaxed/simple;
	bh=jJmrAJ/Flv/7XjmXAxnXGsLlIu0C+BgW2oM0pBM4VcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzz6550+kYL3uPi6hZLc66+i69cPUCUPCMdgJX9HuRRj8r/GumQf6sA7Np9n6xbrN5qr5xvPx7OX16Uvci8gDqLhCcMqzcFq77HH0CQuBqcBQ4OhsigXOTdVS7fwsVpicj7YNzLNVC7vahIl9Y8nkDl3TZLn4ZvSI+gCrwqPcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2gIch1t; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ead60cedb7so1895080b6e.1;
        Wed, 04 Dec 2024 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733319467; x=1733924267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0xj7BGoY99tZIIZ2YbRn0UMSYXkj05wGp4CgWfmUBpQ=;
        b=b2gIch1twoaxgrBx20o2ylECb4VuvZGE5d7GX3b33zLF8kRx0nzcjQemEwkwu6sTGL
         e+8azbjCwFFD6alOV5RiLweAbtokinRWLBm9JFwWSuNevFv684kSTu+3Lst9MAyHy+G3
         nibby1S1mYZD9ikLTj2C2Fz0dfVPCzIoYSnbks1W15vKVcYRb1nfGUHA8YjbTCWMLSb4
         vHdz41p2TAvYGmigwAUkPOQsSRyF+5/sznxmGeR262Zzb0N4v0ovzDqKUELqmnP7zI91
         PcymKIPnhfwqXBUr/oQc0JEW2vJdqJwqEDNrRgeuYsxwSpgXbOwx0d12iZfdbK6/idYX
         kxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319467; x=1733924267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xj7BGoY99tZIIZ2YbRn0UMSYXkj05wGp4CgWfmUBpQ=;
        b=V4PTlsEg8MOPj0tJkOZeEFkeldAW5we+F92sj49bJAUTaM5bEu97erhFwL0g2QsVJP
         AzRlbkFL6IdAHofPMEwKy2nX3j3zjBcn82LpaAnNY98xISG4i41JuB7AslisK9sc2yUO
         jDPYEDNpEi6Aa5qfIKmoFu3rztSU3byi4iCUu3o8jobaDMBxXsy3zEHDcL7MX0WyIIXT
         7eKY1WW59suyhmvjcmEqsfZrImjREAjVkc+5EI6PLIR3y9xgLLWxUtj6w3Mafbjxzady
         9QkCP6fSnA0g1jJatGYubVW8nrwsY/cBdWXGUkAFyRBK/k4eZoKa4zXFFNjrk3+QEGQG
         y1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/LvTgpSLRv9Iscx2xWelMfZNpNi1eYPWjCTmtvb1rgiKFOINdRFbw/ORRI5gwPiiNOBPajup0qycNGZAJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLUSyoUYGsAGsSb+WHYYbMRj29ArmhSAy7A/RWNQLAKpeifQl
	7c4+diew8AjOMnVuklULVpbCyedee5pMBZqZY6M5TfKF5LdzQiryJYg3LMuKPAio0+Q5Beg90Md
	ehA5wRLSvPFnLmL18+Md1rDIf/IY=
X-Gm-Gg: ASbGncvJFmhx9Fy5mrpPeekwZSn4xHiF/e8mWNhlY1xssN/LN5XVywcWMn8RKerZzUd
	0FRwlLaQ2XiJKq88Avl89P8udzXoWcQZ9vDYx4NOqka7/zc6HaGajfQjxLH3NmQ==
X-Google-Smtp-Source: AGHT+IGqFjsPjHucVnO7w0kgz8DLCTPywPzuLXLhOT7DJCKy/x+Chaui3C0Ff/oqiVYebO/fdirIOj/TknLmzTL8+r8=
X-Received: by 2002:a05:6808:e88:b0:3e6:5761:aea with SMTP id
 5614622812f47-3eae4f2d456mr8103913b6e.10.1733319466860; Wed, 04 Dec 2024
 05:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130655.45293-1-donald.hunter@gmail.com>
 <20241203130655.45293-5-donald.hunter@gmail.com> <20241203180714.45a2af81@kernel.org>
In-Reply-To: <20241203180714.45a2af81@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Dec 2024 13:37:35 +0000
Message-ID: <CAD4GDZyXDpbEoVFBzU-ExYcd_Gf-hHocPUFWAXBXJOcmMRrnSg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/7] tools/net/ynl: accept IP string inputs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 02:07, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  3 Dec 2024 13:06:52 +0000 Donald Hunter wrote:
> > +    def _from_string(self, string, display_hint, type):
>
> Any reason not to pass attr_spec instead of the members one by one?

I thought it would be better to keep the low-level helpers decoupled
from attr_spec and mostly just following existing helpers that only
have the display_hint parameter.

> > +        if display_hint in ['ipv4', 'ipv6']:
> > +            ip = ipaddress.ip_address(string)
> > +            if type == 'binary':
> > +                raw = ip.packed
> > +            else:
> > +                raw = int(ip)
> > +        else:
>
> I wonder if we should raise in this case?
> Especially if type is binary passing the string back will just blow up
> later, right? We could instead rise with a nice clear error message
> here.

It's actually a bit misleading that the attr is called 'string'
because it could be a binary input if it was supplied from python
code, i.e. not parsed from JSON on the command-line.

But you highlight the bigger point that our input validation is quite
weak and will need to be improved. In this case it would be desirable
to defensively check if the input is already binary before checking
for a display-hint. Then for input that can't be handled, we can raise
an error message.

