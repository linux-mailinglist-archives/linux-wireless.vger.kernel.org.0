Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E861E09D2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgEYJPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYJPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:15:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E1C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:15:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9Ck-002bNF-Cy; Mon, 25 May 2020 11:15:30 +0200
Message-ID: <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Julian Calaby <julian.calaby@gmail.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 May 2020 11:15:29 +0200
In-Reply-To: <20200524123931.GA915983@wp.pl> (sfid-20200524_143937_630812_BD080B34)
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
         <20200524111751.GA914918@wp.pl>
         <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
         <20200524123931.GA915983@wp.pl> (sfid-20200524_143937_630812_BD080B34)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-05-24 at 14:39 +0200, Stanislaw Gruszka wrote:
> 
> > And once mac80211 is smart enough to make those decisions, couldn't we
> > just enable MFP by default?

For the record, I don't think we'd really want to add such a thing to
mac80211 ... easier done in the driver.

> If we will have indicator from mac80211 that MFP is configured, we can
> just return -EOPNOTSUPP from rt2x00mac_set_key() for CCMP and that will
> make MFP work without specifying nohwcrypt module parameter - software
> encryption will be used anyway.

Not sure mac80211 really knows? Hmm.

johannes

