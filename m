Return-Path: <linux-wireless+bounces-4527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8920877727
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 14:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54352B20B6D
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13783224;
	Sun, 10 Mar 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhBQ16lK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EB219E9
	for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078045; cv=none; b=tW0VSdATs9zrNKNNLEU3PQn5lL8XcSnme51HDed0vllUK7eH2oPbIGS0QNeWUpmr0vKECzAV6C8u3kDbNZQj5qrIJIG/MO/ecb0SgI42ApP6MplpaAY/OG2USdF2hzXVVYGgNj9GZauv2jujTpIEAkV9Sra3GKTsXNKonx+sdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078045; c=relaxed/simple;
	bh=JOz74F1MJd0somsM1kh295TifC+TDhAws3E4cu+0oeA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEhMUrotDxCJZjrvLknEyPOyYY0UE6sqc8DDUVIM5kW46AqpnimXYZquYtlRjhOEpt9qCUxZyLD6kq2J1QmK5mx+ZUKHax/bgn77ZMPglJIzdA9pdxMdgh+jC5ZNxFOQCU10wgzbmyERCM9tjn9vyP0HqJWTMlBDJg8Ct/kR1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhBQ16lK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51380c106d9so2453315e87.3
        for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710078042; x=1710682842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah1V0v1g4neXN5nykCisX6hPOg0I1z6HcbiGAQ7gVdc=;
        b=XhBQ16lK1CGzmDVQccbPdgL9cRjNr4apIiqgXYfn5MIbyzQGd/irLo9ABY80HGqBhh
         3sDEmKZA3GoCfr3EybY1D8PuOcz8LgNsestEKPVfS4Un0bvdXD7BCvSgIqsgYQqpR4s/
         kR2kpZz6gnaaiaAsEXejkiU61Ls3+T6Qw6Xzh9M8h7C6jCInLuyW5uhGIsn7iTFXymGD
         pbH61meNxQbz1GCJ+v1wafRIu6U2fOo9RAPb81eN7/EG6bH8yrRzwXTSXcG+1OL05UW9
         ZNNNhlvrgJkYQg1RAY07wqWrbdGctuNxbqvuLBY0Us6lQEQpTrdMUJO7pTf082z6oIud
         1pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710078042; x=1710682842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1V0v1g4neXN5nykCisX6hPOg0I1z6HcbiGAQ7gVdc=;
        b=edmy61WQ8OY1Gbbmy8LqaDJkD5S3aMekgPLg0ru38pr2RbgCdO5Im4R45zhtYBHTYZ
         Z453FwOZmXT8YHQ3waNSFG1yMEK0VJtdmgI27MLSf0PRLepJwGZI7gEJrDVh2L/NbSeP
         jy+AKZ9FHKsRKPhkMYtsbPtFkQX2MCAJLO/Wb7EvNSM4bnnP6Fx9+iR46DZtbxLNYQbb
         oqmm0e24X9a9sTzL2T1nVD7jc/ZOK9vrkbMQKbJwC/Nuia743NYn1mMbk85zv1eiKi4n
         3Gi2Jo4aFmjj2iYF43gueSwAgIoIFt3hldEo90aQrZdoFRPhfhxhqhbP9bzbcG22wlyE
         f77Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1N/4kweet3oahnROy4Z9L5/RASoptQ6/WGlxoG3PVNd/K2VGe+Xxg1xM05bUOoLHZnjtQqS+jbVavtydpnjJnFZCA7OYNv4H7T7NPDP4=
X-Gm-Message-State: AOJu0YxB3Kmk2EJeHyvqhO0y6LcnUiCImmtqP+tH7RWnv0PlY1ITgFIv
	AWGefEPsfhq2tku2RIZQ840JhHsXHJry/bQTkTauLUMcHmYsMNg/Xfs+z3DlsGsG9g==
