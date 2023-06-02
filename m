Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332FA71F9A9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 07:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjFBFcQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 01:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjFBFcP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 01:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D6C98
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 22:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AADC164AF9
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 05:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C468C433EF;
        Fri,  2 Jun 2023 05:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685683933;
        bh=W7z+G3u3NMTuzBLbx/P826d5tMzNU1iKc4JxP+G4Gc0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iGFyMPnpCRGjJEFDgT8msFraQsVi2SOOMoYCZr1gv7RHEbik8IVockxoXOhR2io75
         8pLC2Hz9nVBlp0YmqG/wbtIxn0mpU5M2yGxcx2/PtM1PbLCFYwwMW2uYEgwhN/i4tt
         GBuhZTm2cy6AhKK65AhgtG08XGF6qCDWigJ9DntiLOpbjPa8S8jP2GRGg9QYU7Lrmx
         4YmKiPk2tpOtouV3FLX1BJ41NUUG6FETNk+Ndnra7XeJqiYOexX0MMn37JdJWE0NgB
         wFj/L2Nzso2mslXWPne17Um17tWoCqt17PwVK/6P2v//L+v7tU5x0u3c3Az9MjTgG2
         NT2WyOc2HvnKA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Neal Sidhwaney <nealsid@gmail.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH v2] wifi: brcmfmac: Detect corner error case earlier with log
References: <20230601054034.43692-1-nealsid@gmail.com>
Date:   Fri, 02 Jun 2023 08:32:07 +0300
In-Reply-To: <20230601054034.43692-1-nealsid@gmail.com> (Neal Sidhwaney's
        message of "Thu, 1 Jun 2023 01:40:36 -0400")
Message-ID: <878rd2jup4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neal Sidhwaney <nealsid@gmail.com> writes:

> In some corner cases, an I/O read can fail and return -1, and this
> patch detects this slightly earlier than is done today and logs an
> appropriate message.
>
> Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>

The formatting seems to be correct now, at least patchwork looks ok:

https://patchwork.kernel.org/project/linux-wireless/patch/20230601054034.43692-1-nealsid@gmail.com/

But the commit log should always answer to the question "why?". Is there
a specific reason why you want to do it earlier?

> @@ -980,6 +981,11 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
>  	 */
>  	regdata = ci->ops->read32(ci->ctx,
>  				  CORE_CC_REG(ci->pub.enum_base, chipid));
> +	if (regdata == READ_FAILED) {
> +	  brcmf_err("MMIO read failed: 0x%08x\n", regdata);
> +	  return -ENODEV;
> +	}

Indentation here does not look correct, did you run checkpatch?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
