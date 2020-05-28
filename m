Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD291E65BA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404324AbgE1PQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404326AbgE1PQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 11:16:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89BCC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 08:16:38 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w20so8574848pga.6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=JFRtbm8LYiAIcIMNI8ceH82fHITHBbeJL+ltXSq+mlY=;
        b=s9xVJYFA9cRXxnPJ0Pfij57ZZ/HIOTV4w8q88UhJQ6a6RiFCOoJ9w/DfhxWbHOpiQw
         j1mugO9JCf4kJthkJ2skgltlF9t04QUzR4YUi/m++OW/Ujn+/LD+P3UGtzqBEvgDoz6Y
         FiyBdHynfrIjCqXkofqJoTGm/SLZNnH8yL/SH+Meos4UWs9h+gXu76UfUxaqhk6EC52+
         gKNRxl79AVSbb5hOfjdaHCj4mmZzVdGLf6B89Cm+3nA2hci0/mEy08wRt7Vj7fDbKQCi
         CENXADGl/6yUgRAXGokc5ae06rEalDxuC8VmCaPSmJ5e+YMdO2jA7UuZOZatz6erksUl
         yFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JFRtbm8LYiAIcIMNI8ceH82fHITHBbeJL+ltXSq+mlY=;
        b=FGIg2wzK4MKkEIGNSlmDvVBXOtHcIobdXXW9DX6nT/WX4YJuTzlitHqRkD2Zv+49Sv
         oXaiSWAcwnic0iwWpz/Ic8HsZWG2S2miByh/thMjy6r3ZHgXZu7alZEyiia9kJKy98wv
         N1OrHnP6QVjTChEkFwI11sPA9RN0kpLWdBKOj8EPJ4RyBwtQ9d7657dtV6M/uygNWqYw
         KjcX6ruacgezNjyqq5HNeZda79VHiUmVV3k/be6gp1pix1faBn1qHNcjK6yxN0l3RChR
         EmiuPueLskMHvs/G0rC9Z88FwrAbGbIXYowP3o5S+9zXVvtQWSZAPIQWN7QBdk0Nk6yg
         55CQ==
X-Gm-Message-State: AOAM533JWSQfr5IfSiFzhueyw/Ie7l+RnnNLJ1CzrIH0uK0FZXO2eiYH
        YUWaGTmwKc7gGv1F9Rard0iW4StxS94=
X-Google-Smtp-Source: ABdhPJwU95IGdbICZrdW3c4ZK5tfR6LGH1YeNus4uMVYWPX43OexLYaNkBjHI+x/1+Dawp581ykp1w==
X-Received: by 2002:a62:7c94:: with SMTP id x142mr3659849pfc.155.1590678998215;
        Thu, 28 May 2020 08:16:38 -0700 (PDT)
Received: from host-29.home (50-39-160-111.bvtn.or.frontiernet.net. [50.39.160.111])
        by smtp.gmail.com with ESMTPSA id g18sm5023438pfq.146.2020.05.28.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:16:37 -0700 (PDT)
Message-ID: <b69cd02287ac29ab2997811f1539392ceaa883ed.camel@gmail.com>
Subject: Re: Potential IBSS race
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 08:16:36 -0700
In-Reply-To: <ebb8df2d32f9923d2e180bff9ca0b9a7d650b8bd.camel@sipsolutions.net>
References: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com>
         (sfid-20200506_174456_293312_214B015A) <b3859a019b965a7a4053c1946a4cde441c0dbc75.camel@sipsolutions.net>
         <845ab63a2796fa0a4d7042f79268a2e10f87bd99.camel@gmail.com>
         (sfid-20200528_010646_663816_382F3247) <ebb8df2d32f9923d2e180bff9ca0b9a7d650b8bd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 08:56 +0200, Johannes Berg wrote:
> On Wed, 2020-05-27 at 16:06 -0700, James Prestwood wrote:
> 
> > > Maybe that's a better approach - make the merge timer be
> > > randomized
> > > between 30 and 60 seconds or so, so that they can eventually
> > > merge.
> > > 
> > 
> > That sounds good, unfortunately it doesn't really help with our
> > test
> > environment since we don't want to wait around for that long... But
> > yeah due to how long scanning takes, maybe thats just the way it
> > is.
> 
> If you can come up with a better solution, I'm all ears :)
> 
> But if your main concern is about the wait in testing, then I suggest
> you go to ARCH=um and time-travel=infcpu testing like wpa_supplicant
> has
> done, that was something like a 6x (!) testing speed increase for me.

Hmm, I'll play around with this. Sounds promising.

Thanks
> 
> Since it's all software/hwsim that shouldn't be too difficult.
> 
> johannes
> 

