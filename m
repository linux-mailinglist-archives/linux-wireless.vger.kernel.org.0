Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9D4ED92A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiCaMC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiCaMCV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 08:02:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1471C553C
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iu2GQb788hJrg8Ry1hz+aY4HjHu+m64LJJ9DY9DclMY=;
        t=1648727961; x=1649937561; b=p6udm5YYgfhJpptouk93a7Gaytd/r8/95tAx16f3oNBBkV0
        Y4Flb0BuDVYT/4j8W6w4yEYp0s4Uw/yT+AKQ0GwUlHtwKG5ueQ1XenxeevAa7C6kEpQmsRzcAdIQ3
        iNNulIm5/u+xHJ8U+paCiHnbhn2/meGLJmeo59jfNQCYHKMTACkm9Uz8cYMSx35ROpcQKGCUUZk8J
        4to1OpwPAAhq27yggwCCg7NO+gNse/yUBvDgRxvbV2oY2BGzlJpYeHjx7y/DHEQ2djVumkJ1L4UJT
        n1V8HwElXsJZL7dAD/IBGHqdlbWj1x3BQx2B2Y8AbwtASaO//AboS7hBtodLc0hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nZtSD-002woy-AY;
        Thu, 31 Mar 2022 13:59:05 +0200
Message-ID: <2f25bb87e665488b30f6fdaa5877ad8b5b19da0a.camel@sipsolutions.net>
Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure with
 WoW unsupported hw
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 31 Mar 2022 13:59:04 +0200
In-Reply-To: <87sfqyv1td.fsf@kernel.org>
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
         <87sfqyv1td.fsf@kernel.org>
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

On Thu, 2022-03-31 at 13:44 +0300, Kalle Valo wrote:
> > 
> > Fixes: ba9177fcef21 ("Add basic WoW functionalities")
> 
> Fixes tag is wrong, it should be:
> 
> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
> 

$ git config --global --add alias.fixes 'show -q --format=fixes'
$ git config --global --add pretty.fixes 'Fixes: %h ("%s")'
$ git config --global --add core.abbrev 12
$ git fixes ba9177fcef21
Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")

:)

johannes
