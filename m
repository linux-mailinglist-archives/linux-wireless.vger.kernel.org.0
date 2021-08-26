Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F263F83AA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhHZIVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHZIVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:21:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C518C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/wciBovcEww3cLA7tWSOeTZCIekl7Ox7i6utsNXClyo=;
        t=1629966060; x=1631175660; b=p21tFFDEbsmPetQoi2mWi/fKITK5omef8cCDVIerzxM3lKN
        mP0ms5DSbatUzUpWk/txR42kC0WKv0ZmO9rCsBc+z9ONve+FUB5ivva3wnYB8KK/34bF3zekkbhul
        mZoHYA5awvFh/LttG85J9R1/bLBe0oZ8x7xxtavhePVYvQKCsM9dBbpbfFyfpcsJ8EoSo0OBhl+Wp
        1lzCGk79lDScFURoXdGc1mUjDeCDXtk3kUfYShvGKcAfiEmK3W424Oi6Z1YD31Mrs8pDeOTWhFAqJ
        +5AjAyJ1J79Z47EIElg8aqsG5Zs7Gduarq0sPDdBde1SSYQxFeiY6dNl81QxZMOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAd5-00G4e2-Ba; Thu, 26 Aug 2021 10:20:55 +0200
Message-ID: <2c911f0e716cbe7c430f46ca5d7fdfd616b06e6a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 7/8] mac80211: add parse transmit power envelope
 element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:20:54 +0200
In-Reply-To: <20210820122041.12157-8-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-8-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-20 at 08:20 -0400, Wen Gong wrote:
> 
> +		case WLAN_EID_TX_POWER_ENVELOPE:
> +			if (elems->tx_pwr_env_num >= ARRAY_SIZE(elems->tx_pwr_env) ||
> +			    elen < 1)
> +				break;

IMHO this should also check the max length, but I'll fix that.

johannes

