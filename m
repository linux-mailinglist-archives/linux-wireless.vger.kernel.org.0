Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E9538EE6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 12:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbiEaK3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 06:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiEaK3r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 06:29:47 -0400
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AB9A9BD
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 03:29:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 5922410FE6;
        Tue, 31 May 2022 10:29:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yksIswjC4KIL; Tue, 31 May 2022 10:29:40 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Tue, 31 May 2022 13:29:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1653992980; bh=8ElSHmuLvrxixw5fyWuxpZWSKmxc7jARvKspZTkCjH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZpYlMDt3QrwIOC9w9BreTCwWc4fM1sIEVpF4cQUH9y5CbYKx8e6RuJuDPX14lNoP
         jkx+CskcrqAcPBJBXEC5anxaq7P7CvDWQyiD5WjCcr/LUtMXgLtjBTntLTXR1N0naV
         ErwRIj8PHnq3IgBQkbwLrmDwqQ5lr5FvOVVnxAg9Gp2PuJbSdGfmbEjwbf+rVpl6Xe
         rJrgfwOhXHTaeaHMY491XMLPw6JBa1jq4kGML+aAKzhkFPvAdd2gA0Fb+WP/zu9hsm
         Tv9bQFVE6My0VEsmtK3S26QlE5i4ub+Hi6sovLF+YPdf1Yb5jjgK9I+VZNU0RD0KXn
         9weaWFML6SjPw==
Date:   Tue, 31 May 2022 13:29:38 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     hostap@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: using WPA3 SAE
Message-ID: <20220531102938.GA425760@w1.fi>
References: <18b4d773-a7b4-54a2-4742-a368bf535384@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b4d773-a7b4-54a2-4742-a368bf535384@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 31, 2022 at 10:44:32AM +0200, Arend van Spriel wrote:
> I am trying to get WPA3 SAE working with brcmfmac driver. Actually it was
> Cypress who added support for that in brcmfmac, but for me it fails now
> because wpa_versions bitmask we get from nl80211 indicates only WPA2. I know
> that wpa_supplicant does not make a difference in the config network block,
> but I did not expect that choice to affect nl80211 API usage. Do you
> consider this a bug in driver_nl80211.c? In nl80211 in the kernel we do not
> check wpa_versions versus key management suites so I guess other vendor
> drivers are more lenient.

Why would one need WPA3 indication to be able to use SAE? SAE was
defined in IEEE Std 802.11-2011, i.e., almost ten years before WPA3 was
launched. It worked and still works just fine without WPA3.
WPA3-Personal just happens to be a marketing name for SAE with PMF
enabled. So no, this is certainly not a bug in driver_nl80211.c, but
IMHO, a somewhat strange constraint in a driver to try to prevent SAE
from being used. No driver should place such arbitrary constraints on
being able to use more secure mechanisms.

I don't see much, if any, real use for the NL80211_WPA_VERSION_3 bit in
nl80211 since it should not result in any difference in driver behavior.
SAE can be used without it being called WPA3-Personal and so can PMF.

All that said, if someone really wants to use NL80211_WPA_VERSION_3 for
something, I don't think I would have anything against making
wpa_supplicant add that bit when including the NL80211_ATTR_WPA_VERSIONS
attribute for cases where both SAE and PMF are enabled for a connection.
I would not promote use of this in any driver, though, since it would
just result in issues with older versions of user space components and
there does is no WPA3 specific functionality that would be enabled (or
disabled) based on that bit.

-- 
Jouni Malinen                                            PGP id EFC895FA
