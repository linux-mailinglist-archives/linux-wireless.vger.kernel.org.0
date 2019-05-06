Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B810C14B7F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFOGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 10:06:39 -0400
Received: from 0.ictbs.com ([203.137.112.168]:36262 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFOGi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 10:06:38 -0400
Received: by hq.local (Postfix, from userid 1000)
        id 20DD366429; Mon,  6 May 2019 16:06:30 +0200 (CEST)
Date:   Mon, 6 May 2019 16:06:30 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
Message-ID: <20190506140629.2swl35wzkves4h2v@localhost>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <87o94gug81.fsf@codeaurora.org>
 <20190506091441.wqtccm4n6xxhxom2@localhost>
 <878svjvk9q.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878svjvk9q.fsf@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 03:29:21PM +0300, Kalle Valo wrote:
> Victor Bravo <1905@spmblk.com> writes:
> 
> > On Mon, May 06, 2019 at 11:42:06AM +0300, Kalle Valo wrote:
> >> Hans de Goede <hdegoede@redhat.com> writes:
> >> 
> >> >> @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
> >> >>   	{}
> >> >>   };
> >> >>   +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed,
> >> >> char safe)
> >> >> +{
> >> >> +	while (*dst) {
> >> >> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
> >> >
> >> > At a first look I have no clue what this code is doing and I honestly do not feel
> >> > like figuring it out, this is clever, but IMHO not readable.
> >> >
> >> > Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
> >> > so that a human can actually see in one look what the code is doing.
> >> 
> >> Is there an existing function for sanitising filenames so that we don't
> >> need to reinvent the wheel, maybe something like isalnum()?
> >
> > I would definitely prefer to use existing function, but I didn't find
> > any suitable one. Suggestions are welcome.
> 
> I didn't find anything either, but hopefully someone knows.
> 
> > As for implementation details, the one I posted was optimized for both
> > speed and size, and at least in my opinion this bit array driven
> > parametric implementation is exactly what is needed here (using a string
> > of allowed characters with strchr-style lookups would bring much worse
> > complexity, and checking the characters using series of hardcoded if
> > conditions could quickly grow to more than those 16 bytes used by the
> > array).
> 
> But is this really something which should be optimised? This is driver
> initialisation, not in some hot path, right? Can you even measure the
> difference?

I didn't measure it, but according to my understanding of "Linux Kernel
Contributor Covenant Code of Conduct Interpretation" this actually
seems to be right according to "everyone involved wants to see the best
possible solution for the overall success of Linux" (but it also depends
on defintion of "best possible" of course).

Honestly, my exact thought behind this was that switch() or if
conditions shouldn't be used here (except simple case handling few
characters) because of above rule.

I also definitely want to avoid reinventing the wheel or even having
duplicate code in the kernel, so I tried to write the routine in a way
that allows it to be used as kernel library function usable in any
driver unless we manage to find existing wheel of similar parameters
elsewhere. That's why allowed and safe are passed as arguments even if
they are available as global varible / macro.

The bitmask approach also still seems useful as it allows to easily
handle any set of allowed characters, while it seems that the set
of unwanted characters may be extended to even more than my patch
handles.

So *in case no suitable existing sanitizing function is found*, the
approach IMHO might be also

1) fine-tuning this kind of sanitizing routine and making it a kernel
"library" function outside the driver, possibly with some useful macros
- e.g. parametric macro to check whether a value is present in a set
(which could also help to make this check more readable as suggested by
Hans), and I would also really like a macro for compile-time initializon
of the bit array from string literal containing allowed characters
(which unfortunately doesn't seem possible in C yet).

2) having only brcmf_dmi_allowed_chars and BRCMF_DMI_SAFE_CHAR in the
driver and use these with the "library" function.

Unfortunately I'm new to kernel development and have no clue whether
it's a good idea to start with such a function inside driver and
eventually moving it later, or start with getting the function in final
location first and delay driver modificatios until it's ready.

Regards,
v.
