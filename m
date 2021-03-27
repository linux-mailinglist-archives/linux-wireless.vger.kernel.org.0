Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432F34B34D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 01:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC0ASX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 20:18:23 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:55322 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhC0ASV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 20:18:21 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 024D013C2B6
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 17:18:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 024D013C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616804301;
        bh=hH4187S/wxKrgwSqwzxsSmTMZQntOJ7JhwSPOtLM9Wo=;
        h=To:From:Subject:Date:From;
        b=gMZN/OEwCje1j1g94Fs66e4fZ/inoafyx+DirafI2Q9ClfkYY1vNooudEpLpCUowq
         pWiUl1AqXO+U3pgqLJxxUu8qHblkaZx7vJUcMSXBj1bDtDKd5+gQyWcOtmeQEnw+CP
         JUU5bpyRr6l/f9BEHPNRBdbVTuRgIGlaLMMZQESg=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: mac80211 mlme connection probing woes
Organization: Candela Technologies
Message-ID: <312fa32e-21f7-fcc0-fef4-55633db53f65@candelatech.com>
Date:   Fri, 26 Mar 2021 17:18:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've been digging into a bug where our ath10k driver shows periodic
throughput drops on regular intervals.  We've bisected this down to a patch
where we disable the firmware connection monitor, and so ask mac80211 to
do the connection monitor.

This works fine in 5.4 kernel, but in 5.11, it does not work well.

First, if anyone has an idea what change might have caused this,
please let me know.  We will try with ath9k, assuming it uses
the mac80211 connection monitor to see if it has the same issue.

And second, if a STA is doing traffic that is passing to/from the AP,
why probe the connection at all?  We get tx status showing success, and also valid
rx packets from AP, shouldn't that cause the probe timer to
defer?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
