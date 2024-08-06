Return-Path: <linux-wireless+bounces-11007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8991948D6B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41CE7B2548E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61F1C232A;
	Tue,  6 Aug 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtVYneJ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7481BE23E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942286; cv=none; b=bXnhy48amZY1DcsK3F/PkJQ/IypDCW5qoz99NbFyLT0g3PmJDI2/0RE94f+zL2mSkjgFAuddq5Na0ay2ZfBkzQ6vA+gy+M79BXXD7f4yUuhQoBpWvKHmiOEuatVUFxeWzPEWnWGMNi3RBYkcdUQlFH0y0v9kytJieAizof8ctXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942286; c=relaxed/simple;
	bh=c4xKF9EFqwa7Eg2Awhq8zwH3ncTbgXM7e92R62jcPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhTpFuSB5j9dZNPzXowYV9NeJl+xAhD4yKmTKeaW5r7pDjTQJkcpAukW3EYDzooN4z0423GaL8p4pr+cq7ZAxWjWDj3DskDMCudBPmF30WURuyqpgn917n9oIIwIHhpdq28acGR18UDOHsfFAMr42vMeUddksCyH92/BUtiKv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtVYneJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722942283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLO0GFLtC0/RCpuHKysGRgafRy8oEPXNMF1zIFnu4R4=;
	b=gtVYneJ24L5NOqVYYJHXG+/4I/QDQrmtQc4it2QD114Tp0487+UrMNEsHRRv+vm1pkUXHr
	aFm/RNulR3vrHtvFdufTKQ0IKF7p+otLQbUb58+ohoCOs84vW7bnW3gfdna0Q//pbfufcX
	RMybG7gEuFodxm3OBjhbQt8MYMjyBoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-iPZIC96XNxinbxNPfgH4YQ-1; Tue, 06 Aug 2024 07:04:40 -0400
X-MC-Unique: iPZIC96XNxinbxNPfgH4YQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso3630185e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722942279; x=1723547079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLO0GFLtC0/RCpuHKysGRgafRy8oEPXNMF1zIFnu4R4=;
        b=BIm0PrQOQ4dglB+caGsEUpunEv7Ubc5eu8UntkrVgpVuhdPzIcBqYqxR4h5nhuEaBM
         0h6Ktvz1y+XwEYzgLkZlVWCvFRQBxRMdQ5/HTX1zjmU041hhCoyuRp1GyOMGiKlh78uH
         10vMY5jt4ZLZyBp42N59UcU22Ql6FaGiQGSazoRbFp9WPtOkbaUul0ymzjwoSma3yfLb
         TuFTn4fBY4FRlPEHS2SIDxFk+EqyTKgAbtdn/t8cL1c/gSg4Tbq1XVD6R8uEApXepgny
         2+VNxLtS2R2UkC0DioEDm/W+zX+9zBpe92iZFIv2+8o/38dh3pNO5t37zkQYp3rjTOFd
         Hfaw==
X-Forwarded-Encrypted: i=1; AJvYcCWmLzYgbDrPVrboCksGBAYPE2f1RlLkuvEtHkKPsJR1FvIoupLjzCldA3+k9Yl5MKy7rkznDKdx3kNLw9Nk51y0UwXO8cBAS8NTgLOoqZE=
X-Gm-Message-State: AOJu0YysutZ1k9S/N1U+YJcN6CYVU+ulBLfQ8n74seBFGl7tBbCMA7M7
	GBA62BeiPq1QFqm3SGF9faiMNFSCdUwX+1qxXNAQ/vFKeGqHMpKkOBuQgNvMworEYgWXDPnnde6
	qfLynZ7GbizeupwyAu/N5gBUVN2GUdaR9ppw9DDMqztz5o5jNYmtsCZk/qMSAd94u
X-Received: by 2002:a05:600c:1546:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-428e6b7c1aemr108511825e9.23.1722942278901;
        Tue, 06 Aug 2024 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqIgPzQp8aE9L2eNg2nsXsX1CiCpuwVjIveNT+MoC2Hiz6BBfy9/LyQmgMTdGvjH0s74T53g==
X-Received: by 2002:a05:600c:1546:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-428e6b7c1aemr108511335e9.23.1722942277893;
        Tue, 06 Aug 2024 04:04:37 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3174bsm175059375e9.21.2024.08.06.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:04:37 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:04:34 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: hhorace <hhoracehsu@gmail.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect
 User Priority
Message-ID: <ZrIDQq1g6w/zO25l@debian>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
 <20240806090844.GR2636630@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806090844.GR2636630@kernel.org>

On Tue, Aug 06, 2024 at 10:08:44AM +0100, Simon Horman wrote:
> + Guillaume and Ido
> 
> On Mon, Aug 05, 2024 at 03:17:42PM +0800, hhorace wrote:
> > According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26), 
> > AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4 
> > and AC_VI (Video).
> > 
> > However, the original code remain the default three Most Significant
> > Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> > and AC_BE (Best Effort).
> > 
> > Signed-off-by: hhorace <hhoracehsu@gmail.com>
> 
> Adding Guillaume and Ido as this relates to DSCP.

Thanks. The patch looks good to me (only missing a Fixes tag).

Just a note to hhorace: the entry for CS5 (case 40) is useless as CS5
is 101000. So the value of the 3 high order bits already is 5 (in case
you want to make a followup patch for net-next).

Fixes: 6fdb8b8781d5 ("wifi: cfg80211: Update the default DSCP-to-UP mapping")
Reviewed-by: Guillaume Nault <gnault@redhat.com>

> > ---
> >  net/wireless/util.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/wireless/util.c b/net/wireless/util.c
> > index 082c6f9..4e04618 100644
> > --- a/net/wireless/util.c
> > +++ b/net/wireless/util.c
> > @@ -998,7 +998,6 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
> >  	 * Diffserv Service Classes no update is needed:
> >  	 * - Standard: DF
> >  	 * - Low Priority Data: CS1
> > -	 * - Multimedia Streaming: AF31, AF32, AF33
> >  	 * - Multimedia Conferencing: AF41, AF42, AF43
> >  	 * - Network Control Traffic: CS7
> >  	 * - Real-Time Interactive: CS4
> > @@ -1026,6 +1025,12 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
> >  		/* Broadcasting video: CS3 */
> >  		ret = 4;
> >  		break;
> > +	case 26:
> > +	case 28:
> > +	case 30:
> > +		/* Multimedia Streaming: AF31, AF32, AF33 */
> > +		ret = 4;
> > +		break;
> >  	case 40:
> >  		/* Signaling: CS5 */
> >  		ret = 5;
> > -- 
> > 2.42.0.windows.2
> > 
> > 
> 


