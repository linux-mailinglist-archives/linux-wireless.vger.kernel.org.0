Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21A6D4632
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjDCNvH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjDCNvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:51:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920E0EC66
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E25E6CE1283
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B26C433D2;
        Mon,  3 Apr 2023 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529837;
        bh=KXb654pOlO9IZUwS6X4T64kuYcs6aFDZ3puK+EwNjJk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NPw5el2/IGyKWSRuz7zM7JJ6A00s5oa8b1WNG/Q2pRNjBo0DjPsaK2FWau/OZFmlR
         pNkdL0+FMMGPwBeXWyrcR2Q6AshcTXajOnHEJNhAN/rdLTEWY4ks0Sm6UNB5f865O5
         nMwmKooVMP23BKniZ3YNHjpK3BosZ6FvRequ3ccHpgHCys+TUl60+wIHDiBqzjyq68
         vYrn6C4fWnZS2P55sU8Vq0uENht0wjHEER83dSvIguI96oZPSwD0bz603DdsZt2CYO
         k9pU4wW7zNf53N7g1LYrll0AIBGUvf0qxxdlF0f5wX6/zy8l3GwS7AGgE8xgQOc4Co
         Q5IAOiNCqWgaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: ignore key disable commands
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230330091259.61378-1-nbd@nbd.name>
References: <20230330091259.61378-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052983449.12755.12918457324948223503.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:50:36 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> This helps avoid cleartext leakage of already queued or powersave buffered
> packets, when a reassoc triggers the key deletion.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

e6db67fa871d wifi: mt76: ignore key disable commands

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230330091259.61378-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

