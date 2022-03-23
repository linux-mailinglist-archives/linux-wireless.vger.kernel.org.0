Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0614E532E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbiCWNgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244298AbiCWNgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:36:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ADB1F616
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yLfh/bdmlUuRZmCWl0lmrZk5wAcGoK5FerC5+CqDlAI=;
        t=1648042519; x=1649252119; b=pnVcYwl6S0A0eRkt8MXoSVVSKjqvj/qXOfyt6+S2h9F0Wwv
        CqC6QbGw2Kh/TdDiAwQFUGnu9wYZezxNmQ+s2wCgeuIHn1YlI0WJyUiswqvRm5TJ2T90Ro6RTWANi
        KM6hs6blz5hAs0KIUoxunARcrWVm0BRM9xsn1Po1xWbjN5ygSUtJkPXZHeAL0zCuSDjYHeYnaZqKf
        KnJT2IuA7rbHNXFDnRvXwJfHUU1qn/AU6GfcGJixeBZT1w3OqQ7VgT8g2FzlR9IUFBfSqxXnphSQw
        HEsfb+X1KPNABYvq0wogU8MCLewvm81Nwb6X9IM4fWedcEo8VxJGbirGqCp5FGNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX18v-00H6F3-CT;
        Wed, 23 Mar 2022 14:35:17 +0100
Message-ID: <dde1f3a29b7da55697cfaca58565458766f74209.camel@sipsolutions.net>
Subject: Re: iwlwifi: Beacon frame injection at higher modulation in kernel
 5.13+?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kevin Kellar <kevin.kellar@flyzipline.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 23 Mar 2022 14:35:16 +0100
In-Reply-To: <CAJyMcLWcoCAHOmoNUT2=oVUWj7Lj5R1O-57KNX_5VXHfBr91OQ@mail.gmail.com>
References: <CAJyMcLWcoCAHOmoNUT2=oVUWj7Lj5R1O-57KNX_5VXHfBr91OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

On Mon, 2022-01-31 at 17:26 -0800, Kevin Kellar wrote:
> 
> Would anyone here be able to weigh in on:
> If frame injection while the interface is in monitor mode is supported
> by the iwlwifi driver

Kind of.

> Whether the iwlwifi team intentionally limits supported
> modulations/datarates for injected frames to be 802.11b 1Mb/s

Not really, but there's no code to handle it otherwise I guess, and
given how rate control works that's not really trivial.

> Whether injection at 802.11n MCSs is supported by Intel wireless
> device firmware, and if we could use this feature through the iwlwifi
> driver.
> 

Yes that should work in firmware, just need to set the rate into the TX
command (rate from command, not rate from STA LQ table)

johannes
