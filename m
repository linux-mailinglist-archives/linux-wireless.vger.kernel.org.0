Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA33E31EEEB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhBRSvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 13:51:13 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:57974 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhBRR1Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 12:27:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613669228; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+3XHhx0Taub9uAB2Q4lBSTd3DlFkm5RKfu3T3RcgFak=;
 b=VGoS+5rCSQ/mVw0/36lvluIYySTikgC+4Ew8k9JO2VbOnWxhcGZC4wGuSAZEWI+HT9YX9b6W
 3UUvKGK1TrMLeIk6YUFvZ9ZVR0mkvTKntdEF3H2dnwi3Zykb1cWuBHxSq4saHRY2HmAlE5n1
 7bP+TsAHBpIl1ZpC6wzGaMN+CHg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 602ea3478949ac638e6b5b05 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 17:26:31
 GMT
Sender: usdutt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0346C43461; Thu, 18 Feb 2021 17:26:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: usdutt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6023FC433CA;
        Thu, 18 Feb 2021 17:26:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 18 Feb 2021 22:56:30 +0530
From:   usdutt@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE
 802.11be)
In-Reply-To: <85fa75f9619a7235710b26c2e728da4b@codeaurora.org>
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
 <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
 <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
 <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
 <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
 <5e229fce-2468-425f-404b-3a059cac7a94@broadcom.com>
 <058991d5879bd499d4410a851ebd268e@codeaurora.org>
 <c7a976ecb4269a877e20d62319846625c2b1b15c.camel@sipsolutions.net>
 <85fa75f9619a7235710b26c2e728da4b@codeaurora.org>
