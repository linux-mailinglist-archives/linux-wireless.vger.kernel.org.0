Return-Path: <linux-wireless+bounces-26076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48527B17C4D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 07:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C917BB0D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C229CEB;
	Fri,  1 Aug 2025 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="SmTnoT3z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF2139D
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 05:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754025069; cv=none; b=ghDsdawoc1fXXK/aV+vU4XC9QQOylEBDtkVcPdPxQ7Et4pyKo8lbvxrXWbgaoZ8yZUYd2YtKXMGycu0UnGdb6/y38VM8+BXvIl/qQDKm9lN64Scyft7GRn+J759FfrzvFo6IImBg3KbvUnoUS8ME+1CTJqYWkIHeBn3OvOIWsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754025069; c=relaxed/simple;
	bh=JsMqroGehOkOyuNnrH4QGrZvZZ25ct9mnGd8d+EcSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhMPo80W18BkY8E3IXPrp0hKGw88HSxjdOz/88xnx5iTUPpDsPmuGnGdq6gtUsfTZvwYVhJr4nuJz3esiLZ1EOgp6PFClDahbvCnQ/b4gRQAhMFJAxxT9AP7EiJV6ZEEC6eVDX/th4wrd5oz0UbP2Ndu0aqL7np2gbNkUHMVOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=SmTnoT3z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23fc5aedaf0so9563115ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1754025066; x=1754629866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xCRzom0SFHLKHEZcXJu/rKhQccbjcV6ehAV3P1yUQY=;
        b=SmTnoT3z/e4Q4sW0StelOC9qVSAkVqix4cs9aOEPPal30CSzsIZWzRXuWggS7V1zAJ
         qU3k3y+31SvwZ/dKYw4GWoWtU0t5zoGD+7X2cZmB1vsvywDJYavETtI82DIksBjA6y5A
         2/TkYvqpv0vtvggMBg9bCD2rVVVrGlGmAl6oace4YaX8/oE+4cyZ537ogUC6RLyAaeS5
         DLxAWX8DMrsaKAv0JrfKFBFqsM1Fr2e7+btRV1R/6VVRoBKUvyNXJ9UDEGTYXfBv/9sa
         jzMLXdV18rts6QRnmLX8Ab+uu7iYE/1jFvYQPstR2SGBj4+lBg3xN++O8Pgv/ItuH7Ed
         0cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754025066; x=1754629866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xCRzom0SFHLKHEZcXJu/rKhQccbjcV6ehAV3P1yUQY=;
        b=qpr5N88Ecf5LToIXq06PCEWveRZfJ6NZL+ltFe6RFEL9LDSNqBrWtt9Nk18YXiMs9c
         QwnfScAy+M/IfOwTEcWcUZCwSz2KM9GBSKN68P5Dyn/CKBlUTIm/7e9t0hFzyIfFqfmF
         fsetHUk5nmkBHEDIXwPFgh4IhHbQGP0z/+2H4Du7u7ifmXt+H+TdxAA3/PQpI6U6b4BT
         8Li4wdo0RjGM9M1GNcnEC9QmdLg6Y1pHhn4kyRWZSd/bSTPT7zmYxBAOLlH7HDfCfnl+
         J2HGrJFLSG0iz5m6qRSR8MDy7quaU+HHuX/kXswZPt2PROEmr10q84iOkZ8WZFYemgCE
         VV6g==
X-Gm-Message-State: AOJu0YzG4bC+3xW1BsshFJuevLxAAR0u7y/zDkT3kzPLWWc37ICfj/2K
	9In5AwoaBfD+0IQILkP7+nSyTXwz9LCnJUkcTBTplE8tThBLErkX6dWZfQsbuQpqGic=
X-Gm-Gg: ASbGnctHOHosiMRkcaIrgF6iOeLdEnSaFpdL0ldalCG8HoI+lY1v/nv9Hb1E6Uv2fkW
	NBqIC1VHVuSQBa/GULy9Gy2AXWqwvC+g61A2b4PrNz7eOMv6MSkbNwhVPKWYwQtRFfCVDC+xLZS
	CV0aCZjhxY5zQMfdKFyI1SSDAiSRIB1NQArHCrKfgN8kmw9niXHEcpUxCflEgksc5oxvDM9kfF3
	2w3yDAeHkSa1bkt+bPlhRr80etdy7IU0nfps70xLT6SWhDDHECOnS5SVofviMMY1lZtcIpozhUv
	/YPiW6bcnPCNbVs+9/B3lcun61FBjYCPn3d0eGWenuhw5dCXWQaWE5tCabXgq9wXCL/yp12QzUz
	AopRSmZp5GPhzsLu0zX0QHluKG2CS8orf04EqG8f4Nw==
X-Google-Smtp-Source: AGHT+IGQTG8B1K0M5OG3eJVHo5BK2UREmMRU/URvF5vKpnziwLUbEDHg7tl6pLDshuDnK5+02+5Z9Q==
X-Received: by 2002:a17:902:e849:b0:240:3dbb:761c with SMTP id d9443c01a7336-2422a699be0mr23145085ad.32.1754025066376;
        Thu, 31 Jul 2025 22:11:06 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaab44sm32738555ad.155.2025.07.31.22.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 22:11:05 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:11:01 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next v2 3/3] wifi: mac80211: kunit: add kunit tests
 for S1G PVB decoding
Message-ID: <e4j5rbffwxgrqafkwyuezl2q3z4mgdn5lxrkxjxaphmn66movm@d743xb4xbdrc>
References: <20250725132221.258217-1-lachlan.hodges@morsemicro.com>
 <20250725132221.258217-4-lachlan.hodges@morsemicro.com>
 <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65411d6ba7516e01920ccf39627269fc2f71dd56.camel@sipsolutions.net>

On Thu, Jul 31, 2025 at 09:56:56PM +0200, Johannes Berg wrote:
> On Fri, 2025-07-25 at 23:22 +1000, Lachlan Hodges wrote:
> > 
> > +static inline u8 *tim_push(u8 **p, u8 v)
> > +{
> > +	*(*p)++ = v;
> > +	return *p;
> > +}
> 
> The robot complains about this, there should (normally) not be inline in
> C files.
> 
> Also, looks like you don't need the return value?
> 
> Anyway, it's the middle of the merge windows, so I guess it'll be a
> while before I apply things.

That's fine - I can submit a v3 once the merge window closes with these
minor fixups, no rush from our end. Plus its always good getting the
dopamine hit from seeing all green :)

lachlan

