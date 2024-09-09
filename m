Return-Path: <linux-wireless+bounces-12680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D954971EEC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0E285CB7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946213C812;
	Mon,  9 Sep 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeZwHnh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61E013B791
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898577; cv=none; b=Ss7QXx+UmfexR8bGZU2kYP5wfIyxtQ9db578+Dre0IxpSu3lnee2Rw99WE6IVFBCjVu1aXHzkdswewRCUL0RWx9B2mH/uBOfmi+L1hurQnLGmbgm2fArC8ZdsyZx/KRR4D/apTmq78WUKNMIclualyrDjVQHLn3q1cXcaKA3ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898577; c=relaxed/simple;
	bh=yF4IcqmCMDCWoKEYbgDAb9hvl1UKIgWn6+PT26QJBfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aitm1AtrLdnIKN2leNEBXE+AL6SWXcFlsDdeIiPzU2cuo5++2LPngLNLMpsGM5hozJfH3JAH7P8GWrqHJThDlGnZgkPPd2aYzru9hIoNId9d8Nj0uKhw+zMlPkQXvjdKrzL0hrN/2PvSsPkevRgtCsKYupNXoEZbXxibNtDjXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeZwHnh3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so4816404276.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2024 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725898575; x=1726503375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yF4IcqmCMDCWoKEYbgDAb9hvl1UKIgWn6+PT26QJBfc=;
        b=AeZwHnh32yzwqaReITfSAGFGv6hYgO/PnLZKSGns7KX5+QPu658/pKHjJ/7nZq5gcQ
         HepgCWKJDH0eiqp4h7zVrO7TaKeWgAj4u+r3Jdl8Ss2UgiI77XRIpmlBj3ggwD/B+QSH
         Pz/vk1UaigimEVCSq7iVz5RQYj4honJXonNJXn6x07Uh7D2WZaZlzY0DXE8YIPufkc3e
         cV/6jlI3W/CMPp3hFca2BE88/qAPZWwNoBocKjSgFxFNSZq6ruMei/OQtdMvfEdyo4mw
         NixH4P5WetyUXDNvZzmVaryIFK+HwyJL7One9RVHFz6IYXbKn37ypxI8DP7BzQtmKT0n
         qJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898575; x=1726503375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF4IcqmCMDCWoKEYbgDAb9hvl1UKIgWn6+PT26QJBfc=;
        b=gRmjmPiOMTr1FKkPklNRkjL1iDEzChH1frDP7u3elljBvFGXb15rmlrga9QIC7bqHe
         YofykpnKVY1/m1kG4oU1k6V0N/Xd6hEZU83exwZIc6nXwPujnQw+U8a9SKWRlPBUQDx2
         dhkSkmxOG6mIPPDlW4B1pNplJyQ9t2+CnLpNjYVWWQxgVXz3Ry2t6G+lMNKSHpi32hzJ
         cy6k4aVlfPsgYX7GLk7jP7etoPvoV+8S/nnHP3f9MUmlU+2yqTDym883+gJG6io57bjz
         jdcbBCkF5CQAcGXt08dVw2uUvojGrCOPmOjOQvkE6+OEp/DfR3xuEOiPfzZL3M1Ktcf4
         Fh8w==
X-Gm-Message-State: AOJu0Yxm/aUFQGbL5auYbGJe+O3eJdfSenhnOI1Ock+xF+JnvhfDxdy6
	Pvkcotpi/IYtATg5UiEMygMLFoYcuBT6uTGXHOqTwjCMSgO+wm4pEEVPjMCvjQgIrdcHFyfdiw8
	+b81oIVXhbG/btVKLWEFYwWbV+Rw=
X-Google-Smtp-Source: AGHT+IE5myYfw1EWv/hxokhOA6Qn4KsSWVWcQtK/QRaaxCKn8a8jjN5pV/Dzm4k35N2vyg5SDWtEaVh8kKdrv4qh5rI=
X-Received: by 2002:a05:6902:274a:b0:e1c:fa56:9b72 with SMTP id
 3f1490d57ef6-e1d34a36f9bmr13517427276.47.1725898574820; Mon, 09 Sep 2024
 09:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
 <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>
 <Zt4PKMCp_FTx3kac@debian.local> <cd2ec07a08c9a51e0dfa5be70b35d39e5cc5e577.camel@intel.com>
In-Reply-To: <cd2ec07a08c9a51e0dfa5be70b35d39e5cc5e577.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 9 Sep 2024 17:16:03 +0100
Message-ID: <CAP-bSRbmKvaoU662XtgjaPaOwR7fHZaJyrYxkpT=DfuCxwsJ4w@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 04:08, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> On Sun, 2024-09-08 at 21:55 +0100, Chris Bainbridge wrote:
> > On Sun, Sep 08, 2024 at 10:54:09AM +0000, Grumbach, Emmanuel wrote:
> > >
> > > Strike that.
> > >
> > > Can you please take the patch in attached instead?
> >
> > Sure, the error with v6.11-rc6+patch is:
>
> I expected that, but is wifi functional after resume?
> Not having wifi after resume is one thing.
> Having wifi but with lots of garbage in the logs is another thing.

Yes, wifi is working after resume.

