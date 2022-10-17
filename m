Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B7600883
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJQIOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJQIOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 04:14:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A09825FE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IxT765SpRu/AccEWgVHDP2HHCCrUqfmWUft6GnhhGmk=;
        t=1665994478; x=1667204078; b=h/OxQXLP1ZzZ7h2M7kyUavRqz3uBNyAbaaoP1b37AGhwRlP
        R2gzzwPzP4VqiWTphMtHyYqmdLrOJmF5GFKXTyAxs0ZDK/sBO8UpLds1LZs90w6YaqsfsNCUJDqaB
        7icpwljv/v+utjsFh9ONHUkWEWhg0YlbH5t/jiq/hrPuBr/1Y/lbgzOgmFbYXoOEgMgFQ9PYaeFwk
        tdH1dS7n8krz/fCH7ZD764tbkRmcHj1AAmkFSdoAoW4BlsWuRaMues8Hrp7dzLPFQG9I8G+JqSz2c
        a3llbJ+45uZp3WSs6PA0UEOa903ZUmKX3xTRy1r7G0ghwxkaypVneOyqeYIOXSjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okLGQ-009CHG-1a;
        Mon, 17 Oct 2022 10:14:22 +0200
Message-ID: <dbb569976328b5442c6373a8aaacfec9a157ac56.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: mlo rx nss value 0 of wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org
Date:   Mon, 17 Oct 2022 10:14:21 +0200
In-Reply-To: <191042d8-7781-808f-71aa-db76ed763bec@quicinc.com>
References: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
         <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
         <91b975e2116521cfa9f9371a976039a53ed9a85c.camel@sipsolutions.net>
         <2a2c466fbdcc2c3cc7af81bcd4d370d0119ea865.camel@sipsolutions.net>
         <c52e6634-4a90-f165-9f41-8f23df9414a4@quicinc.com>
         <ca0f6ea2d78538ffb6640f2e56d65c89c86f5221.camel@sipsolutions.net>
         <191042d8-7781-808f-71aa-db76ed763bec@quicinc.com>
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

On Mon, 2022-10-17 at 16:12 +0800, Wen Gong wrote:
> > >=20
> > I guess valid links wasn't set at that point yet?
> >=20
> > Anyway should also move out of rate_control_rate_init() and probably
> > into something like ieee80211_assoc_config_link()? That already does
> > some rx_nss calculations which is probably not great ...
>=20
> OK. I will test with my change internal now. And replace to use upstream=
=20
> change
>=20
> after someone fix it.
>=20

Well, I think you should try to fix it and submit the patch, I'm not
going to do it in the short term ... :)

johannes
