Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AB5428CA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiFHH7K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiFHH6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 03:58:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111A1FDEB0
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1BhtDLJkdEEhSTigXAf678o7IZFZZYsNgWtW+n+y9T8=;
        t=1654673535; x=1655883135; b=qkjEZd2s+XQoXop7E4T2claAflD4qMwlRa5m9Vh9k9GeWy6
        k7Vm8Kd72prf/37AjErvGE2byqRyIdM1cbXeeHnWY7mb8ETHxFOFY3JhdiW2/rIN6nl3hICFmh65O
        R0QMZqQzfpSpL+xyMnlWD+tlnBzhHAG3+fDwyhbRylBj4/Cq2PosLmGarSBm1RHTHvvS7Pzg5p3is
        P1SPgSdibQgbDqdS/8tFeu2kOhtgVk2YzyOST1wg24ypp0fKH6cbih4uB/HU5qbGarwD7GkBM4Qy/
        A0/xkcjfmUwtrrN0RmUe98NrxtiqpvkK8530kWpxH0qxxAfNdtawB1bnsZr2aK5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nyq9g-00GpVB-Jn;
        Wed, 08 Jun 2022 09:31:04 +0200
Message-ID: <a2cc93f959394a3430755d4664d9f2abeabb3ab7.camel@sipsolutions.net>
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 08 Jun 2022 09:31:03 +0200
In-Reply-To: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

On Mon, 2022-06-06 at 23:01 +0530, Veerendranath Jakkam wrote:

> +	if (cr->status =3D=3D WLAN_STATUS_SUCCESS) {
> +		for_each_valid_link(cr, link) {
> +			if (!cr->links[link].bss)
> +				break;
> +		}
> +
> +		WARN_ON_ONCE((!cr->valid_links && link !=3D 1) ||
> +			     (cr->valid_links &&
> +			      link !=3D ARRAY_SIZE(wdev->links)));
> +

I will say I'm not super happy with using the link variable after the
loop, that always feels a bit magic to me, especially if the loop is
hidden like that...

But I guess I don't see a lot of alternatives here, other than open-
coding it, or keeping track of "how many BSSes do I have".

Actually, for the MLO case, is this even valid? link[14] could be set,
so you wouldn't break, ending up with link=3D=3D15? Or am I confused?

Anyway, looks good to me.

johannes
