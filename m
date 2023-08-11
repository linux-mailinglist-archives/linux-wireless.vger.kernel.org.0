Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D2778A89
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjHKKCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHKKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 06:02:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0032723
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sFnYbfoX8sDJndsar1nb384O4i3Hyi1qGT2KuRLKEEE=;
        t=1691748139; x=1692957739; b=W2RyH1hG0BKpZYgqcZ7b73W6gVqoGirO8/yPmqUMhyIjtEJ
        /sqzljw0Iom4ibEhrXow3oYDSqmjwOdrFBd9O5ArYNl4ZAg2hCvHQXqLI2bQfHZN4MUx7G7jzJHbk
        W/hIw1wDc2BBXgglhpiu8AqjZUW4StLCuYVFVhebbxh2uA+c2aLJcWAFuLv6o4kHX1Xoq5zaqqOX0
        Namhx4B8Zj13bII0VAOr29BytnnOCNCrrkoDMdnh7rRSwJTFXJAN2O47lUWddtilxwAXkonRacSb7
        33rUE6R4v22zCbxYvkUoSgjQva9Qluzi8GcZVFmLTw/aFgtN0KE4KP2IeF6+mjBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOyF-000rml-2d;
        Fri, 11 Aug 2023 12:02:16 +0200
Message-ID: <107da8d2ff2610d14cae36124d24fd55eaee469b.camel@sipsolutions.net>
Subject: Re: [PATCH v8] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Polaris Pi <pinkperfect2021@gmail.com>, matthewmwang@chromium.org,
        kuba@kernel.org, kvalo@kernel.org, linux-wireless@vger.kernel.org
Date:   Fri, 11 Aug 2023 12:02:14 +0200
In-Reply-To: <ZNV4piNiozRcGRYo@google.com>
References: <20230809215817.3080280-1-pinkperfect2021@gmail.com>
         <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
         <ZNV4piNiozRcGRYo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-08-10 at 16:54 -0700, Brian Norris wrote:
> On Thu, Aug 10, 2023 at 09:32:57AM +0200, Johannes Berg wrote:
> > On Wed, 2023-08-09 at 21:58 +0000, Polaris Pi wrote:
> > > Make sure mwifiex_process_mgmt_packet,
> > > mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> > > mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> > > not out-of-bounds access the skb->data buffer.
> > >=20
> > > Fixes: 2dbaf751b1de ("mwifiex: report received management frames to c=
fg80211")
> > > Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> > > ---
> > > V5: Follow chromeos comments: preserve the original flow of mwifiex_p=
rocess_uap_rx_packet
> > > V6: Simplify check in mwifiex_process_uap_rx_packet
> > > V7: Fix drop packets issue when auotest V6, now pass manual and auto =
tests
> > > V8: Fix missing return after free skb
> > >=20
> >=20
> > Arguably, as Brian also said, that missing return is completely
> > unrelated and should perhaps be a separate commit?
>=20
> I think the key here is that Polaris's buggy patch has already been
> applied, so this v8 doesn't really work. He has since submitted a proper
> fixup patch that applies appropriately, and I've Ack'd that.
>=20

Right, sorry, I missed that, was looking only at wireless, not wireless-
next.

Thanks all, I'll leave the -next patches for Kalle though :)

johannes
