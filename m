Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7FE4D870C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiCNOin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiCNOim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 10:38:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FC3D48B
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xNq6R8CjDCXlgfqdVyRSKbiUrrTEQsCB2SHbde1EVIo=; b=ueQzZMLY6sv7oib52NnvNSbThC
        eWn9zwDVUwopsUyoFCrk2MfooDF2l9LxG1hn4u5BGLF+pgFtlgTj1v+hsDBQ8csOQSgLv221ErlgG
        5334gc72PuVvJ6lajzxB/rsgYtXdXt+TBsef4wHnYfrOF4knT1ryeOlelAfIQQF9yQTQ=;
Received: from p200300daa7204f006c015a90d6b6c4d6.dip0.t-ipconnect.de ([2003:da:a720:4f00:6c01:5a90:d6b6:c4d6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nTlp9-00006D-9L; Mon, 14 Mar 2022 15:37:27 +0100
Message-ID: <f105dff0-f78e-72c5-5558-ab532e95f87e@nbd.name>
Date:   Mon, 14 Mar 2022 15:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] mt76: mt7915: fix MBSS index condition in DBDC mode
Content-Language: en-US
To:     Evelyn Tsai <evelyn.tsai@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Bo Jiao <bo.jiao@mediatek.com>
References: <20220309140249.10285-1-evelyn.tsai@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220309140249.10285-1-evelyn.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09.03.22 15:02, Evelyn Tsai wrote:
> MT7915_MAX_INTERFACES is per-band declartion.
> 
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h        | 2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 5e10fe156926..c60af144f611 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -727,7 +727,7 @@ struct mt76_dev {
>   	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
>   	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
>   
> -	u32 vif_mask;
> +	u64 vif_mask;
>   
>   	struct mt76_wcid global_wcid;
>   	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> index c3f44d801e7f..9eefc132d77a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -205,7 +205,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
>   		phy->monitor_vif = vif;
>   
>   	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
> -	if (mvif->mt76.idx >= MT7915_MAX_INTERFACES) {
> +	if (mvif->mt76.idx >= (MT7915_MAX_INTERFACES << dev->dbdc_support)) {
This patch is incomplete. There are several other places in the code 
that are not prepared for vif_mask being 64 bits wide, including the ffs 
line above.

- Felix
