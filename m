Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92174B65E4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 09:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiBOIUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 03:20:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiBOIUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 03:20:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22B9BBBE
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Y4xJYlLiAI3eidWxLUjP9iLDxbIs9iAFeLwInC+ws5Q=;
        t=1644913222; x=1646122822; b=K2l2dnnK7+4EToW30s1E4rj2vMbcycOkrehVhXNTDuVIqEZ
        mA/n8Pi2xqOLhNm6zFzKbWitqzW8+WjX+Ns895oKbtLRGGUTfpIXBEezjQdH3vrC1op/aZmFxUwsu
        5/+VUuhj1Yxsku/VheGCuIfPEtk6bdU5p1pgY/8yuoB0ZNoP+IL5YJ4AErVWxkhjcZNdFw4f5Nn+E
        wbuveI5kdbhezgc9IdcLgMHTefYtYxUxBToDWT5ozIPfoDkwwZrIiffFg4Gzsrk03wT6TPwbTPwtU
        OC20TFIqjsfFYQb7GbxikpXoCXb4tgU/rFvKHn8/3Gr3fp3AmK7hsBRELcz8ROOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJt4O-001LaW-Co;
        Tue, 15 Feb 2022 09:20:20 +0100
Message-ID: <1e4c2234663bf3e7c5f481999e3b50d9b7961083.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] nl80211: advertise RU puncturing support to
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 15 Feb 2022 09:20:19 +0100
In-Reply-To: <20220214223051.3610-2-quic_alokad@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Mon, 2022-02-14 at 14:30 -0800, Aloka Dixit wrote:
> 
> +	if (rdev->wiphy.ru_punct_supp_bw > NL80211_RU_PUNCT_SUPP_BW_320)
> +		return -EINVAL;
> 

This check really belongs somewhere else, e.g. wiphy_register() or so?

johannes
