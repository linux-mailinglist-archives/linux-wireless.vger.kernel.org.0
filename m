Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A98508CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiDTQCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiDTQCO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 12:02:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0440926
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 08:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18366B81FC3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 15:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD00C385A4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650470364;
        bh=jBfkbPt+WqgrPbEPmDx39QoUW/YAD8qvmYlg9t4Mkzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mBQ78bcB6jv/eAbe97JJ8+XTsUUv+Fv5eapfmKoPLosoW1/bBsGuUTm+jOMTjqO3Q
         w+7eagVbzzcLB019NsyReCqk3xJTYToZAmHOPSRAHZYwl42QpuisUDVqf6sDZHmV7k
         XGU7KbGQycQ64H92sJMIxZvR6eWjeSsOyIFFGmHOe4ob0U1yRF9hU/y0QMDBWa3EuV
         Jmw38jHt7/c4N6rooAP9Lf4Wn7Qos7KWrEiTrRGPlFaL9/a/XSqYT+ZTc403mzWwN/
         rA3YkxV7gMLeeI/dtXGw4wD4HjhBPcmD+DGJaczdqjoEk2laSBvuhI8NeuvjEMYP0r
         qubCCfPI2bvnA==
Received: by mail-pf1-f169.google.com with SMTP id b15so2325164pfm.5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 08:59:24 -0700 (PDT)
X-Gm-Message-State: AOAM530jr0QXBO5gD31/nHq804x9CyJakuRQ4ejabtTb3jqrVwwHTy4Q
        oOMkQgGidRhp13BPg7mU3DAn20hjogPevUo0Z08=
X-Google-Smtp-Source: ABdhPJwonKJxRDyNfYcRX41UD6pJGFn6O6+MW6Tc4OsxbMvkwf4L2igEDcKtGR2bmUF/TGdgM5vT2NCjIxr35hYd7mU=
X-Received: by 2002:a05:6a00:181b:b0:50a:46c6:aa74 with SMTP id
 y27-20020a056a00181b00b0050a46c6aa74mr23988768pfa.15.1650470364221; Wed, 20
 Apr 2022 08:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220420090433.20003-1-bo.jiao@mediatek.com>
In-Reply-To: <20220420090433.20003-1-bo.jiao@mediatek.com>
From:   Ryder Lee <ryder.lee@kernel.org>
Date:   Wed, 20 Apr 2022 08:59:12 -0700
X-Gmail-Original-Message-ID: <CA+SzRW5ZU+riTg3939O10+8Xtoms-i_oGRMFTF_8WBtawV0H_g@mail.gmail.com>
Message-ID: <CA+SzRW5ZU+riTg3939O10+8Xtoms-i_oGRMFTF_8WBtawV0H_g@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7915: dump SER stats through debugfs
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "lian . chen" <lian.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 20, 2022 at 2:05 AM Bo Jiao <bo.jiao@mediatek.com> wrote:
>
> From: Ryder Lee <ryder.lee@mediatek.com>
>
> Grab status of system recovery from firmware.
>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 48 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  5 +-
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 ++
>  .../net/wireless/mediatek/mt76/mt7915/regs.h  | 18 ++++++-
>  4 files changed, 64 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index dece0a6..76a6570 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -45,7 +45,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
>                          mt7915_implicit_txbf_set, "%lld\n");
>
>  /* test knob of system layer 1/2 error recovery */
> -static int mt7915_ser_trigger_set(void *data, u64 val)
> +static int mt7915_fw_ser_set(void *data, u64 val)
>  {
>         enum {
>                 SER_SET_RECOVER_L1 = 1,
> @@ -71,8 +71,47 @@ static int mt7915_ser_trigger_set(void *data, u64 val)
>         return ret;
>  }
>
> -DEFINE_DEBUGFS_ATTRIBUTE(fops_ser_trigger, NULL,
> -                        mt7915_ser_trigger_set, "%lld\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_ser, NULL,
> +                        mt7915_fw_ser_set, "%lld\n");
> +
> +static int
> +mt7915_fw_ser_stats_show(struct seq_file *s, void *data)
> +{
> +       struct mt7915_dev *dev = s->private;
> +       int ret;
> +
> +       /* grab firmware SER stats */
> +       ret = mt7915_mcu_set_ser(dev, 0, 0, 0);
> +       if (ret)
> +               return ret;
> +
> +       msleep(100);
> +
> +       seq_printf(s, "::E  R , SER_STATUS        = 0x%08x\n",
> +                  MT_SWDEF_SER_STATS);
> +       seq_printf(s, "::E  R , SER_PLE_ERR       = 0x%08x\n",
> +                  MT_SWDEF_PLE_STATS);
> +       seq_printf(s, "::E  R , SER_PLE_ERR_1     = 0x%08x\n",
> +                  MT_SWDEF_PLE1_STATS);
> +       seq_printf(s, "::E  R , SER_PLE_ERR_AMSDU = 0x%08x\n",
> +                  MT_SWDEF_PLE_AMSDU_STATS);
> +       seq_printf(s, "::E  R , SER_PSE_ERR       = 0x%08x\n",
> +                  MT_SWDEF_PSE_STATS);
> +       seq_printf(s, "::E  R , SER_PSE_ERR_1     = 0x%08x\n",
> +                  MT_SWDEF_PSE1_STATS);
> +       seq_printf(s, "::E  R , SER_LMAC_WISR6_B0 = 0x%08x\n",
> +                  MT_SWDEF_LAMC_WISR6_BN0_STATS);
> +       seq_printf(s, "::E  R , SER_LMAC_WISR6_B1 = 0x%08x\n",
> +                  MT_SWDEF_LAMC_WISR6_BN1_STATS);
> +       seq_printf(s, "::E  R , SER_LMAC_WISR7_B0 = 0x%08x\n",
> +                  MT_SWDEF_LAMC_WISR7_BN0_STATS);
> +       seq_printf(s, "::E  R , SER_LMAC_WISR7_B1 = 0x%08x\n",
> +                  MT_SWDEF_LAMC_WISR7_BN1_STATS);
> +
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(mt7915_fw_ser_stats);

I'm thinking we can merge this knob fw_ser_stats into fw_ser to make
it more convenient for use.

>  static int
>  mt7915_radar_trigger(void *data, u64 val)
> @@ -884,6 +923,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
>         debugfs_create_file("xmit-queues", 0400, dir, phy,
>                             &mt7915_xmit_queues_fops);
>         debugfs_create_file("tx_stats", 0400, dir, phy, &mt7915_tx_stats_fops);
> +       debugfs_create_file("fw_ser", 0200, dir, dev, &fops_fw_ser);
> +       debugfs_create_file("fw_ser_stats", 0400, dir, dev, &mt7915_fw_ser_stats_fops);
>         debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
>         debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
>         debugfs_create_file("fw_debug_bin", 0600, dir, dev, &fops_fw_debug_bin);
> @@ -897,7 +938,6 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
>                             &mt7915_rate_txpower_fops);
>         debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
>                                     mt7915_twt_stats);
> -       debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
>         if (!dev->dbdc_support || phy->band_idx) {
>                 debugfs_create_u32("dfs_hw_pattern", 0400, dir,
>                                    &dev->hw_pattern);
