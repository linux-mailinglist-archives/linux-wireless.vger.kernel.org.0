Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BB724A5F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjFFRf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjFFRfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 13:35:33 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1326170B
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 10:35:29 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id 6VXBqyPFaWU1c6aaeqAUes; Tue, 06 Jun 2023 17:35:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6aadqgqwPovBq6aadqyi95; Tue, 06 Jun 2023 17:35:27 +0000
X-Authority-Analysis: v=2.4 cv=E6reGIRl c=1 sm=1 tr=0 ts=647f6e5f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iZmTPvbfiRjpTRcFDqwA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TNXHp03C81TzQxB0Nx0rxgtRLz59GHTTR4umt/LIWNo=; b=NxOdtAjzBHaNvBAX0bwt8CK5fx
        eAHVuF623LHiCAO4VnUdF8riD1BkF2qokDqyzi43LRcavkTkM27k85P5DhATttNrCEO2wvgMDdb28
        AYvIuJksnUGe3HykASrKRLdQUQq4RSNwsTxTSvZFswHPvFUR3bd6qeC/zSY2+caFeOrbGYoAE3sy+
        BnFQopPjHsKZWncQlluFwLYO2fQrPL1jWmRoR3Mcv+JpmpEQOzaAb9btOwtKu5UfRpWZb4lKrF3rO
        508y5pinHs98XJK6TkH29d7b5tHKYednZ4pE+LiVV0v69NNfvCBQmqqRs0H/MVhs6tPvpOFfvQtoC
        lipxXAhg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39590 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q6aac-002w4x-H5;
        Tue, 06 Jun 2023 12:35:26 -0500
Message-ID: <62ed7ac9-71bf-1fa5-1ae3-9c2060393b4b@embeddedor.com>
Date:   Tue, 6 Jun 2023 11:36:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZHpGN555FwAKGduH@work> <202306051758.CD86F1E638@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202306051758.CD86F1E638@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1q6aac-002w4x-H5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39590
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDcrCetOB8ixZt0hp2R+0Pwc7qagQKoiFjb0xGZcNpxcGR0puO5MVXCmJbzrZDqv/JcxzgQ2IE4o6OPBv/OLNwWYfHNHl/FmaFWCywJvYwLiQIFPWpxq
 rUSvjmiIrlzR02KgDzaq4X4L7lS1JuFt50XV497DgyAXqaE4RJvH+Khr6UN+iQ73WQdHgkWqgwFn7b48HFs84SSxDXTzC4Ep1dkiYqZtRNrs1Ci57CvzyvcQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 6/5/23 19:03, Kees Cook wrote:

>>
>> Link: https://github.com/KSPP/linux/issues/306
>> Fixes: 905d50ddbc83 ("wifi: iwlwifi: mvm: support wowlan info notification version 2")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Nice catch!

(dancy-dance):D

,
>>   		if (wowlan_info_ver < 2) {
>>   			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
>>   
>> -			notif = kmemdup(notif_v1,
>> -					offsetofend(struct iwl_wowlan_info_notif,
>> -						    received_beacons),
>> -					GFP_ATOMIC);
>> -
>> +			notif = kmemdup(notif_v1, sizeof(*notif), GFP_ATOMIC);
> 
> The only question I have here is whether or not pkt->data actually
> contains sizeof(*notif)-many bytes? It seems the length isn't checked
> until after this area:
> 
>                  len = iwl_rx_packet_payload_len(pkt);
> 
> So, perhaps this needs to be changed instead, and the length
> double-checked, etc. Perhaps a regular kzalloc + memcpy is needed to
> handle pkt->data not being large enough?

As per Gregory's reply, it seems that the length is just fine.

Thanks
--
Gustavo
