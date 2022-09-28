Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A85EE5AB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiI1T2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 15:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiI1T2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 15:28:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2887E038
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qoBk84Coaxad38euvOy8oFH7RuoWMQKYKDLnzoU/ivM=;
        t=1664393314; x=1665602914; b=qUOJwyxOTGgPQpjBKVLq89fW4DTG7RDIewvvU6p/d9davtJ
        UdyIsc1mWmRXp2/bSuLKTtcYN6UG5LJwDAl6za2EK+9FqlQfKpo8cl5kYJ9z4WGKr7AVOGtqxIu9a
        9Jrp0xQaGWFBrgyB51tA/YHJjqOy0cUSOrlNnbyzvQ/4OLuVQ4xT7696wMjThx5CDzFXXrnFXkItP
        Qu+khQH4/wzVbhSBbXkxn7k62Xs/+VxNHwdwtMWVgLGePYOk8bXh6BHU8xSi131w69gEjqC2XiBde
        tQ55CzQ5hyv4A8QeEpPf4RmFmWqG42zVsdoasOPhTV0abJr8UjWo+1BJAdDQYJog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1odcjP-00AVVs-2A;
        Wed, 28 Sep 2022 21:28:31 +0200
Message-ID: <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org
Date:   Wed, 28 Sep 2022 21:28:30 +0200
In-Reply-To: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
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

On Wed, 2022-09-28 at 23:33 +0800, Wen Gong wrote:
> Hi Johannes,
>=20
> May I know the status for below work which is written in the patch below?
> I think it is needed in=20
> ieee80211_assoc_config_link()/ieee80211_assoc_success(), right?
>=20

It passed the plugfest last week ;-)

Yes, I need to get this posted ... but now I got another urgent thing to
look at, so it'll be some time.

johannes
