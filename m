Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE24390175
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhEYNBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 09:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhEYNBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 09:01:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008AC061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 06:00:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1llWey-00EOir-E1; Tue, 25 May 2021 14:59:48 +0200
Message-ID: <f1a1d5da376d0ec187079d1277d3628328fdd81c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/4] mac80211: call ieee80211_tx_h_rate_ctrl() when
 dequeue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Tue, 25 May 2021 14:59:46 +0200
In-Reply-To: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com> (sfid-20210519_215633_470280_525C572D)
References: <a959135d3fe21118f38c33fc9ffb18124c1ef7ce.1621453091.git.ryder.lee@mediatek.com>
         (sfid-20210519_215633_470280_525C572D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-05-20 at 03:56 +0800, Ryder Lee wrote:
> 
> +static ieee80211_tx_result
> +ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
> +			   struct sta_info *sta, u8 pn_offs,
> +			   struct ieee80211_key *key,
> +			   struct ieee80211_tx_data *tx)
>  {
> +	struct sk_buff *skb = tx->skb;
>  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>  	struct ieee80211_hdr *hdr = (void *)skb->data;
>  	u8 tid = IEEE80211_NUM_TIDS;
>  
> 
> 
> 
> +	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
> +		if (ieee80211_tx_h_rate_ctrl(tx) != TX_CONTINUE)
> +			return TX_DROP;

Probably nicer to roll that into one condition:

if (!...() &&
    ..._rate_ctrl(tx) != ...)
	return TX_DROP;


johannes

