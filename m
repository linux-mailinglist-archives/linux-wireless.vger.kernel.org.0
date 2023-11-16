Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DC7EE812
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjKPUFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 15:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKPUFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 15:05:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEB196
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cvyZOOhxHJuee1Zg6iHwodXM+OXil4lT5nBkrQ8rEzM=;
        t=1700165114; x=1701374714; b=xHl9SOLylw+XkDoqCIWej/yLs8wQI/7VZjqdGWADD9NG5CG
        ihql8LWK7vxsLqN/spMSO+SwUamIOOLZ8Zki68fpZHJ2NJCrXXhr8wVDt+jDXvliICG/wyt7QDAnn
        gvy8NPnjAm9iqsA2d4v4VTFUUVfZGSDCrzEA8ol6fXRByJ6f/j71d9zYv8pqfpqN9ANAP/muniCqV
        UR07wzcfONJ/8i0z/G1UZwoad8ZP9k//gnEW4zeaBvAe88UjKXxTklJnSCMtW1Oz3AcZj8Biw251c
        oZT/DYVYhRTXD9eLDvTv43h8berwgeMfuR3/Dvk6M9fFDGrtMEGWRrLJwD+L4jXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r3ibw-0000000AcNF-3D0l;
        Thu, 16 Nov 2023 21:05:12 +0100
Message-ID: <5cb00149a01706042aaa44f015f5330b57808951.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Add debugging around scan failure
 warning.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 16 Nov 2023 21:05:11 +0100
In-Reply-To: <cc2a770a-d780-5d7b-82a8-9837c407e720@candelatech.com>
References: <20231114212309.2180281-1-greearb@candelatech.com>
         <9574407e2be4c97b1ef2d9f73b5eecb08791ff56.camel@sipsolutions.net>
         <7a76305b-dd42-b866-f64f-93b7c8811f97@candelatech.com>
         <8693a54d50f05a7668b11518eea2de46dd13952d.camel@sipsolutions.net>
         <cc2a770a-d780-5d7b-82a8-9837c407e720@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-11-16 at 09:51 -0800, Ben Greear wrote:

> I found a splat with my debugging enabled today, running with the v86 fir=
mware.  Looks like
> immediate cause is that active_links was 0x0.  Logs are full of it, in fa=
ct.  Seems to always
> be the same reason.

active_links will be 0 if there isn't MLO, i.e. you're not connected.

> [ 4382.603271] iwlwifi 0000:21:00.0: scan failure: Cannot find link info =
for link-id: 0 active-links: 0x0
>=20

The real question is how we ended up with no info for link-id 0, but
like I said, that's a more dynamic question, just knowing the number
doesn't really help with it :)

johannes
