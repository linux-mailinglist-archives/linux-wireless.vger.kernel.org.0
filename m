Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22065AE4D5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiIFJzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiIFJzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:55:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346833A11
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qSlQeJg/OKQIMOZYYNfO5qtaN7OMLB+FFLaTfKutCSA=;
        t=1662458107; x=1663667707; b=bb2vCzzfjM2J/0YSus3UNVQnAtOOq6qRyQoWX26AgiiM/9D
        X3VHbOz9rucqcYTL8PthBlbYrR9UdspOrJHz07pU8HB/p7SbwE/n2vOvWqBnfK1TmpRbM9ruLAIh7
        2h4w23aqw5BZPtLolgY1kqUo/9XJRYXW0cU00bpEJaydg3r8G00SJP+YVOzY9CeWmdMTlH8a4afEd
        PMKDquIvX3ZeomHq+wXUpJ6Zoh+SN41W9PjfhzaK50qD0h7VET86B4qn8rpsWj7Sy0Pn/92cjjFh6
        +oCXpP700BNxPILMHWzW0tSUpv5b5dN1sk/5LE+glS5zeWnNx6QlRN8Ah04EJW4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVVI7-009N7Z-2W;
        Tue, 06 Sep 2022 11:54:47 +0200
Message-ID: <6993afb1b9e19d3435e512e71f04054cdc6bee30.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Tue, 06 Sep 2022 11:54:46 +0200
In-Reply-To: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
References: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-08-26 at 18:25 +0530, Vinayak Yadawad wrote:
>=20
> @@ -1267,6 +1268,7 @@ void cfg80211_port_authorized(struct net_device *de=
v, const u8 *bssid,
> =20
>  	ev->type =3D EVENT_PORT_AUTHORIZED;
>  	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
> +	ev->pa.td_bitmap =3D td_bitmap;
> =20
>=20

Surely this will cause some kind of use-after-free, or stack use after
stack frame return??

In the event, I guess you need to size it for the max possible bitmap
size and copy it.

(also nit somewhere: "u8 *x" instead of "u8* x")

The function argument should probably also be const.


FWIW, I didn't really mind having a fixed two-byte bitmap, but that
doesn't address the case of it being not valid.

We could just use an "int" and say "-1 for invalid, otherwise a 16-bit
bitmap value"?

johannes
