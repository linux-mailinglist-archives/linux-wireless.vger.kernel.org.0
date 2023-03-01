Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23E6A759E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 21:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCAUxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 15:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAUxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 15:53:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFD265B1
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 12:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/5PgG2WfJAHtjeLMEd0uVyIojNMFn+zqK+12wnOulC8=;
        t=1677704003; x=1678913603; b=Noi3hgecUtvPmzoCJsi2ovKuOxJZ1lhKJ5XcJO5t+rvolEa
        P1zoFp8bxK80KWbGAuEQIPKf8FzISnWp3WZnZv7VA7XqXfPXK4pz0akkt3f3Q4PhKRO64dEdTEDid
        HAmyUlOgT8hZy77yWW9etxhZMQX1vC2il22TFX1iTKielQhb23oltxJhxEn7iaB2r08mTTj4D69lT
        YKZTzDAepu2F9XYcp5LkaAmTWHd5m1T/AofsnDoY0BxvybbfTyRlQyZID8XU7rgfPgrc4lsXKWH5I
        rdF+OOXEHARwlMdczJ7FDkrS3MzjWIeVzZqZG107fJEm6GZwHJ4A8KOZHqtSnKNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pXTRs-00968O-0y;
        Wed, 01 Mar 2023 21:53:16 +0100
Message-ID: <80ddafb7c3d04b145817bb4c909ab736d06f1e1e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: ipw2x00: convert ipw_fw_error->elem to
 flexible array[]
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Wed, 01 Mar 2023 21:53:15 +0100
In-Reply-To: <99bc0165-814b-918f-1d62-4256836ab9a8@intel.com>
References: <20230228162827.3876606-1-jacob.e.keller@intel.com>
         <a8798dce4ae87aee64dfd56721b1668f8c969951.camel@sipsolutions.net>
         <d393ba90-ecdd-ffea-540b-d6db15571d5b@intel.com>
         <7f996d2efd23cefd17074edaeed0a6bbbd9f1a99.camel@sipsolutions.net>
         <99bc0165-814b-918f-1d62-4256836ab9a8@intel.com>
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

On Wed, 2023-03-01 at 12:49 -0800, Jacob Keller wrote:
>=20
> I can drop this one out of the series if you don't have an intention of
> taking it, or I can refactor to just use size_add and array_size without
> converting it to flexible array, which would prevent that coccinelle
> patch from complaining and at least ensure that we can't overflow size
> and under-allocate.
>=20
> Do you have a preference?
>=20

Ah, it's up to Kalle, not me :-)

I think it's OK to do, and if it gets rid of drive-by submissions from
the coccinelle patch later, I guess it's better to take it now. And you
already have it anyway.

I might prefer though if you sent the drivers and cfg80211 patches
separately, since that's usually Kalle vs. me applying it, and if it's
in a same series we tend to end up wondering if there's a dependency or
something, which is clearly not the case here.

johannes
