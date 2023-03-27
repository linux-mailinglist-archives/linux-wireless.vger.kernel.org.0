Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B46CA1A0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 12:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjC0KsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0Kr7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 06:47:59 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770AB5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JJpWt9s21SkDzN868Ycl9scKYBZabhvtSuX4N4znx2I=; b=idn/xQ8Tep2xKzfY9XGvXOygkX
        W/SF2/UmHZOvnurQK09hDdpGrIEcrmgAxQjh4bNL1nVrm15g3NwCKZvkoHGRiYXObHIrKNi94T1g+
        LW5K92tB4qafZxRWPCM72gwmkgBKyAy+eVXvTST9xABzeTenVozQLPayktwJRcCm5qIM=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pgkOH-007LUO-7z; Mon, 27 Mar 2023 12:47:53 +0200
Message-ID: <1da4680e-d7b9-dc17-0bff-3edfa046a357@nbd.name>
Date:   Mon, 27 Mar 2023 12:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] wifi: mac80211: enable EHT mesh support
Content-Language: en-US
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <6088d99492ce29f1075b3a22b2c2e5d010196e51.1679891359.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <6088d99492ce29f1075b3a22b2c2e5d010196e51.1679891359.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27.03.23 06:37, Ryder Lee wrote:
> @@ -4903,7 +4974,7 @@ u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
>   				       &eht_cap->eht_cap_elem,
>   				       is_ap);
>   	return 2 + 1 +
> -	       sizeof(he_cap->he_cap_elem) + n +
> +	       sizeof(eht_cap->eht_cap_elem) + n +
>   	       ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
>   				      eht_cap->eht_cap_elem.phy_cap_info);
>   	return 0;
This looks like it should be a separate fix, right?

- Felix
