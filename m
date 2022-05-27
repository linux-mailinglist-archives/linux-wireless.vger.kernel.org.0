Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DD5360CA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbiE0Lvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352073AbiE0Ltj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 07:49:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658AFFC4FA
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KiZ/WKaHso5OzApjoctCw5WFOyGtQO0XwiZVaNP9bng=;
        t=1653651845; x=1654861445; b=hj4b6fnAAXpmWO3cWWLESjLgPNNlnvSoXeqvyiNQDJM69Gr
        iVyv/iaL5Lay/FNpNSdl/rpC4jSL82WkxqypTvUW5vcbdERWJgfZsHI2Xc/UsiIlQRFDxuK776UH8
        WpKLufahGY9SJHQX52dxnaVNVKi2AaBvnUbE19i4XAbQYUao4B/+wIoxgLH786UCmIcUCzV3iSPOT
        kKfCAf/edrBueh2ZKNHxgRKP1IOU0WBozWA3+wOXM8DFFoLnfgIPZ0tUfMBn/0rPENSYAAji9VXbN
        jlZ/eLc3qVArA0HdmByFz0sq1d8H2PBOto6ZrwQ+RH1nP6IZ1AGY9EsLZ1j35uVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuYNu-0061m2-Mh;
        Fri, 27 May 2022 13:44:02 +0200
Message-ID: <c5fe3475cdfbe2633e965682ac41db5e61271411.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: libertas: use variable-size data in assoc
 req/resp cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date:   Fri, 27 May 2022 13:44:01 +0200
In-Reply-To: <87sfovuroh.fsf@kernel.org>
References: <20220523180200.115fa27fbece.Ie66d874b047e7afad63900aa2df70f031711147e@changeid>
         <87sfovuroh.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-05-27 at 14:43 +0300, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > The firmware has a 512 limit here, but we use less, so gcc
> > starts complaining about it:
> >=20
> > drivers/net/wireless/marvell/libertas/cfg.c:1198:63: warning: array sub=
script =E2=80=98struct cmd_ds_802_11_associate_response[0]=E2=80=99 is part=
ly outside array bounds of =E2=80=98unsigned char[203]=E2=80=99 [-Warray-bo=
unds]
> >  1198 |                       "aid 0x%04x\n", status, le16_to_cpu(resp-=
>statuscode),
> >       |                                                               ^=
~
> >=20
> > Since we size the command and response buffer per our needs
> > and not per the firmware maximum, change to a variable size
> > data array and put the 512 only into a comment.
> >=20
> > In the end, that's actually what the code always wanted, and
> > it simplifies the code that used to subtract the fixed size
> > buffer size in two places.
> >=20
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Can we now remove the no-array-bounds hack from libertas?
>=20

I think Jakub said he dropped it from the patches?

johannes
