Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEC626B00
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLSRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 13:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 13:17:43 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F214D0F
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SNsH8GHfFhIHPCzOolA1tSZKkcYoEwafSwGLKDy3uhk=; b=GHE6ANOAe+3B39VhYoisQE3PRs
        3X/iVGCIvDYE18rVRHkqOL5VNTt6wj8MT+Y+tEajguvcKgj/dY6lzqcRMmItAnW7wXIMaBJEMgmvV
        r5KUCwbiPKoXymrR71GoULPD8+0SEDySw2/U9PNpQk4GEb/d/iOH/W/Mh93cSsnD7Tjw=;
Received: from p200300daa72ee10cb9d33d2e9c9a0fe5.dip0.t-ipconnect.de ([2003:da:a72e:e10c:b9d3:3d2e:9c9a:fe5] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1otv4U-001PEY-2e; Sat, 12 Nov 2022 19:17:38 +0100
Message-ID: <db2bde41-7b89-7e89-ae28-e92b1fe0525b@nbd.name>
Date:   Sat, 12 Nov 2022 19:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] wifi: mt76: mt7915: Fix chainmask calculation on
 mt7915 DBDC
Content-Language: en-US
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
 <20221110153953.22562-3-nicolas.cavallari@green-communications.fr>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20221110153953.22562-3-nicolas.cavallari@green-communications.fr>
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

On 10.11.22 16:39, Nicolas Cavallari wrote:
> mt7915 does not have a per-band number of chains unlike the other chips,
> it only has a total number of chains.  Yet the current code would
> consider the total number as a per-band number.
> 
> For example, it would report that a 2x2 + 2x2 DBDC card have 4 chains on
> each band and set chainmask to 0b1111 for the first interface and
> 0b11110000 for the second.
> 
> Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index 83bced0c0785..8bb971018a1e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -194,6 +194,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
>   	nss = path;
>   	if (dev->dbdc_support) {
>   		if (is_mt7915(&dev->mt76)) {
> +			path = path / 2;
>   			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
>   					eeprom[MT_EE_WIFI_CONF + 3]);
>   			if (phy->band_idx)
This was causing a regression on properly calibrated DBDC cards, where
the 'path' variable contains the per-band path, not the total path.
I've folded in the following change to fix your commit:

--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -194,7 +194,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
  	nss = path;
  	if (dev->dbdc_support) {
  		if (is_mt7915(&dev->mt76)) {
-			path = path / 2;
+			path = min_t(u8, path, 2);
  			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
  					eeprom[MT_EE_WIFI_CONF + 3]);
  			if (phy->band_idx)

