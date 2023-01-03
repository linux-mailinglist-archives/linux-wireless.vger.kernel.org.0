Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C765C750
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjACTTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjACTSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:25 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F815832
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 11:15:35 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkpOZ-1oWnmR3aTn-00mHf8; Tue, 03 Jan 2023 20:15:28 +0100
Message-ID: <0cd97839-b293-9c0b-be88-9bfe9fe510f4@i2se.com>
Date:   Tue, 3 Jan 2023 20:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-6.2 1/3] wifi: brcmfmac: avoid handling disabled
 channels for survey dump
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230103124117.271988-1-arend.vanspriel@broadcom.com>
 <20230103124117.271988-2-arend.vanspriel@broadcom.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230103124117.271988-2-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OPvS5vxgfB34r1hGgQky/0mw9Y8FcU1jHB/v5+vpVzjAOVEUKOX
 Iga9RxLj+sp6OOJcyuN6NKigrU1LTKFcgq94Ns5m5qyAceg2RU/lktfF9/sfKj5Yj83fMjn
 Z2F22cfbalcsRrWHzYJ/1NwnolrGMXMSenlu4equGUmf+qyMiqTRmBAeFvty/lvz+4VgJJD
 ODccwFldm2MtAy2MoAokQ==
UI-OutboundReport: notjunk:1;M01:P0:ljRIYJ8ni/A=;CqX/786ZZrUJsDhycpdHsx02ayT
 nbEYH/T5aErBsPPKahhEc+yPfI8TqVx199Rq3dwhzDAOdWV8zuhSmhLQkPfIihtpDn2Wqymis
 zIQN+RC7JglES/ulFnFGp9GPoUYfjvK+U8g5hcqMsfyRpePzpx+UjXG1TKCo8BLTkUGVf/hQ9
 1dxP1Dx1JpzCJnuSMXPET4VS/KDAm5QgBr+taa04pgf6YF9sOn3Mrz/2UX/tA8tKsRtWtsF7P
 WGyQoPuSkOS5Bxsf315Dz2KvIsDO8c4ie6PBEuXtpv9XXOno5Kw1VfGZDe+wyslFjFAwF0IHr
 m30wKBiIbm+her6lcF7MuEVpivdUNsO1e4w9FVrXToeH+Cdh+8CPA7M3WEyDNZv4ZrlUM6d/J
 MAj7044R/RAluqIqotPkjstEE7UdyxIS/4m70ngy9+mHq2H6IZVwJ+8r0WEeEu2prQPDtNIYj
 Z3jyRcc2/vvbqBBW1f8McSAuzIKI1h+dkuuQXrMjlnhwZr5FL9qocpBHU/Pa22Y3+7rYFM9BC
 bsGLllH5UShhF6QrqTU5bETDJKVaUBtM+OC/wSXxMJwTXhLkX3Tp7MrYk17fh/03VamJjwyCU
 xtlBrxXmdq1dBmAn2/1p5cyFPhaDsVNwiQN9oKfa70JjdJhF+UFfMMiX42OHNOcGCZKWOE+/D
 k3JtJT6Xpmm7XKzaplR8zbe3SlnDnTD68mEP/egJnQ==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,
hi Kalle,

Am 03.01.23 um 13:41 schrieb Arend van Spriel:
> An issue was reported in which periodically error messages are
> printed in the kernel log:
>
> [   26.303445] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
> [   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
> [   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
regardless of this patch the commit d6a5c562214f ("wifi: brcmfmac: add 
support for vendor-specific firmware api") introduced this error message 
wcc/core.c, but i guess this should be trace or info message?
> [   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
> [   27.076829] Bluetooth: hci0: BCM: features 0x2f
> [   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
> [   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
> [   30.142104] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 across:102396k SS
> [   30.590017] Bluetooth: MGMT ver 1.22
> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
> [  104.897992] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
> [  105.007672] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
> [  105.117654] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
> [  105.227636] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
> [  106.987552] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
> [  106.987911] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
> [  106.988233] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
> [  106.988565] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
> [  106.988909] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52
>
> This happens in brcmf_cfg80211_dump_survey() because we try a disabled
> channel. When channel is marked as disabled we do not need to fill any
> other info so bail out.
>
> Fixes: 6c04deae1438 ("brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

this patch is:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c       | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index bff3128c2f26..478ca3848c64 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -7937,6 +7937,9 @@ cfg80211_set_channel(struct wiphy *wiphy, struct net_device *dev,
>   	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
>   	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
>   
> +	if (chan->flags & IEEE80211_CHAN_DISABLED)
> +		return -EINVAL;
> +
>   	/* set_channel */
>   	chspec = channel_to_chanspec(&cfg->d11inf, chan);
>   	if (chspec != INVCHANSPEC) {
> @@ -7961,7 +7964,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
>   	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
>   	struct brcmf_dump_survey survey = {};
>   	struct ieee80211_supported_band *band;
> -	struct ieee80211_channel *chan;
>   	struct cca_msrmnt_query req;
>   	u32 noise;
>   	int err;
> @@ -7987,13 +7989,10 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
>   	}
>   
>   	/* Setting current channel to the requested channel */
> -	chan = &band->channels[idx];
> -	err = cfg80211_set_channel(wiphy, ndev, chan, NL80211_CHAN_HT20);
> -	if (err) {
> -		info->channel = chan;
> -		info->filled = 0;
> +	info->filled = 0;
> +	info->channel = &band->channels[idx];
> +	if (cfg80211_set_channel(wiphy, ndev, info->channel, NL80211_CHAN_HT20))
>   		return 0;
> -	}
>   
>   	/* Disable mpc */
>   	brcmf_set_mpc(ifp, 0);
> @@ -8028,7 +8027,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
>   	if (err)
>   		goto exit;
>   
> -	info->channel = chan;
>   	info->noise = noise;
>   	info->time = ACS_MSRMNT_DELAY;
>   	info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
> @@ -8040,7 +8038,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
>   		SURVEY_INFO_TIME_TX;
>   
>   	brcmf_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
> -		  ieee80211_frequency_to_channel(chan->center_freq),
> +		  ieee80211_frequency_to_channel(info->channel->center_freq),
>   		  ACS_MSRMNT_DELAY);
>   	brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
>   		  info->noise, info->time_busy, info->time_rx, info->time_tx);
