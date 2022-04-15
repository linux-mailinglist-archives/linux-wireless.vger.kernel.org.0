Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE7502AC5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiDONEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Apr 2022 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354067AbiDONEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Apr 2022 09:04:36 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBF9A9AA
        for <linux-wireless@vger.kernel.org>; Fri, 15 Apr 2022 06:01:21 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 24E0F2A007C;
        Fri, 15 Apr 2022 13:01:19 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 356B5200091;
        Fri, 15 Apr 2022 13:01:18 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.67.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F371F13C2B0;
        Fri, 15 Apr 2022 06:01:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F371F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1650027677;
        bh=97Pwh5Wb0Tmj32eBIlqicePDh2T1qVGNCP+b9k8pu8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i9XqPgPykla7e07qmPJH4NqMkvTPRO1s1N1B/zT+oUYbKdic7E/2Vraaf+K26Sx16
         clgls7796m4+grwyFNIQiwdS1ZZgJyOyFWSlkhc0OamIe3tTP99uw+h1MUygmX8sH3
         HJUJNs4W8oePYLqGLwnG0aq+OyJcdujQEHjBPAlM=
Subject: Re: [PATCH v2] mt76: mt7915: add debugfs knob for RF registers
 read/write
To:     Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
References: <20220415061444.30720-1-shayne.chen@mediatek.com>
 <c8662170-bf59-06df-a78c-8fb24303f274@nbd.name>
 <9188cd3d7463cb8fc65c741bd07de817d0e60f6f.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <1cb3d71f-5537-a4ab-8711-62ecd4b84c43@candelatech.com>
Date:   Fri, 15 Apr 2022 06:01:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9188cd3d7463cb8fc65c741bd07de817d0e60f6f.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1650027679-N_yYVltTBvWx
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/15/22 4:15 AM, Shayne Chen wrote:
> On Fri, 2022-04-15 at 10:26 +0200, Felix Fietkau wrote:
>> On 15.04.22 08:14, Shayne Chen wrote:
>>> Add RF registers read/write support for debugging RF issues, which
>>> should be processed by mcu commands.
>>>
>>> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
>>> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>>> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>>
>> What's the required width of rf_sel and rf_ofs? Would both fit
>> together
>> in a single u32? If so, you could just use the generic regidx
>> debugfs
>> file for both and simply add a rf_regval debugfs file.
>>
>> - Felix
> 
> Hi Felix,
> 
> FW use the WF sel (antenna 0-3) and offset to locate rf registers.
> I'll send an update patch to merge them in the generic regidx with
> wf sel [31:28] and offset [27:0].
> 
> Thanks,
> Shayne

Hello,

Can you document the registers, or is this only for internal mediatek use?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
