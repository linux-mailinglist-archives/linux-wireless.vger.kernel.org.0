Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C601CB5B3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHRS7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 13:18:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60370 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbgEHRS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 13:18:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jX6eF-000Whd-N6; Fri, 08 May 2020 20:18:56 +0300
Message-ID: <600179d2c1679b933e5129a3aac6c1f788a1c24f.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     =?UTF-8?Q?=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB_?=
         =?UTF-8?Q?=D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD?= 
        <klukonin@gmail.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Fri, 08 May 2020 20:18:54 +0300
In-Reply-To: <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
References: <20200508140802.558267-1-luca@coelho.fi>
         <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
         <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
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

On Fri, 2020-05-08 at 21:41 +0500, Кирилл Луконин wrote:
> Does it mean that wireless-regdb is not needed anymore and any vendor
> can configure wireless stack from it's proprietary firmware?

This is not new.  This is part of the self-managed regulatory feature.

--
Cheers,
Luca.

