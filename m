Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A16ED5B9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDXT6y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDXT6x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 15:58:53 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322744211
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 12:58:18 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 68F6BC4006D;
        Mon, 24 Apr 2023 19:58:16 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id BFD6113C2B0;
        Mon, 24 Apr 2023 12:58:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BFD6113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682366295;
        bh=8hKpYO0DxuaJ6Xo80gftvgxB+7nXii4+IhtLauvOTFA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LGWJiB184Vy8wM92c2hvwD7nxyPvvZaKFyhR3fyRGxVp3Ss6GW2ySPqQ2MVMmmnMX
         Gf5oKqLtBicxAe9c5wedsEOoOGW4V1yA+yPiq7oZ8/v9SHfLfCNyI7tuP37oUSZ1iD
         1OT9jobtGlViMOsQ56zqq1e19Vdm3RdpgwrABfCw=
Message-ID: <dab721af-4f9b-20b8-94da-fb1913ff4095@candelatech.com>
Date:   Mon, 24 Apr 2023 12:58:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Question on why ieee80211_prep_channel clears the
 IEEE80211_CONN_DISABLE_160MHZ flag.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <451c423b-4d0b-c2e6-7f39-0dc7da3e8080@candelatech.com>
 <e247d0832435218fcdb78f3b81a66306b8873946.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <e247d0832435218fcdb78f3b81a66306b8873946.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1682366297-Hd0owRLc8vFl
X-MDID-O: us5;ut7;1682366297;Hd0owRLc8vFl;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/24/23 09:58, Johannes Berg wrote:
> On Thu, 2023-03-30 at 16:55 -0700, Ben Greear wrote:
>> I'm trying to have supplicant tell the STA to not allow 160Mhz.
>>
>> In the method below, in my setup, *conn_flags has IEEE80211_CONN_DISABLE_160MHZ
>> set when entering the method, but this method clears that and some related flags.
>> The clear logic dates back to 2012, effectively, but I guess in 5.19 kernel era somehow my hacks worked.
>>
>> So question is, should it still be clearing the flags here?  I can add more
>> hack-around logic, but possibly those lines should just be removed for everyone?
>>
>> static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>> 				  struct ieee80211_link_data *link,
>> 				  struct cfg80211_bss *cbss,
>> 				  ieee80211_conn_flags_t *conn_flags)
>> {
>> 	struct ieee80211_local *local = sdata->local;
>> 	const struct ieee80211_ht_cap *ht_cap = NULL;
>> 	const struct ieee80211_ht_operation *ht_oper = NULL;
>> 	const struct ieee80211_vht_operation *vht_oper = NULL;
>> 	const struct ieee80211_he_operation *he_oper = NULL;
>> 	const struct ieee80211_eht_operation *eht_oper = NULL;
>> 	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
>> 	struct ieee80211_supported_band *sband;
>> 	struct cfg80211_chan_def chandef;
>> 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
>> 	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
>> 	struct ieee80211_bss *bss = (void *)cbss->priv;
>> 	struct ieee80211_elems_parse_params parse_params = {
>> 		.bss = cbss,
>> 		.link_id = -1,
>> 		.from_ap = true,
>> 	};
>> 	struct ieee802_11_elems *elems;
>> 	const struct cfg80211_bss_ies *ies;
>> 	int ret;
>> 	u32 i;
>>
>> 	pr_info("prep-channel-0, CONN_DISABLE_160MHZ: %d\n",
>> 		!!(*conn_flags & IEEE80211_CONN_DISABLE_160MHZ));
>>
>> 	rcu_read_lock();
>>
>> 	ies = rcu_dereference(cbss->ies);
>> 	parse_params.start = ies->data;
>> 	parse_params.len = ies->len;
>> 	elems = ieee802_11_parse_elems_full(&parse_params);
>> 	if (!elems) {
>> 		rcu_read_unlock();
>> 		return -ENOMEM;
>> 	}
>>
>> 	sband = local->hw.wiphy->bands[cbss->channel->band];
>>
>> 	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
>> 			 IEEE80211_CONN_DISABLE_80P80MHZ |
>> 			 IEEE80211_CONN_DISABLE_160MHZ);
>>
> 
> I'm guessing - I don't really remember right now - that this is so we
> can make a new decision to set these flags? We don't really clear them
> in any other place, I guess?
> 
> But honestly I don't know. There's a lot of state and maybe we should
> just memset() it all whenever we disconnect (get into some kind of idle
> state), just like we do with the links now that we free...

We have been running this patch below for 3 or so weeks, and have not noticed any problems.

I am personally worried about making bigger changes to this sort of logic (ie, memset),
as the over all code is convoluted and hard to think through all of the changes
and use cases.

The MLO changes seem to have done a better job of splitting up
the configured vs current settings.  I think that split is key to better
architecture over all.  Conn-flags is 'configured' as I understand it, so
probably removing mac80211 code that changes it (as opposed to changing it from
user-space or other configured input) is in the right direction.


@@ -4762,9 +4762,13 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,

  	sband = local->hw.wiphy->bands[cbss->channel->band];

+	/* This makes our logic to disable 160Mhz (at least) not work.
+	 * I am not sure it is useful in any case, so commenting out for now.
+	 * --Ben
  	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
  			 IEEE80211_CONN_DISABLE_80P80MHZ |
  			 IEEE80211_CONN_DISABLE_160MHZ);
+	*/

  	/* disable HT/VHT/HE if we don't support them */
  	if (!sband->ht_cap.ht_supported && !is_6ghz) {

I can send a patch to just remove those three lines if you think that is good approach?

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


