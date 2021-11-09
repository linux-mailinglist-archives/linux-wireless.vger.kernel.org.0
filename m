Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B644A7A8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 08:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKIHk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 02:40:56 -0500
Received: from mx3.wp.pl ([212.77.101.10]:58388 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhKIHkz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 02:40:55 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 02:40:54 EST
Received: (wp-smtpd smtp.wp.pl 20783 invoked from network); 9 Nov 2021 08:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1636443087; bh=Y9jSDG8GSucvN6BUVYfUqMbru52N4/qD0TOZFAHchTU=;
          h=From:To:Cc:Subject;
          b=AwIYFdO0nR23eud+DI/ySXdHZM1l/MntyHP2yQvdR7A3OcbuMqxJ7u7uQ28ZdHkF7
           4n83cvORdqJ9RGw8k8B4K/Jq2oE3ugiU5uJs9HbOlS79/RWqxHJlZxHVlH0GInV7uv
           YkwkWj+p3Hax4DECdc7CQqG2E4Dr1x/vW8V6wVrE=
Received: from 89-64-85-14.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.85.14])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <regressions@leemhuis.info>; 9 Nov 2021 08:31:27 +0100
Date:   Tue, 9 Nov 2021 08:31:27 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        regressions@lists.linux.dev, Kalle Valo <kvalo@codeaurora.org>,
        Exuvo <exuvo@exuvo.se>
Subject: Re: rt2x00 regression
Message-ID: <20211109073127.GA109212@wp.pl>
References: <20190927080303.GA7667@redhat.com>
 <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
 <20191203075736.GA701@redhat.com>
 <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
 <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
 <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
 <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
 <87czop5j33.fsf@tynnyri.adurom.net>
 <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
 <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
X-WP-MailID: eecb398e44ed113b6bed9b16aa1a3176
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [sbIh]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 08, 2021 at 07:00:20PM +0100, Thorsten Leemhuis wrote:
> Sending this again, but this time also to Stanislaw's email address
> currently found in MAINTAINERS.
>
> Stanislaw, can you help with this regression?

Yes. 

I'll check on mail archives what is the status and what can be done.

Stanislaw

> Helmut: or can you help somehow to get things rolling again?
> 
> Ciao, Thorsten, your Linux kernel regression tracker
> 
> On 05.11.21 14:25, Thorsten Leemhuis wrote:
> > Lo, this is your Linux kernel regression tracker speaking.
> > 
> > On 01.10.21 08:56, Kalle Valo wrote:
> >> (adding regressions list for easier tracking)
> > 
> > Thx for this, that's how it got on the radar of regzbot, my Linux kernel
> > regression tracking bot:
> > https://linux-regtracking.leemhuis.info/regzbot/regression/87czop5j33.fsf@tynnyri.adurom.net/
> > 
> > 
> >> Exuvo <exuvo@exuvo.se> writes:
> >>
> >>> I would like to get this resolved, is there any more information you need from me?
> >>>
> >>> I have been manually patching this all year with:
> >>>
> >>> drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> >>> - if (rt2x00dev->num_proto_errs > 8)
> >>> -    return true;
> >>>
> >>> It seems to just be some part of rt2800_load_firmware that is not
> >>> supported on my device and generating errors but it has been running
> >>> without problems in AP mode with daily usage.
> >>
> >> [...]
> >>
> >>>>>>>>> This most likely is the problem introduced by commit:
> >>>>>>>>>
> >>>>>>>>> commit e383c70474db32b9d4a3de6dfbd08784d19e6751
> >>>>>>>>> Author: Stanislaw Gruszka <sgruszka@redhat.com>
> >>>>>>>>> Date:   Tue Mar 12 10:51:42 2019 +0100
> >>>>>>>>>
> >>>>>>>>>      rt2x00: check number of EPROTO errors
> >>>>>>>>>
> >>>>>>>>> Plase check below patch that increase number of EPROTO checks
> >>>>>>>>> before marking device removed. If it does not help, plese
> >>>>>>>>> check if reverting above commits helps.
> >>
> >> Should we do a revert? Can someone submit that including an explanation
> >> of the regression.
> > 
> > Afaics nothing happened since then. Or did I miss anything? How can we
> > get the ball rolling again?
> > 
> > Stanislaw, is there anything Exuvo (who offered to help afaics) could
> > test to get us closer to a fix?
> > 
> > Ciao, Thorsten
> > 
> > P.S.: I have no personal interest in this issue and watch it using
> > regzbot. Hence, feel free to exclude me on further messages in this
> > thread after the first reply, as I'm only posting this mail to hopefully
> > get a status update and things rolling again.
> 
> #regzbot poke
