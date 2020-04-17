Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF01AD623
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 08:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgDQGdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 02:33:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56324 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727818AbgDQGdY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 02:33:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPKYt-000KLK-7r; Fri, 17 Apr 2020 09:33:15 +0300
Message-ID: <8b6fef441fc89ab1591999e5bf3dcd15ae8ff2d7.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Mark Asselstine <asselsm@gmail.com>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 17 Apr 2020 09:33:13 +0300
In-Reply-To: <895ba040fcefbc8899cf297c09dfbf804ec4bc87.camel@sipsolutions.net>
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
         <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com>
         <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com>
         (sfid-20200403_191045_693592_55FBA86D) <895ba040fcefbc8899cf297c09dfbf804ec4bc87.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v5.7 4/8] iwlwifi: mvm: limit maximum queue appropriately
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-04-14 at 13:29 +0200, Johannes Berg wrote:
> On Fri, 2020-04-03 at 13:10 -0400, Mark Asselstine wrote:
> > On Fri, Apr 3, 2020 at 10:38 AM Mark Asselstine <asselsm@gmail.com> wrote:
> > > On Fri, Apr 3, 2020 at 4:32 AM Luca Coelho <luca@coelho.fi> wrote:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > 
> > > > Due to some hardware issues, queue 32 isn't usable on devices that have
> > > > 32 queues (7000, 8000, 9000 families),
> > 
> > Is this statement really correct?
> 
> No, it should've said "queue 31" since they're numbered 0-based ...

I will fix this in the commit message and send v2 of the entire series
today.

--
Cheers,
Luca.

