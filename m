Return-Path: <linux-wireless+bounces-12184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91179630B5
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B124B2111F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA191AAE1C;
	Wed, 28 Aug 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="DVQYDmTl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2E1AAE19
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872039; cv=none; b=lYufafrHto5IFJnhAWfdihKjiBjqUr3kuteV88ZWwc6P8mU/0KLvJ0KLSp4Agy4vewDSBzeU/buIDBTZnYlbk86+9SAv7nUgIMyHE1yB3Q2jGCGFjyTKDIz8s2MTBb7go3htGXMcKhNW8r4lN0UvtwcGf+WzZfSf2TiIVn+63js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872039; c=relaxed/simple;
	bh=eqmVW5P/GzQMaT4QUrLtOaeMYjROauG5/uXX3KmPl3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr+FrIWy/sFhRo/ePzLrbfoXlxHwU24J9Kxs5EpBM35j2CQQDpegAtWYSnTHzZyQ8Ujja6XHQUJCS+FZB0xAV2AFmflJDk33hPQmOUUhXcO8CDMEau+K+OXtMdwE9JD9lITm+LvgSD9y4rwWkmOX6x91v+nNxRzd/t4bkt9G+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=DVQYDmTl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-454e92f001eso39330481cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724872036; x=1725476836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCdQOuvZpEr9wBMs5a08LbnbOHqvFyOtRZvV3qzozk0=;
        b=DVQYDmTl384Uj6nx9Lx2+Kp9VDLAYBulTBSn9bmGHZhVls2+VJNVduQvhAoJg+IW9H
         Boh/Ce2X+GjeEIFka006v/WUxXvC+Wxk0dNhyMXNaR20WUBIjSM/z7i3u3XPNfoTKZvO
         VqEg+noyy3wfY7bL0oR4EKUrxeUUSb74uLWmoADqLiUtHtoG4cWAuPOXc4dhDjjxHFoo
         BdQ7kL1/nu0gDfO6q/jW2lvyH6H4nk7b76E0KE+0P8g9/OuuF02vDcSs1Bx/W8YP6Rxu
         32ITH09rK/BFiXnDNYXSM7k0enfMC/ks7Qij8eUXVvT1a0tQflU837n6X5IlQcM425zK
         NvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872036; x=1725476836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCdQOuvZpEr9wBMs5a08LbnbOHqvFyOtRZvV3qzozk0=;
        b=wGLxTtoLbQrfZk4X7gzWhyVXCvwwubQ2rVRpM+gBJWsfVGMGkvenML0ktDLd9tA01d
         O9CEyvU24vRC4Syg7O4OWZlnvtJUbdmhibObFQQeidi8+Upz1vFI4A950wGicezymshe
         HsGrJSCpCUBwxzsciNN9neDGMXozS3/IBpLtLFcx/aBTarcsS9/yaWHoSAnpjlCmOJBm
         8uQ28r2+9TFS4fJd05wRA9wJZbS+LQXnsjxNVbIDJTu8IkNLppypjt5AnF9MoagNFIMo
         SmfdPy0cPQ60ETi9EbcoUTOKVBimXrG5aGpfWN8NlJmuO17KCUYu+eh5dEp2qg1hAHUE
         zfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5j0uYg2DI0LACgJ+/N8SFXLWTfcDxQM8IBmJ28q7xajst/lLAuJ5rmtwfqmfOSLHT+W9yv/HUfoWSrakgtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5b73pBsi5RgAwHdWyW5yvPxNEKCv23SmQm8StY5ErpFJmp3FX
	xF7T+ABdurjmRAJb16ZsdU1xqqbK8t0+mKwMGa9F4jWsvAImsCUMHKHhx1Mmby97HYsvyXKPkN1
	HQQ==
X-Google-Smtp-Source: AGHT+IGha5XEyRE0jG0dAR6gTqYdeYC95s0PfIrCVXNtjJVSbyXU9cV+q40QV1nT83diBm6BWXEu2A==
X-Received: by 2002:ac8:6f06:0:b0:453:14a1:3d37 with SMTP id d75a77b69052e-4567f7077cbmr5263761cf.48.1724872036291;
        Wed, 28 Aug 2024 12:07:16 -0700 (PDT)
Received: from rowland.harvard.edu (wrls-249-137-9.wrls-client.fas.harvard.edu. [140.247.12.9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c5646sm63239041cf.94.2024.08.28.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:07:15 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:07:14 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jouni Malinen <j@w1.fi>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <db648027-9208-43f5-8a5a-b235796a25db@rowland.harvard.edu>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
 <Zs7WegloyrfZdRu9@w1.fi>
 <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>
 <fa0c3a9f-7034-41c7-a066-08284d8a069b@rowland.harvard.edu>
 <Zs9zxsjJD2jQ/jBc@w1.fi>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9zxsjJD2jQ/jBc@w1.fi>

On Wed, Aug 28, 2024 at 10:00:22PM +0300, Jouni Malinen wrote:
> On Wed, Aug 28, 2024 at 02:02:32PM -0400, Alan Stern wrote:
> > Attached is a compressed file containing a 10-minute section of the 
> > journalctl output.  wpa_supplicant was running with -ddt and without -s, 
> > so this should contain all of its output.
> > 
> > Initially both wpa_supplicant and NetworkManager were turned off.  The 
> > log starts at the time when I turned on wpa_supplicant, and a few 
> > seconds later, turned on NetworkManager.  An INVALID_IE event occurred 
> > at timestamp 12:03:59.  The output is so voluminous it's hard to see 
> > what's really happening, however.
> 
> Thanks. This seems to make it clear that the AP has an issue in its FT
> implementation at least in the BSS that operates on the 6 GHz band.
> Based on the OUI, that AP is from HPE (Aruba?), so I guess I'll check
> with them whether this is a known issue.

Yes, I believe Harvard uses Aruba hardware for their access points.

> The log did not include any other attempt to use the FT protocol, so I
> could not check whether it could have worked on other bands. However, I
> do note that the RSNE from the 5 GHz band is indeed different and
> matches the value that the AP included on the 6 GHz band in the
> Reassociation Response frame, so this seems to point towards some
> implementation or configuration issues on the AP side and that could
> result in an issue that is specific to the 6 GHz band.
> 
> PS.
> 
> The reason for this particular sequence is in the STA first connecting
> on the 5 GHz band and wpa_supplicant being configured to use bgscan
> to find a better candidate. Background scan from that ends up finding a
> 6 GHz AP and that has better estimated throughput and wpa_supplicant
> decides to roam based on that. Since FT is enabled here, that roam tries
> to use FT from the 5 GHz AP to the 6 GHz one and that fails. This
> results in the 6 GHz AP getting temporarily disabled and a 5 GHz AP
> being selected as the next option. That succeeds with initial FT
> mobility domain association (i.e., not using FT protocol). However, now
> we get back to that same state where bgscan will find a better AP on 6
> GHz and that will result in the same failure..

Is there a way to tell wpa_supplicant to ignore APs on the 6-GHz band?

> As far as I can tell, the main issue here is in AP misbehavior. This
> could be worked around by disabling FT or bgscan. A potential
> wpa_supplicant change could be considered to disable FT protocol for
> that specific AP when this type of behavior is detected. I'll talk to
> Aruba first to see if I can get a better understanding on what is behind
> this AP behavior.

Thanks.  If you need more information, let me know.

Alan Stern

