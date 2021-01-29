Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425AA30901E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 23:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhA2Wbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 17:31:47 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:55240 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhA2Wbn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 17:31:43 -0500
Received: from [192.168.254.6] (unknown [50.34.179.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A187F13C2B0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jan 2021 14:31:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A187F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1611959461;
        bh=G+8mWSEunJqWDP7Wyx3OIl4P1sVPD4ZwwEFNZoJb74U=;
        h=To:From:Subject:Date:From;
        b=AW9biwE8G5edbbSCz9I0j7G/XYK6BJqoGvxdBv9HBLBfrJBgEYQ9qHdoeuqqn5IXG
         ovL/ZvalBx63LmE4Xos8Sg9/SIVbcCmgOglQJ7KPgvQBzbYNk/3SkBfksoJNWJRWFy
         jWe2NxQFH5J3t5bwHYE4tALfU36P5jNBEE1LAmGw=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax210: Why no 6E channels valid in regdom?
Organization: Candela Technologies
Message-ID: <3b3b53f6-a974-601f-f136-d685c4841647@candelatech.com>
Date:   Fri, 29 Jan 2021 14:31:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I cannot figure out why my ax210 won't show any 6E channels.  It worked for a bit a few days
ago, but now it does not..and not sure why.  Looks like it uses some internal regdom.

Any idea from these logs what is going on?

  kernel: iwlwifi 0000:0f:00.0: In iwl-mvm-init-mcc, nvm-type: 1  NVM_EXT: 1
  kernel: iwlwifi 0000:0f:00.0: init-fw-regd: r: 0000000000000000
  kernel: iwlwifi 0000:0f:00.0: Getting regdomain data for ZZ from FW
  kernel: iwlwifi 0000:0f:00.0: send MCC update to FW with 'ZZ' src = 16
  kernel: iwlwifi 0000:0f:00.0: MCC response status: 0x1. new MCC: 0x3030 ('00') n_chans: 110
  kernel: iwlwifi 0000:0f:00.0: MCC update response version: 6
  kernel: iwlwifi 0000:0f:00.0: setting alpha2 from FW to 00 (0x30, 0x30) src=7
  kernel: iwlwifi 0000:0f:00.0: Get current regdom: 000000001caad6b5  mcc-supported: 1
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 2484.000 MHz as custom regd has no rule that fits it
....
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5955.000 MHz as custom regd has no rule that fits it
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5975.000 MHz as custom regd has no rule that fits it
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 5995.000 MHz as custom regd has no rule that fits it
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6015.000 MHz as custom regd has no rule that fits it
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6035.000 MHz as custom regd has no rule that fits it
  kernel: cfg80211: d8:f8:83:35:e9:f9: Disabling freq 6055.000 MHz as custom regd has no rule that fits it

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
