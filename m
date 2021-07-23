Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571113D37B2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGWItS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhGWItR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:49:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4CC06175F
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3Qm6xZcMymKdfo9RM5NqXirB4Wo/7ICAOvyA6DwlxQg=;
        t=1627032589; x=1628242189; b=OTimCxUKUvPWVOEiy8u2/qxRpZUyicNV+rJKcPE87aunPF9
        EYFISkeHvZ5+HKu8U4X/cq+LpysziOv6oydk3GxTY1DPyIY1iiYySB+oL1U+u+11Mks1MFeKXghVZ
        Z8kCrn0nku4zrEhrbHeQ52ocjCG/gjDuHHXe46xM0ON7aVU30deikhuwCG+zW1V1WMQSaDokdGzXA
        pVDd+QfNJOawqr7D6CIwOAlHSeELIpqj99JdqIyMjo08IJLc8NR7WNwmjltFG4lk6LbgUbeM+XKJ3
        JFcsLCm70Oi8+J2EgBYPmqj6btJYkXWP+m0grWgrLdZaLc7LRk568xE71OO3NFKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rSU-000U6t-Ga; Fri, 23 Jul 2021 11:29:45 +0200
Message-ID: <58d19c13200063dc0a19625770db0601f047b5a9.camel@sipsolutions.net>
Subject: Re: [PATCH 6/9] mac80211: add definition for transmit power
 envelope element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:29:44 +0200
In-Reply-To: <20210517201932.8860-7-wgong@codeaurora.org> (sfid-20210517_222029_289940_80C21857)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-7-wgong@codeaurora.org>
         (sfid-20210517_222029_289940_80C21857)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
> 
> +#define TX_PWR_ENV_INFO_COUNT	GENMASK(2, 0)
> +#define TX_PWR_ENV_INFO_INTERPRET	GENMASK(5, 3)
> +#define TX_PWR_ENV_INFO_CATEGORY	GENMASK(7, 6)

Personally, I'm not a big fan of GENMASK(), seems more complicated to me
than
			0x0007
			0x0038
			0x00c0

but YMMV :)

We haven't really used GENMASK here anywhere else, have we?


> +#define GET_TX_PWR_ENV_COUNT(fv) FIELD_GET(TX_PWR_ENV_INFO_COUNT, fv)
> +#define GET_TX_PWR_ENV_INTERPRET(fv) FIELD_GET(TX_PWR_ENV_INFO_INTERPRET, fv)
> +#define GET_TX_PWR_ENV_CATEGORY(fv) FIELD_GET(TX_PWR_ENV_INFO_CATEGORY, fv)

I don't think we really need these, and we should be using u*_get_bits()
anyway rather than FIELD_GET.

johannes

