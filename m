Return-Path: <linux-wireless+bounces-20870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA8A727F5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668593B1D58
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A62CCC0;
	Thu, 27 Mar 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvSj5vNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D9288DB
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743037118; cv=none; b=BrnhvoET7FF6o5dovcErhhM1RmdxyR6uv9NICa1ciCYJiBp+ZyBrZS/obq1p97EYFQBZQmLTxDR8ilABNhJjl//NzVxgN7JRoquCA8kWnjKvCpyYC323NkX+M7Nt6Y/aCGXwRm0ZvHCcQlyzoBG6GT7Tpkynr8rOXkFi5fx2Bmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743037118; c=relaxed/simple;
	bh=ajJpnvlctkmr1rqIhEfs8fmWIL+8rSu4llRb/sTa22I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL7IFGv/SgnJzDGeWOjwKjV3EKHYM46Xrb6rxH86OYnES3RfG3KOKTijDkWNmTzg6H7Quf+v5eYlxgqW29kU5Pqts+Kdp3NLSE0RJd+0t4a67kgxMNoUnNUGvU6evPHEQCk8OktnNLrqHszrMvUYXGEomcfpqt0cf8bS4UdbKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvSj5vNs; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e63504bedd0so382370276.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743037116; x=1743641916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ajJpnvlctkmr1rqIhEfs8fmWIL+8rSu4llRb/sTa22I=;
        b=DvSj5vNsb/K1sLbV1TMeI51cGkLeaxZY9zCRvF9w96H4Ik8aodAl7df8SCAqu54bmc
         t6/IcOAvT8V8EF2kdslTU6pEfiFJ9N5q5oLlD3CVjDz6ESQlRL4CM6yAL0CVAEcz75tu
         RhR2ybiaNl65E/sBKBRRMl9cKAuWk4Vlt6XFi0x5RRRUBe3iFT3CSzCJnP6dlZs/Q9/p
         z3MLNNC/09uNwDwYtgrSOJc9zI8E6u5iQCa+jKtMA9csKNipLg+9U2uBtUMTeIBfksLv
         t6pIPsmmjYGP393Bc+dEFKhMVEVSy59EZAZ8aIP6TIPhvuyKniLoEmF0KrgnieCWRzxn
         QmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743037116; x=1743641916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajJpnvlctkmr1rqIhEfs8fmWIL+8rSu4llRb/sTa22I=;
        b=l3JkG6ecphz4zdLlXumhhurRuFVF55H5mAFzGWPjq3+rdBjqdXHTjN0AiDrKh1ydMf
         qHE2WvOU0GM3sNaT2GaNkC3TKWO3aKasYSJrdS9egQTmKbJqTVtdxYNpXzWd5jIHGeZs
         C3AT1RFuKFe46p73+B9LWCBQ5uHquZo19P7DAbtp01tQuNcBfob6TEMKnAMDNkb8GyHj
         zSp4R8Lyt1skQ9nRoXyU81cfgxFC9s6mEYrIAA8VMVhN9rqBv1bWybpyShuqDx0kQhcN
         PplKjfBF1EENWh5+9s6LR98Ax+wy+S3246YI7yzCiyTrMm0+qrx00DqwJF5YrhAMkCF4
         tWmg==
X-Gm-Message-State: AOJu0Yz2W4SRTIGnPurZSmHnmzyyus1vCHwD68T2NgslDhcYe3n+hFtt
	Up+CJza1a7dyeUZmSunGXm22Briuxle/U1R+tY39BPNl0Pc97Hg/N6SaxHbcaNHulJO0+SVE9Az
	turF1OHATGLNnRilJeV6X4XDyFGuwCjF9
X-Gm-Gg: ASbGncuqNmu8IKShBkkMp2k209DGMEHgBMLFcjOExjXWDKanTIt5w4B6twVSkn1VmS4
	SLujq/yachWq+1SKqkjIES2iXf1tcaVHcAxO5CfC/8CVAK83TpmAiXf/qRUTl63mbJIYsquD1yG
	PGYoEQfFH9qcJGWR0Xf/nZkr9Gqckrbw8QcJbB013YsLvC99H07sO8pEkTDWw=
X-Google-Smtp-Source: AGHT+IE3zuk37tFvMHRlTuGB9eMhTk6ti9oN5MzAUdhAEetqGOAKpE+yEiAmrz2qvQH9veqgE+2sF99glXX1r8F111E=
X-Received: by 2002:a05:6902:e0f:b0:e60:7d3b:1e18 with SMTP id
 3f1490d57ef6-e694377711dmr2257768276.40.1743037115695; Wed, 26 Mar 2025
 17:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com> <Z-SdYIm_lDvmCcO-@debian.local>
In-Reply-To: <Z-SdYIm_lDvmCcO-@debian.local>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Thu, 27 Mar 2025 00:58:24 +0000
X-Gm-Features: AQ5f1Jq-JpMbTLVMt549o5Y1FwtpkmVt9z4einpWZQEsID5879IMIFH3BN7qVXo
Message-ID: <CAP-bSRYA4sL29+cYE9fF6DHwZPWNA+mpOfMDKTKRpXfsNKUFAg@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 00:35, Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
> Yes, I still see this in 6.14.0 on every suspend/resume with laptop
> Lenovo Legion 7 16ACHg6.

The error happens with S3 suspend. s2idle appears to be ok.

