Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C6777165
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjHJHdE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 03:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 03:33:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14893A3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N+D41Q+QlpeYyVXtZk3ZG0P4glsZ0DBFuobGucfdMBw=;
        t=1691652783; x=1692862383; b=FcglCNN4TwsnV8XFrVW0iqF73rAPe14AjUb5HYYq9y1crhh
        exp6kW3nFcAc0+YtxAwIur2GyHE2Kk+XPlqA0s5bzTvNTrHX7BCYG6ENYuniIQsTuiRWXzJIczn4k
        kh9xCrAfT/8JU101D8xko7aNpIVlhimLU9G7hUL4NHCVUaKE5KQpvhVaF8RhRjv0GPPJ6de6riDqx
        ZESG0Gu3/jRTCbAbCGWvDFA8AWaVh+s1xh5HhuIt6XPFNUHa2jMk3IkeLvKm4pGnmj2JTSJdBdUAy
        t53GQPqLfKqV0lBqUXmSGDtujt9IDc8rVZCbzSrKdpK2F2B00SKFMuoLd1G2GIcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qU0AF-00GLV9-2C;
        Thu, 10 Aug 2023 09:32:59 +0200
Message-ID: <4933455600e633c8cbafc0fc3180a7023894f8c9.camel@sipsolutions.net>
Subject: Re: [PATCH v8] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Polaris Pi <pinkperfect2021@gmail.com>, matthewmwang@chromium.org,
        briannorris@chromium.org, kuba@kernel.org, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 10 Aug 2023 09:32:57 +0200
In-Reply-To: <20230809215817.3080280-1-pinkperfect2021@gmail.com>
References: <20230809215817.3080280-1-pinkperfect2021@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-09 at 21:58 +0000, Polaris Pi wrote:
> Make sure mwifiex_process_mgmt_packet,
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> not out-of-bounds access the skb->data buffer.
>=20
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80=
211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> ---
> V5: Follow chromeos comments: preserve the original flow of mwifiex_proce=
ss_uap_rx_packet
> V6: Simplify check in mwifiex_process_uap_rx_packet
> V7: Fix drop packets issue when auotest V6, now pass manual and auto test=
s
> V8: Fix missing return after free skb
>=20

Arguably, as Brian also said, that missing return is completely
unrelated and should perhaps be a separate commit?

johannes
