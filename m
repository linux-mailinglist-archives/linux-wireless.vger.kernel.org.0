Return-Path: <linux-wireless+bounces-4795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B287D779
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DA2281D81
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984535B5A9;
	Fri, 15 Mar 2024 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ef/dAj5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5455B5A3
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547162; cv=none; b=Ihag80cMLrliJ3oMseBsSViU3zHOE0RPfmrv4Io+egRKNVlrn9CEoxS/+jZEmiOJ1EzzZ/xkV2qbYOe7XkqSAKpiECqcC0vpXRdh403XQvsjQ4KBitOsI3vIAxxBMVRsRGzNeRpdvyVNSaMThc88Qk2CkmA/V4y3q8pFVL23u4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547162; c=relaxed/simple;
	bh=bCicF5ebdVDpqKU0osODMuPcFTFPYVOiZMVq3Jbo2sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIgPvvRtdkUwTFyMuWHWfIK3wq10C+QebZnrFyNVz2nBkneggHaZj2QdFYgyupVkJaZWrGhOthMGnGACNGvGa2rYeT21k5I1TITNdA1nX/a5wERtAsb9D53YGklXMKMyASJAhLdJU4NfSWsOfuI/ow2zRn39upqOha+CPQ5+jnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ef/dAj5r; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29c4fe68666so2105166a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547160; x=1711151960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sM275NZSd8vxHK6j0cBZSVmYBz9fGKRC+k2owwgR1cw=;
        b=Ef/dAj5rinEkkXRD7FRHcIzCfaon+h4ckd8c7/eLZQEJGzLBs7BOjF1fx/577PlrRr
         3YiyPwLof3md1/oQeuMf7aN71f6jMXZiNUYwILGiCc5/UXsDZDggy6NiP2jmAskTw34x
         dvoXgYlydzMr3tVNHE4vZp2GVhG+UJdoz6qjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547160; x=1711151960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM275NZSd8vxHK6j0cBZSVmYBz9fGKRC+k2owwgR1cw=;
        b=M4N5Z2Dh05nasgF4PM5Wo1647GEivGUgqk7ysHVQnT/aw8VAx+nVr2y6dY2nvqiAsZ
         l4X1GP+bSWdDWAkN56cx1vwrNXG5VPWlE9DMtbe2WWSoZvMX4kD/IUEjneP3CexH9cRi
         b9oW3dMOLZNUiz3ZAhs9DmOgH1DrHo+O43KfvHDg/yYsAfZNT+5Lo2ZTRdTBSXMqyxng
         whvDNtbjFkv7SFKf36N6hGc0VxVWjqJeeuiny0LDPRTP9UozwyIrD/THQgCIGGn2c0mM
         kRsn7BTbuxiC7w5z2N4GUp89XrB7L68VhfchCNHJgPPMV3VYRY1ydnBN9B21dTJTlLFX
         Qi5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9WCzPCXWxYAV6jDDea1yzbPcm42wCp7bQAYtTaRmzAnLi9DedQuoYy2C9AvGfF9oR2pR3xSdDn67FuB5I5AIQaFzsdOD+xMIymqAcoIY=
X-Gm-Message-State: AOJu0Yyc9Rj6ge7Q3nsRGZmhMff/2wZPHIDFta6O7fhDnTK80+CGJ1Y7
	D5jBJl6FL5dGhGuZ/Z+C8N1eduuXwbjkO7se3vQLUR2bXe+r2geTiZ3uwQSafw==
X-Google-Smtp-Source: AGHT+IHpqnT9Fv5bbiRYCIPz1P+GxwqhkiVdn7cjJFZWI9cmIRcnwcon3IXOAxF8rnoQaIsu06sQsw==
X-Received: by 2002:a17:90b:3b88:b0:29f:689f:f2f2 with SMTP id pc8-20020a17090b3b8800b0029f689ff2f2mr536880pjb.31.1710547160502;
        Fri, 15 Mar 2024 16:59:20 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id 37-20020a17090a09a800b0029c3bac0aa8sm3873484pjo.4.2024.03.15.16.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:59:20 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:59:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	tsung-hsien.hsieh@nxp.com, rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZfTg1xKT-Mxmpf9w@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315094927.GA6624@francesco-nb>

Hi Francesco,

On Fri, Mar 15, 2024 at 10:49:27AM +0100, Francesco Dolcini wrote:
> Hello Brian (and Kalle),
> 
> On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > This series add host based MLME support to the mwifiex driver, this
> > enables WPA3 support in both client and AP mode.
> 
> What's your plan for this series? I know you raised some concern when
> this started months ago and I'd love to know if there is something that
> would need to be addressed to move forward here.

My plan was (especially given the "Odd Fixes" status in MAINTAINERS) to
wait until a 2nd party was happy with things here. From my cursory
following of things, that has now occurred -- thanks for all the review
Francesco.

My plan recently was to get back to reviewing the code again, and it's
been sitting in my inbox. Unfortunately, I haven't made time in these
last ~9 days so far.

I'm revisiting it now.

Regards,
Brian

