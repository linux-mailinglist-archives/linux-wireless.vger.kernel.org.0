Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F45F6493
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 12:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiJFKvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 06:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJFKvY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 06:51:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB759A9D9
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LdkWm+26zWGaQDRnGaWJCXNW9Jzxk0FUwS9gedUP7ng=;
        t=1665053482; x=1666263082; b=Q3jDHBHhhR3+i3jQOG4IViWOVXeD85D8rbz3RfoZaXjlgIG
        X6oCb56NikDjHqh8NBnqyg8ncA+kUc/fWvrXT4yffR5MGjq+aVfgDQmXOktoI/bX9ANhBGyQIEck8
        xZmGRxKKm8RmsN1sWMFwTnHcpEnaTEI8zJ/Voq196LO5Cryi1AnBIUJUL8Fco69Lp+/gYvQZZB1HI
        ru8SawMJmuZBovfYbdBIvOU+5qYHKyOdCP8EkppXsa5R22d7lmWbnIrijcCzKevYO7XjH5wJLGISk
        Pr/PxCu46uX31yMJg4aZPTq+bW/WXcyYuW7PHYgH07R1TR0pdMmUqrE5/CR/Wf4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ogOTH-00Gsil-23;
        Thu, 06 Oct 2022 12:51:19 +0200
Message-ID: <0fd2932c29adcc6be5fe5528d297b7deb0e0617b.camel@sipsolutions.net>
Subject: Re: [PATCH 05/28] wifi: cfg80211: support reporting failed links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 06 Oct 2022 12:51:18 +0200
In-Reply-To: <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
References: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
         <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
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

On Thu, 2022-10-06 at 16:19 +0530, Veerendranath Jakkam wrote:
> I think similar enhancement needed for cfg80211_roamed/NL80211_CMD_ROAM=
=20
> also to know accepted and rejected links info during roaming.
>=20

Not sure, in that case we might care only about the successful links
since wpa_s didn't request the others, so maybe it doesn't matter?

In any case, I have no driver I deal with that would ever use this API,
so I can't really do anything about it.

johannes
