Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5056F130D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjD1IMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 04:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjD1IML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 04:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD701FF7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 01:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA26C64137
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FB5C433EF;
        Fri, 28 Apr 2023 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682669528;
        bh=dUDTu1D1lFx1mD9VVSXWLBio9szUW5fz3KU4yjoQDRo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XiW+xMzggPSDEjPG4eM9Yv4kWrjxkoU1Oxz73JWHZ6tAJa5FPwak3FA2eUpkcheld
         CihLMIyVJaZYum+AYagGybBaYnIc9cW9SeYsjIbNVXxffcPQBtFUkHAnWe59sCXM18
         1NxlQFi46tg8y+jjwv+rCuN2Rf9drBrOQwXT6CdEDlx5YaSl+/QQmqzo1b+sIqfdDR
         l+nBX05cNeC7sKXYUda22GFOVDEQM4rFRrksR3q+im3N7feM9a6RPhOQNmAMcOQ/2h
         1uWbrPiJWSIbVJonKWuuIpWPQIqHpAzMGvrKAOMK7xy82+xtj20x2lgWni4sw6R5tu
         Y4JBpjYBzCtIQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] cfg80211: Handle driver updated MU-EDCA params
References: <1682620315-590-1-git-send-email-quic_msinada@quicinc.com>
        <1682620315-590-3-git-send-email-quic_msinada@quicinc.com>
Date:   Fri, 28 Apr 2023 11:12:04 +0300
In-Reply-To: <1682620315-590-3-git-send-email-quic_msinada@quicinc.com> (Muna
        Sinada's message of "Thu, 27 Apr 2023 11:31:55 -0700")
Message-ID: <87edo4pgrv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> writes:

> Add necessary functions and attributes to receive updated MU-EDCA
> parameters from driver and send to user space, where management
> frame are updated to reflect latest parameters.
>
> The updated parameters from driver are part of an AP mode feature
> where firmware determines better MU-EDCA parameters based on channel
> conditions. The updated parameters are used and reported to user space
> to reflect in AP management frames. These dynamic parameter updates
> are offloaded to firmware for better user experience, thus details on
> algorithm are not provided. This is a driver specific feature, thus
> no spec references.
>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>

"wifi:" prefix missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
