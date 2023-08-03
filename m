Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49676E004
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHCGFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 02:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjHCGFk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 02:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6895E4
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 23:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F7061B91
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 06:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B82C433C8;
        Thu,  3 Aug 2023 06:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691042738;
        bh=WZTFoVHcGeMmalzByxFyx7Fz4svVAt6JNaj6xq40gBQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i/o2o8dFGsGjnQXVMP5YG/uLnZFrELKMI3syPiEHRsJ6Vft4oFTwK+hseKfHiujD3
         y2vhYx5UZj7jW2YTYmXQAkjAXRPnGjCsIpzJUoE0h26tEgXaxOSB9EplqlsojLECdW
         djSb8ta/PwH+AYWjgS6nRqY6aKzGkohazUJrix3QezuunKs5nywtxoR41yyVw1vfyA
         HMIaXUd8sKeOmkgof6ve/k7WNhY5H+dc6uPYQdoYFgBhgG33yVb0REGQNOqTXXW615
         nLmIJ4vHyV9pV102vzjTwqQFXeOyxkLyz6fKjwM/RZi1ENdDseYzGHhHvYlBPAUr2p
         JHczCFRlsMtog==
From:   Kalle Valo <kvalo@kernel.org>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with
 flexible-array member
References: <20230803052238.12147-1-rauji.raut@gmail.com>
        <20230803052238.12147-2-rauji.raut@gmail.com>
Date:   Thu, 03 Aug 2023 09:05:35 +0300
In-Reply-To: <20230803052238.12147-2-rauji.raut@gmail.com> (Atul Raut's
        message of "Wed, 2 Aug 2023 22:22:38 -0700")
Message-ID: <874jlgvexc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Atul Raut <rauji.raut@gmail.com> writes:

> One-element arrays are obsolete, and flexible
> array members have taken their place. So, in
> struct cca_stats_n_flags, replace the one-element
> array with a flexible-array member.
>
> This fixes warnings such as:
> ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9:
> WARNING use flexible-array member instead
> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>

I have now three patches from you in queue:

https://patchwork.kernel.org/project/linux-wireless/patch/20230731011635.20993-1-rauji.raut@gmail.com/

https://patchwork.kernel.org/project/linux-wireless/patch/20230803052238.12147-1-rauji.raut@gmail.com/

https://patchwork.kernel.org/project/linux-wireless/patch/20230803052238.12147-2-rauji.raut@gmail.com/

v1 submitted twice and v2 without any change log. Please read the
documentation from our wiki link below how to submit patches.

Also I would like to have a review from someone else before I consider
taking this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
