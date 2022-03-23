Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0F4E4F69
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiCWJcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiCWJcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 05:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789F6C90A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 02:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5325F617F1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 09:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD21C340E8;
        Wed, 23 Mar 2022 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648027838;
        bh=vZYCNUHV4zmv/5CoibqwB+H/k7XXEhrK/ObsmEfltFk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CM7k9IJMzKBbCu77FXQcHmKtdFhxAcYgfr7+rOl4EIBhn9+eg22hxRkvZNgKpixjZ
         j+B86M8VwxUz+VF7s0NQFpeOBdcFrW8fPQN386lOvRAGu58VsNBRvekZp5YU7Z7qU7
         lapSL7lGhlDUFWoQc9DO+aEM3vlXR3CJQzIjRDdrbzMnsI3y8bw/amFoNFNJ2s0nwB
         qEUV2SDvHsbSyGL5R/ai6S5ydwnNYH06qdPi9ZxPaceANrrRXveT1Ri9hT/v5oTwLP
         37O/9JiLmR/Uko4yQ53wteiamXKJshL7CTmksVxCYtxhqyeulqhrbxSiiFC1bJpu2z
         7jOWzbAAxVf5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
        <20220320233010.123106-5-wlooi@ucalgary.ca>
Date:   Wed, 23 Mar 2022 11:30:35 +0200
In-Reply-To: <20220320233010.123106-5-wlooi@ucalgary.ca> (Wenli Looi's message
        of "Sun, 20 Mar 2022 17:30:08 -0600")
Message-ID: <8735j9vww4.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> The current implementation is reading the wrong eeprom type.
>
> Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

The Fixes tag is wrong, I fixed it in the pending branch.

In commit

  265e303cc469 ("ath9k: fix ar9003_get_eepmisc")

Fixes tag

  Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")

has these problem(s):

  - SHA1 should be at least 12 digits long
      Can be fixed by setting core.abbrev to 12 (or more) or (for git
      v2.11 or later) just making sure it is not set (or set to "auto").
          

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
