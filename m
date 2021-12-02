Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E8466830
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359674AbhLBQbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359732AbhLBQah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:37 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347DC0619EA
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+9hlZFOStr99oVMYW977nDGw4O5HtmVFQUr3l8gEHlc=; b=HS0hoXvIxrlI9ZAqdlvSdOOGoN
        wNevb+tFOnlwOQzWgHF8Ls2/9FbE4PgkbJjrZqTMQfcyjwC2/SRDRN23RNZ7moxD8aTwbRCA/XP7u
        wLMa/XWoNi/ByoPUej4e6F5RFXbDfgRTiI7+96i99ucGoLKHSP0XSmDrZnwPx1fbshw8=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1msouh-0006im-Rs; Thu, 02 Dec 2021 17:26:27 +0100
Message-ID: <4b5332e8-6eef-3a3a-0765-a7563bc745ad@nbd.name>
Date:   Thu, 2 Dec 2021 17:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] mt76: eeprom: tolerate corrected bit-flips
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
References: <YZ/nv74JH/uQwpBt@makrotopia.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <YZ/nv74JH/uQwpBt@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 2021-11-25 20:45, Daniel Golle wrote:
> mtd_read() returns -EUCLEAN in case of corrected bit-flips.
> As data was read, don't error out in this case.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: fix wrong variable name
> 
>   drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index 2d58aa31db934..4a5d14473ddc4 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -65,7 +65,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
>   	offset = be32_to_cpup(list);
>   	ret = mtd_read(mtd, offset, len, &retlen, eep);
>   	put_mtd_device(mtd);
> -	if (ret) {
> +	if (ret && !mtd_is_bitflip(ret)) {
unfortunately the patch is still incomplete. I will fold in the
following change to make it work:
---
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -65,7 +65,9 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
  	offset = be32_to_cpup(list);
  	ret = mtd_read(mtd, offset, len, &retlen, eep);
  	put_mtd_device(mtd);
-	if (ret && !mtd_is_bitflip(ret)) {
+	if (mtd_is_bitflip(ret))
+		ret = 0;
+	if (ret) {
  		dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\n",
  			part, ret);
  		goto out_put_node;
