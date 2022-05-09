Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270B952056A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiEITsj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 15:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiEITsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 15:48:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49032D9ED9
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7m/9oUwqcQ+mHWUWgpbbBTTQFzglaV3pywa+M/m7L1U=;
        t=1652125484; x=1653335084; b=DVkgzn/4dP3f+05guCrOpoyx7VJ28Wyhvj5Boc6bku3evlu
        m/fo6wGhHbsrUMfGWtdpDN3uGFVc7OMT+pgdF97veZuj9ReCMU+o+tnxlqJUUOX4BZk17iVhi6647
        IUWDu8RSvDKgg64Ogl/Xc5qB+ISHv/2k0ymiDvBzcsISrBvNZ8HSgac4ozuhzfEG/x/uSF009ldvo
        n56MQH7VWtDgBEtqaRhQOPZGPXmb2+J3r7VqsRA1oiULIPcFBYQDWo1PRXSM6f6atsoZpjzuiYkuG
        bivibLS+PjfXKzkSGxyDvyC8j0vBnk9as7Q7mKj2Ba255BZnxLQ/WZyCi4KEGuXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1no9JA-006vHR-Vc;
        Mon, 09 May 2022 21:44:41 +0200
Message-ID: <57cb3e2f1ba75aec472ca5cfdcd8fc3c7ffffeb0.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ajay.Kathat@microchip.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com
Date:   Mon, 09 May 2022 21:44:40 +0200
In-Reply-To: <aeafb6e2-d294-475b-1c43-1f90bf8d5114@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
         <20220504161924.2146601-3-ajay.kathat@microchip.com>
         <87pmkmylex.fsf@kernel.org>
         <aeafb6e2-d294-475b-1c43-1f90bf8d5114@microchip.com>
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

On Mon, 2022-05-09 at 13:49 +0000, Ajay.Kathat@microchip.com wrote:
> 
> As I understand, in WILC "ieee80211_ptr" is used for the station/AP 
> interface but not to configure the monitor interface which gets 
> additionally added in AP mode. In AP mode, for an interface( wlan0 ), an 
> additional monitor interface( mon.wlan0 ) gets created. A netdevice is 
> register for monitor interface(mon.wlan0) to transmit/receive frames 
> from/to hostapd. That interface doesn't explicitly set up 
> 'ieee80211_ptr' because the original interface(wlan0) uses it, so using 
> "cfg80211_register/unregister" API's for mon.wlan0 interfaces fails.

Btw, this probably should just be removed in favour of using the nl80211
based APIs for hostapd ...

But I think as a quick bugfix goes this is fine, but it'd be better to
remove this and either allow hostapd to create the interface with the
proper ieee80211_ptr, or to just use the nl80211-based TX/RX.

johannes
