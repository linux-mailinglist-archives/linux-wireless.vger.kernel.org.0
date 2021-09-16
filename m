Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447940D9D8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbhIPMYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 08:24:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33722 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235962AbhIPMY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 08:24:29 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mQqPt-000F61-4C; Thu, 16 Sep 2021 15:23:01 +0300
Message-ID: <f30f21e6547686563d4058e73b8b5b013c69c93a.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     You-Sheng Yang <vicamo.yang@canonical.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Thu, 16 Sep 2021 15:22:58 +0300
In-Reply-To: <945c6e9d-6635-7039-c876-260df26ee3d2@canonical.com>
References: <cf74966169f716164a7e642edc1aae8cdb7417c6.camel@coelho.fi>
         <945c6e9d-6635-7039-c876-260df26ee3d2@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: pull request: iwlwifi firmware updates 2021-09-14
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-15 at 12:52 +0800, You-Sheng Yang wrote:
> On 9/14/21 4:19 PM, Luca Coelho wrote:
> > Hi,
> > 
> > 
> > This pull request contains a single patch that adds firmware binaries
> > to support one more device family in iwlwifi, namely So SOCs with Gf,
> > Hr and Jf radio modules.  This replaces the previous patch that we
> > reverted.
> > 
> > Please pull or let me know if there are any issues.
> > 
> > --
> > Cheers,
> > Luca.
> > 
> > 
> > The following changes since commit 090a34dfe32bfe139bf0f8df96bcbce320ee8864:
> > 
> >   linux-firmware: add frimware for mediatek bluetooth chip (MT7922) (2021-09-13 11:35:49 -0400)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2021-09-14
> > 
> > for you to fetch changes up to 22cfb96ad56e7c0fdee96550ce9612981dc8342d:
> > 
> >   iwlwifi: add FWs for new So device types with multiple RF modules (2021-09-14 11:11:43 +0300)
> > 
> > ----------------------------------------------------------------
> > Add iwlwifi firmware binaries for So with Gf, Hr and Jf.
> > 
> > ----------------------------------------------------------------
> > Luca Coelho (1):
> >       iwlwifi: add FWs for new So device types with multiple RF modules
> > 
> >  WHENCE                       |  11 +++++++++++
> 
> This adds incorrect filenames. The `a0-hr-a0` and `a0-jf-a0` should be
> `a0-hr-b0` and `a0-jf-b0` instead.

Good catch! I'll fix the WHENCE and send v2 of this pull request.

Thanks!

--
Cheers,
Luca.

