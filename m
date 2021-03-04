Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2032CE66
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhCDI1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 03:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhCDI0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 03:26:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D35C061756
        for <linux-wireless@vger.kernel.org>; Thu,  4 Mar 2021 00:26:10 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lHjJA-00BXy0-Am; Thu, 04 Mar 2021 09:26:08 +0100
Message-ID: <c4ad2ef0c110fd038a82ff5b38bee42bc1a1a254.camel@sipsolutions.net>
Subject: Re: bridge mac80211_hwsim AP to internet?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Joshua Zhao <swzhao@gmail.com>, linux-wireless@vger.kernel.org
Date:   Thu, 04 Mar 2021 09:26:07 +0100
In-Reply-To: <CAKmTU=qZUm5T=nOMT-4cpJekKevLETwxY07CDe00iwLxkMpJGQ@mail.gmail.com> (sfid-20210304_021016_482226_92E625AC)
References: <CAKmTU=qZUm5T=nOMT-4cpJekKevLETwxY07CDe00iwLxkMpJGQ@mail.gmail.com>
         (sfid-20210304_021016_482226_92E625AC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-03 at 16:06 -0800, Joshua Zhao wrote:
> Hi,
> I'm using mac80211_hwsim to simulate a virtual STA and a virtual AP.
> How can I bridge the virtual AP to a backhaul link on my PC (e.g. a
> physical ethernet link) for real internet connection? i.e. so that my
> virtual STA can access the internet.  The AP could be configured in
> NAT mode or layer-2 bridge mode. Is it possible/supported?

Just like on a normal AP? Create a bridge interface (e.g. brctl) and add
the AP and backhaul interface to it. Use IP assignment etc. on the
bridge and configure hostapd accordingly to know about it.

johannes

