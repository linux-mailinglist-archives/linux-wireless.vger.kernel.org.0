Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6B79E82A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 14:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjIMMhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbjIMMhM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 08:37:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A651BC7
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Z71LGBNOGmmy6rhlj3321Jd2eVPQhklKTXZPuf3t9cU=;
        t=1694608628; x=1695818228; b=mL4Fm7GlNYPhQnbu7yFdoibQ8BelYWeAvJBdqdIWgHL6il4
        BmUhvWZRndFF2klt56Hl6474uzZrfvuoAW1f6TaBebPw8CCWtwlGw9qrUlbIzvXgBUSBWuhXoqUvb
        fuXgAz/4xupWH7CGrlTnbO2iLPtOpTfW/BbUahIWfh34/1548XyQzaSpCVOjufuF61jKKFau78H6L
        UxYNDowvbTrY+mOP1HaMs2G5R+mOFQRost7cZZRsO7lzIch6gSlNLEijHb/FNqaAuEBPjxGHoki24
        IgfC/31JoXQ9bxnn5qovRIVYA5SHk1sxzJUhTBvVkhgxmSWkvmJ+lThXIkARYUgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgP7B-00Euz9-2U;
        Wed, 13 Sep 2023 14:37:05 +0200
Message-ID: <63345d4e41e1eb980dea9c3ec2185d554e1798e6.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] wifi: iwlwifi: pcie: rescan bus if no parent
From:   Johannes Berg <johannes@sipsolutions.net>
To:     gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 14:37:04 +0200
In-Reply-To: <20230913145231.f7795a1ccdab.I2b84810a743469a1bcabf3628262cf54311593f4@changeid>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
         <20230913145231.f7795a1ccdab.I2b84810a743469a1bcabf3628262cf54311593f4@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-09-13 at 14:56 +0300, gregory.greenman@intel.com wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> If the bus has no parent due to the topology, platform level device
> reset (PLDR) wouldn't work.

I learned later that this description is really pretty much wrong - it
shouldn't really reference PLDR at all, that's not what's going on
here.=C2=A0It should be talking about just the rescanning not working, or s=
o,
that's the only part here that matters.

Anyway, I can fix it when I commit it, just wanted to state it in public
and not just silently do it.

johannes
