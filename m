Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE896B7903
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCMNbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCMNbe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:31:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389C37B5B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44281B8106E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AADCC433D2;
        Mon, 13 Mar 2023 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678714244;
        bh=jedHWfUCyWHu4Dmjb38U4oCyEA4q8BXGXaQ8V8Ehjyg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q/m/SqWYAR8zshrJORJw+PcGyimrLXG0r/Qf6eeL66irLNda8baaipeocBYki1Riv
         gWDOD/zTsWvFtkdYicfFdqNFTNQW1glN8Mc/s2burjzGibVlWfimPCB8j8hfwYxIHm
         781CiUio7cTn/4jFxiqYFWZ+jKlQXMllFq/xYpCpZDN7HvsXtk7PYETXtoYYvAzkYg
         hhpWLin3wuYQNLQKbDhgRInVIjQ1LlY8zlVo4HQOrTjl2RY9h/RvUrYzbt5NHygXCS
         1XAjJ6fCkYzKDtnT5rr6J8pOyYW78qCQb6XVSC/D1HAdse9PGzPmDeL4CUtMfsgq1L
         THFTD6bVOfqcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.3] wifi: mt76: mt7915: add back 160MHz channel width
 support
 for MT7915
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230301163739.52314-1-nbd@nbd.name>
References: <20230301163739.52314-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871424103.22880.17558695029802237900.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:30:43 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> A number of users reported that this support was working fine before
> it got removed. Add it back, but leave out the unsupported 80+80 mode.
> 
> Fixes: ac922bd60ace ("wifi: mt76: mt7915: remove BW160 and BW80+80 support")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

c2f73eacee3b wifi: mt76: mt7915: add back 160MHz channel width support for MT7915

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230301163739.52314-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

