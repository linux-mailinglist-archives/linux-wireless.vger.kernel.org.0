Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED72AE142
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgKJVAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJVAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:00:02 -0500
X-Greylist: delayed 52750 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Nov 2020 12:59:59 PST
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:171:314c::100:a1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2538CC0613D1;
        Tue, 10 Nov 2020 12:59:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1605041997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yygze7HI9YJNXxbkMRM/doJInuQMK3mUGoENwg4pCD8=;
        b=tTN/JXhv5q2ziwyHU7FS5OpwfUH7Xhn4R97x/Y0VUqXCmtbytUU10Bzivi8/1zUO+FY8b/
        QDGIws2JEXpH7eJRgAlr0zJzb9VxFRI8dhodV/Fecx2uYoVvR5LOvoCW7QBuu886o2ypbT
        nGb+poX9GI3jmz7icZG8Fbz/a/i6mo7Kso7mmt7LD4OxhFrOJA/osEi3LywDKseEbdxY2T
        WLkyFGuf7xSdQbMIo1u9Ui2ruWsWVkgX2XolZLGUHbMRhhakH0anSb0x4Am5N79NJ2k+Ik
        JKKk4YzXyFgsDYOdjXnBEqSAb+fvhMM7wEWtmUhlvm2q3ieceaCfV2RVBKER+w==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Crash / Null pointer dereference in l2cap_chan_send()
Message-ID: <20201110205950.GF2423@otheros>
References: <20201110062039.GC2423@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110062039.GC2423@otheros>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 10, 2020 at 07:20:39AM +0100, Linus Lüssing wrote:
> [...]
>
> The issue was introduced with the following commit:
> 
>     f4bfdc5e571e ("iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module parameters")
>     * first affected tag: v5.8-rc1
> 

PS: As this commit mentioned bt_coex_active, I retried with a
vanilla 5.9.6 kernel while leaving bt_coex_active at its
default value. That is leaving it enabled while all previous tests
I did had it disabled.

However I still get the Bluetooth A2DP freeze and subsequent
kernel panics.

Only the warnings in dmesg with
"iwlmvm doesn't allow to disable BT Coex, check bt_coex_active module parameter"
seem to have vanished.


Also, swcrypto is disabled, as it is by default. So the majority
of the lines changed shouldn't affect me.

The only thing that should affect and trigger the crashes for me
seems to be that BT_COEX_NW is now always enabled and that the code
now ignores what I set for the iwlwifi bt_coex_active module parameter.
While before I had it always disabled via the iwlwifi module parameter.
