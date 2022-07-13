Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81163573B3D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiGMQ3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiGMQ3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 12:29:09 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586FB20F44
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657729748; x=1689265748;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uC5dSSqpO4WvNlh/P1j4LIA4Fcbaifqg2BMLXQTERGA=;
  b=U5+Wcw1CrnpUPjck6M2MaiBiqm4becAktTOZF19KMyfB+t6HxLOeGN9T
   hN+F+2S9cjjD28mqMlxIrRTUBRaiq0zzjYyivN0ndJAIG1iFULZAUrUcs
   Ux98hd9JetzwHtHEd5ohSuqz4DjZ+CBSuuWvZ2Gho+B/PC2b51JTwhyIE
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 09:29:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:29:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 09:29:07 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 09:29:06 -0700
Message-ID: <6c529c77-079e-4817-3f2c-ed60c5cfd1ee@quicinc.com>
Date:   Wed, 13 Jul 2022 09:29:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/76] wifi: mac80211: rx: accept link-addressed frames
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
 <20220713114425.bf1302a63e1c.Idcd337705a4d1737a89bf9247ba73f82a0fc8b61@changeid>
 <bc928f09-cdbc-b5e5-c2f2-0c13ba3ebadb@quicinc.com>
 <d2f68ad4dbe7157fcd5b405a0f12176e03dafe70.camel@sipsolutions.net>
 <48389f1dc78383f6d863b13543bc8fc7902a1896.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <48389f1dc78383f6d863b13543bc8fc7902a1896.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/13/2022 9:23 AM, Johannes Berg wrote:
> On Wed, 2022-07-13 at 18:16 +0200, Johannes Berg wrote:
>> On Wed, 2022-07-13 at 09:14 -0700, Jeff Johnson wrote:
>>> On 7/13/2022 2:43 AM, Johannes Berg wrote:
>>>>     * This structure is the "EHT Operation Element" fields as
>>>> - * described in P802.11be_D1.4 section 9.4.2.311
>>>> + * described in P802.11be_D1.5 section 9.4.2.311
>>>
>>> In D2.0 this has changed to add the fixed 4-octet Basic EHT-MCS
>>> And Nss Set before the variable-length EHT Operation
>>> Information
>>>
>>> Do you have a timeline to incorporate D2.0 changes?
>>>
>>
>> Erm. I don't know what happened with this patch - it shouldn't have had
>> this contents ...
>>
>> But yes we also have D2.0 changes prepared somewhere.
>>
> 
> I'm not going to repost the set, but I pushed those out too now, with
> the D1.5 changes broken out from this patch into a proper separate patch
> - not sure how that happened, sorry.
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=d0d0f80a4c685f4bdc7164c15ee6b83b69877e23
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=mld&id=ddfde5917e6ac5d081bf771b3a28125d416c625e

Thanks, Johannes. You're awesome as always!
