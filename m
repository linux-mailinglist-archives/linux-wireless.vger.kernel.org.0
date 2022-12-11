Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61B649529
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Dec 2022 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiLKRM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Dec 2022 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLKRMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Dec 2022 12:12:54 -0500
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08718BC9F
        for <linux-wireless@vger.kernel.org>; Sun, 11 Dec 2022 09:12:50 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 1523 invoked from network); 11 Dec 2022 18:12:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1670778762; bh=1nt6EAlhgk2nwkDPstF6IhZZw1aP5T5mZpnCqYziP7o=;
          h=From:To:Cc:Subject;
          b=jWSVbUMIFVjE+7EiQSTW3N63va1NWmtV/kPcfoq4IhVuTtEfin9Pv8sNX7SBLIs+L
           bLhN8AZMu4rTJlG4MxQK+zIRmIXP/4oic3G2h99gUC+j6BAgLTltvzLpEwzucx5p/B
           ndoVa0wtE4035zQ7lPpodF103b3ArWk9WZg8Pnac=
Received: from 89-64-15-29.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.15.29])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangyingliang@huawei.com>; 11 Dec 2022 18:12:42 +0100
Date:   Sun, 11 Dec 2022 18:12:42 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: common: don't call dev_kfree_skb() under
 spin_lock_irqsave()
Message-ID: <20221211171242.GA810227@wp.pl>
References: <20221207144013.70210-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207144013.70210-1-yangyingliang@huawei.com>
X-WP-MailID: 13ccd522ca636df53a1aea510e9fbb0c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EaOF]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 07, 2022 at 10:40:13PM +0800, Yang Yingliang wrote:
> It is not allowed to call consume_skb() from hardware interrupt context
> or with interrupts being disabled. So replace dev_kfree_skb() with
> dev_consume_skb_irq() under spin_lock_irqsave(). Compile tested only.
> 
> Fixes: 4bc85c1324aa ("Revert "iwlwifi: split the drivers for agn and legacy devices 3945/4965"")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

