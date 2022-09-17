Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083315BB845
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQMr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIQMrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 08:47:25 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFC32A9B
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 05:47:22 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 1481 invoked from network); 17 Sep 2022 14:47:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663418840; bh=bbuc92MmsavU8/6ehJtov3b+wGoR9SactW28mgGrvKU=;
          h=From:To:Cc:Subject;
          b=m54WnJZTM3DKGpYRkM4tVeDHmQU0dQFifsjJzU8YQtPGGpue2Mm9JUt/tY5tpVLm4
           BrPZNLeGT7vqIO05UC7SKlE3y9yjND2mxsJc0qEbl9km+kZPXEYCnalp6k8FQ10ye7
           jW/FudITYEWrPWaJEjSEp2wfw6HuD8dh0MyuJrXc=
Received: from 89-64-7-128.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.128])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <daniel@makrotopia.org>; 17 Sep 2022 14:47:20 +0200
Date:   Sat, 17 Sep 2022 14:47:19 +0200
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
Subject: Re: [PATCH 07/15] rt2x00: add RXIQ calibration for MT7620
Message-ID: <20220917124719.GE17901@wp.pl>
References: <YyUBbZxKGljegJR5@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyUBbZxKGljegJR5@makrotopia.org>
X-WP-MailID: 9150cee57583d6ac5af93e2e51261efc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MYMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Sep 17, 2022 at 12:06:21AM +0100, Daniel Golle wrote:
> From: Tomislav Požega <pozega.tomislav@gmail.com>
> 
> Add RXIQ calibration found in mtk driver. With old openwrt builds this
> gets us ~8Mbps more of RX bandwidth (test with iPA/eLNA layout).
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    | 384 ++++++++++++++++++
>  1 file changed, 384 insertions(+)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index d5b4dba3b27203..6e5a72cf2a81a0 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -8695,6 +8695,389 @@ static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
>  	rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, saverfb0r2);
>  }
>  
> +static u32 rt2800_do_sqrt_accumulation(u32 si)
> +{
> +	u32 root, root_pre, bit;
> +	char i;
> +
> +	bit = 1 << 15;
> +	root = 0;
> +	for (i = 15; i >= 0; i = i - 1) {
> +		root_pre = root + bit;
> +		if ((root_pre * root_pre) <= si)
> +			root = root_pre;
> +		bit = bit >> 1;
> +	}
> +
> +	return root;
> +}
> +
> +static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
> +{
> +	u8 rfb0r1, rfb0r2, rfb0r42;
> +	u8 rfb4r0, rfb4r19;
> +	u8 rfb5r3, rfb5r4, rfb5r17, rfb5r18, rfb5r19, rfb5r20;
> +	u8 rfb6r0, rfb6r19;
> +	u8 rfb7r3, rfb7r4, rfb7r17, rfb7r18, rfb7r19, rfb7r20;
> +
> +	u8 bbp1, bbp4;
> +	u8 bbpr241, bbpr242;
> +	u32 i;
> +	u8 ch_idx;
> +	u8 bbpval;
> +	u8 rfval, vga_idx = 0;
> +	int mi = 0, mq = 0, si = 0, sq = 0, riq = 0;
> +	int sigma_i, sigma_q, r_iq, g_rx;
> +	int g_imb;
> +	int ph_rx;
> +	u32 savemacsysctrl = 0;
> +	u32 orig_RF_CONTROL0 = 0;
> +	u32 orig_RF_BYPASS0 = 0;
> +	u32 orig_RF_CONTROL1 = 0;
> +	u32 orig_RF_BYPASS1 = 0;
> +	u32 orig_RF_CONTROL3 = 0;
> +	u32 orig_RF_BYPASS3 = 0;
> +	u32 macstatus, bbpval1 = 0;

> +	u8 rf_vga_table[] = {0x20, 0x21, 0x22, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f};

static const maybe ? 

> +	savemacsysctrl = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
> +	orig_RF_CONTROL0 = rt2800_register_read(rt2x00dev, RF_CONTROL0);
> +	orig_RF_BYPASS0 = rt2800_register_read(rt2x00dev, RF_BYPASS0);
> +	orig_RF_CONTROL1 = rt2800_register_read(rt2x00dev, RF_CONTROL1);
> +	orig_RF_BYPASS1 = rt2800_register_read(rt2x00dev, RF_BYPASS1);
> +	orig_RF_CONTROL3 = rt2800_register_read(rt2x00dev, RF_CONTROL3);
> +	orig_RF_BYPASS3 = rt2800_register_read(rt2x00dev, RF_BYPASS3);
> +
> +	bbp1 = rt2800_bbp_read(rt2x00dev, 1);
> +	bbp4 = rt2800_bbp_read(rt2x00dev, 4);
> +
> +	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, 0x0);
> +
> +	for (i = 0; i < 10000; i++) {
> +		macstatus = rt2800_register_read(rt2x00dev, MAC_STATUS_CFG);
> +		if (macstatus & 0x3)
> +			usleep_range(50, 100);
> +		else
> +			break;
> +	}

This one is used frequently , I think we can add helper for that.
mt76 has mt76x02_wait_for_txrx_idle , so we can create something
similar.


> +		vga_idx = 0;
> +			while (vga_idx < 11) {

Looks like ideation issue.  In general this function is too big.
Could be split into small sub-functions ? 


