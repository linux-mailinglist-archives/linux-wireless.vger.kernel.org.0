Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762EB6D7DCC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjDENfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDENfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 09:35:24 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E28640C8
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 06:35:23 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 64443180073;
        Wed,  5 Apr 2023 13:35:21 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id BBA0913C2B0;
        Wed,  5 Apr 2023 06:35:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BBA0913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1680701721;
        bh=wQ02EN6kaz7cuPkSutXTbMshkXXDeODxUPu6RSzL8Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A4C1rofYvzeY3LszSZdT55Bc42xOmdC3y74XxYmddRP+HUdfsB/WsQnyQFry5KW8b
         ms9Ghz77nfCgMT31KVkArYawmP3fwKEAFDiLLebONBcLL/qjIDJ4R/8p/6am9VR5GM
         2QxvEvx7bWRJyLp+wIcEYN5DkpWv35kQgCkZmt0U=
Subject: Re: [PATCH] wifi: ath11k: Add rx histogram stats
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        ath11k-bounces@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
References: <20230405132804.226681-1-quic_mkenna@quicinc.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <1e0de6cd-4e43-273f-2222-1c52d2b6d95e@candelatech.com>
Date:   Wed, 5 Apr 2023 06:35:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230405132804.226681-1-quic_mkenna@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1680701722-HJFkU3jFImna
X-MDID-O: us5;ut7;1680701722;HJFkU3jFImna;<greearb@candelatech.com>;1c781e5017f3ef067c1dc9f19e8beb22
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/5/23 6:28 AM, Maharaja Kennadyrajan wrote:
> Add peer specific debugfs support to store and
> display peer rx stats info like HE, VHT, HT,
> legacy and NSS.
> Also, add a debugfs knob to reset rx stats
> specific to the peer.
> 
> This helps  to debug the throughput related
> issues in the UL traffic(STA to AP) by getting
> the segregated rx_stats info like HE, VHT, HT etc,.
> 
> There is no addition of new debugfs_file here to get
> these segregated stats. The exising rx_stats is enhanced
> to get these stats.

I'm a big fan of stats, so nice to see you adding this.

I'd also suggest adding histogram for ampdu length if you can,
as a sta sending series of 2 frames in ampdu vs sta sending a series
of 64 frames in ampdu will get significantly different throughput.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
