Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D86B7947
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCMNog (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCMNoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDE58C17
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3902D612AE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB56C433EF;
        Mon, 13 Mar 2023 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715065;
        bh=EG3F1l1KXKN4JEdW5ttxp5LlruwpACJ/06TMYkeg9P8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RH1uNPXOggyjW/t+7gSSfszehUVY7cZ+etSWrgTdY8n6SX6E51IPnwL0B63R08z5i
         rsvOwwg8Nz0noSzFsfDwwlVPAHf+O7vb1M8I5GWDLOliLjqfpigxN7W7Bmn41nXNcB
         DEB/3otDhq7jW9FgU6QMEWP2XVPGnJWHVOgvFdQsKT9xQOMw7QI5+I4O9uyzpRaCkV
         XfPXRoSXhxTj5ZVPwO7ewwZhTcqFiybb3TK+NkY3PvFgbj00pElPZNWy0a+eoi0InH
         BLkBAQJ61F3rTaeHsC94fVL9Dj9dQU3cNUy0Xk4OQFOA57wOAD5tqdQnBeBsUlLsFy
         cmqXDfY/6YkNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ipw2x00: convert ipw_fw_error->elem to flexible
 array[]
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230307230148.3735684-1-jacob.e.keller@intel.com>
References: <20230307230148.3735684-1-jacob.e.keller@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871506266.31347.15867066093999254730.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:44:24 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> wrote:

> The ipw_fw_error structure contains a payload[] flexible array as well as
> two pointers to this array area, ->elem, and ->log. The total size of the
> allocated structure is computed without use of the <linux/overflow.h>
> macros.
> 
> There's no reason to keep both a payload[] and an extra pointer to both the
> elem and log members. Convert the elem pointer member into the flexible
> array member, removing payload.
> 
> Fix the allocation of the ipw_fw_error structure to use size_add(),
> struct_size(), and array_size() to compute the allocation. This ensures
> that any overflow saturates at SIZE_MAX rather than overflowing and
> potentially allowing an undersized allocation.
> 
> Before the structure change, the layout of ipw_fw_error was:
> 
> struct ipw_fw_error {
>         long unsigned int          jiffies;              /*     0     8 */
>         u32                        status;               /*     8     4 */
>         u32                        config;               /*    12     4 */
>         u32                        elem_len;             /*    16     4 */
>         u32                        log_len;              /*    20     4 */
>         struct ipw_error_elem *    elem;                 /*    24     8 */
>         struct ipw_event *         log;                  /*    32     8 */
>         u8                         payload[];            /*    40     0 */
> 
>         /* size: 40, cachelines: 1, members: 8 */
>         /* last cacheline: 40 bytes */
> };
> 
> After this change, the layout is now:
> 
> struct ipw_fw_error {
>         long unsigned int          jiffies;              /*     0     8 */
>         u32                        status;               /*     8     4 */
>         u32                        config;               /*    12     4 */
>         u32                        elem_len;             /*    16     4 */
>         u32                        log_len;              /*    20     4 */
>         struct ipw_event *         log;                  /*    24     8 */
>         struct ipw_error_elem      elem[];               /*    32     0 */
> 
>         /* size: 32, cachelines: 1, members: 7 */
>         /* last cacheline: 32 bytes */
> };
> 
> This saves a total of 8 bytes for every ipw_fw_error allocation, and
> removes the risk of a potential overflow on the allocation.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>

Patch applied to wireless-next.git, thanks.

a23c82e006db wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230307230148.3735684-1-jacob.e.keller@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

