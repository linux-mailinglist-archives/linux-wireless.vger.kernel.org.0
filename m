Return-Path: <linux-wireless+bounces-11919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D429195E551
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBA11C22348
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9016C6AB;
	Sun, 25 Aug 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="dVUqlW4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027A4AED1
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724618266; cv=none; b=P0qNJ9JV2w7Mm5oG6Cl35NbCfKouNUoremwOIr6hFSqjhf+uSYEkRMrW7Vym1VJwOzG9+VYJcb8rFcwTg8UANnxyixJJvI34lOfOLM2Q3McLf8oQWTEaF1Nd0sHLsFEkF5kzzO4xjkr/mPaFJyDF9vP3hegoavLJ2kyL+eSYrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724618266; c=relaxed/simple;
	bh=e5J5GnMjPxS28QEan6DZSJISQyGhBhc/WtJTfGt/0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2F61kdMUV8vJSvlJQvlR+rAT3aCUI5lGRt9tkkw1kAIM7wCjbwzZbnHoQMAGut4hYC+0yheuavZM6oa+6EfzwyzqrFHJSP+tejyqLJzsqqBmhP2Qc7UC4ovondZDfFANJfuB/QoinxKgnuhfQNqf8zw/0dpxirsmUg47EyARDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=dVUqlW4R; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5c7f24372so2977492eaf.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1724618263; x=1725223063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTJoWiuSXupIYXzci6yLRxeub4jTzc42HIPlkJCTPi0=;
        b=dVUqlW4R8rFqaj62KlBz+LtoE4rGuBYBz8VbNULbQAOd5PjfJkIVF8LEpfhQFUW04Z
         OnxS69QLVwdyrTIKjEi+3CdgcCd2BZhSPtaSUIlrTP/fPK2iBRNeh3z7T3ZZHuZCXBo3
         VCSlFITDW/EPIKez+kUbfXQAgAJ/5aXFPXEaK3mOynA6aQS9OqkBIlUpZjWG2i2RaSTO
         xC7aGsHe1KO6m9aIXOkmaF7JAJk74iR2Lkcph8/jApmSIIGlXr6lGGEzBS5KVrpryl0M
         ULJUc24LbMzl/kXxY16G20o1I/PtQV1V0pAwYdV7SFE75J5zL3LBOAszGziMCAH7cxAX
         uGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724618263; x=1725223063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTJoWiuSXupIYXzci6yLRxeub4jTzc42HIPlkJCTPi0=;
        b=LQaqw/zo2GKuA+nbSH3dYruIJSv2EO3mtge9ezmjjsqz9N8le6TEGME+3UbFZVS3om
         JuhjsXAWvrzDZXmH0lKoZQ1hoFI6I/vPkKuWFsSRI3r+UMv7Ot1vgOzjBKLfK7VgdyaZ
         29E9Lye9pfcU9aGVoXfV8olLqh78kRe5HmWnQ3t4w2l0yzz9FtUkIzZCSjBvUyIl92Rd
         ShrtMaYm6bJNDq7bLC/tbkopRfhRUeopaVFx6MYE2UnbK0PnZ/trH90E+Zxpd6L0jl2Y
         5Y0/rGx6ODJhAqbLLxvYSRhKBlOLaRUKqdDkh2mKtvROGS9guCi709unnbCqtpz5Iz9s
         hnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw8kUbYlT6lwZIZh9ZDRTpkDX9kqOTiW0pgW2AxtQi6UgrkEKO95tV9U+0xMx7w18dqZsKBRv59IP93QOG+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi72HX9B0bHTq7GGxq5r6Paamhmocfp45G63IrRjgqFMzYeInC
	4LUMmbcfI6mATXEgKfN7hpl9ubaNWfTXNW8qnuhFxB8bgzcSYdN0GvlDLhS3KfQ=
X-Google-Smtp-Source: AGHT+IH2rsxy4mf9AQPRGFvkC2NisLBc27SPwU/cuhA9UxYvOH5ldeutSET2+uipuNOckmn7eH/ebQ==
X-Received: by 2002:a05:6808:384f:b0:3d9:ddab:125c with SMTP id 5614622812f47-3de2a845346mr11465810b6e.7.1724618262897;
        Sun, 25 Aug 2024 13:37:42 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad82c3dsm5515363a12.94.2024.08.25.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 13:37:42 -0700 (PDT)
Date: Sun, 25 Aug 2024 13:37:39 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvalo@kernel.org,
	johannes@sipsolutions.net, briannorris@chromium.org,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	kernel@pengutronix.de, calvin@wbinvd.org
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zsc1efkBHDXdZtfJ@pengutronix.de>

On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > This series adds support for IW61x which is a new family of 2.4/5 GHz
> > dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
> > tri-radio single chip by NXP. These devices support 20/40/80MHz
> > single spatial stream in both STA and AP mode. Communication to the
> > IW61x is done via SDIO interface
> > 
> > This driver is a derivative of existing Mwifiex [1] and based on similar
> > full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
> > kits in both AP and STA mode.
> > 
> > All code passes sparse and checkpatch
> > 
> > Data sheet (require registration):
> > https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
> > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
> > 4-plus-802-15-4-tri-radio-solution:IW612
> > 
> > Known gaps to be addressed in the following patches,
> >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> >   - Support DFS channel. This initial patch doesn't support DFS channel in
> >     both AP/STA mode.
> > 
> > This patch is presented as a request for comment with the intention of being
> > made into a patch after initial feedbacks are addressed
> > 
> > [1] We had considered adding IW61x to mwifiex driver, however due to
> >     FW architecture, host command interface and supported features are
> >     significantly different, we have to create the new nxpwifi driver.
> >     Subsequent NXP chipsets will be added and sustained in this new driver.
> 
> I added IW61x support to the mwifiex driver and besides the VDLL
> handling which must be added I didn't notice any differences. There
> might be other differences, but I doubt that these can't be integrated
> into the mwifiex driver.

Hi Sascha,

I'd also love to see this patchset, if you're able to share it. I can
test on an IW612 if that's helpful at all.

> Honestly I don't think adding a new driver is a good ideai, given how big
> wifi drivers are and how limited the review bandwidth is.
> 
> What we'll end up with is that we'll receive the same patches for both
> drivers, or worse, only for one driver while the other stays unpatched.

I have some concrete experience with "in-tree driver forks" like this:
a pair of SCSI drivers named mpt2sas and mpt3sas.

The latter was created as a near copy of the former:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f92363d12359

The result was *exactly* what you forsee happening here: both drivers
were constantly missing fixes from the other, and they were just subtly
different enough that it wasn't simple to "port" patches from one to the
other. It was a frustrating experience for everybody involved. I think
their git histories prove your point, I'd encourage everyone with a
horse in this race to take a look at them.

It took three years to finally unify them:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c84b06a48c4d

I doubt anyone would disagree that wifi drivers are much more complex
than SCSI drivers. It would be strictly *worse* here, and the path to
unifying them strictly longer.

Thanks,
Calvin

> I even found some of the bugs and deficiencies I am just fixing for the
> mwifiex driver in the nxpwifi driver as well. So please direct your
> effort to improving the existing driver rather than putting more burden
> to the maintainers by adding a new driver. I am sure this is the faster
> path to get the necessary changes upstream, plus users of the mwifiex
> driver will profit from these changes as well.
> 
> Of course I don't have to decide this. The wifi maintainer(s) will have
> the final word, but these are my 2 cents on this topic.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

