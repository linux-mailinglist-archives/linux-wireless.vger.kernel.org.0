Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41EC2E966C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhADNzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 08:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhADNzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 08:55:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D885C061793
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jan 2021 05:54:41 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kwQJ1-001Vd8-GB; Mon, 04 Jan 2021 14:54:34 +0100
Message-ID: <097b8ea0c643c8372f1a57499969d7a96b1542bd.camel@sipsolutions.net>
Subject: Re: [PATCH mac80211-next] mac80211: introduce aql_enable node in
 debugfs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>, kyan@google.com
Date:   Mon, 04 Jan 2021 14:54:17 +0100
In-Reply-To: <87pn2k4xw1.fsf@toke.dk>
References: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
         <87y2h8525a.fsf@toke.dk>
         <CAJ0CqmVq2+poxg_V6pMCh2CFuqt3dwUW3x6eF=J0ek_uX5k6yQ@mail.gmail.com>
         <87pn2k4xw1.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-01-04 at 14:47 +0100, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 
> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > 
> > > > Introduce aql_enable node in debugfs in order to enable/disable aql.
> > > > This is useful for debugging purpose.
> > > 
> > > Don't mind having a switch, although I wonder if it would be better to
> > > overload the existing debugfs file (e.g., a threshold of 0 could disable
> > > everything?) so as not to clutter up debugfs too much?
> > > 
> > > -Toke
> > > 
> > 
> > You mean to consider 0 as a special value to disable aql, right? I
> > would prefer to have a dedicated switch for it since I guess it is
> > clearer for users (but I can live with it :) )
> 
> Yeah, maybe a bit clearer but at the cost of clutter. I dunno, not a
> strong preference either way; I guess Johannes can make the call :)

I'm not sure I care about an extra debugfs file - but I do wonder about
the extra check at runtime that would basically never be true since the
default is enable ...

Maybe that should use a static_branch() or something?

johannes

