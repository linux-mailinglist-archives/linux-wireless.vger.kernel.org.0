Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00C3193BDC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCZJ34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:29:56 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44032 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727755AbgCZJ34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:29:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHOpl-0003sI-Sv; Thu, 26 Mar 2020 11:29:54 +0200
Message-ID: <55b28b93f7be6a326597e710a20dadac89323991.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 11:29:52 +0200
In-Reply-To: <a9447df7bb83222d04199eef7c804431b877e773.camel@sipsolutions.net>
References: <20200131111300.891737-1-luca@coelho.fi>
         <20200131111300.891737-24-luca@coelho.fi>
         <a9447df7bb83222d04199eef7c804431b877e773.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 23/23] mac80211: Properly set the SMPS mode for 6GHz
 station
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-02-14 at 10:06 +0100, Johannes Berg wrote:
> On Fri, 2020-01-31 at 13:13 +0200, Luca Coelho wrote:
> > From: Shaul Triebitz <shaul.triebitz@intel.com>
> > 
> > The managed interface SMPS mode was not set in the HE 6GHz
> > capabilities IE. Set it.
> > 
> > Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> This author/s-o-b chain makes no sense...
> 
> > + * @twt_protected: does this BSS support protected TWT frame
> 
> and this patch is not related to SMPS mode at all, Luca, what happened
> here?!

Ouch, sorry about this.  The wrong-commit-message bug in my script is
still there, apparently... :(

I'll resend this patch with the correct message in a new series.

--
Luca.

