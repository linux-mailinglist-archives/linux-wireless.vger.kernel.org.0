Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2912535350
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiEZSYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbiEZSYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 14:24:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956766ADC
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hvcZNHlHzD+ELvaEHkEQK8ognl5hIZa+2nNArh8APO8=;
        t=1653589448; x=1654799048; b=sICH2QX26HsbuuLpj57hbF91wdT4CHM1HXiCNbBK28y31Qb
        Q5C6FhiVhFjwJFghmg1+Ia1FnVDS6LZHilbi3ErGH3EKGctDpNP/xoOVtojykGQ/xjlQSPXAcWSk7
        CeMwS7OcAsRy9ekD87VsocMHG45ch/TNB5KWC/mo3hh9FQAKxqxah99nAIjQsDZli6+MV717+tuVd
        AL1O0BZs7jJTJsiN4RIY1svCNRlwxntPfGQMhvmi2eJtHy5ff8blfd4CYEN0mPfPnTz+15m9g/HEY
        juYx/LM5gGZM6z47mgMMO3DMUeC/6RIqF71u8q8rLRp6zQ1ki+LqX43zhvgFAC0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuI9V-005Eew-Hj;
        Thu, 26 May 2022 20:24:05 +0200
Message-ID: <32d207736ce219051d5cf3d1a17e829bfb3d34ff.camel@sipsolutions.net>
Subject: Re: [RFC v2 04/96] cl8k: add Makefile
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 20:24:04 +0200
In-Reply-To: <20220524113502.1094459-5-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-5-viktor.barna@celeno.com>
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

On Tue, 2022-05-24 at 14:33 +0300, viktor.barna@celeno.com wrote:
>=20
> +ccflags-y +=3D -I$(src) -I$(srctree)/net/wireless -I$(srctree)/net/mac80=
211/
> +ccflags-y +=3D -I$(src) -Werror

Neither of these should be here. *Maybe* -I$(src), but that's probably
not even needed.

> +
> +define cc_ver_cmp
> +$(shell [ "$$($(CC) -dumpversion | cut -d. -f1)" -$(1) "$(2)" ] && echo =
"true" || echo "false")
> +endef
> +
> +ifeq ($(call cc_ver_cmp,ge,8),true)
> +ccflags-y +=3D -Wno-error=3Dstringop-truncation
> +ccflags-y +=3D -Wno-error=3Dformat-truncation
> +endif
> +
> +# Stop these C90 warnings. We use C99.
> +ccflags-y +=3D -Wno-declaration-after-statement -g

No no, all of that needs to go, don't make up your own stuff here.

johannes
