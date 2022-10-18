Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCF6034A1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJRVKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRVKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:10:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3CA4E422;
        Tue, 18 Oct 2022 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666127411; x=1697663411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0qr5y5RO8+qSe873oiemwL8NkKjsYL7al2DaasvpX4=;
  b=Rzq0Ud5qU7AADB+0/U1i2p5weOvPyaZQy99Scc+0oa01889r62NlpA0y
   q7nXUqoukPulbZIo35R8YpOJIne8m5fxZS8j54wuUX8bdlJASdpk/B5uS
   vB81TBdh5zGQBuYBTfOk1aFm+rE/n4eJstVbGdZvjd+5XFrC6jjuFSnkL
   p1OJCIfB3yvOmvLT7BEDeSr1YOXpBDwfR7DwHZeKKf6aiEVQVAg+VtfP1
   QP/Qmj2Fq9glFFs8OFWHTxTGrL4w7OyBm5dgFZ5Csp4JgiFM72zHbedh+
   UDk0kveqCr8H38hS3pMo1B3j2RaoMhkLMfwMKBG+sRUieq1v2dBAVHghN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306221533"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306221533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 14:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662108042"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="662108042"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2022 14:10:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oktqh-009Ydm-1s;
        Wed, 19 Oct 2022 00:10:07 +0300
Date:   Wed, 19 Oct 2022 00:10:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: rt2x00: use explicitly signed type for clamping
Message-ID: <Y08WL6kcTH4uehHx@smile.fi.intel.com>
References: <202210190108.ESC3pc3D-lkp@intel.com>
 <20221018202734.140489-1-Jason@zx2c4.com>
 <Y08PVnsTw75sHfbg@smile.fi.intel.com>
 <Y08SGz/xGSN87ynk@zx2c4.com>
 <Y08TQwcY3zL3kGHR@smile.fi.intel.com>
 <CAHmME9qQAqXYR0+K=32otECgrni51Z0c38iO3h1VRM4Xf3o2=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qQAqXYR0+K=32otECgrni51Z0c38iO3h1VRM4Xf3o2=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 18, 2022 at 02:58:30PM -0600, Jason A. Donenfeld wrote:
> On Tue, Oct 18, 2022 at 2:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 18, 2022 at 02:52:43PM -0600, Jason A. Donenfeld wrote:
> > > On Tue, Oct 18, 2022 at 11:40:54PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 18, 2022 at 02:27:34PM -0600, Jason A. Donenfeld wrote:
> > > > > On some platforms, `char` is unsigned, which makes casting -7 to char
> > > > > overflow, which in turn makes the clamping operation bogus. Instead,
> > > > > deal with an explicit `s8` type, so that the comparison is always
> > > > > signed, and return an s8 result from the function as well. Note that
> > > > > this function's result is assigned to a `short`, which is always signed.
> > > >
> > > > Why not to use short? See my patch I just sent.
> > >
> > > Trying to have the most minimal change here that doesn't rock the boat.
> > > I'm not out to rewrite the driver. I don't know the original author's
> > > rationales. This patch here is correct and will generate the same code
> > > as before on architectures where it wasn't broken.
> > >
> > > However, if you want your "change the codegen" patch to be taken
> > > seriously, you should probably send it to the wireless maintainers like
> > > this one, and they can decide. Personally, I don't really care either
> > > way.
> >
> > I have checked the code paths there and I found no evidence that short can't be
> > used. That's why my patch.
> 
> Do you have a rationale why you want to change codegen?

It's not a hot path as far as I understand and keeping data types aligned seems
to me worth it even if codegen is changed. IS it so awful with short?

-- 
With Best Regards,
Andy Shevchenko


