Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE6613CCD
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaSCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJaSCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 14:02:16 -0400
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20B13D1E
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 11:02:15 -0700 (PDT)
Received: from eig-obgw-5014a.ext.cloudfilter.net ([10.0.29.198])
        by cmsmtp with ESMTP
        id pXhiopPjflI84pZ71o9odP; Mon, 31 Oct 2022 18:02:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id pZ6yoyqRV4gRbpZ6zoCJcx; Mon, 31 Oct 2022 18:02:13 +0000
X-Authority-Analysis: v=2.4 cv=EMIVbnVC c=1 sm=1 tr=0 ts=63600da5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=wYkD_t78qR0A:10 a=XPDCPBHLajm3aRFYHAUA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4M+EkqO2JIQhdRROs6iO5knFvCzc2rYBZdIfB6LFo1M=; b=eYQmoSDCBMmgeFFVkQtGqxSpu6
        VbhdOaE5Q6z1ta4Y4WbtONilXDaXlCi7bvqUp8/lBqNx3816DhW7waQaBPrFYo8iL6kIxedBrjOH/
        jy9CgKAef2zrh7WR3I/lKcQ53sXf5Of1HnTWJZFr4xfyO9CbMtYVD4yD5xvLMRjZ5J2DEq5BgDRjc
        Nn/C6ck/0lGwUdTO81d7vAqLMQZUfRuqN6ooq3H9vgDYkCjV30tD7evQn4amKnGbjPgzJM1dmNs3G
        AwaJd2eIAZIIcJ2KrPdjC3v1jf9dcM/cj1vdI3Sgnd8kpkl9vxnClkoDV2kPABGgGES8vtrNo24uB
        wi3lTTag==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:60834 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1opZ6x-002ncA-Um;
        Mon, 31 Oct 2022 13:02:12 -0500
Message-ID: <fb504b1e-e558-c3ed-61ed-220a24299599@embeddedor.com>
Date:   Mon, 31 Oct 2022 12:01:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/6] cfg80211: Avoid clashing function prototypes
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <cover.1666894751.git.gustavoars@kernel.org>
 <c8239f5813dec6e5cfb554ca92b1783a18ac5537.1666894751.git.gustavoars@kernel.org>
 <a92ffa8db8228b5cb41939dc37d6ee677aef0619.camel@sipsolutions.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <a92ffa8db8228b5cb41939dc37d6ee677aef0619.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1opZ6x-002ncA-Um
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:60834
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFDZ61MlAWN0jmKOs65rQpyFkdSy/vJ+8Tq6HcQfI1dhDzZTn7bCmFETn+QkWMecHj0MafkgnXxUer+x0M+3v04lzEb1QJ5FpsQ9OixXAPYiy0JimY9G
 uddpXUDuQQ4LbVVP0AlVCqUabQLVAJ4xE5V0F38mB0K3FCmaroaY6W0Ng84XEGGmLA/D98n/gu7BRZg7txt9Y9qeLH4iiigSx59C3vQITpgTcHbPHobzn4Oz
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/28/22 03:22, Johannes Berg wrote:
> Hm.
> 
> If you're splitting out per driver,
> 
>> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
>> @@ -9870,7 +9870,7 @@ static int ipw_wx_sw_reset(struct net_device *dev,
>>   
>>   /* Rebase the WE IOCTLs to zero for the handler array */
>>   static iw_handler ipw_wx_handlers[] = {
>> -	IW_HANDLER(SIOCGIWNAME, (iw_handler)cfg80211_wext_giwname),
>> +	IW_HANDLER(SIOCGIWNAME, cfg80211_wext_giwname),
> 
> I can see how this (and similar) still belongs into this patch since
> it's related to the cfg80211 change, but
> 
>> +++ b/drivers/net/wireless/intersil/orinoco/wext.c
>> @@ -154,9 +154,10 @@ static struct iw_statistics *orinoco_get_wireless_stats(struct net_device *dev)
>>   
>>   static int orinoco_ioctl_setwap(struct net_device *dev,
>>   				struct iw_request_info *info,
>> -				struct sockaddr *ap_addr,
>> +				union iwreq_data *wrqu,
>>   				char *extra)
>>   {
>> +	struct sockaddr *ap_addr = &wrqu->ap_addr;
> 
> why this (and similar) too?

mmh... yeah; orinoco should be a separate patch. :)

Thanks
--
Gustavo


