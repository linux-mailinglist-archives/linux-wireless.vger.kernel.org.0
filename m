Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFA5F51CB
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJEJfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJEJfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 05:35:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601826542;
        Wed,  5 Oct 2022 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dyLl3WQbCwzUKWL1AapoYi6wcWkNTECSWFDzC8v5MlI=;
        t=1664962522; x=1666172122; b=Ky9Pb+0VjjbKUpFucfaE+vkKZ8xobKGiWvQvSt9rfnHGWk1
        5BXNuLKvt5HjgaTHPZcUB37IPsg1UJrM9OSkC9q5d0HVlzRRSWz9O+GkggscIO6aHqQ9jHgn19G36
        z0hoCXqyqWK76NzZq+ivyis8szgAJ4to3nUhgJ3Gn83T9Gmah5gLrGJldd2JxTJtCDqsdQphXBYbe
        Mw/l33xSkudQ6rdL64hD+cfz8+frAnD6PJezHSRM0++iDNIIpSWwJfkQD/1OAewvuNQGTJa4wAn1Y
        71PZFGmRDZ3Q05RBMRh02nq8MGBojWHbZK+84hjwcsKL5qVox7sZPj/eGW0IVT1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og0oA-00FxtO-1x;
        Wed, 05 Oct 2022 11:35:18 +0200
Message-ID: <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0
 versions above 55
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?ISO-8859-1?Q?=CD=F1igo?= Huguet <ihuguet@redhat.com>,
        gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Date:   Wed, 05 Oct 2022 11:35:16 +0200
In-Reply-To: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
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

On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> With an AC9560 installed on a system with Quasar (11th gen processor,
> in my case) we're getting a firmware crash as soon as you try to do
> something with the card. The problem doesn't happen with the card
> installed in older platforms (8th / 9th gen), and it neither happens
> with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any other
> newer version.
>=20
> I've tried different versions of kernel and firmware, including the
> latest kernel and linux-firmware available today, and all of them fail
> unless I remove all fw files above version 55.
>=20

I believe this is a duplicate of

https://bugzilla.kernel.org/show_bug.cgi?id=3D214343

which was supposed to be fixed in firmware, but evidently that fix was
never backported to older images.

Internally, FW commit d8887278 fixed this, so FW version 69 should be
OK?

I'm not sure we can easily workaround it in the driver? Maybe we can
detect the RF, but that's kind of awkward.

johannes
