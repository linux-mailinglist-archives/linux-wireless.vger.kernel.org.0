Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856B418FCA2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 19:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCWSYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 14:24:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42836 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgCWSXw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 14:23:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id t9so8626675qto.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/E2v/x0pD9S4co1rTwzqU5wtimX1Afhqg2gi2bulTI=;
        b=FH2qRmBSbSJZwB+BSXSQMYNKeGdg7FKsSXSb1K9JlVNhBvCRpF35Y1/cWbC8uK2uBj
         sxGBJGFMVlcJsfQa8mZ95ubQaEtjdmQCqtEE3Q92O2nL8F41seejAlpR8I49wXqAeU/B
         eqkpUOGxjScSYfB1LTpqwq4PRjJgwkCS4B5OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/E2v/x0pD9S4co1rTwzqU5wtimX1Afhqg2gi2bulTI=;
        b=YIUSyNQkA3xc1K8BpTZqaAiyoKnk+m1ZwRvQgAlrwqVdLHgqfe4KIt/ujthf9/aZW6
         To1EC/VzVIbqfTq4izsMXj7xbOMX4Pw6lJISS1E3ryPgbIN4Cs7K3F7P2Nw8MmM/+2H0
         80NFiAHr8jHVS8JOMQdaackuPcibsgKKrcVqEj+I7KwZXeWDPUDySCDD7MJBI0ll5EQs
         r1itU0CSZ2N1WEG4m5Pibv8VMb5uQvCuUlBZ2IXc9IVQkUG8NHJwn2ocUTNitPH5tihB
         KjpuSBqECGt809rAqq4k4bnMRYVMdb4MHd4DeeyljVJRY+WicnMucf4DKAt3YAZgksS0
         t35w==
X-Gm-Message-State: ANhLgQ22Qwim7e+ysmV0OB0gN7PqixHeIvDEIrIuYUIk0DHbE2s+lLoa
        GybY/RLlkYwhlwaLGjSAxhwZhA==
X-Google-Smtp-Source: ADFU+vva33T81FQrImBGAaIoEJK5Y8QnH9XQzRThIpIuh9LK6narFxQkMI+JxtK3VLi/dxYocOD3FA==
X-Received: by 2002:ac8:140e:: with SMTP id k14mr22547629qtj.222.1584987830199;
        Mon, 23 Mar 2020 11:23:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 85sm9774863qke.128.2020.03.23.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:23:49 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:23:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org Felipe Balbi" <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Documentation: Clarify better about the rwsem non-owner
 release issue
Message-ID: <20200323182349.GA203600@google.com>
References: <20200322021938.175736-1-joel@joelfernandes.org>
 <87a748khlo.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a748khlo.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 22, 2020 at 08:51:15AM +0200, Kalle Valo wrote:
> "Joel Fernandes (Google)" <joel@joelfernandes.org> writes:
> 
> > Reword and clarify better about the rwsem non-owner release issue.
> >
> > Link: https://lore.kernel.org/linux-pci/20200321212144.GA6475@google.com/
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> There's something wrong with your linux-pci and linux-usb addresses:
> 
> 	"linux-pci@vger.kernel.org Felipe Balbi" <balbi@kernel.org>,
> 
> 
> 	"linux-usb@vger.kernel.org Kalle Valo" <kvalo@codeaurora.org>,

Not sure. It appears fine in the archive. Thomas, let me know if you wanted
me to resend the diff patch. Hopefully it squashed fine into your original
patch.

thanks,

 - Joel

