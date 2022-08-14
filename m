Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5D592590
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Aug 2022 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiHNQre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiHNQrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 12:47:14 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D995E4D
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 09:37:12 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4M5NNg3cwsz9sPp;
        Sun, 14 Aug 2022 18:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joachim-breitner.de;
        s=MBO0001; t=1660495027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUgKaSDTGfAJOnIp6YIP3got4AcrL7V/NfhnZeV0/38=;
        b=iuFWkKeecKyP25iIPrRg6AaaaWgFzyem7EeweBW2eT+EvRNhEOJCb2Idvyim3KNGu5lbJJ
        iOHqtqKQHuKgQeyi7npGcfyx/evPERJ+hYZMW69BiN+svjqBiBvRxccbhBBCuSSjnRQeFj
        X9Do6+Z47eMrNcgclArPf5DkPSPxFqletV2c/fj6Th5bsIOWIZ/01Ewk7rrdlGGVQXt+Oq
        wzIjfleZrfd4FRWT1qvAO2T9cj5R1gl7kNpFlEccLIIXMYgUVAk5BykjSNth2de1A6/Nyl
        MPRNIcZchAmxfh588rfgQJPpSfS1+uBnIrPfNHi62/JUHwf+2XKgzm8V1ns/wA==
Message-ID: <f5a35c6e83835afc114f969ee3d3f6c2003fa51b.camel@joachim-breitner.de>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
From:   Joachim Breitner <mail@joachim-breitner.de>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "toke@toke.dk" <toke@toke.dk>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Stern, Avraham" <avraham.stern@intel.com>
Date:   Sun, 14 Aug 2022 18:37:04 +0200
In-Reply-To: <491ec4d63116aa51567f74004b5fba299af42029.camel@intel.com>
References: <87ilr4hv8k.fsf@toke.dk>
         <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
         <SA1PR11MB5825CF723F193508BC04B051F2669@SA1PR11MB5825.namprd11.prod.outlook.com>
         <491ec4d63116aa51567f74004b5fba299af42029.camel@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4M5NNg3cwsz9sPp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Am Sonntag, dem 14.08.2022 um 14:06 +0000 schrieb Greenman, Gregory:
> @Joachim - Can you please file a bug in kernel bugzilla, we will assign
> someone internally to look into this.

Sure thing! https://bugzilla.kernel.org/show_bug.cgi?id=3D216362

Let me know if I can be of any help, giving more information or testing
patches.

Cheers,
Joachim
--=20
Joachim Breitner
  mail@joachim-breitner.de
  http://www.joachim-breitner.de/

