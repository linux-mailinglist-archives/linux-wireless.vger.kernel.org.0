Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE126D7FA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgIQJqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQJqN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 05:46:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215FC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 02:46:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIqUU-005VBH-Es; Thu, 17 Sep 2020 11:46:10 +0200
Message-ID: <23f8106d26ec9122a7ba4cbff60ae28e2c410ce9.camel@sipsolutions.net>
Subject: Re: [RFC 1/1] mac80211_hwsim: fix crash when receiving frame
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 17 Sep 2020 11:46:02 +0200
In-Reply-To: <20200910235707.7732-2-prestwoj@gmail.com> (sfid-20200911_015725_167183_373D4325)
References: <20200910235707.7732-1-prestwoj@gmail.com>
         <20200910235707.7732-2-prestwoj@gmail.com>
         (sfid-20200911_015725_167183_373D4325)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-09-10 at 16:57 -0700, James Prestwood wrote:
> This crash has rarely happened to me on bare metal, but when running
> in a virtual environment it happens much more frequently. It would
> appear that the mac80211_hwsim_data (data2) obtained from
> get_hwsim_data_ref_from_addr() is not fully initialized. When the
> crash happens the 'channel' member (ieee80211_channel*) is NULL. This
> is not checked for and eventually dereferenced which causes the
> segmentation fault.

Seems reasonable to me. I guess data2 is somehow getting packets
delivered but never even started operating.

johannes

