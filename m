Return-Path: <linux-wireless+bounces-7633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4118C4E34
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C0F1F22CD5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F91DDF5;
	Tue, 14 May 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjQY7EOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4F10A23
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676871; cv=none; b=f+Hsm6xaiouZM0VsS3sFYmDpH3TMVxrsnx3Li/bN7PeGRXqP1hrqmtDi4wIEs7Uao4v4JugAcdypCvsuTRKrDnG+rpcCFg9vGj0r/N6kKrD81vaQCNUIgaFrac8hBc2vmAQanCNNr/ggQwq39+wBn5klRfjK0ftbz0vV9bdJLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676871; c=relaxed/simple;
	bh=AB+zdeB0QP678i8snZ0R/moi0IS0k9M3mN0A1d+j/OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSoYzjyGkTKbi7Kri74sKLxQj+EntVvaID/p9TDAbHhxDIhoOlMDgGhfNLBT4VImPW9htAciavVj7DmhzNw/GkGyaYpjI/411g5bJmQeT7FoTuuvDVDOki0GbaDVjTR+tSjRqKzZswHpiJeJuBV0yduxVYo7YBJQTW7nekBybX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjQY7EOq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59b097b202so1136501366b.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715676868; x=1716281668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QiJXGKVtwWBxNoA2bp0B6WfoYDTVfxaQV3GjyqJUAsM=;
        b=gjQY7EOqoOAUdGrUMVBYSYJTfjOH0gZ2m/i4PMVb/dFeKjJr2W6ZO1psltXlXZm7Mg
         bQqrdDyGWyOj4OQPCEuLkXdIcH3GEzexRpF8pkljoItEd9B0Vax5Fn+0GRokRCR4F/C9
         kTZ17cxhmmGdLyM9OzlizEgh8ijfU4Rm6diWXbwhrfGDTuwFtSNCaE4paV+vZiq/T4xZ
         p39r4Xcmu6524/iymAJ9yoRofzuIXZEP/HCap9PxayG7VSWCS/KNJLS9EnGc1tInDkzs
         4GtOmNXWd/fvhdXva1/fhbmXqUdVNPor7nb243LN754KygHxTODxgpZEkyQJayPMIekS
         7zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676868; x=1716281668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiJXGKVtwWBxNoA2bp0B6WfoYDTVfxaQV3GjyqJUAsM=;
        b=uG/eD/ba+HyhJZICx85dI/ikijZ6P+JEZqR1fTBaoCLFZFv+o6RYZdwXizSWXSH+rh
         bm5PBH7m70isvqnNhGFJ2xOl7sTj7aj9rY95dMf9iNey0jP63V1HfFTcP7eYNF7XT2hR
         Fy0n+kEnbt7oNyPugjlBW7IwLxH/kWQTZEaPvTrEtTfYG2SkPZYz+jkDPQbBexqxxevu
         qo3VtgsAi4TG3gQ8i9gqMMv3vVcef4zkjV6hDv9hHEUDmG+tyXPwZIf8u0gbBWfgrboh
         E1jxHVNzxvH0coE8pbGYZ1KMtK70ypqwBIRUNauwCIfrmnAflIwGRF+jQLW+grDG9i93
         1GFg==
X-Gm-Message-State: AOJu0YzQj0bUC6HJNovwQF7DPw3GDmY0Ywfyz1UMYqdOLG/t+Jcn+rOo
	CnUUdHL0RkHGMtF25NI3dlxekSUROkcEi/61uuVKKzDmJKnNr3itcDhl5yWtZZu5BcZbnob4LWd
	7
X-Google-Smtp-Source: AGHT+IHwmqh3BAOl8GnBOG7pIWqkmokPPAFMW6ypnEfh/59tG49aYuYCK8Ffq6QXslxxDi09QYEqlQ==
X-Received: by 2002:a50:ab47:0:b0:572:9984:1921 with SMTP id 4fb4d7f45d1cf-5734d5bec35mr8793353a12.17.1715676867565;
        Tue, 14 May 2024 01:54:27 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb83sm7224501a12.46.2024.05.14.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 01:54:27 -0700 (PDT)
Date: Tue, 14 May 2024 10:54:26 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
Message-ID: <8ee9481f-7677-4a0e-be11-0c81d4bbef9f@suswa.mountain>
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
 <1a982ba8-c5f3-415a-bb39-fae9973b100e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a982ba8-c5f3-415a-bb39-fae9973b100e@bootlin.com>

On Mon, May 13, 2024 at 04:16:05PM +0200, Alexis Lothoré wrote:
> Hello Dan,
> sorry for the late reply
> 
> On 5/9/24 15:24, Dan Carpenter wrote:
> > Hello Alexis Lothoré,
> > 
> > Commit f236464f1db7 ("wifi: wilc1000: convert list management to
> > RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
> > static checker warning:
> > 
> > 	drivers/net/wireless/microchip/wilc1000/mon.c:236 wilc_wfi_init_mon_interface()
> > 	warn: sleeping in atomic context
> 
> I am struggling to reproduce the warning in smatch. I executed those basic steps:
> - clone and build latest smatch
> - checkout linux-next master branch
> - export ARCH and CROSS_COMPILE
> - load a defconfig enabling all features in wilc driver
> - run ~/src/smatch/smatch_scripts/build_kernel_data.sh
> - then run ~/src/smatch/smatch_scripts/test_kernel.sh
> Yet I do no see any mention to wilc in the resulting smatch_warns.txt file. The
> outcome is the same if I run smatch only on the wilc driver:
> - ~/src/smatch/smatch_scripts/kchecker drivers/net/wireless/microchip/
> 
> Am I missing something obvious ?

Yeah.  I'm sorry, I need to write a blog entry about this.  These checks
rely on the cross function database, and you need to rebuild it a bunch
of times.  It's a simple process but very time consuming.

Instead of that, it's better to do run time testing using
CONFIG_DEBUG_ATOMIC_SLEEP=y

regards,
dan carpenter


