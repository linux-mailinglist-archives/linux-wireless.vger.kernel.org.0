Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54B999685
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfHVO1p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 10:27:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:38088 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728903AbfHVO1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 10:27:45 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0o3w-0003NY-Ey; Thu, 22 Aug 2019 17:27:41 +0300
Message-ID: <9c101e4016e73831c92d228ee90689e835a9d7d0.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Chris Clayton <chris2553@googlemail.com>,
        Stuart Little <achirvasub@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Thu, 22 Aug 2019 17:27:39 +0300
In-Reply-To: <5e3ed328-7eea-f112-45d7-4ddee04c4b77@googlemail.com>
References: <fd102579-d83d-b86d-e165-8168c74a4bac@googlemail.com>
         <20190818105530.GA1247@chirva-void>
         <5e3ed328-7eea-f112-45d7-4ddee04c4b77@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-22 at 09:59 +0100, Chris Clayton wrote:
> Thanks, Stuart.
> 
> On 18/08/2019 11:55, Stuart Little wrote:
> > On Sun, Aug 18, 2019 at 09:17:59AM +0100, Chris Clayton wrote:
> > > 
> > > On 17/08/2019 22:44, Stuart Little wrote:
> > > > After some private coaching from Serge Belyshev on git-revert I can confirm that reverting that commit atop the current tree resolves the issue (the wifi card scans for and finds networks just fine, no dmesg errors reported, etc.).
> > > > 
> > > 
> > > I've reported the "Microcode SW error detected" issue too, but, wrongly, only to LKML. I'll point that thread to this
> > > one. I've also been experiencing my network stopping working after suspend resume, but haven't got round to reporting
> > > that yet.
> > > 
> > > What was the git magic that you acquired to revert the patch, please?
> > > 
> 
> By following the advice below, I reverted 4fd445a2c855bbcab81fbe06d110e78dbd974a5b and using the resultant kernel I
> haven't seen the "Microcode SW error detected" again. I am, however, still experiencing the problem of my network not
> working after resume from suspend. I've reported it to LKML, so it can be followed there should anyone need/want to.

FWIW, we're tracking the iwlwifi bug here:

https://bugzilla.kernel.org/show_bug.cgi?id=204151

I'm thinking about how to solve this and will probably have a proper
patch by the end of the week.

--
Cheers,
Luca.

