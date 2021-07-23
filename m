Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF43D37C5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGWIxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhGWIxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:53:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602BC061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eEgru/BErxZ5RFckEhJVfW2QEESEkpBfrJ0xlqtEV60=;
        t=1627032829; x=1628242429; b=WH9GCAmee9oXpilHiAGulriNTRuYV0u5DiFT5bvfYwBddT2
        XOJcE/+RmM+mvaTPJ4ZXHMyWq20vXYTDhXk1aeFHjOR8VYB9qj6k+orA/N05TydyPtWQEPLBQnQBX
        fwNxochAU1mzLw3+XsMgPFDNyHXK7aquaMjRx4JmTjx7SlwzRUfaOaSjuX5MKKz5z6j0MBovTAU/y
        CV/TGEKtEd6G0bU+JJk5ldDFMCWbcJf/hDrg/m1M9VzJaCC0dsoQ68eLaj0idz0M0hkawAOcsRXpV
        J7JtJjtRAurRqIMDTGHa0DfHYvkaVhGPgWvwUesUHttT0LmLKSIQqkWd2o7I+Mrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rWM-000UEO-Or; Fri, 23 Jul 2021 11:33:45 +0200
Message-ID: <c5d0572a6f2076170a1f50e2b33db82ccfe5adf0.camel@sipsolutions.net>
Subject: Re: [PATCH 8/9] mac80211: add transmit power envelope element and
 power constraint in bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:33:44 +0200
In-Reply-To: <20210517201932.8860-9-wgong@codeaurora.org> (sfid-20210517_222030_180537_A7E27982)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-9-wgong@codeaurora.org>
         (sfid-20210517_222030_180537_A7E27982)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
> This patch is to add definition of transmit power envelope element and
> power constraint in struct ieee80211_bss_conf for 6GHz.

This does nothing, please squash with the next patch.

johannes

