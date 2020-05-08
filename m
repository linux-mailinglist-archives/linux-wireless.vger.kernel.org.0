Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2F1CB994
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEHVOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 17:14:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60386 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726883AbgEHVOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 17:14:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jXAJh-000WoL-6h; Sat, 09 May 2020 00:13:57 +0300
Message-ID: <e86656c0892ead97c21ab0b4c77070bfa56336a8.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     =?UTF-8?Q?=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB_?=
         =?UTF-8?Q?=D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD?= 
        <klukonin@gmail.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Sat, 09 May 2020 00:13:55 +0300
In-Reply-To: <CALYz8yozMjWmMVy9O277162n58MyD=NTLXAb0dVkLxR4-cnRew@mail.gmail.com>
References: <20200508140802.558267-1-luca@coelho.fi>
         <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
         <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
         <600179d2c1679b933e5129a3aac6c1f788a1c24f.camel@coelho.fi>
         <CALYz8yozMjWmMVy9O277162n58MyD=NTLXAb0dVkLxR4-cnRew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/11] iwlwifi: set NO_HE if the regulatory domain
 forbids it
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-05-09 at 01:10 +0500, Кирилл Луконин wrote:
> Channels ON/OFF logic is OK.
> But I (and possibly not only me) bought a lot of ax200 cards.
> And now they all will work in 802.11ac mode without any reason and
> without any chance to avoid such behavior.
> That's something new, I think.

The reason is regulatory.  That may be new, but it's just part of
following regulations.

--
Cheers,
Luca.

