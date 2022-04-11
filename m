Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D54FBD3A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbiDKNg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346540AbiDKNgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 09:36:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE9965F9
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=C9xchTjAFtTmjuDam3HVfCer5l+epoWakYY3IKI8vpw=;
        t=1649684078; x=1650893678; b=PvKleetziwk0qvP9GcMrj28DI8kl0pVwrSmuLcUwMT/2uwR
        VryMJw4ibBgYIrOKNwlElRdFJ3Ms0FmrzO1Pu0kuOusg7ycyQc5T5Sgq/ceRrCwVnyKK2WhGNEZEL
        4QfNped51EZ5Ypv6uY1TyunVG5MLEbSG3j8dz17ayYxlhVLj3oSZNmjt8zZCEsIsUXzf95lPvESkY
        WMkzEwyjmRUJAAxamHyESFkmuNPFpZRKdip0IyXdUsEEh1sghSVUieQMXLfnfuoAdiQo76uupa9xx
        dssy2Bd4EtToYVJsCNq89Y4XTUEXc+2O+O3sv0g1thSKzVp5rMIKzCayuESrIiag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nduBg-008Ixl-Va;
        Mon, 11 Apr 2022 15:34:37 +0200
Message-ID: <01e5333a9a41f1eba214d3bca36cd38fada5a3fd.camel@sipsolutions.net>
Subject: Re: [PATCH v4] mac80211: disable BSS color collision detection in
 case of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:34:36 +0200
In-Reply-To: <1648195961-3811-1-git-send-email-quic_ramess@quicinc.com>
References: <1648195961-3811-1-git-send-email-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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


>  include/net/cfg80211.h |  4 ++--
>  net/mac80211/cfg.c     | 11 +++++++--
>  net/wireless/nl80211.c | 62 ++++++++++++++++++++++++--------------------------
> 

Also, the mac80211 part is small, so maybe split the patch. Yes, the
mac80211 part is the key part that actually does something, but the
changes in the API could use a separate commit message explaining how
they work and how they are backward compatible.

johannes
