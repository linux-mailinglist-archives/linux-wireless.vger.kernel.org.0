Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8143728A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVHPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 03:15:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56986 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230332AbhJVHPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 03:15:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdok6-000bfq-IQ; Fri, 22 Oct 2021 10:13:31 +0300
Message-ID: <11df6807c56d9f3f3bc9346b6b55e20a48e90c92.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Fri, 22 Oct 2021 10:13:29 +0300
In-Reply-To: <E1mdnzg-000beE-Fz@farmhouse.coelho.fi>
References: <iwlwifi.20210826224715.820c2ae18c2b.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
         <E1mdnzg-000beE-Fz@farmhouse.coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 10/12] iwlwifi: Add support for getting rf id with
 blank otp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-22 at 09:25 +0300, Luca Coelho wrote:
> Luca Coelho <luca@coelho.fi> wrote:
> 
> > From: Matti Gottlieb <matti.gottlieb@intel.com>
> > 
> > When having a blank OTP the only way to get the rf id
> > and the cdb info is from prph registers.
> > 
> > Currently there is some implementation for this, but it
> > is located in the wrong place in the code (should be before
> > trying to understand what HW is connected and not after),
> > and it has a partial implementation.
> > 
> > Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> 3 patches applied to iwlwifi-next.git, thanks.
> 
> c5dd7b08bae0 iwlwifi: Add support for getting rf id with blank otp
> f2bc2f70292e iwlwifi: Add support for more BZ HWs
> ca5b81f972a8 iwlwifi: Start scratch debug register for Bz family

Kalle, just to clarify.  I'm going to take this 3 patches that were
left out due to the DHC issue with my previous pull request.  They'll
be part of my next pull-request.

Sorry for these automated emails.  I had "no-automatic-emails" in my
.pwclientrc instead of "automatic-emails=no"... :(

--
Cheers,
Luca.
