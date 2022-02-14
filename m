Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC924B4570
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbiBNJRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 04:17:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiBNJRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 04:17:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A9A606E8
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H3hFWxFo1JZg0rgEYljGhwgXqDGAAibdkEhAbcu6u2I=;
        t=1644830262; x=1646039862; b=O420U03dmXErH124OWKkE68A1xIVBet9se3oca3HKwBf8Gu
        VXJFHX6fkof5VtLH9TaLvIpElBJ6pABsIvnJuT5u2F3H052t0COGAdWu5N0XhZs43KXzeOY1i6fGz
        z9WIe72oEDgmSA3AP+R902dDRPqEgEysLiOv74G/VeblVe2YxcRJ7SwIDSKKVZD46WKzh6moyVAYX
        3qb0dO9GYZxsnlietilh8OFDCDc26fqfoFfc3f+xK1ryyavPGChTWlqLhltGQmX1myVCgxASxRo9O
        ozyuoSa/UNZfjJ79i0bTbiAWNOIWZ4WnAAaf8Lr0VhbhubmSHlBzNsdE9dPLH+FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJXUJ-000tvV-EW;
        Mon, 14 Feb 2022 10:17:39 +0100
Message-ID: <689fcef44a12f33281dccfe35e56859bccd1c058.camel@sipsolutions.net>
Subject: Re: locking in wiphy_apply_custom_regulatory()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 14 Feb 2022 10:17:38 +0100
In-Reply-To: <8c9879f5-fcfc-69e5-5803-e8b5b1fabfd0@broadcom.com>
References: <6562d8c3-27f6-490a-7732-6c300eb3aa64@broadcom.com>
         <a3d73398fa51b66e77d98cf1e883c72b66d6a3f4.camel@sipsolutions.net>
         <8c9879f5-fcfc-69e5-5803-e8b5b1fabfd0@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Mon, 2022-02-14 at 09:45 +0100, Arend van Spriel wrote:
> 
> Correct. Just not sure I understand why is has to be RTNL lock.

Well, does it? Now I forgot again from when I looked ;-)


Surely for nl80211_get_reg_do() for example it has to be, at least
today, though that is already protecting the regdom with RCU in the non-
wiphy case, so doesn't really need to use RTNL.

Similarly, nl80211_get_reg_dump() could use RCU.

So that's easy, but all the interaction e.g. with brcms_reg_notifier()
calling freq_reg_info() which uses it too, but then is called from
wiphy_update_regulatory() from e.g. update_all_wiphy_regulatory() only
with RTNL makes it all complicated ...


> So would wiphy mutex be sufficient. I guess my question is what is 
> protected by these lock in wiphy_apply_custom_regulatory() and is it 
> really necessary to have both.

See above.

Honestly, I wouldn't mind if wiphy mutex (or RCU) _was_ sufficient. But
we're not there, and the regulatory code is sufficiently complex and
called sufficiently infrequently that I just haven't bothered trying to
reduce its reliance on the RTNL.

> Just some experimental coding where I ended up calling 
> wiphy_apply_custom_regulatory() upon IFF_UP and hit deadlock because 
> RTNL was already taken. Anyway, that code already ended up in the 
> garbage bin, but wanted to ask anyway. Learning by asking (stupid) 
> questions ;-)
> 

Given the length and depth I had to go to to answer it, that really
couldn't be a stupid question :)

johannes
