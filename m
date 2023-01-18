Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4921167289B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjARTlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARTlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 14:41:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C95412A
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WwVPtg6mlST/VDdlMrLHIyxVOpJbqpxwb99JAQ0fjTg=;
        t=1674070876; x=1675280476; b=Mce+TTZrcZT9YbHrl/pMkk/ZA8gLhrMO4GE4+hWHCDcoeCL
        plS7rDYlXlRebyrh6RnleCY0Hfnkf4kzYQPQHhjwhsgGMpwRooeRG2dHr9b4hTO+Rc76sQ3M2xo4p
        /sMMWLV7oOCfs4fHlc3sSHyCNug9foTkP0ZhtjzUPwR1ydCABrcTkq8WJ2zLN1CtJrV+eWMtO0lAX
        rd17svbpS8m42xNHOa5YQzGPsVW8g9WmESEreONSFoW/qSkJDjOEBcYEHimJDnEBNL88XQBhHQpqR
        F14kW2nvHdzw4M3x5gVaLCcSUCPQbQ1/I9yFR93mil9X3ZTXYBXoTt4V1UKwms3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIEJ6-005kN0-0p;
        Wed, 18 Jan 2023 20:41:12 +0100
Message-ID: <b3c6f2839c2092250ad8f6cd1e6ed4cb9d7a3ce5.camel@sipsolutions.net>
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 20:41:11 +0100
In-Reply-To: <5ade37de-2582-9e80-b99f-01aab13d991c@intel.com>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
         <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
         <3fe52061d5d9e3701f598add5c64f8b3583c31df.camel@sipsolutions.net>
         <b2c78f45-345b-e3ec-20b1-9d18ee0c9f98@intel.com>
         <8b955e4d859aafdf42f1a11f37ddf2a5e47c2610.camel@sipsolutions.net>
         <5ade37de-2582-9e80-b99f-01aab13d991c@intel.com>
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

On Wed, 2023-01-18 at 19:21 +0100, Alexander Lobakin wrote:
> > So you could pull out the expression "((n) & ((n) - 1)) !=3D 0" from al=
l
> > four of these, but it doesn't feel worth it.
>=20
> Aaaah I see.
>=20
> __BUILD_BUG_ON_NOT_POWER_OF_2_ZERO() then? :D
>=20
> (mostly joking and not sure it's worth it, up to you)
>=20

Yeah exactly! I briefly considered but didn't really want to touch
build_bug.h for basically nothing :)

johannes
