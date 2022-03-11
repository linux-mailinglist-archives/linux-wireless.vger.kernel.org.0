Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9674D6840
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 19:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiCKSFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343712AbiCKSFW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 13:05:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE991B0BD0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RChqngkkOkfqZxUnk5T9mEkJiANxo7SnNQDYq5MExmw=;
        t=1647021858; x=1648231458; b=UCAch1uaom7ocMkKDmfXbsgbqBO3pGo378kPhrYvN3XqT6S
        IYck6bT5DlQq0j8dHjqZDs1IWSUiqBX66MVJGDq7Qm8z5MQlJ+qtyX9M+f8YDtuR2+KKKOEz3qFgm
        lo8sBA3Js6R8oaYXtteds6YZ2BaG00R94J0oNJILOfs0GJtG94gR+qPs1CdNBxUl55h5Bj3cF15JJ
        SQSUR4rDuUEUuwhseFrprsYi7PQpZKClG84uCVP0/0CVuPFAH2VL47s39inlpcn/8x0miGEaypPL0
        3geJzui7SsCK2GlpYUAH6Pb3+LUpkFwA1uorMugaIBFReqsld1nwJXAUNFhzPndA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSjcZ-00Bzof-H8;
        Fri, 11 Mar 2022 19:04:11 +0100
Message-ID: <23914231f7ec66a5552ff6cb3fb6ec91a7c6cc61.camel@sipsolutions.net>
Subject: Re: [PATCH] qtnfmac: fix null check
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Weiguo Li <liwg06@foxmail.com>, igor.mitsyanko.os@quantenna.com
Cc:     kvalo@codeaurora.org, geomatsi@gmail.com,
        linux-wireless@vger.kernel.org
Date:   Fri, 11 Mar 2022 19:04:10 +0100
In-Reply-To: <tencent_1874B4BE714648459A63EC78424E87226609@qq.com>
References: <tencent_1874B4BE714648459A63EC78424E87226609@qq.com>
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

On Fri, 2022-03-11 at 21:30 +0800, Weiguo Li wrote:
> We did a null check after "mac_info->if_comb = kcalloc(...)", but we checked
> "mac->macinfo.if_comb" instead of "mac_info->if_comb".

Yeah well:

	mac_info = &mac->macinfo;

johannes
