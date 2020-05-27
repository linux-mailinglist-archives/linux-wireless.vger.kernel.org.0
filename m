Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDC1E518C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgE0XDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 19:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0XDK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 19:03:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45777C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 16:03:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s10so12506918pgm.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ogkqcSPy5IlSjPS3hOSX36RQH4o28bWo+xGTfO0S/eU=;
        b=I+tizfElCG0BqhiT/p+kJSP+zDyvwrmqhRNIzjLTZLh5oCfFdG/6aq3UAGZkolG/qx
         roN3IM4Tex9rrfGT8zMbauCsOEz3/4yCDleDGT84Rf31qYZu5JiAHraUx3YzTuhrsdNu
         m1+vBauIcIhYeR0iJqB76G22DLU5QPPA7GWvFi1tYaQQWcCJRDzF/s7Jebji427DhA0F
         9EJZVkhipqymjmpcELc9kuRJDhY2pIRDtZS8qQaN712UaaGmsWtCq1peaReTuBn9oETH
         iYGJO7dQwXqSiTlTLhD4MEtTYhlv8a7RpE8TWS+jMsb09wat/h+/8wVxwlRMj68W0kuI
         DYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ogkqcSPy5IlSjPS3hOSX36RQH4o28bWo+xGTfO0S/eU=;
        b=MHSNdj4J3bWygTBEdF9CnU19PmLU3UYhQ9DarmHXK6Ys4/cByHN7Zr1tZfSVvyqKIi
         xBAcb2DfKi82a92XHyC5KfvuOoc7gHV/aHD88Lubt0ncT+DBZ0eTtNFvD4D+/K3UnXgC
         ULKssGuslPBtEA5zalElLk9quteCixv2zY+5dvoubnGLlNtALcknjKTWdE1/PiSVfjx/
         bYYpxxxbOtWELcWb6s5ZahQL+uN9YdMxlXD4qTVMBpAAACIQvldr2caY7aV6F41pKTF1
         TwuGl6xGb3OVm0n0KaNsM/1wET2nMAUTv06n4wbDI8nUKXJ8x2Qwa8k05Q30ksU4V1Nv
         OXGQ==
X-Gm-Message-State: AOAM530dMRkdBiktkK/2bsz46MVCR6iqPCWROAvbaPWf7CS+XXl/7TSL
        Nz5QtWXwCe89rpvGW08Sb/XhK6+zcy4=
X-Google-Smtp-Source: ABdhPJymEmfTF+7fPb57kILXqv5TdEQNyUPjicJrbN0uY4Oz4l+9CI8fDUbjUeRrC83uN2eIAxFKaA==
X-Received: by 2002:a63:d652:: with SMTP id d18mr94980pgj.164.1590620589787;
        Wed, 27 May 2020 16:03:09 -0700 (PDT)
Received: from host-29.home (50-39-160-111.bvtn.or.frontiernet.net. [50.39.160.111])
        by smtp.gmail.com with ESMTPSA id b16sm166991pfd.111.2020.05.27.16.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:03:09 -0700 (PDT)
Message-ID: <967e9193bc7d6573c4f0226e5801f2aeed92dc1c.camel@gmail.com>
Subject: Re: Auth/Assoc/Connect events coming before CMD_CONNECT response
 (hwsim)
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 27 May 2020 16:03:08 -0700
In-Reply-To: <68be99836859c4216a667e5784ed0e519cc1143c.camel@sipsolutions.net>
References: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
         <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
         <CAPv5Ue4Cp=Eeo+xy1K0CRz-AC3p-tUnEuRjuL1dyt0yiKhpwpA@mail.gmail.com>
         (sfid-20200501_193303_702944_53D89397) <68be99836859c4216a667e5784ed0e519cc1143c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HiJohannes,

On Tue, 2020-05-26 at 14:38 +0200, Johannes Berg wrote:
> Hi James,
> 
> > > I guess you could "fix" that by running with wmediumd?
> > 
> > We do run with wmediumd, although I hadn't looking into this much.
> 
> Well, I was sort of assuming that even just running wmediumd would
> introduce the latency of another userspace roundtrip, and, perhaps
> more
> importantly, disconnect the code paths.
> 
> I didn't really think you need any additional delay, and yes, I don't
> think wmediumd supports adding additional delay, but it does add its
> own
> fake medium acquisition delay.
> 
> So maybe that means my theory was wrong?

I was actually incorrect thinking we used wmediumd, we don't :) We have
our own hwsim thing that is effectively taking the place of wmediumd.
And with this I added a very small delay to resending out the frames
and it totally fixed the issue.

Thanks,
James
> 
> johannes
> 

