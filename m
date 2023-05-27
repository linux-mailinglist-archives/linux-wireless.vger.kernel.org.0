Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69796713341
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjE0IRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjE0IRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D012A
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 01:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7510760AC0
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 08:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3ABC433D2;
        Sat, 27 May 2023 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685175446;
        bh=25oVWuqrMZQegHIMxg5qA8RCZTPzReBmBx150UZTXEE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eqtpS8I9SI//2A//yhm6yDJXj1P6TZHflGoHY7ZzwBy+2ojoZZ/30S4UxRdlcYl24
         x/jWz+IHoRkvz+Wmf4C6ht2QNRW+HUuUGYfKPBRqa/8fxNwXwIPl0yghANFWl+bQx1
         OMZKsIV4E9Ebf+TLWEA34EJgahDkcfWZpmmcNcMemZ8ShEymAww5QWj+ViaOAXlbaU
         JTR6kwQnePRC2arIRsWdb531QZHNFPNaRqmpBeU7ajVWhpseGOi1se2kFwlOjSdrfK
         7tTDhnxYYE5ZsIP09LnTkNP9LBeEcvDhGJPHg83DqJCMIuL12VqM/QsoG31OwgsUTx
         khilk84NCIqWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7615: fix possible race in
 mt7615_mac_sta_poll
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org>
References: <48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        nbd@nbd.name
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168517544393.19767.7798185086603649281.kvalo@kernel.org>
Date:   Sat, 27 May 2023 08:17:25 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Grab sta_poll_lock spinlock in mt7615_mac_sta_poll routine in order to
> avoid possible races with mt7615_mac_add_txs() or mt7615_mac_fill_rx()
> removing msta pointer from sta_poll_list.
> 
> Fixes: a621372a04ac ("mt76: mt7615: rework mt7615_mac_sta_poll for usb code")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

30bc32c7c1f9 wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

