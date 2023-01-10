Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5701F663F00
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 12:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjAJLI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 06:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbjAJLH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 06:07:58 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F923D9C6
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 03:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/7ZM1EIbBmTahnbmN6yYJoTW4FPTRQ1pX2Him1Cq/pU=;
        t=1673348839; x=1674558439; b=jE5xskBi2dw9sNa/IsNBaeF8jqJkWrMFBKXun1NFrC/jgqi
        6cqq1AEEIKLotIbNxLGJHr7YKl/+i6SVvoIUDZefO5j+aUO3efJ2wS5y0fTVVER7fjvUC3rpS1joY
        Ti2y6YsIvperMdjwPlXYiI1z6GpEnwMAUPxWPVg1oms2P+I9Ce0sUWTwfQV1UTbVbRbCE5/5wRoK7
        E9FfHPkNG5XEgF/da+q716tXBAkUWwuPJQS621u7lFzO8qc/a5wJjYnFqFbIbWTstomHEKThFWgRr
        0xGF3UNcN3QUzUw75Fe6JaCJIuQ704tDBaDP+f8Mm40IENWJ3Mlp24kGmHRm8vuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFCTM-00FCYi-17;
        Tue, 10 Jan 2023 12:07:16 +0100
Message-ID: <a7ccf0e6a1481f592fa9ff81f7b6545a4f4a653f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: add support for scanning in ap mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nick Hainke <vincent@systemli.org>, linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Date:   Tue, 10 Jan 2023 12:07:15 +0100
In-Reply-To: <20230110110524.511258-1-vincent@systemli.org>
References: <20230110110524.511258-1-vincent@systemli.org>
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

On Tue, 2023-01-10 at 12:05 +0100, Nick Hainke wrote:
> OpenWRT has shipped a patch since 2011 that allows it to perform a scan
> in AP mode, whether it is supported by the driver or not. In certain
> situations, it may be desirable to scan an interface that is currently
> in AP mode regardless of whether frames are missed. The patch adds a
> module parameter "allow_ap_scan" that, if set to true, allows the behavio=
r
> described above.
>=20

I must say - not really in favour of throwing around random module
parameters like that :)

johannes
