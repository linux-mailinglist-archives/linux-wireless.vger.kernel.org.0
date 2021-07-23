Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7B3D37A3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGWImo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhGWImn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:42:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044F3C061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=r5cwD4SqBwKFbUOXyNm3ivl2yIn3BK5PAFCB14rQW6w=;
        t=1627032197; x=1628241797; b=OBztmeV2H0zQJ680S8PTA653UGapXl7CCzr208ZSw83c+lK
        mffl4JbX/JeufrghneUFDYwKNsp9PF9TbAXjvGYhK37rSNKj3CnZrzIoVVC4hqyjk5UmhP9LOLugy
        Ruq0rEIujl7tbRPYXk+XPa56fqtQd8AVVf8Qc5Llw4yhWGy/xo49ikCN6ac0+sY1Dq/5IOh7yVYiy
        g9VE/7DIiB0EDPzf9RT5o3g4B/9Z4afImMLLubSaqJ3SdEKcd0dXyg9lIG55xa93dJwTJWKaAowGb
        87W0Nls+/3GO4CDel3Zqw2isMPv+tpzIcSeXcZjjEW6BK5AIX0iCa/6ECZOh8beg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rM9-000Ty0-Dh; Fri, 23 Jul 2021 11:23:12 +0200
Message-ID: <0a958db9948bc16fce0ab1e3b7d010ca64f5a18b.camel@sipsolutions.net>
Subject: Re: [PATCH 3/9] mac80211: add parse regulatory info in 6G Hz
 operation information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:23:11 +0200
In-Reply-To: <20210517201932.8860-4-wgong@codeaurora.org> (sfid-20210517_222019_338829_5D3A5A0F)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-4-wgong@codeaurora.org>
         (sfid-20210517_222019_338829_5D3A5A0F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 6G Hz
(subject)

You have a few different ways of spelling "6 GHz" in this patchset,
sometimes only 6G, sometimes like this - I'd prefer it be consistently
spelled as "6 GHz" :)

johannes

