Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA246A5E68
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjB1Rqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB1Rqn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:46:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB728303F5
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/CELGcD/3DFPP1o2J4WrnDilkE5dRwIWYad3AWkxB6Q=;
        t=1677606401; x=1678816001; b=QB5k9Y3oxoDd+aERKsG/sv4LgwYKqx8zPMSrkXFyMDRvG1o
        QgbBk7QAvON0YsuQj87h4gmv6Uqvv7fBIII6ZjPWGlmDudGrQFOANFMhSMnvKSYQjTmHXZ47Izs0L
        eKRPgB0zTLrkQcnuuprwPGZDbuI09NcLZn8X4uzuV2AW6OiOBb3l7s9rauPvxmrLnUzCGyZqHesQt
        bqSKuYD2J1M/4kSOjZ7Yv5kjuebuxOu0W20A4UKarBqF8xUkYNATUEvk/Xqp+NKSi8KwUgE0+jM5W
        GOAWTZVz8xqAWPAc2XmNcTMeg422ivy2n2bSMVrWRoTdyjudcHtwu1KxSeaJaemQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pX43h-0084Ir-1S;
        Tue, 28 Feb 2023 18:46:37 +0100
Message-ID: <7f996d2efd23cefd17074edaeed0a6bbbd9f1a99.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to
 flexible array[]
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Tue, 28 Feb 2023 18:46:36 +0100
In-Reply-To: <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
         <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
         <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Tue, 2023-02-28 at 09:44 -0800, Jacob Keller wrote:
>=20
> Previous to this change, error struct has two pointers to sections of
> memory allocated at the end of the buffer.
>=20
> The code used to be:
>=20
> -	error =3D kmalloc(sizeof(*error) +
> -			sizeof(*error->elem) * elem_len +
> -			sizeof(*error->log) * log_len, GFP_ATOMIC);
>=20
> i.e. the elem_len is multiplying sizeof(*error->elem).
>=20
> The code is essentially trying to get two flexible arrays in the same
> allocation, and its a bit messy to do that. I don't see how elem_len
> could be anything other than "number of elems" given this code I removed.

Yeah, you're right. I was thinking of more modern HW/FW too much I
guess, I see now even in the driver we have an array walk here (and it
trusts the elem_len from firmware... ahrg!)

> I posted these mainly because I was trying to resolve all of the hits
> that were found by the coccinelle patch I made, posted at [1]. I wanted
> to get it to run clean so that we had no more struct_size hits.
>=20
> Dropping this would just make that patch have some hits until the driver
> is removed, eventually...
>=20
> Not really a big deal to me, I just didn't want to post a coccinelle
> patch without also trying to fix the handful of problems it reported,
> since the total number of reports was small.
>=20

Makes sense. I don't think we'll drop the driver at any point soon, but
I also don't see it being changed much :)

johannes
