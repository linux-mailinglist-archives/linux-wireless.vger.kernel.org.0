Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8C6259DB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKKLwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKLw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 06:52:28 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6927FDB
        for <linux-wireless@vger.kernel.org>; Fri, 11 Nov 2022 03:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8OtYKVWMi1GkRVogIfj4s/B5mdbZjVV1yjLy1OxRYi8=; b=bO6zTklQqjTdIX2E5cEafZezoV
        E7shapaKbRtONzaBh2WVspgBsuqfD8lGSipyMS8QUOInLxxgzt9UK347qXOR6LxGnt8c+vqOzG5Zo
        8KomaAQ1MS2mdIg/ne4pkiJT+gGB6ewAATQpzSu5Tzjfi/Ybh0NmUKneghmyiwySTy9Q=;
Received: from p200300daa72ee10c199752172ce6dd7a.dip0.t-ipconnect.de ([2003:da:a72e:e10c:1997:5217:2ce6:dd7a] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1otSa1-0018dc-Aj; Fri, 11 Nov 2022 12:52:17 +0100
Message-ID: <f2f873d2-fca1-f4d0-b6df-2c69f795b449@nbd.name>
Date:   Fri, 11 Nov 2022 12:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3 6/7] wifi: mt76: mt7921: introduce remain_on_channel
 support
Content-Language: en-US
To:     sean.wang@mediatek.com, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <cover.1668068326.git.objelf@gmail.com>
 <8e285c5f1b4fe477c477bf01156b26b8b5e65bc8.1668068326.git.objelf@gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <8e285c5f1b4fe477c477bf01156b26b8b5e65bc8.1668068326.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.11.22 22:23, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Introduce remain_on_channel support. Additionally, we add
> mt7921_check_offload_capability to disable .remain_on_channel and
> .cancel_remain_on_channel and related configuration because those
> operations would rely on the fundamental MCU commands that will be only
> supported with newer firmware.
> 
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7921/init.c  |  63 +++++++
>   .../net/wireless/mediatek/mt76/mt7921/main.c  | 165 ++++++++++++++++++
>   .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 +++
>   .../wireless/mediatek/mt76/mt7921/mt7921.h    |  49 ++++++
>   .../net/wireless/mediatek/mt76/mt7921/pci.c   |  26 ++-
>   .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  17 +-
>   .../net/wireless/mediatek/mt76/mt7921/usb.c   |  16 +-
>   7 files changed, 346 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 82df5fa4fbc7..82837ccc104d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1573,6 +1683,61 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>   	mt7921_mutex_release(dev);
>   }
>   
> +const struct ieee80211_ops mt7921_ops_chanctx = {
> +	.tx = mt7921_tx,
> +	.start = mt7921_start,
> +	.stop = mt7921_stop,
> +	.add_interface = mt7921_add_interface,
> +	.remove_interface = mt7921_remove_interface,
> +	.config = mt7921_config,
> +	.conf_tx = mt7921_conf_tx,
> +	.configure_filter = mt7921_configure_filter,
> +	.bss_info_changed = mt7921_bss_info_changed,
> +	.start_ap = mt7921_start_ap,
> +	.stop_ap = mt7921_stop_ap,
> +	.sta_state = mt7921_sta_state,
> +	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
> +	.set_key = mt7921_set_key,
> +	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
> +#if IS_ENABLED(CONFIG_IPV6)
> +	.ipv6_addr_change = mt7921_ipv6_addr_change,
> +#endif /* CONFIG_IPV6 */
> +	.ampdu_action = mt7921_ampdu_action,
> +	.set_rts_threshold = mt7921_set_rts_threshold,
> +	.wake_tx_queue = mt76_wake_tx_queue,
> +	.release_buffered_frames = mt76_release_buffered_frames,
> +	.channel_switch_beacon = mt7921_channel_switch_beacon,
> +	.get_txpower = mt76_get_txpower,
> +	.get_stats = mt7921_get_stats,
> +	.get_et_sset_count = mt7921_get_et_sset_count,
> +	.get_et_strings = mt7921_get_et_strings,
> +	.get_et_stats = mt7921_get_et_stats,
> +	.get_tsf = mt7921_get_tsf,
> +	.set_tsf = mt7921_set_tsf,
> +	.get_survey = mt76_get_survey,
> +	.get_antenna = mt76_get_antenna,
> +	.set_antenna = mt7921_set_antenna,
> +	.set_coverage_class = mt7921_set_coverage_class,
> +	.hw_scan = mt7921_hw_scan,
> +	.cancel_hw_scan = mt7921_cancel_hw_scan,
> +	.sta_statistics = mt7921_sta_statistics,
> +	.sched_scan_start = mt7921_start_sched_scan,
> +	.sched_scan_stop = mt7921_stop_sched_scan,
> +	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
> +	CFG80211_TESTMODE_DUMP(mt7921_testmode_dump)
> +#ifdef CONFIG_PM
> +	.suspend = mt7921_suspend,
> +	.resume = mt7921_resume,
> +	.set_wakeup = mt7921_set_wakeup,
> +	.set_rekey_data = mt7921_set_rekey_data,
> +#endif /* CONFIG_PM */
> +	.flush = mt7921_flush,
> +	.set_sar_specs = mt7921_set_sar_specs,
> +	.remain_on_channel = mt7921_remain_on_channel,
> +	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
> +};
> +EXPORT_SYMBOL_GPL(mt7921_ops_chanctx);
> +
>   const struct ieee80211_ops mt7921_ops = {
>   	.tx = mt7921_tx,
>   	.start = mt7921_start,
Please avoid creating a copy&paste ops struct, since that adds extra 
maintenance overhead.
For some devices we already use devm_kmemdup to duplicate and modify 
ops. Please use the same for chanctx. You could add a common function 
that fills in the remain_on_channel/chanctx part into the duplicated ops.

- Felix
