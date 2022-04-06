Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E854F6AD5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiDFUIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiDFUHy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 16:07:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E6247C1A
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649265626; x=1680801626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YfI1wksFn84LMVuzMK/WxQ2Kpm6LNT84m1UrBM4DMEs=;
  b=pIjQ0DrTH618Z204fD7XSeeOVl4F69gO4Cp0daxOYxyQn7TnfzJ+qhmx
   Vi9jbwNq5mQZTnYv9m80BS/WjeFh9Ri8XFSuuTtVm91qN3zN/aS6Cqs9Z
   8/lWWRrRkTt3RPhIl3u1xpQvsAdA28NbDk7foePpgX24wPR+MdddOKmSU
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 10:20:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:20:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 10:20:25 -0700
Received: from [10.110.72.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 10:20:24 -0700
Message-ID: <73189e3e-2874-1bb9-bb52-2cbca5e8584b@quicinc.com>
Date:   Wed, 6 Apr 2022 10:20:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/7] cfg80211/nl80211: move rx management data into a
 struct
Content-Language: en-US
To:     Luca Coelho <luca@coelho.fi>, <johannes@sipsolutions.net>,
        <kvalo@kernel.org>
CC:     <gregory.greenman@intel.com>, <linux-wireless@vger.kernel.org>
References: <20220406120924.979792-1-luca@coelho.fi>
 <iwlwifi.20220406145756.04af2017dd54.I8817e862b11039a7ead1ac8395ea314250462460@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <iwlwifi.20220406145756.04af2017dd54.I8817e862b11039a7ead1ac8395ea314250462460@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/6/2022 5:09 AM, Luca Coelho wrote:
[...snip...]
> +/**
> + * cfg80211_rx_mgmt_ext - management frame notification with extended info
> + * @wdev: wireless device receiving the frame
> + * @info: RX info as defined in struct cfg80211_rx_info
> + *
> + * This function is called whenever an Action frame is received for a station
> + * mode interface, but is not processed in kernel.
> + *
> + * Return: %true if a user space application has registered for this frame.
> + * For action frames, that makes it responsible for rejecting unrecognized
> + * action frames; %false otherwise, in which case for action frames the
> + * driver is responsible for rejecting the frame.
> + */
> +bool cfg80211_rx_mgmt_ext(struct wireless_dev *wdev,
> +			  struct cfg80211_rx_info *info);

can/should info be const?

/jeff
