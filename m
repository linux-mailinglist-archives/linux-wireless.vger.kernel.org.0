Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0855BB837
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIQMe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQMez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:34:55 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3D1D32F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:34:52 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 859 invoked from network); 17 Sep 2022 14:34:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663418089; bh=H0bWb7vCyXq7oI2LkDnBEQHCr4PJlpbhdZdsopE54/o=;
          h=From:To:Cc:Subject;
          b=cO0nP/Mo4tNMMMnYk9dWRu2u6Ojo+C+ASyhRUG70zXAJ7PXixCh5sMLhLz2fvb30E
           17vHptVvELPZtc3oYUG0qiY5bnEoQaemVClabjoM48Pm6rO5rs1Rb/x2Lzayc9BsL6
           t1IiWMS8zlbbymIRWDcJkn2vBHHsyDKPIvl2207c=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:34:49 +0200
Date:   Sat, 17 Sep 2022 14:34:40 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 04/15] rt2x00: add RF self TXDC calibration for MT7620
Message-ID: <20220917123440.GC17901@wp.pl>
References: <YyUBN0F9t8GfTEQ3@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyUBN0F9t8GfTEQ3@makrotopia.org>
X-WP-MailID: 2faaca68bc641801aedfbc36a1cf6cbf
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8TOU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:05:27AM +0100, Daniel Golle wrote:
> From: Tomislav Požega <pozega.tomislav@gmail.com>
> 
> Add TX self calibration based on mtk driver.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>

Daniel, this needs your Signed-off-by,

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> +	rt2800_rfcsr_write_bank(rt2x00dev, 5, 1, 0x4);
> +	for (i = 0; i < 100; i = i + 1) {

Why not i++ ? :-) 
> 
