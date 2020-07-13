Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5821E40B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 01:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMX53 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jul 2020 19:57:29 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56872 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMX52 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jul 2020 19:57:28 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 22FC013C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2020 16:57:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 22FC013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1594684648;
        bh=rzbB0GpJXvzZKA5XtWvgLhPpwrGm2LQZ7Hq9FaLM+qo=;
        h=To:From:Subject:Date:From;
        b=f3eub0dOasunYcyBnjgX8UrRK88qLwCmMSOs5QhOIreLSOpsZUZzKeNBBgxUoK6PX
         9uk7xoNuv1dxvFGncSrqutUoq0Yz+rwW3h7K+tzIDSdAg6mWa2DUo5IySD4HMAniq3
         wHLQ5gj+ODrMJPLzlIKGH/FHqyepyrQkL+eHEncc=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200, fw crashes, and sdata-in-driver
Organization: Candela Technologies
Message-ID: <bb23b798-f347-7559-b3dc-d8f713899d26@candelatech.com>
Date:   Mon, 13 Jul 2020 16:57:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I larded up my 5.4 kernel with KASAN and lockdep, and ran some tests.  This is with my
patch that keeps from busy-spinning forever (see previous ignored patch).

After a few restarts and FW crashes, the ax200 could not recover firmware.  There
were lots of sdata-in-driver errors, and then KASAN hit a use-after-free issue
related to ax200 accessing sta object that was previously deleted.

Now, I think I know why:

In the ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
method, it will clear the SDATA_IN_DRIVER flag, and according to comments,
this is run when firmware cannot be recovered.  But, just because FW is
dead does not mean that the driver itself has cleaned up its state.

So question is, should ax200 (and all drivers) be responsible for cleaning
up all state when FW cannot be recovered, or should instead mac80211 do cleanup
in this case by, among other things, not clearing that flag (and probably
not doing the ctx->driver_present = false; config as well)?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
