Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2781938DC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 07:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCZGtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 02:49:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44002 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727708AbgCZGtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHMKH-0003o5-2j; Thu, 26 Mar 2020 08:49:13 +0200
Message-ID: <937db1c0c8a1352705f07d7866873efba0d1da44.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 08:49:11 +0200
In-Reply-To: <877dz94wrg.fsf@kamboji.qca.qualcomm.com>
References: <20200323131925.208376-1-luca@coelho.fi>
         <iwlwifi.20200323151304.a491f6c5ae4b.I6829a46b89e4e701f80a0e4033f4dd41ee44ed12@changeid>
         <877dz94wrg.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/14] iwlwifi: mvm: add soc latency support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 17:07 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > 
> > Some devices require longer time to stabilize the power and XTAL.
> > This is especially true for devices integrated in the SoC.  Add
> > support for a new firmware API that allows the driver to set the
> > latency value accordingly.
> > 
> > Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
> > @@ -0,0 +1,83 @@
> > +/******************************************************************************
> > + *
> > + * This file is provided under a dual BSD/GPLv2 license.  When using or
> > + * redistributing this file, you may do so under either license.
> 
> Any chance of getting SPDX tags to iwlwifi soon? They are awesome and
> make life so much easier.

Hmmm... Most of our files already have it.  I'll add the tags to the
remaining ones and send it upstream as usual.

--
Cheers,
Luca.

