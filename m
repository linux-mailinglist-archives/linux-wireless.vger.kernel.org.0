Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24432463218
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhK3LSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 06:18:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49978 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237792AbhK3LSn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 06:18:43 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1ms16Y-0013Xu-FN; Tue, 30 Nov 2021 13:15:23 +0200
Message-ID: <22a9f754ea1ce8b3bf1a4bfb96bff8049c269613.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Nov 2021 13:15:21 +0200
In-Reply-To: <iwlwifi.20211129152938.9e81043f04f6.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.9e81043f04f6.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 01/16] mac80211: add more HT/VHT/HE state logging
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-11-29 at 15:32 +0200, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add more logging in places that affect HT/VHT/HE state, so
> things get easier to debug.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Sorry, there was a merge mistake in this patch and it broke
compilation.  I'll send v2 in a sec.

--
Cheers,
Luca.
