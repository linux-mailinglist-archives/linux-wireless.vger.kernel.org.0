Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2698C5B593C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiILLZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiILLZ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9120F4E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FF7611BC
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B7DC433C1;
        Mon, 12 Sep 2022 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662981925;
        bh=EWaH68FJlROk+qIGw0/Apa8iTnEbDA5G9Udtau8Rx88=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SQylqW+NoQCExOkmnCKMnvvQEPsqe3xQxOvwQSKOIRFNgp2hvcf2DGMGjEhId47di
         bsY+RFiCECbfFnArP1B2TpZhVsmnRbe/mrj10olHKb4oph559DmtE7rHoBflH03xK8
         CBQksj5+/2EEpf9Rs7YkKJcuC9/XtdadDhvhkJg15UqsxfHQLCkY28C5+Nbsb7ygGd
         +C4npOffWqAF5qfOBJHJjZuZdX3s3Ih1s7/wT3MDgdOqGDZ7vZ73Qs5PaqnSq0i3YO
         VpdwxfRaTciZNR4BdH15czCB+heuzaL7cMevOfSdWhKpo0ozk/nLsJwCVH6/F6nYxd
         WZt8X+BzX34wQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.0] wifi: mt76: fix reading current per-tid starting
 sequence
 number for aggregation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220826182329.18155-1-nbd@nbd.name>
References: <20220826182329.18155-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298192339.17348.2852758764690081755.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:25:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> The code was accidentally shifting register values down by tid % 32 instead of
> (tid * field_size) % 32.
> 
> Cc: stable@vger.kernel.org
> Fixes: a28bef561a5c ("mt76: mt7615: re-enable offloading of sequence number assignment")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

c3a510e2b537 wifi: mt76: fix reading current per-tid starting sequence number for aggregation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220826182329.18155-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

