Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B205F9C21
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJJJle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiJJJlc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:41:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DEC647E0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=d2vfQ/VsQfsM16DZXa9IpyRQVbgn/bhPOQe9JsCha60=;
        t=1665394890; x=1666604490; b=jRc/F4wTf1BIvkO4/WWUrS4k9jcVY4pSBr7lyVQ5mvVlKkD
        Y5E+41nokDbdgKs7gtp0tOku66iQQUrB9oPN/42iAREdMO/IrY5NOU70abfMBUTLPivPBiq297NE1
        f40EcT6c/WLL0o4ycWAmCAmuvZ+0Bwlq2iLhvccYTkn3kIF9Y3jjBbIFF6uL8LHVfqblBjamIavH8
        fH2P9c1UlPaUWcUej0PD43SR07SY3nUBE6RwsW8Kiv6QimzkWw5KzOz2k2yLoEaUGxu3wDVZ4ispJ
        diGLvjZygM5gD5l/BMFzky2/Cu3/YQui1WtIbqbR1l4puU7HE6mwq8CvvsOZjMGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ohpHr-002ycC-1x;
        Mon, 10 Oct 2022 11:41:27 +0200
Message-ID: <065a6cc23f5553fd6d7d98b1e9c533d3f4e544a6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while
 informing its bss to cfg80211 layer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <aspriel@gmail.com>,
        "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        Double.Lo@infineon.com
Date:   Mon, 10 Oct 2022 11:41:26 +0200
In-Reply-To: <b7518fd9-fcd1-0ddb-e1cc-2bc7687d3ab7@gmail.com>
References: <20220927034138.20463-1-ian.lin@infineon.com>
         <20220927034138.20463-5-ian.lin@infineon.com> <874jwsrojr.fsf@kernel.org>
         <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
         <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
         <87y1tupuqy.fsf@kernel.org>
         <9e166687-1d35-4216-5c2c-a0e783ead406@gmail.com>
         <51236a0c-5210-533b-7755-94145e6c5a1d@infineon.com>
         <b7518fd9-fcd1-0ddb-e1cc-2bc7687d3ab7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-10-10 at 11:23 +0200, Arend Van Spriel wrote:
>  Maybe I am mistaken and the SSID element for the=20
> Hidden-SSID scenarion is different. Will check the 802.11 spec.
>=20

hidden SSID isn't in the spec, but these days is typically implemented
by a zero-size SSID element:

 00 00

In the past, sometimes it would also be done by some APs with a zeroed
SSID element, e.g. for the SSID "myAP" you could see

 00 04 00 00 00 00

instead.

johannes
