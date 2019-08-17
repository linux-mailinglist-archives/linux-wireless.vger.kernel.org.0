Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2318B90F9C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfHQJIq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 05:08:46 -0400
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQJIq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 05:08:46 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Aug 2019 05:08:45 EDT
Received: from spider (unknown [109.63.188.125])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 54DBD1BF45B;
        Sat, 17 Aug 2019 12:00:01 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
To:     Stuart Little <achirvasub@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
In-Reply-To: <20190817041258.GA1641@chirva-slack.chirva-slack>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
Date:   Sat, 17 Aug 2019 11:59:59 +0300
Message-ID: <87y2zsf9ps.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux
> x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config
> attached).
>
> I am using the Intel wifi adapter on this machine:
>
> 02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
>
> with the iwlwifi driver. I am attaching the output to 'lspci -vv -s
> 02:00.0' as the file device-info.
>
> All 5.3.0-rc* versions I have tried (including rc4) cause multiple
> dmesg iwlwifi-related errors (dmesg attached). Examples:
>
> iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
> iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND
>

I have my logs filled with similar garbage throughout 5.3-rc*. Also
since 5.3-rcsomething not only it WARNS in dmesg about firmware failure,
but completely stops working after suspend/resume cycle.

It looks like that:

commit 4fd445a2c855bbcab81fbe06d110e78dbd974a5b
Author: Haim Dreyfuss <haim.dreyfuss@intel.com>
Date:   Thu May 2 11:45:02 2019 +0300

    iwlwifi: mvm: Add log information about SAR status
    
    Inform users when SAR status is changing.
    
    Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>


is the culprit. (manually) reverting it on top of 5.3-rc4 makes
everything work again.
