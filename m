Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE685AAA30
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiIBIhS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiIBIgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F686FF2
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86B83B82A00
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F63C433D7;
        Fri,  2 Sep 2022 08:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107729;
        bh=wN3lDbBo/VZMIiQX+2XGmJvfMEq1mDJ03ryyKyrzzNw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nlH5oi6cA/wmRbczBr9AU6Fwt8mdTemptpolxQGWZMyGsxOlWWDbyAbUw1LsYuP2v
         d6UKYJzwA8cP/JJQLMkEkCGqSbJ/xyMutA4+Q/4pm18MnL5gPFCjzU3FmvQ37AGl5W
         4nupibjplk+G4pHLthe7K6C5IV0rzWQKNhcXCtfi/2ujSMvKMJ/J43hPmQCEzLWr4l
         PKQRJjZy5zozB/6iJjhGTlZcRR9cGb7qo5D1wATgv29g2oUK425ZPkW84UBfblhnE4
         CLL5XZUvDgSyERaxqxo0JyLFnROunhXmXcWkNcBF+o2pUh61FqGkkPuXqE3XS8SEF1
         DF0VfwVM8EVGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: rtw89: 8852c: declare correct BA CAM number
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220816013247.6243-2-pkshih@realtek.com>
References: <20220816013247.6243-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210772703.24345.15337879111360109949.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:35:28 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852A has 2 BA CAM entries, but 8852C has 8 entries. Add a field to
> discriminate their differences.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

2def73563318 wifi: rtw89: 8852c: declare correct BA CAM number
8b1b4730b025 wifi: rtw89: 8852c: initialize and correct BA CAM content
08aa80777be9 wifi: rtw89: correct BA CAM allocation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220816013247.6243-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

