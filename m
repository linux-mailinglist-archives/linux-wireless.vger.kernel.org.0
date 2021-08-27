Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04243F961F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhH0IbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhH0IbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 04:31:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818AC061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NPI1DWHvxdOXdaAuD4n6bQ7bx+Wi8FJBMBcsb3Gyodc=;
        t=1630053020; x=1631262620; b=sjb25/pcrUCJ4bgTArlUwsWWiRu+9TtxBs1zV9JIczswIAO
        RVGvIvo9IvN8rQxYYTUzRkMMAe5oI1dj8WMs01nJNKgrCUMDSmMowTo2D5Qcvazl/10qpjldQJ64c
        TO61eDUxtJZUcrYJE36Qjl4Dpewo2g87GUqlp7NiOsRxEJ/vyEexbIXMlwZDbQQz/pyIfneVVe14V
        DTv+1scjIg8XktW+RSl8gxwuPcwZOPmB01jgMJzAwTLDsKkd36CljZO82Iy0rgLGB1PT7ECElB+Lb
        RavpsXzdRcYwk6lYMOuGD+BFuye9MSA0MYm7b961s94ZkiPfkG/HyWF8mHcaYe7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJXFf-00GXJu-1g; Fri, 27 Aug 2021 10:30:15 +0200
Message-ID: <e985d4aa1556e9660cc7d4a3ff348d64764c4ad8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 27 Aug 2021 10:30:14 +0200
In-Reply-To: <40e8c88cec2d3601afbfe187c57fac6b@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
         <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
         <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
         <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
         <110489059796b17849d0f32fb5189828@codeaurora.org>
         <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
         <01d9e4eadbb0d87edbc026fc719858a3@codeaurora.org>
         <3483aeb87a81dea538af3a2640cd49831274320f.camel@sipsolutions.net>
         <40e8c88cec2d3601afbfe187c57fac6b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-27 at 16:28 +0800, Wen Gong wrote:
> 
> the TPE is only 8 pointer in the struct ieee802_11_elems.


I know, but it's showing _just_ above the threshold for the warning now,
so if it was _just_ below the threshold before, adding 64 bytes could
still do that. 64 bytes is a lot, after all, the threshold is only 512 I
think.

johannes

