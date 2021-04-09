Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4A359A2E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhDIJ4e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:56:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44292 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233599AbhDIJ4I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:56:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUnrk-000EV4-Ii; Fri, 09 Apr 2021 12:55:54 +0300
Message-ID: <68c974fc5f329180cf73f47f9547ee64c4755890.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 09 Apr 2021 12:55:52 +0300
In-Reply-To: <a808b3c0e5acbc9658e80223b5278c78a62d2024.camel@sipsolutions.net>
References: <20210409094028.356611-1-luca@coelho.fi>
         <iwlwifi.20210409123755.2e0ef3e0cf37.I78e0a780ce466a23833cc101143ad45cb1c387e5@changeid>
         <a808b3c0e5acbc9658e80223b5278c78a62d2024.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 08/15] cfg80211: allow to specifying a reason for
 hw_rfkill
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-04-09 at 11:47 +0200, Johannes Berg wrote:
> On Fri, 2021-04-09 at 12:40 +0300, Luca Coelho wrote:
> > 
> > ---
> >  backport-include/net/cfg80211.h | 17 +++++++++++++++++
> 
> Umm :)

Ooops, sorry.  I usually cut them off, but since this was a new file, I
missed it.  Wonder what people would say if they suddenly saw a new
directory at the root of the tree! 8-|

--
Luca.

