Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC34A90B0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiBCWaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 17:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBCWaN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 17:30:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A7C061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Mx8vWjRGtc80e95/oiodIL/Pzm0TxSGQlREvqurz1zk=;
        t=1643927413; x=1645137013; b=XAx+vvY1OvOHv5kTvCcVfeBGn813NAdtEcHuxZFRjc+fRYG
        goZN+uS+mS6/RmSzKelxBZGEnxRbvL9mrGBa+lixYlMkI8u1UcKmwGhQ31y5p5biV2uA5lwU3eZen
        NR5bnVaUa5+1mvxolfUc1x4jGOnEnTav+Bc8O3qJoHelH5nP7oz2LQfPQxtOtcR8+NBO0zEN95yrC
        EIIn0TPafwNiRCXWmlwJN395BOz5Bex2+J+TlPixY5kJyDXbMg0B7wI9Hj9egM4//sC90TGZQqoGD
        qyvJC8Rorj7+SlYL8a4nsk87HekgxMK9I6kesx6lvnitn8YhrrXsJe7eWc0ARbzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFkcC-00EG60-Sf;
        Thu, 03 Feb 2022 23:30:09 +0100
Message-ID: <0848f5eba90a2125425da52b6b5f6f47ba9d6630.camel@sipsolutions.net>
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 03 Feb 2022 23:30:07 +0100
In-Reply-To: <cedc93ef-496f-a403-0089-b2a82477fe0f@green-communications.fr>
References: <20201129153055.1971298-1-luca@coelho.fi>
         <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
         <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
         <87ily325t4.fsf@tynnyri.adurom.net>
         <cedc93ef-496f-a403-0089-b2a82477fe0f@green-communications.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-10-12 at 12:24 +0200, Nicolas Cavallari wrote:
> > > 
> > > This patch somehow appears to break ath9k's eeprom hints and restrict
> > > it to the world regulatory domain on v5.12.10.
> > > 
> > > ath9k calls wiphy_apply_custom_regulatory() with its own kind of world
> > > regulatory domain, before it decodes hints from the eeprom and uses
> > > regulatory_hint() to request a specific alpha2.
> > > 
> > > With this patch, applying the hint fails because wiphy->regd is already set.
> > > If i revert this patch, ath9k works again.
> > 

Hm. It stands to reason that perhaps ath9k should call
wiphy_apply_custom_regulatory(NULL) (if that's possible) to reset the
knowledge of having a custom regulatory domain, before requesting the
correct one be applied by cfg80211 (and possibly even crda userspace).

I can't really say that I think the patch itself is wrong, even if it
caused this problem.

johannes
