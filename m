Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E84766340
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 06:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjG1Eim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 00:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjG1Eik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 00:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028826A0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 21:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4540B61FA3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 04:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BCDC433C8;
        Fri, 28 Jul 2023 04:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690519115;
        bh=6Paqva8bTnilynKTua0zFM0M59eOyMt9X4M6p8RMM8U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NkOdTdWFehRT23qyjre+6rgJ6eJMMR6kzjw9mvRx3AdcVn25zlPM9cmJItll7VDyu
         pEvRyv9G4eWFiDNLZLKNNAov0rfFabrF1iYLrUPuUb5lW7kiPjWX8AOzkXATYJVv3X
         Lga301nkiqVEQe8r7w9RFczgUcGDSRB6ItYWT2CF0x2K4uMl10qv3N7ehdkLQgNwMO
         I7lgJ7g9+hB8JaFZP3jqrgd9U2GCeYJ8+UpPGEFloL5hATdyEzvGjbxVRZqUZ3Eihu
         3I5OnQw5PEya5P5f6kpGCwWmTZ11a7R6Z6EZM8fUtEQxgXxm72qxm7CCsE3ZTgdZ1z
         qdiobhGg4i0xg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <yahuan@qti.qualcomm.com>
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support
 for all power modes
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
        <9d393f3e-4452-47c4-1911-92d817e89a25@quicinc.com>
        <f070a5d3-e013-590b-ca05-43b777e9783d@quicinc.com>
Date:   Fri, 28 Jul 2023 07:38:44 +0300
In-Reply-To: <f070a5d3-e013-590b-ca05-43b777e9783d@quicinc.com> (Wen Gong's
        message of "Thu, 27 Jul 2023 15:48:45 +0800")
Message-ID: <87r0oszm3v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Hi Johannes,
>
> Kindly Reminder. Could you give comments for these v3 patches?
>
> On 6/9/2023 1:41 PM, Wen Gong wrote:
>> Hi Johannes,
>>
>> Could you give comments for these v3 patches?

Please stop spamming the lists like this, it's simply rude. And check
our summer schedule:

https://lore.kernel.org/all/87y1kncuh4.fsf@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
