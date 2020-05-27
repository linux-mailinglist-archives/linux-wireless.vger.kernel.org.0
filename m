Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994791E4D5D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgE0Srg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgE0Srg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E06C008637
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 11:41:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1je0za-004Lve-5a; Wed, 27 May 2020 20:41:30 +0200
Message-ID: <5f32a7d8b256fbf9f17172e86a4c18325fc67f5c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Date:   Wed, 27 May 2020 20:41:29 +0200
In-Reply-To: <61b5ee51619e8cc676e644bb25463d3b@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-10-git-send-email-rmanohar@codeaurora.org>
         <74232fe9a140a15306c04f0509e6c615b8e329de.camel@sipsolutions.net>
         (sfid-20200527_164156_614875_57253EF5) <6383af0eec17c942c20361d237c298f8a8ceaa54.camel@sipsolutions.net>
         <61b5ee51619e8cc676e644bb25463d3b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 11:34 -0700, Rajkumar Manoharan wrote:
> On 2020-05-27 07:44, Johannes Berg wrote:
> > Oh, that was the last patch, ok.
> > 
> > So let's hear what you want to say regarding my comments - but please
> > don't respin.
> > 
> > I will put some order into our patches tomorrow and post them, or
> > perhaps better, post a combined series of yours and mine.
> > 
> > Sounds OK?
> > 
> Sounds great. There is one more followup patch I posted later. Sorry for 
> that..
> This is needed to propagate HE 6 GHz cap to user space.
> 
> https://patchwork.kernel.org/patch/11569921/

Oh right, I saw that, just hadn't really looked at it yet.

> As you aware that the related hostapd series were submitted.
> 
> http://patchwork.ozlabs.org/project/hostap/list/?series=179527

Yeah, haven't looked either.

Thanks!

johannes

