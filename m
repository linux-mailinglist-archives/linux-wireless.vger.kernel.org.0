Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAD4E5A16
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 21:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiCWUsI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiCWUsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 16:48:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0F8CCC6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0Qxtz1L63MJJGmZbh22FeB8BoxzX09nGGm/rRYdvIw4=;
        t=1648068397; x=1649277997; b=KNFW5BOW7tgytlFeilv+f0+2UJ8ggzmQCd9rXiIXdBfri+s
        bd00lAa5JHhx11OFdHkZ1d6E4g/xtJGJk5HCUlnKwc6vDwlFksT7rIUbiC1KXG+R/Qzb79NlMTkcK
        HQTxUf3vbu56MDjd42VjM/5D2ZS89KO9Yhh+2xUGaYWFKn+ovdeJ6WrJ1cZObTHlShZZEw7Puf5n8
        dlPZVAT/kpJ+/ZvElNLcgO2QhZp1M4KmqM4Wrlyk0B2ReKG0OF8uGiuHMczJzpyDh66IPfEk0x9u7
        KQCLrrXJtdddeNVTg5CkeEwYbU1Goe3tWOuOaQzK7hR4WhKpjOy5tWbLeyxFuOtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX7sJ-00HE7z-Hm;
        Wed, 23 Mar 2022 21:46:35 +0100
Message-ID: <3a2974e63c6da59ba65e2cc768245477fb4c1dd6.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] nl80211: advertise RU puncturing support to
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 23 Mar 2022 21:46:34 +0100
In-Reply-To: <e2faf5ac-ee71-3ed4-7598-70f083a5996c@quicinc.com>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
         <e2faf5ac-ee71-3ed4-7598-70f083a5996c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-03-23 at 13:45 -0700, Aloka Dixit wrote:
> On 3/23/2022 12:16 PM, Aloka Dixit wrote:
> > RU preamble puncturing is allowed for bandwidths more that 80 MHz
> > except 80+80. Drivers may not support puncturing at all or have
> > restrictions for a minimum bandwidth.
> > Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
> > driver support to the userspace. Default value (0) will indicate that
> > RU puncturing is not supported.
> > 
> > Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> > ---
> > v2: Moved boundary check for ru_punct_supp_bw to wiphy_register().
> > 
> 
> These patches depend on EHT support from
> https://patchwork.kernel.org/project/linux-wireless/list/?series=614176&state=%2A&archive=both 
> which are not yet present in mac80211-next tree.
> 

There's no mac80211-next tree anymore. Well, it exists, but we've moved
to a combined tree in wireless-next.

johannes
