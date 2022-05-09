Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF951FB74
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiEILok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiEILoj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 07:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C32213324
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 04:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE476118D
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 11:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F84C385A8;
        Mon,  9 May 2022 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652096444;
        bh=eeVoDmHC4PGS58SJlBYUk0CFX2/KN3tqf7iSr215GkU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZF43ZZVN3BU+a2QnD87qlFs5vHE6bcbKcnWuMheMj1Ga/NgSPkUtNc9EBSa0uULku
         zUzqLAdmC4JiFvXm6LKHRsOJIQJAM0ILN+5DHCnkJ1k7XeAyC+ImtG4z7VsCRnQt78
         44Gptb0HdrQO373ntlVRySGqjfieGDOX30U645ns2alC2NAKV5IagG8JSKqaSiWoaA
         w0QWKc922o/xAgLWyNaItsPC5KbqMOA3S3XAlgVPAVSJf1iAe/XO46+zKmJmyWisOV
         HbiG4jaRVZk5FAJfORkyZWvDTinELRkv+NcKfpotykh1AeHFNYbxiD8bMm3MlbnFih
         OW7AtTMUVechQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: adjust adaptivity option to 1
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506235045.4669-1-pkshih@realtek.com>
References: <20220506235045.4669-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165209644175.4132.7913165691142072268.kvalo@kernel.org>
Date:   Mon,  9 May 2022 11:40:43 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Fine tune algorithm of adaptivity sensitivity to avoid disconnecting
> from AP suddenly in field.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

4fb3f1f1818c rtw88: adjust adaptivity option to 1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506235045.4669-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

