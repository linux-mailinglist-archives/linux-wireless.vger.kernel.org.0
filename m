Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3A41F1E1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhJAQMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJAQMu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:12:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E318C06177D;
        Fri,  1 Oct 2021 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=laKyfFWU+cmryX08PIvbn5jn2uvTsnRUpE43WSwkwSI=;
        t=1633104666; x=1634314266; b=Zq8eDjHS1Oej+xWRrosC0Kzb/xBxHTRubddttIc4bu5QHcD
        HRJOapg4bhXjReY0OxDSnqNzPrhBRZgdNYZpAFVq3e1YTJupfe4P8Hg8npI970Mvu6HIk9i8awzI9
        CVhk/6JEpvx+UEnD78gUql8OjEUvsqPuMT0ZC/HObKlZFZmg1SqUEL9nJK/Yyqrx8NLqxo9jFY8nr
        po20DJq6Mao0NptOcezjpmcomeR8tmItx8Sg/wi8+XSz30t8o0T8LUesflUGZcPVgJAZFzThI1o9q
        PPIT4oD42/kt0crjEtbYotHibH6C2oL9N/f7Hm2uMzWzGqYaqdkkY3QkuuijoUNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mWL7m-00EHby-RI;
        Fri, 01 Oct 2021 18:11:02 +0200
Message-ID: <1058fe13a8b5ce56b0ec22039209c9b00d98dcc0.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: fix error pointer dereference in error handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 01 Oct 2021 18:11:02 +0200
In-Reply-To: <20211001125616.GI2283@kili>
References: <20211001125616.GI2283@kili>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-10-01 at 15:56 +0300, Dan Carpenter wrote:
> The error handling calls kfree(params->acl) so if "params->acl" is an
> error pointer that will lead to an Oops.
> 
> Fixes: 9e263e193af7 ("nl80211: don't put struct cfg80211_ap_settings on stack")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/wireless/nl80211.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 0b4f29d689d2..962fb169a5fb 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5507,6 +5507,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>  		params->acl = parse_acl_data(&rdev->wiphy, info);
>  		if (IS_ERR(params->acl)) {
>  			err = PTR_ERR(params->acl);
> +			params->acl = NULL;

Yeah. I think I had just applied the exact same patch:

commit 05075fe7455a210769b266e62a0040ddc98b2739
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Sep 27 13:44:03 2021 +0200

    nl80211: don't kfree() ERR_PTR() value

johannes

