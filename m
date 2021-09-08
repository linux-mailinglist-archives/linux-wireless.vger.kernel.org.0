Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F24034AF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbhIHHCt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347962AbhIHHCr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 03:02:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1AC061757
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HP3JYBib0733pf46bS3DoQ4PhZZNztZqGHAWUkz0ixg=;
        t=1631084500; x=1632294100; b=gx5BegzDWRhuh5aQsfgdOiVoZfeESpjVPx0ZC6SBIWFCKIu
        eZgQViICxMy4YP9IhbbhF8SNkDfvIP022Bd0DC0dnzmJpHVX9froYpSXa0JcQceeiP3i3iislClF4
        q4Zl3E32fQfl0AzFVKcw8QzIufpF2jS0qO27gXpLCvvJwUBAx+JAeSGk0BsmcfHL3h87mumoSeFZ6
        ZfDvp0FiXQpOQFgULPrOPFn+3Df5rLnllhbfw6EnFcHrcbBl1P9m4452hOJ14Iststz5mlsENuVbp
        YwmoujeBg4+q0SfE3EOc/1CEpcU0uW49OXuQRmWLIg0XA2M2fRbornlGKrG4EW2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mNraT-004EBi-MR;
        Wed, 08 Sep 2021 09:01:37 +0200
Message-ID: <fb5dc775524d8c358d2e2fae9e28280d48e49eff.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: AP mode driver offload for FILS association
 crypto
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Subrat Mishra <subratm@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 08 Sep 2021 09:01:36 +0200
In-Reply-To: <1631083922-24136-1-git-send-email-subratm@codeaurora.org>
References: <1631083922-24136-1-git-send-email-subratm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-08 at 12:22 +0530, Subrat Mishra wrote:
> 
> +	{
> +		.cmd = NL80211_CMD_SET_FILS_AAD,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = nl80211_set_fils_aad,
> +		.flags = GENL_UNS_ADMIN_PERM,
> +		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_NEED_RTNL,

I don't know how long you've been sitting on this patch, but NEED_RTNL
is no longer acceptable.

johannes

