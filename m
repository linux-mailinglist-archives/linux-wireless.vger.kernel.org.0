Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6566C3F0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjAPPct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 10:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAPPcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 10:32:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F116AFB
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 07:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35B23B80FEF
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 15:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8AC433D2;
        Mon, 16 Jan 2023 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673882859;
        bh=Zk7GE3Il4lxMYXyzndGj1Jxf/Pyj1fx7KVtHRNSl/5Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rH1rhjgv3JSZdwUrAuFncYHlK9afwNv7tUnwWWw9c+WS2FMtdgljDNnQCCzEPHBXd
         CswzM4UnDBCWwcUG50S0A7ekskOJ1dgzGOW6wMn6QNubuZzBv1bDgrk86PDcukg+96
         /AiBZz7naczKMw2ZVI0cGK6x1NyWIo0kds5qqKSCWNOfrtQ8+kOq368a4eLRZW9eps
         pChdC/y9vnAYYi6ZowpAIVNVrSopR+adWkTtP07slpQrbM7z5mgMi62luQ6bBKhGzs
         0R3dlyKWcxJPA9WWmqBu7zoQ1qEEZ+WTQ6RPLglLXHu7hytanHFcyMOWL0uZtC6MR8
         vTI3WLsN/N3qw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless 1/3] wifi: mt76: dma: do not increment queue head
 if
 mt76_dma_add_buf fails
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230113105848.34642-1-nbd@nbd.name>
References: <20230113105848.34642-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388285630.25993.8694081633392719567.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 15:27:38 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Do not increment queue head if mt76_dma_add_buf fails for Wireless
> Ethernet Dispatcher rx queues.
> 
> Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> (cherry picked from commit fe13dad8992be0b26c1be390bcd111acf9892c17)

3 patches applied to wireless.git, thanks.

1132d1c834d6 wifi: mt76: dma: do not increment queue head if mt76_dma_add_buf fails
e5c3ac895750 wifi: mt76: handle possible mt76_rx_token_consume failures
953519b35227 wifi: mt76: dma: fix a regression in adding rx buffers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230113105848.34642-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

