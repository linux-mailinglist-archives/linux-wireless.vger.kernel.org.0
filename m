Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189D4F746F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiDGESj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 00:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGESi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 00:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F231DCCF2
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 21:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D146261C28
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 04:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DCAC385A7;
        Thu,  7 Apr 2022 04:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649304998;
        bh=AXXJIKXZQcspTbLZrmkORgfqlyIjRaRW+Qpb1kEpfvc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LKq6KYb8e/v6lnx725gEdXQ91eWwY5Fv0IKCRhKhdJ4PKUAguBE1LUNpjFpEHSPEf
         8C/s/hWa6hY/Ew6sgHcwnW187GrghA6vtgu9cIdJV/Bz6WiB6fQ4Y+gbHzt+NRkl6r
         /eeuoFZgrI+j33jPeQnTfLi/udNXf7U1lnFRJvtFNL9z56fpYMGnHYcnvIz7AgAP/e
         mH/kxEOK2RRFALpn49/UCY9j0wed15CsmmmExzvi4eXYE0Lo3HfoIfV5OL+dgqa7vr
         P2sQz8eA5EsieX7d7BFRv4ptBku5vbIRP8kcI84b10VG7hUXkJdYJKfPByUk9ZSpr+
         s/WYNTb8XgicQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6/7] mac80211: add hardware timestamps for RX and TX
References: <20220406120924.979792-1-luca@coelho.fi>
        <iwlwifi.20220406145756.8c67d9d16b62.Ib11def78ef30a308f73602338b8c17d4a781a433@changeid>
Date:   Thu, 07 Apr 2022 07:16:35 +0300
In-Reply-To: <iwlwifi.20220406145756.8c67d9d16b62.Ib11def78ef30a308f73602338b8c17d4a781a433@changeid>
        (Luca Coelho's message of "Wed, 6 Apr 2022 15:09:23 +0300")
Message-ID: <87ee29sf30.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Avraham Stern <avraham.stern@intel.com>
>
> When the low level driver reports hardware timestamps for frame
> TX status or frame RX, pass the timestamps to cfg80211.

So the driver is supposed to set timestamps for all frames, not just
management frames?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
