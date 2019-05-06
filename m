Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5E14752
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEFJOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 05:14:46 -0400
Received: from 0.ictbs.com ([203.137.112.168]:53975 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEFJOq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 05:14:46 -0400
Received: by hq.local (Postfix, from userid 1000)
        id 5596C66429; Mon,  6 May 2019 11:14:41 +0200 (CEST)
Date:   Mon, 6 May 2019 11:14:41 +0200
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
Message-ID: <20190506091441.wqtccm4n6xxhxom2@localhost>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <87o94gug81.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o94gug81.fsf@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 11:42:06AM +0300, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
> >> @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
> >>   	{}
> >>   };
> >>   +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed,
> >> char safe)
> >> +{
> >> +	while (*dst) {
> >> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
> >
> > At a first look I have no clue what this code is doing and I honestly do not feel
> > like figuring it out, this is clever, but IMHO not readable.
> >
> > Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
> > so that a human can actually see in one look what the code is doing.
> 
> Is there an existing function for sanitising filenames so that we don't
> need to reinvent the wheel, maybe something like isalnum()?

I would definitely prefer to use existing function, but I didn't find
any suitable one. Suggestions are welcome.

As for implementation details, the one I posted was optimized for both
speed and size, and at least in my opinion this bit array driven
parametric implementation is exactly what is needed here (using a string
of allowed characters with strchr-style lookups would bring much worse
complexity, and checking the characters using series of hardcoded if
conditions could quickly grow to more than those 16 bytes used by the
array).

Regards,
v.
