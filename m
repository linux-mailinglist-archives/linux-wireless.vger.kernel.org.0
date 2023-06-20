Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43C736D2C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFTNWF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjFTNVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 09:21:51 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF9210B
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 06:20:43 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8101F283C15
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 13:19:39 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 93145340064;
        Tue, 20 Jun 2023 13:19:27 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.35.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A074513C2B0;
        Tue, 20 Jun 2023 06:19:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A074513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1687267167;
        bh=rrMv3DVJ+9vsd1XBWLV8ryZqPd2LEYh+BJ3vSDQZwmQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GWyWVytPuhK0SJvtp2FGZvEi1uy41lnycMrQfXryBzfLTIoPSN3F6qrSFJ+fL9c7V
         y9/UV1y/OU1UGi4aFW1K6ANWUiMSda/qgkQYtpnO/lm2XLT0A1HKm3rSYSp4+c8wEk
         CQ6IQjDdXMF3KLUIJ+WFkvV03xRG9e6sQ4jrh/0o=
Subject: Re: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on PCIe
 link speed
To:     gregory.greenman@intel.com, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
 <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com>
Date:   Tue, 20 Jun 2023 06:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1687267168-CJVsEtA90vdk
X-MDID-O: us5;ut7;1687267168;CJVsEtA90vdk;<greearb@candelatech.com>;5c90bc175759a0446550edff92160f2f
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/20/23 3:03 AM, gregory.greenman@intel.com wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If a discrete NIC is connected to a PCIe link hat isn't at least
> Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remove
> that from EHT capabilities in that case.
> 
> While at it, also move setting 320 MHz beamformee to the right
> place in the code so it's not set while not supporting 320 MHz.

Is there not an advantage to allowing 320Mhz for longer distance connections
where signal is relatively weak, so over-all tput would easily fit in lesser
pcie bus?  Especially on 6E band where the US regdom allows more over-all power
when using wider bandwidths?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
