Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38AC614694
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 10:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKAJZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKAJZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 05:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F918B2A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 02:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26DC96153C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 09:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE7FC433D6;
        Tue,  1 Nov 2022 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294739;
        bh=vJAWFjEgLAj+n7BtC/iJTcl+J4IX8mhC7i8QrRppVSk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZJ8x6lWrs0vQ+vtMeL3ygr+V2UvDCRdYK3S6iz9q3lN33VRxclaDx2SqGdCnugjeV
         5ALgN3/dS3X7nyWCmzuoHdpjYRRPB4v99HXUws+D78hzbwudYanXavoqfp7POQ4AM6
         z+JpCxWZM+o34jkCXk1ozB8nLEL4UzBWrWv0tgv/ZrMVDMUmMb6MJno67esv50kI/M
         /FkxXjm4S11GD/57wS9GceVPYLhC/vsRFatdhkazcMOnN7ImfCFf++cZ/TX+N5Fvyb
         nTTtgGgG2D68UPQPch4RVctXlxbisQ8Y6rzT55VpUTbQR5tH959tOfM1BPZrtccco9
         NQ1spEQ1Lf85w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: add BW info for both TX and RX in phy_info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221021091601.39884-1-pkshih@realtek.com>
References: <20221021091601.39884-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166729473462.21401.4251288821685657331.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 09:25:38 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> In order to debug performance issue intuitively, add bandwidth information
> into debugfs entry phy_info. After applying this patch, it looks like:
> 
>  TX rate [0]: HE 2SS MCS-11 GI:0.8 BW:80 (hw_rate=0x19b) ==> agg_wait=1 (3500)
>  RX rate [0]: HE 2SS MCS-9 GI:0.8 BW:80  (hw_rate=0x199)
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

25f49617b5c9 wifi: rtw89: add BW info for both TX and RX in phy_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221021091601.39884-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

