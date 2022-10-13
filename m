Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0F5FD751
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJMJsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJMJsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 05:48:50 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 02:48:47 PDT
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA35104531
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 02:48:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 29A4211081;
        Thu, 13 Oct 2022 09:40:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P4hGrlAu7TeB; Thu, 13 Oct 2022 09:40:13 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 13 Oct 2022 12:40:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1665654013; bh=dAY4PuMFxGvl0E5R/dwh6VNQ2jkSDY74WFM6hyO7iug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okuhBH3Ed6F0DgR+NFkzQYHqbIRisp5sTsskswS2gGZuaZkpLAwfXr8yvGLRYm04P
         RHWd/xQtmmJ2ENmeWbBlIMo5F3gGPBtdqpfZy5r3L3QQDIvSb5p9l6pxEF3+tSdkV+
         T+iUQ2Kl6CgLPo9lug1ionmUY8s6oTiKt3nhuekB1Q/LQyUfwzkjo0Y0noFKbysq8B
         nLwbnVoQAzjNlsx6M67XIyBZnddD5S3sRcL96yqneSEBxfP1G/QrKoYIQ4Zq0rpKd1
         lptKBebKpKmVgsB23MBKZsFBCa2MWkHsiJYpx58Hu3LbITAbH1wg5Mo+YQcxKlb79L
         ACEi1q2Qj33/g==
Date:   Thu, 13 Oct 2022 12:40:11 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ajay.Kathat@microchip.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, lkp@intel.com,
        hostap@lists.infradead.org
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse
 warning
Message-ID: <20221013094011.GB3862@w1.fi>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
 <87v8rik8vp.fsf@kernel.org>
 <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
 <e677e3cd1b5c34146017a65f28fabdb673a91d23.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e677e3cd1b5c34146017a65f28fabdb673a91d23.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 13, 2022 at 09:39:56AM +0200, Johannes Berg wrote:
> On Wed, 2022-07-27 at 17:32 +0000, Ajay.Kathat@microchip.com wrote:
> > I think, there is an another way to handle this issue. 'key_mgmt_suite' 
> > element in 'cfg80211_external_auth_params' struct should be converted to 
> > '__be32' type(like below code snippet) because wpa_s expects the value 
> > in big-endian format . After this change, the type case can be avoided. 
> > Though I am not sure if these changes can have impact on other driver.
> > 
> 
> Ugh. I think maybe it would be better to fix wpa_supplicant?

Assuming you are referring to what sme_external_auth_trigger() does,
yes, the use of RSN_SELECTOR_GET() there on an unsigned int variable is
clearly wrong. As a workaround, it could be modified to accept both the
big endian and host byte order since the risk of conflicting with a
vendor specific AKM suite here would be very minimal.. Furthermore, it
looks like this has missed the new RSN_AUTH_KEY_MGMT_SAE_EXT_KEY
selector update as well.

> Thing is, we use the NL80211_ATTR_AKM_SUITES attribute here for it, and
> even wpa_supplicant mostly uses that in host endian:

By the way, that use of a u32 attribute (or an array of such) in an
interface is quite confusing for suite selectors (both AKM and cipher)
since a suite selector is really a four octet binary string that starts
with three octet OUI that is followed with a single octet integer
value. nl80211.h does not seem to provide any documentation on what the
exact value is supposed to be.

I can understand use of u32 and native byte order as an implementation
internal thing, but it should not really be used in an interface since
it is just waiting for this type of issues to show up. It's always
confusing to review the driver_nl80211* changes for this area since I
have to convince myself each time that this really is a native byte
order u32 value.. That sme_external_auth_trigger() case is outside
driver_nl80211* so it did not get the same detail of review
unfortunately.

-- 
Jouni Malinen                                            PGP id EFC895FA
