Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A042704E7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRTTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 15:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 15:19:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B32C0613CE
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 12:19:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJLuv-006RSl-OJ; Fri, 18 Sep 2020 21:19:33 +0200
Message-ID: <8a3380b3d3f12610e8cf4c6d51f5a33fed7b85c6.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: support HE rate configuration in 6 GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 21:19:32 +0200
In-Reply-To: <fe2b37ecbe10eb1ceb2b25eaabb76efa@codeaurora.org>
References: <1600276451-3259-1-git-send-email-rmanohar@codeaurora.org>
         <cff3474685590bbc9663f970bb0a4a10143d3913.camel@sipsolutions.net>
         <fe2b37ecbe10eb1ceb2b25eaabb76efa@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-18 at 11:49 -0700, Rajkumar Manoharan wrote:
> On 2020-09-18 04:25, Johannes Berg wrote:
> > On Wed, 2020-09-16 at 10:14 -0700, Rajkumar Manoharan wrote:
> > > Allow HE-MCS, HE-GI, HE-LTF in 6 GHz band as well and allow only
> > > MCS rates in 6 GHz.
> > 
> > This doesn't apply at all, please respin.
> > 
> My bad. Forgot to mention that this change depends on "iw: add HE 
> rate/gi/ltf support".
> 
> https://patchwork.kernel.org/patch/11364395/

Oh. But can I apply that? I think the kernel bits weren't there? But I
get confused with John's patch series'...

johannes

