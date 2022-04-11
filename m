Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC64FBDA4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbiDKNr7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 09:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbiDKNr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 09:47:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85612090
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bn195SmM6LrFCs1RfAPAESaQ3kDGPOl/6T+EIRT1vKo=;
        t=1649684739; x=1650894339; b=tHqTXrqRoNYQHv/EEc9S9y4W/f7u+CPbqOAXFq3jtegeBNa
        6ETYs0KZT7Aoi9yVz9RupX9e6WdtgMqwYjD2ioOF4fsYqe0QE4pPEaG2LYb7Fa7JdadxXVWli3ntA
        EV+eM1hy+ztP9jyUle3r7RT4FgA0r324jUEm1V8fZAmnaUrC62eokl1xqFRPH3voGD1y4EwFr1vhP
        U8BzFkfr4ZwahtVk1i5tyfYtdvYolt5jmrg2iy8W8vunyqN5FplqeUQZ6Wu0oy4zubpvviZvGhcwI
        aikwAzZ3iOD31wZkKzvEpQiErWOFQmo3+5ZVtfkRqQwjX/yn3RnrZ00hlkRFDUcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nduML-008JCd-Bv;
        Mon, 11 Apr 2022 15:45:37 +0200
Message-ID: <cb24c3dfb707fd361a3e64489b8b68e1e3dbaa07.camel@sipsolutions.net>
Subject: Re: [PATCH v3] cfg80211: Handle driver updated MU-EDCA params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, j@w1.fi
Date:   Mon, 11 Apr 2022 15:45:36 +0200
In-Reply-To: <1641512609-29774-1-git-send-email-msinada@codeaurora.org>
References: <1641512609-29774-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-01-06 at 15:43 -0800, Muna Sinada wrote:
> Add necessary functions and attributes to receive updated MU-EDCA
> parameters from driver and send to user space, where management
> frame are updated to reflect latest parameters.
> 
> The updated parameters from driver are part of an AP mode feature
> where firmware determines better MU-EDCA parameters based on channel
> conditions. The updated parameters are used and reported to user space
> to reflect in AP management frames. These dynamic parameter updates
> are offloaded to firmware for better user experience, thus details on
> algorithm are not provided. This is a driver specific feature, thus
> no IEEE80211 spec references.
> 

So, I think this is missing tracing? Earlier I thought you had it, but
that was in mac80211 -- I thought you had both so I said you can remove
it, but it looks like you should have it in cfg80211 perhaps.

More importantly though, shouldn't we have some kind of opt-in flag, so
userspace actually can tell the driver that it's willing to accept this?
As it is, the driver might update it without userspace ever reacting,
since this needs a corresponding hostapd change. Wouldn't this cause
problems? Do you really not care at all about any users who might be
running a slightly older version of hostapd? So maybe hostapd should set
an attribute (even this one as a flag) somewhere to opt in to receiving
this, and thereby promising it will use it?

johannes
