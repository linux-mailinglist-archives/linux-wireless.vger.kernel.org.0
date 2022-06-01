Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22933539D22
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349761AbiFAGTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349769AbiFAGTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 02:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870BF6A066
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 23:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0A9DB817F3
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 06:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC04C385B8;
        Wed,  1 Jun 2022 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654064341;
        bh=ahMPCuEzja98C3+MLmZ8Jd2FzggqehBUIJvPVQ7VFrY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ieofgAtaeXVEwHv6/xMMfC6LsZGlRXwgU0WGN63NxOW68KVRKcw4oginLBIbr5qH4
         m7vVoN9aTHIHG9EbdYuohnVVGVATwWnvCN/eMQCb1bEjoFLGHFx2eqvKjlWiDeYEh6
         yLUWs4PDlORmjhqDWyLOQLSjBEL6a43PiE1N3m3lJGaPz1DfEM6j/E4/mmY9R04I1t
         eHMxJI1toIpkbpc22UbZWqDTcc5rTP0q7L1yd1pPkoeub9dzYXH4mKMiDnrzvoJ+on
         O7+F2Fulig1h2+l2JQqyoyHNTaD5QQQpt8RXM9m8slxSoYUi89TtP5BviEILphwfiM
         wfteuSsgHI6Qw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] ath11k: fix missing skb drop on htc_tx_completion error
In-Reply-To: <cfb03aa3-1a98-8131-0090-93c8ae918e7f@quicinc.com> (Jeff
        Johnson's message of "Tue, 31 May 2022 13:32:18 -0700")
References: <20220528142516.20819-1-ansuelsmth@gmail.com>
        <20220528142516.20819-2-ansuelsmth@gmail.com>
        <cfb03aa3-1a98-8131-0090-93c8ae918e7f@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 01 Jun 2022 09:18:57 +0300
Message-ID: <87v8tkoqi6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/28/2022 7:25 AM, Christian 'Ansuel' Marangi wrote:
>> On htc_tx_completion error the skb is not dropped. This is wrong since
>> the completion_handler logic expect the skb to be consumed anyway even
>> when an error is triggerer. Not freeing the skb on error is a memory
>
> nit: s/triggerer/triggered/
>
> Kalle can fix this when he merges so no need to post a correction

Yup, fixed now in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