X-Google-Smtp-Source: AGHT+IEEfOI3b0DjtFMjXt3OxNnu9pZYedDbYtpcyW1qKC08J8uQR/jdSidp6gnV3bNWo/l3zff8jg==
X-Received: by 2002:a05:6512:689:b0:513:9986:e923 with SMTP id t9-20020a056512068900b005139986e923mr3174661lfe.63.1710078041686;
        Sun, 10 Mar 2024 06:40:41 -0700 (PDT)
Received: from radar-prod1.wnam.ru (nat-inorg.chem.msu.ru. [93.180.12.29])
        by smtp.gmail.com with ESMTPSA id j5-20020ac25505000000b00513a8da4592sm73471lfk.74.2024.03.10.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 06:40:41 -0700 (PDT)
Date: Sun, 10 Mar 2024 16:40:38 +0300
From: Ruslan Isaev <legale.legale@gmail.com>
To: Julian Calaby <julian.calaby@gmail.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9] Add JSON output options to 'iw' for scan results
Message-ID: <Ze24Vksizd4kMloW@radar-prod1.wnam.ru>
References: <8dbd0dcc292cf15105d09f48c573f7a5.legale.legale@gmail.com>
 <CAGRGNgWxwYART2wh4LozUZJGvvHd2ztMmxLsdB3-8yBd+beqsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGRGNgWxwYART2wh4LozUZJGvvHd2ztMmxLsdB3-8yBd+beqsw@mail.gmail.com>

On Sun, Mar 10, 2024 at 01:02:45PM +1100, Julian Calaby wrote:
> Hi Isaev,

It seems I need to swap the first name and last name. 8-)

> 
> On Sun, Mar 10, 2024 at 12:44 PM Isaev Ruslan <legale.legale@gmail.com> wrote:
> >
> > v9 changes:
> > - remove binary json/iw_json_printer
> >
> [snip]
> >
> > Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
> > ---
> >  ...utput-options-to-iw-for-scan-results.patch | 3773 +++++++++++++++++
> >  Makefile                                      |    2 +-
> >  iw.c                                          |   27 +-
> >  json/Makefile                                 |   19 +
> >  json/iw_json_print.c                          |  221 +
> >  json/iw_json_print.h                          |   35 +
> >  json/json_writer.c                            |  298 ++
> >  json/json_writer.h                            |   76 +
> >  json/main.c                                   |   49 +
> >  scan.c                                        | 1187 +++---
> >  util.c                                        |  333 +-
> >  11 files changed, 5281 insertions(+), 739 deletions(-)
> 
> I think you need to work on your git processes.
> 
> First things first: please consider staging your changes before
> committing and inspecting what you're committing there. It's a really
> good way to catch "silly" mistakes like "git add"ing the wrong file,
> etc.
> 
> My process if I were working on this patch would be something like this:
> 
> 1. Make changes to files
> 2. git status - note files that need to be staged
> 3. git add file1.c file2.h
> 4. git status - verify the files I've added are the correct ones and
> that I haven't missed anything
> 5. (optional) git diff --cached - verify the changes I've staged are
> all correct and make sense
> 6. git commit --amend - amend my commit with the latest set of changes
> 7. git format-patch -v 9 origin/main - generate patches for my branch
This trick i didn't knew.
> 8. Send email with the patches generated in step 7
> 
> I also tend to delete the patches generated as soon as I'm done with
> them so I don't get confused about which ones are which version.
> 
> Secondly: if you're using "git add --all" or "git commit -a" or "git
> add *" or something like that which commits or stages all files in the
> directory, please don't. You'll do less revisions of the patch and
> produce better patches for upstream if you spend the time to check
> your changes at every step.
> 
> Finally: please add generated files to the .gitignore file (if there
> is one) this tells git to ignore those files and it won't report them
> in "git status" and won't stage or commit them. "git status" being
> "clean" with no untracked files or changes is a really reassuring way
> of knowing that your directory doesn't have any unexpected changes or
> anything like that and it also helps out with stuff like this.
> 
> Thanks,
> 
> -- 
> Julian Calaby

Thanks. Patch v10 was done as you suggested.

> 
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

