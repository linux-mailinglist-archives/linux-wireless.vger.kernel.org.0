Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CD2CED42
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 12:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgLDLkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 06:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgLDLkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 06:40:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D9C0613D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 03:39:32 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kl9Qw-002MuG-9f; Fri, 04 Dec 2020 12:39:30 +0100
Message-ID: <10344296be9a9e4f6f30eb2adf6fa5a3263811cc.camel@sipsolutions.net>
Subject: Re: [PATCH v2] nl80211: reset regdom when reloading regdb
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Finn Behrens <fin@nyantec.com>, linux-wireless@vger.kernel.org
Date:   Fri, 04 Dec 2020 12:39:29 +0100
In-Reply-To: <X7+F/ht8T7aGiIl7@bombur.kloenk.de> (sfid-20201126_114222_031269_4F737E8B)
References: <8c3e46ac-331b-0922-5379-0cb1ef61a83b@nyantec.com>
         <X7+F/ht8T7aGiIl7@bombur.kloenk.de> (sfid-20201126_114222_031269_4F737E8B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-11-26 at 11:39 +0100, Finn Behrens wrote:
> reset the regdom when NL80211_CMD_RELOAD_REGDB is send

Please add a bit more commit message, saying why this is needed.

>  	err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
> -	if (err)
> +	if (err) {
> +		pr_info("failed to load regulatory.db\n");
>  		return err;
> +	}
>  
>  	if (!valid_regdb(fw->data, fw->size)) {
> +		pr_info("loaded regulatory.db is malformed or signature is missing/invalid\n");
>  		err = -ENODATA;
>  		goto out;
>  	}

These changes seem unrelated.

> @@ -1101,6 +1105,28 @@ int reg_reload_regdb(void)
>  	regdb = db;
>  	rtnl_unlock();
>  
> +	// reset regulatory

For whatever reason, the kernel doesn't use C99 comments.

> +	const struct ieee80211_regdomain *current_regdomain = NULL;

This should've given you a compiler warning that you shouldn't declare
variables in the middle of the code.

> +	current_regdomain = get_cfg80211_regdom();
> +
> +	struct regulatory_request *request = NULL;
> +
> +	request = kzalloc(sizeof(*request), GFP_KERNEL);
> +	if (!request) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	request->wiphy_idx = WIPHY_IDX_INVALID;
> +	request->alpha2[0] = current_regdomain->alpha2[0];
> +	request->alpha2[1] = current_regdomain->alpha2[1];
> +	request->initiator = NL80211_USER_REG_HINT_USER;
> +	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
> +	request->reload = true;
> +
> +	queue_regulatory_request(request);
> 
Why does it even need to be queued - we're in a process context where we
can sleep?

johannes

