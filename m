Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28543599BD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIJrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIJrn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:47:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C44C061760
        for <linux-wireless@vger.kernel.org>; Fri,  9 Apr 2021 02:47:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUnjb-009Odb-Nz; Fri, 09 Apr 2021 11:47:27 +0200
Message-ID: <a808b3c0e5acbc9658e80223b5278c78a62d2024.camel@sipsolutions.net>
Subject: Re: [PATCH 08/15] cfg80211: allow to specifying a reason for
 hw_rfkill
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 09 Apr 2021 11:47:26 +0200
In-Reply-To: <iwlwifi.20210409123755.2e0ef3e0cf37.I78e0a780ce466a23833cc101143ad45cb1c387e5@changeid>
References: <20210409094028.356611-1-luca@coelho.fi>
         <iwlwifi.20210409123755.2e0ef3e0cf37.I78e0a780ce466a23833cc101143ad45cb1c387e5@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-04-09 at 12:40 +0300, Luca Coelho wrote:
> 
> ---
>  backport-include/net/cfg80211.h | 17 +++++++++++++++++

Umm :)

johannes

