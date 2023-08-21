Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9935782E05
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHUQOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjHUQOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24FEFE;
        Mon, 21 Aug 2023 09:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E2863D47;
        Mon, 21 Aug 2023 16:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA8C433C8;
        Mon, 21 Aug 2023 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634451;
        bh=ZVlSDi8/0DFgCEop3t/Qx7hMzSgQcVHdJFD4kB+Nb5I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ef9VbZms6+fGm5GnS9tiMiTAVDo0wIU6vDVZaNk+5C1DOpN4sYeBFARHOPtqx6z5b
         k5YDduWMvp38nVFKz8grqMyBndv15K5Fux4wvG9IvauM5QvLqinFuxsxvaWDQgcfDj
         cryH2PbZK494b3xgZ4qaCjIK7RROkY5feM4+y5y0jnt5uIZCie+nx7SUPaHNGs4RCo
         AMIfo3V1LlqDImu8MuTuTlsN11j22AkqDn5CD3MNQrgbbSm37t2G6kwR8DDMdCCEap
         x6qsT5tn/Glv86Q9RgWfo+y5S7q5nBhuMY1s7DKGw+X9ld6amsUI+p7VhI6viHGYF6
         QHAt85xCTbiOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix a width vs precision bug
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
References: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Chin-Yen Lee <timlee@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263444855.572263.15398577248490057559.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:14:10 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The "buf" is skb->data that comes from the firmware.  We want to print
> "len" number of bytes.  But there is a missing period so the "len"
> variable is used for formatting (width) instead of limiting the output
> (precision).
> 
> Fixes: cad2bd8a136c ("wifi: rtw89: support firmware log with formatted text")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied to wireless-next.git, thanks.

e2a61151ff8c wifi: rtw89: fix a width vs precision bug

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

