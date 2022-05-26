Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667EF535341
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiEZSTt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiEZSTm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 14:19:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556D506DE
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1rRQEPeAmfrGFVhlJRON9pa9G0CJ9lRsgKJVlprLDVo=;
        t=1653589177; x=1654798777; b=QMJd3gw0rtPLVu6IY8IHk5m/bBLYNIA9TIW1Td6/vG69e0b
        DzGaVuuCNsgpwGsv8kYTFWDvYkSSBKjoJDKGOmsM/UmaXebfWWO6GeClDXSq/jdFQji8Du/yiEz2T
        VAgcC1jmWVqwzWVinM3h8MbbuyvUB16F9p8135ZJMs1eTjF4G5lTRSb5CFrWDvJBpsUy5P2CMrTb3
        C6UqKL5+ZlzNOD6b2vG7suGkiQU8B8fvq/dFJNMGI494r09KjVgZHOkBFJL31CdHmgId3KAGJQIdH
        xwZpuU3o603+fSgXSjUPkl4vFkVIfF7eSuV7ZXFO/2+h6a1z3j5GN/MRxiJXGIWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuI58-005EZE-8g;
        Thu, 26 May 2022 20:19:34 +0200
Message-ID: <9dfe69b9194c0a95cb554b952b84c5c1d00e3349.camel@sipsolutions.net>
Subject: Re: [RFC v2 05/96] cl8k: add ampdu.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 20:19:33 +0200
In-Reply-To: <20220524113502.1094459-6-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-6-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:33 +0300, viktor.barna@celeno.com wrote:
>=20
> +	if (!ieee80211_hw_check(cl_hw->hw, AMPDU_AGGREGATION) || !cl_hw->conf->=
ci_agg_tx)
> +		return -ENOTSUPP;
> +
> +	if (!cl_txq_is_agg_available(cl_hw)) {
> +		cl_dbg_warn(cl_hw, "No free aggregation queue for sta_idx [%u] tid [%u=
]\n",
> +			    cl_sta->sta_idx, tid);
> +		return -1;
>=20

That'd be -EPERM, which is really not what you want to return - please
use symbolic errors throughout. Maybe -ENOSPC in this case.

johannes
