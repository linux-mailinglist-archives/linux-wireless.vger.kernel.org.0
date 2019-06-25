Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2E523CF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 08:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfFYG5G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 02:57:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFYG5G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 02:57:06 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hffNv-0006bS-C5; Tue, 25 Jun 2019 08:56:55 +0200
Date:   Tue, 25 Jun 2019 08:56:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Kalle Valo <kvalo@codeaurora.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20190625163608.1aa15ad3@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1906250856050.32342@nanos.tec.linutronix.de>
References: <20190625160432.533aa140@canb.auug.org.au> <8736jyfaje.fsf@codeaurora.org> <20190625163608.1aa15ad3@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 25 Jun 2019, Stephen Rothwell wrote:

> Hi Kalle,
> 
> On Tue, 25 Jun 2019 09:23:33 +0300 Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Thanks for the report. Any suggestions how to handle this? Or do we let
> > Linus take care of this?
> 
> Just let Linus take care of it ... mention it in the pull request ... I
> guess DaveM needs to know, right?

Ah. I didn't realize that this is a new commit in Kalle's tree. So yes
that's the right thing to do.

Thanks,

	tglx
