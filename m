Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83351E57F8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 08:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgE1G4W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 02:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1G4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 02:56:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81822C05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 23:56:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeCSh-004hH3-C6; Thu, 28 May 2020 08:56:19 +0200
Message-ID: <ebb8df2d32f9923d2e180bff9ca0b9a7d650b8bd.camel@sipsolutions.net>
Subject: Re: Potential IBSS race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 08:56:18 +0200
In-Reply-To: <845ab63a2796fa0a4d7042f79268a2e10f87bd99.camel@gmail.com> (sfid-20200528_010646_663816_382F3247)
References: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com>
         (sfid-20200506_174456_293312_214B015A) <b3859a019b965a7a4053c1946a4cde441c0dbc75.camel@sipsolutions.net>
         <845ab63a2796fa0a4d7042f79268a2e10f87bd99.camel@gmail.com>
         (sfid-20200528_010646_663816_382F3247)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-27 at 16:06 -0700, James Prestwood wrote:

> > Maybe that's a better approach - make the merge timer be randomized
> > between 30 and 60 seconds or so, so that they can eventually merge.
> > 
> 
> That sounds good, unfortunately it doesn't really help with our test
> environment since we don't want to wait around for that long... But
> yeah due to how long scanning takes, maybe thats just the way it is.

If you can come up with a better solution, I'm all ears :)

But if your main concern is about the wait in testing, then I suggest
you go to ARCH=um and time-travel=infcpu testing like wpa_supplicant has
done, that was something like a 6x (!) testing speed increase for me.

Since it's all software/hwsim that shouldn't be too difficult.

johannes

