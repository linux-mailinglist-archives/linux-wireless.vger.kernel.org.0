Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F24F0C49
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Apr 2022 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351388AbiDCTWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Apr 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiDCTWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Apr 2022 15:22:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54159338A2
        for <linux-wireless@vger.kernel.org>; Sun,  3 Apr 2022 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kMq7RxIZ5IvBzNT5B7TERb/5ZoCtX7k/xueTrUrO1ug=;
        t=1649013653; x=1650223253; b=j9AJFoyIZ2JVYTiMqFlSqu072kwSKUQJTahNNVkUap4M6DB
        HPdKIbWZv/RXJZwkjo+diozI7Ur0Pf+CEqV3yhyNULXjd1vvpau4s75nnJNJJGfS7+8DE59J9lya8
        r0pGnpxLybwloPVzgv71HXfqsrKqeUUeRIlAueKFLX/WwbcEylnJfUtB6MHMncYSTOwHTPXeVamvW
        UK4+7wOKZ3/4NyT1iiwYDwT2gIBxvUdLQfRxJ6m923FqHlnw3lHABNuE6Gt+GHnouMvug2sWLmC8F
        no5fhvIf8yTW1rw32mzG7aJdEP7sBSaLhlMAAqAZQ69IolUuVt4WLRYWN5V93Neg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nb5mH-004QEy-L7;
        Sun, 03 Apr 2022 21:20:45 +0200
Message-ID: <3e30cdabeb1d1a33f16a41d86f8b660a996a0d0e.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless: Change Kconfig to select WEXT_PRIV
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 03 Apr 2022 21:20:44 +0200
In-Reply-To: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
References: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
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

On Sun, 2022-04-03 at 13:14 -0500, Larry Finger wrote:
> File net/wireless/Kconfig contains two blind configuration variables,
> namely WEXT_PRIV and WEXT_SPY. If those variables are already in the
> configuration file, they will be retained, but there is no way to
> set them if they are missing other than to manually edit .config.
> They should be enabled if either WIRELESS_EXT or CFG80211_WEXT are set
> in the same manner as WEXT_CORE and WEXT_PROC.
> 
> Personally, the setting of WEXT_SPY is not important; however, openSUSE
> and Ubuntu both enable it in their default kernels. Other distros have
> not been checked, but it is likely that they also enable that setting.
> 

They're intentionally this way though - they're only selected by the
(few) drivers that need them.

Yeah, out of tree drivers lose out, but we don't really care?

johannes
