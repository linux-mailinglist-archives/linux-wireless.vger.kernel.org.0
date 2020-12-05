Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88392CFE0B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLETBz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 14:01:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34598 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbgLETBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 14:01:55 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klZ7U-0039bc-Rx; Sat, 05 Dec 2020 17:05:09 +0200
Message-ID: <ec07608552a69bf03cab926712a42f13925b91e6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Date:   Sat, 05 Dec 2020 17:05:07 +0200
In-Reply-To: <20201205090252.337391-1-luca@coelho.fi>
References: <20201205090252.337391-1-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 0/2] iwlwifi: updates intended for v5.11 2020-12-05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-12-05 at 11:02 +0200, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Hi,
> 
> Here's the second set of patches intended for v5.11.  This time it's
> only support for 6GHz and one dependency patch.
> 
> This is the work of several developers, I just aggregated everything
> into a single patch.  The following developers were involved in either
> initial development or bugfixes:
> 
> Haim Dreyfuss <haim.dreyfuss@intel.com>
> Ilan Peer <ilan.peer@intel.com>
> Tova Mussai <tova.mussai@intel.com>
> Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Tali Levi Rovinsky <Tali.Levi-rovinsky@intel.com>
> Avraham Stern <avraham.stern@intel.com>
> Ayala Beker <ayala.beker@intel.com>

Johannes suggested that I add these developers in "Co-developed-by"
tags, so add them in patch 2/2.

--
Cheers,
Luca.

