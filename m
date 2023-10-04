Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF97B8D86
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjJDTi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjJDTi1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 15:38:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD59BD
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TkPv8Sbi3Zs7b8O8WyzzIUGcc2ER1uN3udrqf8p5nCs=;
        t=1696448304; x=1697657904; b=EPMKscjZu8ipY/qga2jXDSVAp5C372rMiJ6z0/RomUgiExv
        Fpe6BbbQ4EXXVUD1HYQqccVW0hhBJfonmZ2+aoHMeaYHgDRZg4+mZKzB2rgfODJeTfWku+sgvihwH
        yIpDg6LJSLjejsh05p1zE8cLpJMbYVRkBUfBi9otODrf01237KND5rIhnqczkLlUv1SbrCTeyCpxZ
        ucruIgVd1IhnVbO/VKi5kYNxXGFWcoyXapTSxcuvQMct49XV2kNbO/6/nvNsSo4lMqOq8upZeyCmW
        cEtEgN8zmwrBvu3VlyuarCHgs8FdaIiEFY2qKH9XrPxdLbmKMWrIWISAvRxJOVNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC0)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qo7hO-00000004UkN-0jeN;
        Wed, 04 Oct 2023 21:38:22 +0200
Message-ID: <4ae5a8dbe80e0eb0b96e9165892746fc3b3e9197.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  Allow STA to connect in AX mode to MLD AP.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Wed, 04 Oct 2023 21:38:21 +0200
In-Reply-To: <20231003164326.857433-1-greearb@candelatech.com>
References: <20231003164326.857433-1-greearb@candelatech.com>
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

On Tue, 2023-10-03 at 09:43 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> Check if user has configured STA to be AX mode, and if so,
> skip the check for MLD elements (as they would not be needed
> in AX mode).

Eh, no, I think this is wrong.

>=20
>  		if (ieee80211_vif_is_mld(&sdata->vif)) {

If you get past this if, you've (locally) committed to doing EHT
already, not just HE (n=C3=A9e 11ax), so should have an EHT connection?

Though the change is hard to read - but why are you telling the
supplicant to connect with MLO if you wanted to not use EHT?

johannes