Message-ID: <86d6182f8ce01b41dc971e1e576d9619@codeaurora.org>
X-Sender: usdutt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-12 22:33, usdutt@codeaurora.org wrote:
> Hi ,
> Thanks for your response.
> 
>>> The switch / change interface among the STA or MLO Link shall happen
>>> only in the disconnected state.
>>> At this point, (in the disconnected state) these MLO Link wdev’s are 
>>> not
>>> linked to the STA interface ( either on the same / different wiphy ).
>>> These shall be linked after the Association to an MLO AP.
>>> The intention here is to have the wdev in the right mode ( STA or MLO
>>> Link ) before the connect / Association is triggered.
>>> This wdev is put in to a MLO_LINK_DEVICE, before the connect /
>>> association is triggered on the respective MLD (IFTYPE_STA) interface
>>> for an MLO connection.
>>> This wdev is put in the IFTYPE_STA mode, before triggering a connect 
>>> /
>>> association on this interface.
>>> 
>>> This should be applicable for different drivers too.
>>> 
>>> Please let us know if there are any caveats in this design
>> 
>> 
>> Just to summarize, to see if I'm understanding it correctly.
>> 
>> You're basically saying that on the client side
>> 
>>  1) the NL80211_IFTYPE_STATION interfaces becomes the MLD with 
>> whatever
>>     MAC address it may have, and does not maintain its "own" 
>> association
>>     to an AP;
>>  2) instead, a number of NL80211_IFTYPE_MLO_LINK (let's drop the 
>> DEVICE
>>     it's long enough) are added to it, with appropriate link addresses
>>     selected for them;
>>  3) this configuration can only happen while none of them are 
>> connected.
>> 
>> Right?
> 
> No . Our intention was the NL80211_IFTYPE_STATION interface to also 
> represent
> the MLD + MLO Link while the NL80211_IFTYPE_MLO_LINK wdevs represents 
> other MLO
> Links of an MLO connection.
> This MLO_LINK wdev will not have its netdev. The IFTYPE_STATION wdev 
> shall
> link all such MLO_LINK’s which are part of the same MLD connection.
> That way , there will be a single netdev interface exposed to the 
> applications
> for the data transfer and these MLO_LINK wdevs along with 
> NL80211_IFTYPE_STATION
> wdev represent the corresponding connection/link status with the MLD 
> AP.
> Please note that in this case the  NL80211_IFTYPE_STATION Acts as both 
> the MLD
> and one of the MLO Link’s.
> 
>> 
>> Wrt. MAC addresses, I suppose from our pure software POV the _MLO_LINK
>> could share a MAC address with the MLD (_STATION), although I hear 
>> that
>> there's still a discussion right now on MLD-addressed and 
>> link-addressed
>> management frames, so I think we need to wait until we know that for
>> sure.
>> 
>> A couple of questions:
>> 
>>  1) How do we present this to userspace, is that it? Wouldn't the
>>     _STATION (MLD) interface ideally still have *some* visible 
>> wireless
>>     state, and show which network it's connected to? It might be very
>>     awkward to require all userspace tools to be updated to know about
>>     and query for _MLO_LINKs.
>> 
>>     Obviously, wpa_supplicant needs to be aware of these and can 
>> handle
>>     it just fine, so I'm more concerned about other userspace. After
>>     all, people still use tools built on wireless extensions
> 
> As I have mentioned above , the _STATION is both the MLD and one of the
> MLO Links.
> This shall still have the connected state with its MLO Link 
> representing
> the connection info with the AP.
> The other MLO Link of a 2 Link MLO connection to the AP (for example) 
> is
> represented by the _MLO_LINK wdev.
> Userspace tools can still see this _STATION as both the MLD and non MLD
> station interface connection.
> For an MLD connection this _STATION interface will also link with the
> corresponding _MLO_LINK wdev’s and thus any
> MLO aware user applications can as well get the connection stats of the
> corresponding MLO Links along with _STATION link through the _STATION 
> interface.
> 
>> 
>>  2) In some ways related to 1), but in other ways also not - perhaps 
>> we
>>     need to anticipate that some devices will want to handle MLO link
>>     decisions in firmware? I haven't thought about this much at all, 
>> but
>>     if we require separate MLO_LINK type wdevs for each link that 
>> might
>>     be tricky?
> 
> Are you saying that these devices want to totally handle the MLO link
> establishments with in the firmware ?
> Let me take an example here.  I have taken a 2 link MLO for a 
> reference.
> Such devices want to still represent the station interface with
> NL80211_IFTYPE_STATION to the cfg80211 and create multiple links with 
> in
> the firmware ?
> Technically, the _STATION interface here is connected to 2 BSSID’s .
> Can I know What would _STATION(wdev)->current_bss represent here ?
> 
> 
>>  3) I keep thinking about moving much "associated" state into the STA
>>     struct we maintain in the kernel, and actually maintaining the
>>     *links* only as "multiple associations". This also gets tricky 
>> with
>>     the link MAC addresses in a way, though that could be handled. It
>>     might also be an easier way to manage some of that state problem
>>     from my question 1)?
>> 
>>     Any thoughts on this? I'm definitely not saying this would be 
>> easy,
>>     but would it simplify things regarding the userspace APIs and the
>>     offload question in 2)?
> 
> Can I know how these “multiple associations” would be represented as to
> the user space ?
> With your proposal above, the userspace applications shall still see a
> single NL80211_IFTYPE_STATION and multiple links are maintained within 
> this
> wdev ?
> Fine , this would work as long as these links are with in the same 
> wiphy.
> 
> Let me present the two use cases we considered MLO for.
> 
> 1)single wiphy to represent multiple bands on which the MLO Links can
> be formed :
> In this case the _STATION interface would be on a single wiphy and yeah 
> your
> proposal would hold good. We initially thought on similar lines. 
> Thanks.
> 2) single wiphy for each supported band: Say there are two wiphy’s here 
> , each
> representing the respective bands 2G and 5G/6G. In this specific case, 
> the non
> MLO solution had two _STATION interfaces connecting to the AP’s on
> respective bands.
> 
> We are aiming to enhance this design for MLO . In this case, the MLO 
> Links spawn
> across different wiphy’s and at the same time has to be backward 
> compatible for
> the non MLO connection ( dual STA ) .
> To suite the above two use cases , we proposed the introduction of
> _MLO_LINK wdev
> and the _STATION interface to link all the _MLO_LINK wdev’s that are 
> part of the
> respective MLD connection.
> Thus, a _STATION wdev can be changed to the _MLO_LINK wdev and vice
> versa to have
> both the MLO and non MLO connection (Dual STA).
> 
>>     Any other designs than the MLO_LINK wdev that you have considered
>>     and discarded, and if so for which reasons?
>> 
>> 
>>> The wdev - NL80211_IFTYPE_MLO_LINK_DEVICE only represents a “MLO 
>>> Link”
>>> on the non-AP MLD.This would not be required for an AP MLO.
>> 
>> FWIW, I don't buy the part about this not being required for an AP 
>> MLD.
>> 
>>> The following explains our design for AP.
>>> For AP , NL80211_IFTYPE_AP wdev shall represent both –  AP instance 
>>> for
>>> non-MLO / legacy client and an MLO link for AP-MLD.
>>> To be specific, For a 2 link AP MLD , there will be 2  
>>> NL80211_IFTYPE_AP
>>> wdev's created.
>> 
>> This will not work if there's a need (and possibly spec requirement) 
>> to
>> have an MLD address that's different from *all* the link addresses. It
>> will also be difficult to manage that one of the AP interfaces would
>> have to be defacto the MLD, but (at least in theory) any one of the AP
>> interfaces could be removed for 'degraded' operation.
>> 
>> I suspect will also not work right if you want to have AP_VLAN on the 
>> AP
>> MLD.
>> 
>> IMHO it'd be better for things to be symmetric like you suggest for 
>> the
>> client side.
>> 
>> Now, I can see the need for legacy interoperability, but then it seems
>> it would probably be better to do this the other way around and 
>> declare
>> a new AP_MLD interface type (with a netdev) that doesn't maintain its
>> own beacons etc. but just has its own MAC address (the AP MLD address)
>> and bubbles up the data frames exchanged on the MLD.
> 
> OK.  A new AP_MLD with a netdev to represent the MLD. I guess this is 
> to
> only facilitate the need for a different MLD address over the MLO link
> addresses?
> 
> Taking an example , A 2 MLO AP would have the following . Please 
> correct me .
> Two _ IFTYPE_AP wdev’s , representing a Link for an MLD AP and an AP 
> instance
> for a non MLD AP ( for the legacy clients to connect ). These two
> wdev’s maintain
> their own beacon’s and do have the corresponding netdev’s.
> A new AP_MLD with it’s own netdev but doesn’t maintain it’s beacon. The 
> two
> _IFTYPE_AP wdev’s, representing the link shall point to this AP_MLD 
> interface
> for the MLD address ?
> 
> We had seen some concerns on this model and please allow me to get back 
> to you
> as early as possible.

Continuing with this 2 link MLO example further,  our thought is to 
bridge the
2 netdev’s associated with each MLO Link ( MLD AP ) / AP instance ( non 
MLD AP ).
Thus, the bridge interface shall represent the network interface for the 
non MLD &
MLD AP to the network stack.
Adding further, it is this bridge interface that gets routed over the 
network stack
and thus the destination / source MAC address of the IP frames from / to 
non MLO / MLO
clients associated to the AP would be the bridge MAC address.
If this is agreed, then in the above topology the MLD MAC Address / 
netdev is not used
and this MAC address is used as the destination MAC only for certain 
frames
( EAPOL frames , from our study till now ) .
So, we were debating if we need a separate netdev to represent the MLD 
MAC address.
Would it be needed for RX / TX of EAPOL frames also from the hostapd / 
user space ?
IMHO No, as these frames could as well be exchanged over the NL 
interface , isn’t ?

Another thought is to just consider this MLD MAC address as a logical 
entity
(without associating to the netdev) which is different address from the 
Link addresses.
That said, can this model of “AP_MLD interface type ( with a netdev ) “ 
made optional
and left for the driver architectures to use it ( separate netdev for 
the MLD MAC ) ?

Regards,
Sunil
