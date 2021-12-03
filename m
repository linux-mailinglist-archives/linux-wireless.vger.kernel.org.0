Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C0467349
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbhLCIfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 03:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379208AbhLCIfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 03:35:33 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF51C06174A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ikqmK0qvVk8WlbaMK7Xubih/crf4hNNMYHxH+qucySs=; b=jAqA5mfPGcBqQ8B7tnCvpFjEQ8
        WAkrs7Wjnxut9TJCvTo5jqIfA3csrDbVmkDxBdPMZDMHX/GRbe3x0DjIV6qzon3mEZ0KIwVzjcaur
        eCgFtfgwfNzU/CeF7JKBXvQnrdsvg2jtrAKs3rwHcJjphJ2hTjoDO2lIjDiz8tlNP+C8=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt3zE-0006BV-6B; Fri, 03 Dec 2021 09:32:08 +0100
Message-ID: <59de5a7b-8933-03c7-7ce5-fe58279c7457@nbd.name>
Date:   Fri, 3 Dec 2021 09:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] mt76: mt7663: disable 4addr capability
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <009c6c2bc8436f38de85e125cdd7157f1b21a2cf.1638473687.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <009c6c2bc8436f38de85e125cdd7157f1b21a2cf.1638473687.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-12-02 20:35, Lorenzo Bianconi wrote:
> 4addr is not supported by the driver/firmware yet
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index 47f23ac905a3..52182ab6d240 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -378,6 +378,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
>   	if (is_mt7663(&phy->dev->mt76)) {
>   		wiphy->iface_combinations = if_comb;
>   		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
> +		wiphy->flags &= ~WIPHY_FLAG_4ADDR_STATION;
Shouldn't this be done for the offload firmware only?

- Felix
