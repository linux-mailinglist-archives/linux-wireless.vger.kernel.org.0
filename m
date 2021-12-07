Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B371A46BCEE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhLGNwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 08:52:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50642 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237327AbhLGNwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 08:52:54 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1muaqO-001BAW-JY; Tue, 07 Dec 2021 15:49:22 +0200
Message-ID: <f82d3481495a371aaa993b73598f36869a014976.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 07 Dec 2021 15:49:19 +0200
In-Reply-To: <87a6hcttpu.fsf@codeaurora.org>
References: <20211204063555.769822-1-luca@coelho.fi>
         <iwlwifi.20211204083238.64d2ea8b61f2.Ia5287e37fb3439d805336837361f6491f958e465@changeid>
         <87a6hcttpu.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 03/12] iwlwifi: properly support 4-bit MAC step
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-12-07 at 15:44 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Mike Golant <michael.golant@intel.com>
> > 
> > Properly support 4-bit MAC step by refactoring all the current
> > handling of the MAC step/dash.
> 
> What is 4-bit MAC step?

Maybe a bit bad wording.  We have a MAC component (which is inside the
SoC) and it has several different HW steps.  3 bits used to be enough
but now we need 4-bits to represent all the different steps.

Do you want me to reword the commit message?

--
Cheers,
Luca.
