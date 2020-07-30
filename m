Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35A233A72
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgG3VWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgG3VWG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:22:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2AC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 14:22:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k1G03-00Dkqx-HU; Thu, 30 Jul 2020 23:22:03 +0200
Message-ID: <54628f052b380e660c37cb9b7c3f224976aa1c83.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/2] nl80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Date:   Thu, 30 Jul 2020 23:22:02 +0200
In-Reply-To: <2b1ea1c4baedcb119f4e632b26399071@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
         <20200618050427.5891-2-alokad@codeaurora.org>
         <c3dbcc3e4ee2d3596625e8c1226325180444a961.camel@sipsolutions.net>
         <2b1ea1c4baedcb119f4e632b26399071@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 14:17 -0700, Aloka Dixit wrote:

> > OTOH, if it's with headers, how could it be optional? In fact, either
> > way, how is it optional?
> > 
> 
> Template has management frame headers as well. Will change the wording 
> accordingly.

OK.

> I made the template optional because FILS discovery may or may not be 
> offloaded to FW.

But how would anyone know? Try without it, and then try again if that
fails? Would it fail? I mean, you also said it was required at least for
6 GHz, so wouldn't userspace be better off always giving it - and then
we should probably make it mandatory so it doesn't fall into the trap?

However - and here that's my ignorance speaking - can it really be
offloaded? I mean, is everything in there completely determined by the
beacon already, and so you have no choice in how to build it? Or how
does that work?

> Yeah, I looked through existing examples for NLA_BINARY, those provide 
> only the higher bound for length.

Yeah, no way to do anything else right now. But you should have a lower
bound in the code, I think.

> But I can modify it to range once that is added.

Later maybe :)

johannes

