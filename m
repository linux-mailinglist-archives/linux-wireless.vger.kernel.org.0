Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56C18FE7A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 21:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWUMn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 16:12:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54748 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 16:12:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGTRA-0038Ao-RY; Mon, 23 Mar 2020 21:12:41 +0100
Message-ID: <e7ac13b53f3bf77e1ec786496200013aa9602d9e.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] wmediumd: don't treat management frames as noack
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 21:12:39 +0100
In-Reply-To: <20200323190831.GB5207@bobcopeland.com> (sfid-20200323_200835_774964_1437A415)
References: <20200323152542.68696-1-johannes@sipsolutions.net>
         <20200323162245.19716cc94db4.Ib4a8bb12802840a3b9ed7e2e9ca1748a4e77e6ee@changeid>
         <20200323190831.GB5207@bobcopeland.com>
         (sfid-20200323_200835_774964_1437A415)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-03-23 at 15:08 -0400, Bob Copeland wrote:
> On Mon, Mar 23, 2020 at 04:25:42PM +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > It's incorrect to treat management frames as noack, they're
> > retransmitted just like any other frame; fix this.
> 
> I think it was just a hack to make mesh paths establish even
> if snr was terrible, obviously not realistic.  Thanks!

But wouldn't it be the other way around, i.e. they're *less* likely to
be established without retries (noack)?

Anyway, doesn't really matter, just caught my eye there the other day :)

johannes

