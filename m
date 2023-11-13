Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D067E9BCD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 13:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKMMFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 07:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMMFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 07:05:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF2FD6D
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 04:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B70AC433C8;
        Mon, 13 Nov 2023 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699877150;
        bh=KKaeZfp6WdFTcz1zS9N0PuPBIqVOTaAZFAMTGi56FI8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bytXtYv1R28BA4osyUG2IKp6WzeGy9QNoGKe9EK1b5ymCxDRp7QSx+cJIZaM2/2f/
         wwqFGIwDKkKakZ3Ii17p8VymDlS3nK4N3KvmHhPZ81rObn0FsBonkQcXmkjjpd1TgK
         E7x9PnOlY0oWiK10ewM6ikK7OtUBMTbUXli+NqHV1WJ0Zxigr6HYwg5WsAsvuMgOWJ
         FV9EmHTAaIpok4hPLwyUahQLjveRa7eF3B/PMvDNz5UhQu/NsVdcNLVKqJQsUKNWhz
         TmdkTtwIar3LSNy6Y9V6Mjudg6AdyxT9H8xMTlRCKy27oCtzQ/AGtgdraJXl3zLu47
         mxboJot4UPuZg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH wireless] wifi: mt76: mt7925: fix typo in
 mt7925_init_he_caps
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:47 +0200
In-Reply-To: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 13 Nov 2023 11:06:33 +0100")
Message-ID: <87cywdvox0.fsf@kernel.org>
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

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Use iftype for interface type switch in mt7925_init_he_caps routine
>
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver
> for mt7925 chips")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

What issue does this fix? In other words, what are the user visible
symptoms?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
