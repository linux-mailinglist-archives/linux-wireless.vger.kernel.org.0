Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E531F5BB859
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIQNEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIQNEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 09:04:05 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71733A12
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 06:04:04 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 21211 invoked from network); 17 Sep 2022 15:04:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663419842; bh=xyE6fBgd8fEWZcKLIiPx8bFYGsMxXRLdnpvOQl51wtg=;
          h=From:To:Cc:Subject;
          b=L1l8N+2xOeRHJQ2wSnxGPRvCqYC8z1uv7NDDueL6Hi9zNjmQCnTZqlkpEz9MKQuMJ
           XQG5rhPQtIjX6DPkJyQ3sBGpNXgCANvyepFShRPAtqPTRT09dtwfQNVa74pKUnini/
           QDcgLStkNXKIwK+a9u60yAZQg3OZvUFbhsQLBUpc=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 15:04:02 +0200
Date:   Sat, 17 Sep 2022 15:04:01 +0200
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
Subject: Re: [PATCH 09/15] rt2x00: add TX LOFT calibration for MT7620
Message-ID: <20220917130401.GK17901@wp.pl>
References: <YyUBkIKr/KrBsOcD@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUBkIKr/KrBsOcD@makrotopia.org>
X-WP-MailID: 0c0efc7922f25918c3e8454279e3656e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gdOE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:06:56AM +0100, Daniel Golle wrote:
> +static void rt2800_loft_search(struct rt2x00_dev *rt2x00dev, u8 ch_idx,
> +			       u8 alc_idx, u8 dc_result[][RF_ALC_NUM][2])
> +{
> +	u32 p0 = 0, p1 = 0, pf = 0;
> +	char idx0 = 0, idx1 = 0;
> +	u8 idxf[] = {0x00, 0x00};
> +	u8 ibit = 0x20;
> +	u8 iorq;
> +	char bidx;
> +
> +	rt2800_bbp_write(rt2x00dev, 158, 0xb0);
> +	rt2800_bbp_write(rt2x00dev, 159, 0x80);
> +
> +	for (bidx = 5; bidx >= 0; bidx--) {
> +		for (iorq = 0; iorq <= 1; iorq++) {
> +			rt2x00_dbg(rt2x00dev, "\n========================================================\n");

Is this useful for debugging ? 

> +void rt2800_loft_iq_calibration(struct rt2x00_dev *rt2x00dev)
> +{
> +	struct rf_reg_pair rf_store[CHAIN_NUM][13];
> +	u32 macorg1 = 0;
> +	u32 macorg2 = 0;
> +	u32 macorg3 = 0;
> +	u32 macorg4 = 0;
> +	u32 macorg5 = 0;
> +	u32 orig528 = 0;
> +	u32 orig52c = 0;
> +
> +	u32 savemacsysctrl = 0, mtxcycle = 0;
> +	u32 macvalue = 0;
> +	u32 mac13b8 = 0;
> +	u32 p0 = 0, p1 = 0;
> +	u32 p0_idx10 = 0, p1_idx10 = 0;
> +
> +	u8 rfvalue;
> +	u8 loft_dc_search_result[CHAIN_NUM][RF_ALC_NUM][2];
> +	u8 ger[CHAIN_NUM], per[CHAIN_NUM];
> +	u8 rf_gain[] = {0x00, 0x01, 0x02, 0x04, 0x08, 0x0c};
> +	u8 rfvga_gain_table[] = {0x24, 0x25, 0x26, 0x27, 0x28, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
> +				 0x31, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3F};
> +	u8 vga_gain[] = {14, 14};
> +	u8 bbp_2324gain[] = {0x16, 0x14, 0x12, 0x10, 0x0c, 0x08};
We should use static const for those. 

> +	u8 bbp = 0, ch_idx = 0, rf_alc_idx = 0, idx = 0;
> +	u8 bbpr30, rfb0r39, rfb0r42;
> +	u8 bbpr1;
> +	u8 bbpr4;
> +	u8 bbpr241, bbpr242;
> +	u8 count_step;

This function one is also huge too and I think require a bit refacing
int smaller sub functions. Also utilize lot of stack, there are no
warnings about too much stack consuming ? 
