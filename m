Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C359E9E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1PRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 11:17:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53360 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfF1PRe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 11:17:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgsd2-0004T1-MI; Fri, 28 Jun 2019 17:17:32 +0200
Message-ID: <b5a247aa3bb21094c0a6ef1d8e3281d701bb6200.camel@sipsolutions.net>
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined
 behavior in bit shift
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 17:17:30 +0200
In-Reply-To: <9e17c585-bd42-8c65-a37a-add6aa4d5ca4@linuxfoundation.org> (sfid-20190628_170419_565002_8FFEF936)
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
         <20190627032532.18374-4-c0d1n61at3@gmail.com>
         <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
         <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
         <9e17c585-bd42-8c65-a37a-add6aa4d5ca4@linuxfoundation.org>
         (sfid-20190628_170419_565002_8FFEF936)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Shuah,

> I went looking in the git log. Looks like there are several commits with
> "Changes since" included in the commit log. It still appears to be
> maintainer preference. Probably from networking and networking related
> areas - wireless being one of them. This trend is recent it appears in
> any case.

Yeah. I was really just observing that I'd seen this, and some people (I
guess 'many' was an exaggeration) actively request it to be in the
commit log. I "grew up" with "changelog after ---" too ;-)

> There is a value to seeing changes as the work evolves. However, there
> is the concern that how log should it be.

That doesn't parse, what did you mean?

> This example commit has history from RFC stage and no doubt very useful
> since this is a new driver.
> 
> 8ef988b914bd449458eb2174febb67b0f137b33c
> 
> If we make this more of a norm, we do want to make sure, we evolve
> from informal nature of these "Changes since", to "Commit log" text.

Not sure it's really worth it, but I guess some recommendations could be
useful. If it is indeed to become the norm, and there aren't some people
who strongly feel it should *not* be included.

johannes

