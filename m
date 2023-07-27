Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040C7646CF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 08:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjG0GZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0GZz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 02:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAC1737
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 23:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536C761D2E
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 06:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63461C433C8;
        Thu, 27 Jul 2023 06:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690439153;
        bh=03DTX74J6VXxZp4+jEQ2csehpY497pC49E52qsgVptY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gc3X8jtjqy0JIJq+iKyDQ2NqmzXwlht3bLGzl1V48NeV3/1xjicxLOytRITd+QaUd
         C1HRF9uhEPDlLXX8P5JdQ1bWJSAXDCjFDjgoaRZT0TVOxYUWmSmC4k7CRuaYLpXFsW
         HF4u5Pm+3RNHdke6yCcZSYli/wKrEUJ8z3A9vNkl3O7aVtBD4kGOxIfvPaCPMZGimC
         zNUHlKx1FrAJxmEUY57YHxymfEA0QavLmuViA5/z4nOBC0kG1peU3cPjtmp43fbzE0
         +F2XlRkRk3H5AKV4XGCTkjHeBFB5hw+MSmBBF/RMF/MFgt9VSIOBh6+J2KBIfy+kCe
         e/rTx4xkpPlUA==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Ruth <druth@chromium.org>
Cc:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        jsiuda@google.com, arowa@google.org, frankgor@google.com,
        kuabhs@google.com, abhishekpandit@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] wifi: mt76: mt7921: fix the wrong rate pickup for
 the chanctx driver
References: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
        <7c7c2c1f0584e8dd016bc2bf8de88684fcc7679c.1690232804.git.objelf@gmail.com>
        <CAKHmtrQVp9yV1uFagENxW1ra3sVCf-9WP4thpQ97runk3PaXKA@mail.gmail.com>
Date:   Thu, 27 Jul 2023 09:25:58 +0300
In-Reply-To: <CAKHmtrQVp9yV1uFagENxW1ra3sVCf-9WP4thpQ97runk3PaXKA@mail.gmail.com>
        (David Ruth's message of "Wed, 26 Jul 2023 23:43:55 -0400")
Message-ID: <87v8e5zx8p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Ruth <druth@chromium.org> writes:

> Reviewed-by: David Ruth <druth@chromium.org>
> Tested-by: David Ruth <druth@chromium.org>

Please don't top post and edit your quotes, otherwise use of patchwork
becomes horrible for us maintainers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
