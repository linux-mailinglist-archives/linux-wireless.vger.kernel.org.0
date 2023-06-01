Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D693719D29
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjFANRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFANRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 09:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5356E7
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 06:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775D563958
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 13:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDF0C433EF;
        Thu,  1 Jun 2023 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685625466;
        bh=Wi90Rdf9TVMnRfg4uAaMFHWCX2YgFTwXVBtyUG4HGHc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Z+h0kLfLujlzMb4GsToe3njLM8OJNdjHFOgilrIRBjHB+LQuDTTESRAIzRNS049h6
         VZ/lN0gJOGX3aDurZpSjSpe3J02iUxxxBFtBL3bvzyOo1DYw6k5bQvnxTEJDYcK7Ac
         rmBoYvQkYHBOUIquF98V5rsQQ2/76VSmVIW8kEyqMCLKlyWETlextN2kGMcOkPzT5u
         bSyxdauoSI01Nd88S1akUrxhVlBQVtZgbt5gABXbboxzzAvvpJ84RIjUuwPwUUS4zC
         AEyrQN/k7bU4kvK/5ZjTdDGxoyz8xH4Xdkg7sYGtbzc8W5xwzaOOv9miK7G+vIPpH0
         skLcZsKH+K92Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7996: fix possible NULL pointer
 dereference in mt7996_mac_write_txwi()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org>
References: <2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168562546404.17673.6675539514670121435.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 13:17:45 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix possible NULL pointer dereference on mvif pointer in
> mt7996_mac_write_txwi routine.
> 
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless.git, thanks.

ead449023d3a wifi: mt76: mt7996: fix possible NULL pointer dereference in mt7996_mac_write_txwi()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

