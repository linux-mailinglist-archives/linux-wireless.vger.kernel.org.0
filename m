Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F651C82E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiEESpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384918AbiEESoK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 14:44:10 -0400
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1914A6A024
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 11:33:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 754EB10F4D;
        Thu,  5 May 2022 18:19:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wsaQWuqafDEb; Thu,  5 May 2022 18:19:19 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 05 May 2022 21:19:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1651774759; bh=tf2aE6rHDorHeFRFBJY7gW5T2f9tqmgWbVFdANAhNcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5c17ivTgkn/ATb/0W/koHioRTV3DRGjk/3ekV2uT2Qo1goyFhkJG008wV2DqtqoS
         JvlQ1FlB390zAv15t7vEAsxIeENN+fy/Pd/QSHgiMll0AYk3ytks5POTjK08zY/hVf
         mjmNKMY38is6oUC1SeVkUhmmdZZ2a+bemJZzCTXXN4O0tn5eG+vVvgix7ECNOmGEMH
         g/+lQWE/XkVuv0cWsWBYkcx8lntRRiL4dNz/0G4nkfD66INZR68JtmgOw9E4ByS2AA
         gNMOCfl5Lu0A3WKjuOFUhfb5Cr1Osr5YWdB95+/YdqdFW0LALcH8EEmK6NcPyKNg7B
         NpWcwHOOXhBJg==
Date:   Thu, 5 May 2022 21:19:17 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] cfg80211: Add support for sending more than two AKMs
 in crypto settings
Message-ID: <20220505181917.GA25102@w1.fi>
References: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
 <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
 <22bf2f78-587d-429b-867f-f73e542018d2@quicinc.com>
 <53062c8fbe3eaaa281f24c4808a15804938c83ef.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53062c8fbe3eaaa281f24c4808a15804938c83ef.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 05, 2022 at 09:18:40AM +0200, Johannes Berg wrote:
> I also came to think - where's the upstream driver using this?

This capability is needed to implement WPA3-Personal transition mode
correctly with any driver that handles roaming internally, i.e., that
advertises NL80211_ATTR_ROAM_SUPPORT (WIPHY_FLAG_SUPPORTS_FW_ROAM). It
looks like there are two such drivers in the upstream tree today: ath6kl
and brcmfmac. Since WPA3 requires PMF, ath6kl is not really a candidate
for the main use for this (having to indicate PSK, PSK-SHA-256, and SAE
AKMs as allowed), but brcmfmac looks like an example that would need
this to allow the local network profile parameters to be set
appropriately to the driver to allow all the desired roaming cases
between BSSs using different AKM suite selectors to be performed.

That said, I do not know whether someone would be planning on using this
additional capability to extend brcmfmac to take benefit of the proposed
extension. I would support this capability in wpa_supplicant, though, so
the information would be available for that purpose.

> I've been saying this for something like a decade now, I think I'll stop
> investing time in such patches.

Do you have any preference on how to address out-of-the-tree driver
needs for this type of functionality? Many cases today can be covered
through the use of vendor specific commands and events, but there are
some inconvenient examples like the Connect command that is not really
straightforward to replace or extend with vendor commands due to the
concept of tracking the user space process associated with the
connection and internal cfg80211 tracking of the connection in general.

If additional nl80211 attributes cannot be accepted into the upstream
tree for such specific needs, could there be some way of allowing
vendor specific attributes to be added into the Connect command? Or
would this need to use some kind of ugly combination of a vendor
specific command first to modify the behavior of the following Connect
command to address this type of needs?

-- 
Jouni Malinen                                            PGP id EFC895FA
