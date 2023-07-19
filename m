Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB35675937B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjGSKzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSKzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 06:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406611D
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 03:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19DC961375
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 10:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A1BC433C7;
        Wed, 19 Jul 2023 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689764116;
        bh=QWCaAJddrPq16DSUaD9ECaRXA4a0UGlGrt3bGGnbjMU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Z3MGLtsA2nKhGbWH61cULRJPGibHophueB50x6HJpK1/mSIIb7kVKGyLe2kAG40j3
         GBRRgUusA/1OAYHkO+ECoMxqQrzRM7UIvrOXItwzpp85RhoWU67vB2+mj/dLDVrf0P
         wLB7wGAYm81+wolsAxFHzhtba8efW5Kpr5g1MFW9CLuMyKZBlr9r+wa3IwrUacKWkd
         N6wefPggWaMIJyIlF5dGOkoitpc1ui/l5qKVxDww6xhic4uJKzoT/hRiJ8WhxE/FbN
         Ysn7MQpplLrseFceZdFlUFR9fXWMakbKBA/nULW/uZXKzzsZP80KL9/ecndU3UPMdG
         YIIfOV6WNh8rQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kavitha Velayutham <k.velayutham@samsung.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        Pragya Gupta <pragya.gupta@samsung.com>
Subject: Re: External Auth FILS Authentication
References: <20230628045628epcms5p5b1820343f828e3229035d6313fe735ce@epcms5p5>
        <20230622103041epcms5p873a0f3404f38216c9802f6b299787d9d@epcms5p8>
        <202306221827.35MIRU0c2989147@administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net>
        <CGME20230622102548epcas5p3e347215405116f1b64befe72ec99d567@epcms5p4>
        <20230703082654epcms5p42bf0d3816b990c13a4f1d7272c4c8e7b@epcms5p4>
Date:   Wed, 19 Jul 2023 13:55:10 +0300
In-Reply-To: <20230703082654epcms5p42bf0d3816b990c13a4f1d7272c4c8e7b@epcms5p4>
        (Kavitha Velayutham's message of "Mon, 03 Jul 2023 13:56:54 +0530")
Message-ID: <875y6g2msx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kavitha Velayutham <k.velayutham@samsung.com> writes:

> Author: Kavitha Velayutham <k.velayutham@samsung.com>
> Date:=C2=A0  Thu Jun 22 23:48:11 2023 +0530.
> =C2=A0.
> =C2=A0 =C2=A0 [Patch 1/1] changes for FILS Authentication for External Au=
th.
> =C2=A0 =C2=A0 .
> =C2=A0 =C2=A0 For Auth to be handled by supplicant when sme is in lower l=
ayers for FILS Authentication and.
> =C2=A0 =C2=A0 to send Assoc params to the=C2=A0 Lower layers..
> =C2=A0 =C2=A0 .
> =C2=A0 =C2=A0 Signed-off-by: Kavitha Velayutham <k.velayutham@samsung.com=
>.

This patch seems to be badly formatted, I see ^M control characters etc.
Please read the wiki documentation below and use git send-email to
submit patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
