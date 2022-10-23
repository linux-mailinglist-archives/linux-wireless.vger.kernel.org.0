Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8082760948F
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Oct 2022 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJWP5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Oct 2022 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJWP5C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Oct 2022 11:57:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D11EACF
        for <linux-wireless@vger.kernel.org>; Sun, 23 Oct 2022 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Date:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=k4hAD0/JhpOQQ2YRrCC3BNRToFQvLvPNcbphVCwF1u8=;
        t=1666540620; x=1667750220; b=c72lcdGoYysUW+WMEvvWct1MYyuZn+ilt9g+strgnUR/1Ie
        8NBjPS25ArBHaB2ECxvcs49lQX0eKk3IkZz6M7lhKa1dPUs0X8CjlHPYv/tDV2sKUPfXdnMS4YNRp
        ZxChJlihsAATVx9I5BNFogNMt98ByLw/7pagWDJ6CcXKNLu2anAeku33685BbbbBXIRK/z7Hzc7ga
        rABi+3266L1Hak9BTPAeEQZavfV5afbtZHblBpcCvDoEEP8I1QyfY4DMvfYVc6UOgePAIlVLxBfnh
        dLstYOsy0Kv9vvG5oinrW1y/vhgkL0nOaPnh/A41MTQHb3zO4NnhvIORdPIdfXaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1omdLI-00EbZ6-1w;
        Sun, 23 Oct 2022 17:56:58 +0200
Message-ID: <472d5d4687ddbecfbf97419d223b4d1b472777e1.camel@sipsolutions.net>
Subject: Re: How to use the rate control in mac80211?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
In-Reply-To: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
References: <b80eae6f-8369-c98d-ffc4-3ee5b5b4eb22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date:   Sun, 23 Oct 2022 17:53:00 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I thought it's like this:
> 1) don't set HAS_RATE_CONTROL

yes

> 2) tell the chip to use the rate from tx_info->control.rates[0]

I'd prefer you didn't, that's also very limited :-)

> 3) report if the frame was acked or not

Kind of.

It'd be better if new drivers used sta_rate_tbl_update method, so it'd
be something like

 1) don't set HAS_RATE_CONTROL
 2) implement sta_rate_tbl_update(), using the table of rates given
    there to instruct the device to transmit frames at those rates
 3) on TX success/failure, fill in a struct ieee80211_rate_status array=C2=
=A0
    that indicates which rates were used and how many times until the
    eventual success or failure; this is in struct ieee80211_tx_status
 3) alternatively, fill in the tx_info rates array the same way and
    report it that way, but that's less flexible


johannes
