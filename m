Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8825394FD
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbiEaQcA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346169AbiEaQb7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 12:31:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2521B49A
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654014717; x=1685550717;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1cPvus7fKmvFBoSVFioWFzPZTRn7k5ZIyp8cpXTF7hU=;
  b=gmAzVgE9RMYAiUcRwoW9vspo63cTk+Ems1f6FhujsJmGBUXCToyqnRZd
   9SDOi674XAl+gI5sAq3HzDugdPdINlX+OlYAC+8Vp7VVjHWC0t2BdvS90
   4b/on/PHSg/IekipwvJvFjGQFEKNZXpOW+0OaKqAO81/vN6EU6FKo2tcj
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 May 2022 09:31:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 09:31:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 09:31:56 -0700
Received: from [10.110.67.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 09:31:55 -0700
Message-ID: <ed095171-3617-3066-e3df-8091f84078a2@quicinc.com>
Date:   Tue, 31 May 2022 09:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] initial interface-related MLO work
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220520113242.129546-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/20/2022 4:32 AM, Johannes Berg wrote:
> Hi,
> 
> (Note the dependency on these three patches:
> https://lore.kernel.org/linux-wireless/20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid/)
> 
> This series contains initial refactoring of data structures in both
> cfg80211 and mac80211 for MLO support. This is likely not complete,
> but it serves to illustrate the future layout of data structures in
> the stack with MLO support.
> 
> This also doesn't enable anything yet - you cannot use the link ID
> attribute yet since you cannot use the new ADD_LINK command, it's
> gated by a wiphy flag that isn't set.
> 
> However, this is a stepping stone - from here, we can even consider
> splitting up work, e.g. separately focus on AP mode, clients with
> AUTH/ASSOC, and clients with CONNECT (i.e. not mac80211).
> 
> The next things with this would be:
>   1) Look at the auth/assoc APIs, at present I'm not even
>      certain where we do what, I guess userspace would pick
>      the BSS entries and send them in the LINKS attribute,
>      per link, or so, and mac80211 builds the multi-link
>      element(s) as appropriate?
> 
>   2) Look at interface combinations advertisement and tie it
>      into this patch where appropriate; Vasanth is looking
>      at this.
> 
>   3) Try to get to a point where we can at least start the
>      beaconing process, i.e. look at mac80211 much more and
>      refactor data structures there.
> 
> I'll probably start with (3) since at least beaconing lets
> me then test at least scanning for (1) and perhaps sending
> the association request etc.
> 
> I'm aware that this leaves a number of FIXME comments in cfg80211,
> we'll have to fill those in as we port features to MLD one by one.
> 
> We'll also have to properly implement the REMOVE_LINK command and
> various other bits here and there, but I think with these patches
> we can start working in different areas independently.
> 
> johannes

Thanks Johannes,
This is a great start, and looks good to me and my team!

/jeff

