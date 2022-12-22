Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4902654585
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 18:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiLVROM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLVROK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 12:14:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5429372
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 09:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2B661CC7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 17:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7137C433D2;
        Thu, 22 Dec 2022 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671729248;
        bh=ELVRUej20Nwy2G//4c2KV1ctOQI3QQ0mZxMEOF9ji+Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IyB41KSx1+Ub8SObfG2AICV0czU7O0Bmp/TM0QKn4T3I5No3tEh6pDxmR95JStUeI
         YUlkcZVpwphvEzt5kUroZjZ4re0jlBGORMtoHS57db78Npb3I1l3RozuD7N2Gj/BUV
         gvw/GI1i4hdCoT/iSZq80b2hMF8m/sk2/Bh+8vlVeZXp+DkuEK/WVWomnPdQW9giia
         /fcqy799dLOoPR7YmfFELCSOXHr2HqbLPAdNGM8tpu2wuobA93zj3T7McszO3aOhH3
         jIx7tgO0Hjh+xd7ORYf1VSzWrypozr8LJtuyYotJh6oMg58kJPiCk6CAHoBayUelX6
         MHD7xl7VEHUaw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: remove most hidden macro dependencies on ah
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
References: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     =?iso-8859-15?q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167172924589.3254.5088372639709589360.kvalo@kernel.org>
Date:   Thu, 22 Dec 2022 17:14:07 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> wrote:

> Adds an explicit _ah parameter to most macros that previously had a
> hidden dependency on ah. This makes the code more compliant with the
> style guide.
> 
> This change does not appear to affect the final binary.
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b3a663f0037d wifi: ath9k: remove most hidden macro dependencies on ah

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

