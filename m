Return-Path: <linux-wireless+bounces-20897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B9A7405B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 22:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7053B7EE7
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C61DE2C4;
	Thu, 27 Mar 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZp5UKTq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEE1DD88D
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111400; cv=none; b=hLz917cX2y9OvC9eb6KhpXIRgHJE17lr0qpRrBWrj4Idnm4QOukVf1+eJi6yVBTx1ovgVyeCmzUUTo4gIkz3moz3cVKBSms0/9zDU1RA0RkQkdUTY0sWmSo2cknspD124tfgRp+9t1vdZ7i/1EDzmAmNY+ymb77OZmxhbIvNSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111400; c=relaxed/simple;
	bh=B4RusQme468Z14003zakyKd9kbWDDFzxtd6wF0JXIfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hga17DpoNXVtfKoz4SN2Nlreyn6kyKZqpqbyV5zjnDft0aojaS6+3vO+8zBzKBWsGO4HoU9ugJQaq8kelD23ESp9Qi4LgSppXN0/o8MJXCxJGTUM3SlRFPdbVEKlpNIczl8ARwDFHgKpcSlWHmJ/XqpUB5NSCcJagSjhQfxzUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZp5UKTq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feaa0319d8so11831777b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743111397; x=1743716197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4RusQme468Z14003zakyKd9kbWDDFzxtd6wF0JXIfY=;
        b=UZp5UKTqsCXcrOcgjBfsb3+tjptzEaNq4jrgRbh5NQhS3c30mXjnAQ5APSPNz+VupS
         Y/t0m1y2JfoIegg3yN5TTfsf5Vvjnh7+RIreV8xG7IZcQnc6vqM5v4U6mP1HzoJCJhqh
         wTGGko2RCN474EU5DbFZSPRM+w9xsgZ1/6WnzXFA1qtbOc12QuirSKES9vEwb/wicgAP
         11LaKR9Kt1G8sW46Ypnh0ideODU4Cs5Bx/t6sgqicTIiO8doGSqEYxxVCDh0eb3oXUf4
         foSa0mCkGcu6Q6qLlBX5RfPAJBZTe+j5UNbdHv5Nq3bsKmchQpM+qbc2HjfmRuZtB9BQ
         ubgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743111397; x=1743716197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4RusQme468Z14003zakyKd9kbWDDFzxtd6wF0JXIfY=;
        b=eFRPyfGrZjv5Rk6BhHrfB+eTIaJPv98DEhlk4/8ue5/rxoRtamkavfY5bnJl7duoFF
         9dWH+EwdB1qagr7B3th/iLVF9m6+890JDN8b/vXbUInS3x/luHAK4kmS8AumttwRe9Cf
         Oe3PMagyG6Ofh4xIfGu2g7dCD70vw3s7hIVLZdLw+RlOvfqgfNjQvWpT9c+jzDbusV6L
         HD7j5EKbdbMVWB8wtvtNpux0dublFVoPQ8wXyhe8XQgdoLicIduyyPg704iJFIUFx9wv
         p7AudnrGMPElo8D28RYzgKeVzela+r5fBVsJadE5JtBzl9TzKmxFUpos42LR+YF828z5
         5syw==
X-Gm-Message-State: AOJu0Yzmjz+jDqmOnLK++AmdAuUnR7PaDe2AO/vdiR5pQVq839FUxA1a
	gtGvRcZduyOi748ZYafOWY6S4Ec2tDzJKOr12EFs+OqNjrXtuEgstEX1zPniraIhIsZhCXEyx9H
	r772ZOR2lOBXyXzcKOD6w0T9Fzle05xlq
X-Gm-Gg: ASbGncvir1sNvcXsLINOz9h8Cet1xZOO4sLlSWtDeVbjqCe+pe1v8wkLRdKVqRguXxo
	VKU2vH7I0laL0+zdXpoyX77Y8bKVbQxRFF6nWmHbBq6KxS9zu6APQpX7EVPSntxJ/ld0sNm3aBP
	j+mc1PaSpl9zDI3zsZ/GwTF7Ii8p9SDyC4lSuEVlo6sk/QunRjiGhV1wPG4aI=
X-Google-Smtp-Source: AGHT+IGCmN7dI873IFGJjc15EYQLKaNHIe58obkdCOf2gNVCBKeqKVWfvkjj5P8PoluwzVLADbZP6+bn+4tkzWS+DFM=
X-Received: by 2002:a05:690c:6906:b0:6fe:e76a:53d9 with SMTP id
 00721157ae682-702250bfaedmr69236627b3.28.1743111397296; Thu, 27 Mar 2025
 14:36:37 -0700 (PDT)
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
 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
 <Z-SdYIm_lDvmCcO-@debian.local> <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
 <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
In-Reply-To: <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Thu, 27 Mar 2025 21:36:26 +0000
X-Gm-Features: AQ5f1JrxO-Dg4MvK-4svkStoDaI_k7xrDJyGbOntIVmSxwUU1jxIl7-VPzF4HhU
Message-ID: <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 27 Mar 2025 at 20:31, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
> And here is a new version of the patch.

The patch didn't apply cleanly to v6.14 or mainline master (presumably
it was made from some other repo?), but as it was small I manually
merged the changes. Assuming I did it all correctly, then it looks
good to me. I suspended several times, on resume there was no error
and wifi was still functional.

