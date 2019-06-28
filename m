Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC459D60
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF1N5L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:57:11 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:51384 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1N5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:57:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgrNE-0002pi-MB; Fri, 28 Jun 2019 15:57:08 +0200
Message-ID: <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined
 behavior in bit shift
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 15:57:05 +0200
In-Reply-To: <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org> (sfid-20190627_053427_689527_6C7A1CBE)
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
         <20190627032532.18374-4-c0d1n61at3@gmail.com>
         <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
         (sfid-20190627_053427_689527_6C7A1CBE)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-26 at 21:34 -0600, Shuah Khan wrote:
> On 6/26/19 9:25 PM, Jiunn Chang wrote:
> > Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> > significant bit to unsigned.
> > 
> > Changes included in v2:
> >    - use subsystem specific subject lines
> >    - CC required mailing lists
> > 
> > Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> > ---
> 
> Move version change lines here. They don't belong in the commit log.

FWIW, in many cases people (maintainers) now *do* want them in the
commit log. Here, they're just editorial, so agree, but if real
technical changes were made due to reviews, they can indeed be useful.

johannes

