Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233B923583C
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHBPlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBPlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:41:05 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838EC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 08:41:05 -0700 (PDT)
Received: from [2a04:4540:1401:8700:fd6b:4daf:8c30:5c76]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k2G6c-0005Wo-SN; Sun, 02 Aug 2020 17:40:58 +0200
Subject: Re: [PATCH V2 06/10] ath11k: pass multiple bssid info to FW when a
 new vdev is created
To:     Shay Bar <Shay.Bar@celeno.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <20200706115219.663650-1-john@phrozen.org>
 <20200706115219.663650-6-john@phrozen.org>
 <AM0P192MB0468CC75648CE04D26CF58C3E74C0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
From:   John Crispin <john@phrozen.org>
Message-ID: <9d6133d4-de34-95a9-709b-781fd45752ab@phrozen.org>
Date:   Sun, 2 Aug 2020 17:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AM0P192MB0468CC75648CE04D26CF58C3E74C0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 02.08.20 17:02, Shay Bar wrote:
> On 06/07/2020 14:52, John Crispin wrote:
>> -static void
>> +static int
>>   ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
>>                                      struct vdev_create_params *params)
>>   {
>>          struct ath11k *ar = arvif->ar;
>>          struct ath11k_pdev *pdev = ar->pdev;
>> +       struct ieee80211_vif *parent;
>>
>>          params->if_id = arvif->vdev_id;
>>          params->type = arvif->vdev_type;
>>          params->subtype = arvif->vdev_subtype;
>>          params->pdev_id = pdev->pdev_id;
>> +       params->vdevid_trans = 0;
>> +       switch (ieee80211_get_multi_bssid_mode(arvif->vif)) {
>> +       case NL80211_MULTIPLE_BSSID_TRANSMITTED:
>> +               params->flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
>> +               break;
>> +       case NL80211_MULTIPLE_BSSID_NON_TRANSMITTED:
>> +               params->flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
>> +               parent = ieee80211_get_multi_bssid_parent(arvif->vif);
>> +               if (!parent)
>> +                       return -ENOENT;
>> +               if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
>> +                       return -EINVAL;
>> +               params->vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
>> +               break;
>> +       default:
>> +               params->flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
>> +               break;
>> +       }
> Hi John,
> The ath11k_mac_setup_vdev_create_params() is called from the add_interface hook
> which is called from ieee80211_do_open() which is, for the first (TRANSMITTED)
> interface, before wdev->multi_bssid_mode is set to NL80211_MULTIPLE_BSSID_TRANSMITTED
> (set upon start_ap from hostapd).
> Can you please explain how wdev->multi_bssid_mode can have
> NL80211_MULTIPLE_BSSID_TRANSMITTED value in the above code ?

Hi Shay,

https://patchwork.kernel.org/patch/11587085/

     John

