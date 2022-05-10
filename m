Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4965F52211B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbiEJQ0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbiEJQ03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:26:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8FB2CE0F
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=29Gh6lUZVfoU2soXdk+Fj/DGpM+SLDTUfKReAp8jy+w=;
        t=1652199751; x=1653409351; b=iNMgSpw/wSLZL5FNclLlIGsnXWDMejagT51DqEY2aQqhGoP
        IUu65oKTPOYPmWg86p6Zs8GcRsF8WaUjgju+SHo4ppBWpcYKv1xi/8tA2nVOlQ8cdpx/E75ZpxJP7
        5Or142F0GOFjQWokFll/bHvx55EGJTYpgfmjbSE4/FLUp0EzibcKEA/Omg+/DOUTlMnGU1s2g8usY
        Kya+AvA7zDDf1/+8C7mF0auW7zjgG7Ud6RA3hSrp6yRc/yNRm6uJ6AjcXxCpXvCmlENfCy7GOJuC+
        2/9Dp6pyXKGpPqQOtC99hkstXBxcfwiirt520+eMPfJUkF4+6a0ADVCVwQgy1qvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noSd2-007sHz-OJ;
        Tue, 10 May 2022 18:22:28 +0200
Message-ID: <e941f28fe46341dac47c44afc848039ea2008577.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Simplify queue selection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-wireless@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Date:   Tue, 10 May 2022 18:22:27 +0200
In-Reply-To: <7704c238-1d19-b423-881a-6bb3b8920946@nbd.name>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
         <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
         <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
         <7704c238-1d19-b423-881a-6bb3b8920946@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-10 at 18:21 +0200, Felix Fietkau wrote:
> 
> To fix this properly, we'd need to move to iTXQ for all drivers (by 
> having mac80211 push packets via drv_tx calls after pulling from iTXQ).
> This can probably be done without having to modify the drivers.
> 

I looked at this, and I kind of really want to do that, but it's not
_entirely_ trivial... If somebody's sufficiently motivated I'd
definitely be happy :)

johannes
