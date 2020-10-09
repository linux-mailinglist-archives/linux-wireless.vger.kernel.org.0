Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1828851C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgJIIVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 04:21:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:55042 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732337AbgJIIVQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 04:21:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQneG-002Rhf-5a; Fri, 09 Oct 2020 11:21:08 +0300
Message-ID: <11996c068501b02797b4cfaeed87953cc9c24dc6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Alexander Wetzel <alexander@wetzel-home.de>, kvalo@codeaurora.org,
        Andy Lavr <andy.lavr@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 09 Oct 2020 11:21:05 +0300
In-Reply-To: <f20c67c4-3b9b-acc7-5e8c-998ddaf6b6ec@wetzel-home.de>
References: <20200928092321.649185-1-luca@coelho.fi>
         <iwlwifi.20200928121852.e6137861d917.I93405604eb503568688b28d3169fea7fbb88ed7e@changeid>
         <f20c67c4-3b9b-acc7-5e8c-998ddaf6b6ec@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [REGRESSION] Re: [PATCH 10/12] iwlwifi: remove wide_cmd_header
 field
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-10-07 at 22:23 +0200, Alexander Wetzel wrote:
> Am 28.09.20 um 11:23 schrieb Luca Coelho:
> > From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> > 
> > Driver doesn't support fw without wide_cmd
> > so driver always sets it to true.  instead of setting
> > it always to true just remove the field.
> > 
> 
> I guess that's only true for mvm but not dvm...
> 
> At least this patch kills my wireless using a Ultimate-N 6300.
> Reverting to commit on top of wt-2020-10-06 works.
> 
> Here the last error I got during git bisect:
> 
> 
> [  375.671958] iwlwifi 0000:03:00.0: Radio type=0x0-0x3-0x1
> [  375.739218] iwlwifi 0000:03:00.0: Microcode SW error detected. 
> Restarting 0x82000000.
> [  375.739226] iwlwifi 0000:03:00.0: Loaded firmware version: 9.221.4.1 
> build 25532 6000-4.ucode
> [  375.739349] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
> [  375.739353] iwlwifi 0000:03:00.0: Status: 0x00000000, count: 5
> [  375.739357] iwlwifi 0000:03:00.0: 0x00000007 | BAD_COMMAND

Hmmm, this indeed looks wrong.  I'll try to fix it or, in the worst
case, revert this patch.

--
Cheers,
Luca.

