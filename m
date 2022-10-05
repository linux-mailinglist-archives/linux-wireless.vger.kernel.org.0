Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C95F506A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJEHml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJEHmj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0FC5E64D
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 468DEB81CA5
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D46C433D6;
        Wed,  5 Oct 2022 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664955755;
        bh=VA2VbCmQ+Z/CZO9fxOYhpx1R6L4RXu+mgFza2IZ5at4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eCo+P3w9GPemBQlIm+9dHoLOM4kzLV+BaY1CcB3WVdJ3JLfUXxwbsjYbzDx9jnEhv
         45lm2uMmfnU/knOgeJlPD+d/KMgDrh6FrLO4OVH0BmLGzAWP0+4fmWiomipRqbN/F9
         XAf3eezwzP99wb3gv+C9fnWxQ0MvfYulXi3J5B2yFTvhsIqv5OCPbz2n8iLQvb0j2A
         4XQOn5e8ZBxOXmHtD3MYwQOBZrCXgrU9O5lr9Bp0teaAbuXQCIjnQe+RBGDe3iQ78x
         XHn7tEew+VNlvYqvlMw9SeGP7p4U4/EAPFbrT6pmnGpLxKJ2mLGZtOB/i9kGhUXn7J
         dguI2bkId/WmA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852c: correct set of IQK backup
 registers
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220930133318.6335-1-pkshih@realtek.com>
References: <20220930133318.6335-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166495575354.5945.4721912097227658525.kvalo@kernel.org>
Date:   Wed,  5 Oct 2022 07:42:35 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> IQK can change the values of this register set, so need to backup and
> restore the values. During we rewrite IQK, the policy is changed. Some
> values are controlled and filled by IQK, and don't need to restore after
> IQK. Therefore, remove this kind of registers from this array.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

68b0ce5bb400 wifi: rtw89: 8852c: correct set of IQK backup registers
3be11416204a wifi: rtw89: 8852c: rfk: correct miscoding delay of DPK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220930133318.6335-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

