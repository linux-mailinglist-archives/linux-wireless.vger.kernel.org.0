Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B579EBD2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjIMO64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIMO6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:58:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8498B3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=L8c85DCnO4azoBI+4LVfXkV94X/8ki+QpERiYVq3FmA=;
        t=1694617131; x=1695826731; b=ZTCT7feQYMV+pLquNKH6UjaMYwr/31N9xTjYT8NVkWVyOsK
        4EZ4nDONY6dr0YeFH2R+U8QsFNXhiRKcQxeFkqLDLKy4ioJj5vE+C7LYq/ytANngXtV7SknBzAwSU
        qV2Mm6gt2lsNgQsVi1W0gl4z5fDCXhThiDpvHboaaGYmsQLR9xwUHsoXmY0/9KdRPFDyQLrdU41Sp
        L2PScbIDswLl00Mtm/HjLFzZWobRFoCXkyVlwegT13E9ht6RpJVhr6Rs8kQen+Oz0yobtU2SKxXxa
        TQGMSAA6lpaaw6IU5eRf/CxFbTj/uacMacCNLRUg8e/b1pRD8UXwH71B+xgY6S9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgRKL-00F3YB-13;
        Wed, 13 Sep 2023 16:58:49 +0200
Message-ID: <4cb3e92530d3f4db3b414e2a7536a0f01b765c4d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density
 (PSD) of the regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
Date:   Wed, 13 Sep 2023 16:58:48 +0200
In-Reply-To: <20230315132904.31779-3-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <20230315132904.31779-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-03-15 at 18:58 +0530, Aditya Kumar Singh wrote:

> @@ -8650,6 +8660,14 @@ static int parse_reg_rule(struct nlattr *tb[],
> =20
>  	reg_rule->flags =3D nla_get_u32(tb[NL80211_ATTR_REG_RULE_FLAGS]);
> =20
> +	if (reg_rule->flags & NL80211_RRF_PSD) {
> +		if (!tb[NL80211_ATTR_POWER_RULE_PSD])
> +			return -EINVAL;
> +
> +		reg_rule->psd =3D
> +			nla_get_s8(tb[NL80211_ATTR_POWER_RULE_PSD]);
> +	}

Wait ... I'm not sure why we've been adding stuff to this recently, but
anyway, this part should only be used by CRDA which is deprecated
anyway?

So I'd say we shouldn't touch any of the code under #ifdef
CONFIG_CFG80211_CRDA_SUPPORT any more since CRDA will not continue to
developed with any updates here.

johannes

