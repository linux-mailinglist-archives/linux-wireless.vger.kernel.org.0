Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667535F598E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJESKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJESKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 14:10:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9933A2F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8y6xlkuT+XzSxIyOoej1Sj5p51RHjuYERHJoS0O82Js=;
        t=1664993433; x=1666203033; b=NOiqYiwUOD3Z4n2so122ULZjWYLi8W1k0BTpNkNMBwnSq67
        4jMqBbIzuvPMb+/C+5ikszJBkyAr4YYGbdRbYYmyOsZrhk50V3EqrjKEoW3ESg5JFp6OF1qQO1HcA
        TpGtQFnD8WdGTS94BuM94LtX8FUaIpsMWSMUoG2uc+JbqaTKgMdxmU4lsZ5Z9w4WXCefapXnaT+l/
        t1QHtixjITT9ZPer21BEzEsN13UWld1TURTcQ8ogfApcV+TAAAE9nL6cPJ1bJm3g7/TbY0b6R2+Z1
        Mu1SvwNOLuz56A/DRht3I3D4SOh8x8FWuz7/zBTg4zvnp5cdzwhbKF4jUuCfIPNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og8qf-00G8nn-2N;
        Wed, 05 Oct 2022 20:10:25 +0200
Message-ID: <74c6841dbc1edf3e965ea51a438542c2c497a15b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Wed, 05 Oct 2022 20:10:24 +0200
In-Reply-To: <87r0zmgwli.fsf@toke.dk>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
         <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
         <875ygyihhm.fsf@toke.dk>
         <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
         <87r0zmgwli.fsf@toke.dk>
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

On Wed, 2022-10-05 at 16:43 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >=20
> > > This logic has implications for putting "urgent" frames (like PS(?)) =
on
> > > TXQs as well, of course, but that needs to be handled somehow anyway.=
..
> >=20
> > But that probably then anyway needs to be handled in next_txq()?
>=20
> Yeah, just meant that comment as an "for future reference", it doesn't
> impact this patch series (I think?)
>=20

Right now, no, but with the promised patch to make powersave use TXQs it
would, I think :)

johannes
