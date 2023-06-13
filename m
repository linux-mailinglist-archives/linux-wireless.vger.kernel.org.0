Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861772DC59
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjFMIZJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbjFMIZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9BAC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C372761371
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AB9C433EF;
        Tue, 13 Jun 2023 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644699;
        bh=e1nzMmlYiDQdDtnCGBMg4l8ZAu/JZ4WOsCLOZqytEhg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cjfSvBEMX3OOh1TNWVOhjLyds0Ohn3dsNE0Hd9LiImMHu3Iey+LNl3mwsBkOr1bok
         9tQIiAt8S3CJb3BXKuCD303iL4fXFVr2avuswKC576F/RGH5Ruu6CrYheHpqH3UEzF
         0xw63LBlTZMeoOT37t32P2evhlZpPPgVAhdjm+K0BOd1ThVTefwlafeb96XIXeGA1F
         ln/4p7dYyjTglK5M8QgUtwoMUzZCZsSdAPkXAOxjrOyBk7iAjSuy3e6Atsm/3gqtp2
         sqz1icajTA7rX96FXTvzn1+Vs4SJcjPHigykrXYBqKYbjKeuiTOcL84xBMvAh7i3rP
         zL/kJfiq80a2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: use the correct bit in the
 R_AX_PLE_INI_STATUS
 register
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZILW8Uct7yUjsVyh@ns.kevlo.org>
References: <ZILW8Uct7yUjsVyh@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664469619.24637.7314670094052746124.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:24:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> Use the PLE_MGN_INI_RDY bit rather than WDE_MGN_INI_RDY to check if 
> PLE cfg ready runs into a timeout.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Why? Does this improve anything or is it just a theoretical fix. The commit log
should give answers to those.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZILW8Uct7yUjsVyh@ns.kevlo.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

