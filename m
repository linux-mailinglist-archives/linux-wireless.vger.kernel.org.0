Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA54D1064
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Mar 2022 07:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiCHGmj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Mar 2022 01:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiCHGmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Mar 2022 01:42:37 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DA3B578
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 22:41:40 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nRTXH-000SqZ-Hb;
        Tue, 08 Mar 2022 08:41:33 +0200
Message-ID: <61671ef674ed41b326ec39c62676fdd237875a86.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com, You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Tue, 08 Mar 2022 08:41:30 +0200
In-Reply-To: <CA+5PVA4BbLaze8-c4R-8LESA9UhsDAJu3_FK4GZKUpVUkPKDrQ@mail.gmail.com>
References: <af43569b2247f7aff44b1ea3680d88dbe083d78d.camel@coelho.fi>
         <CA+5PVA4BbLaze8-c4R-8LESA9UhsDAJu3_FK4GZKUpVUkPKDrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: Re: pull request: iwlwifi firmware updates 2022-03-03
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-03-04 at 08:46 -0500, Josh Boyer wrote:
> On Thu, Mar 3, 2022 at 6:11 AM Luca Coelho <luca@coelho.fi> wrote:
> > 
> > Hi,
> > 
> > This contains some new and updated firmwares for all our currently
> > maintained FW binaries.
> > 
> > Please pull or let me know if there are any issues.
> 
> 
> [jwboyer@vader linux-firmware]$ ./check_whence.py
> E: iwlwifi-QuZ-a0-jf-b0-71.ucode listed in WHENCE does not exist
> E: iwlwifi-so-a0-hr-b0-71.ucode listed in WHENCE does not exist
> E: iwlwifi-so-a0-jf-b0-71.ucode listed in WHENCE does not exist
> [jwboyer@vader linux-firmware]$

Oops, apparently I forgot to commit those new binaries...


> Can you fix that up please?

v2 coming in a sec.

--
Cheers,
Luca.
