Return-Path: <linux-wireless+bounces-21922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A181DA98FA6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4BB7AFDDC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6502281364;
	Wed, 23 Apr 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5O9ykJ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCF281363
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420818; cv=none; b=oyvb1sO3CzDQQv6RAV1d1EKdO3CmFKQ0DYOrwmxjbLdTtVOBE2kxtLZLtq2e8OoPqEgFwwAu2IHXfXw1UFsJA4svdm2y+GfrN2Kc9Fnto6wsovcoI1z86rV6YMaU5PXeaNxmdAL2o7RsCjUFifG30XmRW2q8P72MHigFIIjy8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420818; c=relaxed/simple;
	bh=htsSRWmKj/59JwlmAD9kixPrm4eAWF+MIiHbLwDyj0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBKcxIN5Z4WHEsE3F0u1t63d0ykUcUpixUJ2JaJMgfCS/V3yxKInK6OUk00QGOKQo8z+wmXmYxLpl9lZUnvigN2Bou4Y/idWVLSGwv7IauUwBJIDwKvamFlAr8YwiDABwoX1B8UjSSOVMVMf6DLuoJhSBILVh9aFVyL2QhX35SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5O9ykJ2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff0c9d1761so58670157b3.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745420815; x=1746025615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htsSRWmKj/59JwlmAD9kixPrm4eAWF+MIiHbLwDyj0U=;
        b=H5O9ykJ2hYluiQ/uvrnRAAz1FotGDsNMY6mglLJHvvO1vxOLNtxPT8G6uak+MnAUve
         f2AyOkyrkWo7Ne5W16orBsirGuQjMbyna5JYPjukKAJC33sPtyWlJsnMeG9LDyhYp5s3
         bnzzBgto351E7OPTY3z9pyda8pGaLmx7RjwifnEYb7k+5gDep+b4XU/vmUzVCYpFL6R9
         K/58AnDNgJleo8Z8osYDokmPavXqdgSAt/1KsDA4qCqoU8iC+s+x2TJG9baM/A5rsa3X
         AWFyVno/JM5SlKdVjQOgb3HMzW0IwDb4sC7Ovp2riAm9FgwoNZewHK1DSFDFA2FB8tEN
         kB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420815; x=1746025615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htsSRWmKj/59JwlmAD9kixPrm4eAWF+MIiHbLwDyj0U=;
        b=USpECQ+i6cSjFPcTzHevNc9FLERITo7dFd2PlvsEaAgYYyxvIZ+Xk7JUlof9E1yX1A
         SD8uTZYFCx5XQrf4d71kmE3WexdezJ9wRoi2aisLTBz0Ch3zdJM7JlJ0DqmVyhyPMmX5
         4rOQrvVchZdwRc8oGnVs5XbYp7OK78hRvdfiKjS7FkGFGqzZeSqEiT2cynGk+jbthokf
         pruntxoUCUE0aTjvMFnHagg0CYTYW7RprFJhtYrcZD7SqmbG0F02+v0AsJaaIL0v112/
         8eWr/OlGmvdsyxJPn3y47OvTNu/Jl7i9JUXAY1bwhY7D9W+KR4gJwILcrt2P1w4/ctcb
         BHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUc4m2Nr2SH5lNNumFH7a4qjxZwYn4jsB3AChUjv/G7Xd76U6MBGbYTQy2LihFhrmdvgFgKAJ4BNgCBdbPnfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmer6KgM5yTn9qZmAmwEHOBCsCfyi7cvWwuMyTFf5qCJRY3GkZ
	CIcgrCum6ouYxjIUzhSYPxxBudKCFZ5NOgPcrnsIv2uSPY4JY8K3KgAILcWou75ij2AiDfhLOPp
	epvI/B677WFtw2q1SboIcK00eVs0=
X-Gm-Gg: ASbGncsoiJH/04yJzQgngT4BgUPSm7QXH3Rc2gqg6deXIfnkfyAjCXOE5emJff0NZ2D
	9uaHRzVDMpLd4UhRpRb3YD25DnEg7ARf6ZO+aMk3PNXmXgI8XLnZ7tXrHwi2cF7jxlxUKqF4Be3
	qpbmVh2LkCZqrt9o/vXG7SxqL48yVSehVsowPiz7bGZs7mRpQvtAjCV4A=
X-Google-Smtp-Source: AGHT+IHIBEUIHIUHbx3Vbq48HtHb0Q3vvCP1K7x/Cj0qJNEOs5kBxploI+OZG4Z2/M2b3tydUe4jNlJLcV2MJw2DXdM=
X-Received: by 2002:a05:690c:306:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-706ccdcdfadmr300167277b3.26.1745420814806; Wed, 23 Apr 2025
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-XvFvGigpY7JYFn@debian.local> <MW5PR11MB5810B066CB7824714FF25D0CA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810B066CB7824714FF25D0CA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Wed, 23 Apr 2025 16:06:44 +0100
X-Gm-Features: ATxdqUHONqKv6b1Qd7Um8aPMy1BYmw5Hsl65TqIngcUOiGOh4mZLyMDOJ0f7HwM
Message-ID: <CAP-bSRbDm_-_uqTX817zaP4HXkW3L3q0j15k2hkGxKERAK=_gQ@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with error -22
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 05:12, Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi Chris, thanks for the report.
> We have a fix for that which will be sent soon.
>
> Thanks,
> Miri

Hi, did this get fixed? v6.15-rc3 appears to still be broken.

