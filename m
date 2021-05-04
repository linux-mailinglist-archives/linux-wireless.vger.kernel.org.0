Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BE372ED8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEDRYJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 13:24:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17592 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhEDRYI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 13:24:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620148993; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=L9uWlytvQ7TU36rh3dVpQOmDYsvDiPUQdQ5Ue2t9E6Q=;
 b=dWnEWgCMSF/deL+hIDbuGyo024JOeQPWSKRZVhbcVs/YAAVeQlMIzh9qK/bzMDQ9i6szs6Wa
 4jon2bRHrBrym6KA6M6Ykdbbcq9EU0WPHgUG6ZIJmzd4BFWCPBLexsEGrRMQTU6ele5cOqwu
 co/e7aXblhsrXV7lEOh8rdoM9oc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 609182fd8807bcde1d8dc825 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 17:23:09
 GMT
Sender: usdutt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73474C433D3; Tue,  4 May 2021 17:23:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: usdutt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83FA4C433F1;
        Tue,  4 May 2021 17:23:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 04 May 2021 22:53:08 +0530
From:   usdutt@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link (IEEE
 802.11be)
In-Reply-To: <86d6182f8ce01b41dc971e1e576d9619@codeaurora.org>
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
 <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
 <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
 <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
 <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
 <5e229fce-2468-425f-404b-3a059cac7a94@broadcom.com>
 <058991d5879bd499d4410a851ebd268e@codeaurora.org>
 <c7a976ecb4269a877e20d62319846625c2b1b15c.camel@sipsolutions.net>
 <85fa75f9619a7235710b26c2e728da4b@codeaurora.org>
 <86d6182f8ce01b41dc971e1e576d9619@codeaurora.org>
Message-ID: <725fa2e421a0fa3fcb7ca78ad8374ff4@codeaurora.org>
X-Sender: usdutt@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-18 22:56, usdutt@codeaurora.org wrote:
> On 2021-02-12 22:33, usdutt@codeaurora.org wrote:
>> Hi ,
>> Thanks for your response.
>> 
>>>> The switch / change interface among the STA or MLO Link shall happen
>>>> only in the disconnected state.
>>>> At this point, (in the disconnected state) these MLO Link wdev’s are 
>>>> not
>>>> linked to the STA interface ( either on the same / different wiphy 
>>>> ).
>>>> These shall be linked after the Association to an MLO AP.
>>>> The intention here is to have the wdev in the right mode ( STA or 
>>>> MLO
>>>> Link ) before the connect / Association is triggered.
>>>> This wdev is put in to a MLO_LINK_DEVICE, before the connect /
>>>> association is triggered on the respective MLD (IFTYPE_STA) 
>>>> interface
>>>> for an MLO connection.
>>>> This wdev is put in the IFTYPE_STA mode, before triggering a connect 
>>>> /
>>>> association on this interface.
>>>> 
>>>> This should be applicable for different drivers too.
>>>> 
>>>> Please let us know if there are any caveats in this design
>>> 
>>> 
>>> Just to summarize, to see if I'm understanding it correctly.
>>> 
>>> You're basically saying that on the client side
>>> 
>>>  1) the NL80211_IFTYPE_STATION interfaces becomes the MLD with 
>>> whatever
>>>     MAC address it may have, and does not maintain its "own" 
>>> association
>>>     to an AP;
>>>  2) instead, a number of NL80211_IFTYPE_MLO_LINK (let's drop the 
>>> DEVICE
>>>     it's long enough) are added to it, with appropriate link 
>>> addresses
>>>     selected for them;
>>>  3) this configuration can only happen while none of them are 
>>> connected.
>>> 
>>> Right?
>> 
>> No . Our intention was the NL80211_IFTYPE_STATION interface to also 
>> represent
>> the MLD + MLO Link while the NL80211_IFTYPE_MLO_LINK wdevs represents 
>> other MLO
>> Links of an MLO connection.
>> This MLO_LINK wdev will not have its netdev. The IFTYPE_STATION wdev 
>> shall
>> link all such MLO_LINK’s which are part of the same MLD connection.
>> That way , there will be a single netdev interface exposed to the 
>> applications
>> for the data transfer and these MLO_LINK wdevs along with 
>> NL80211_IFTYPE_STATION
>> wdev represent the corresponding connection/link status with the MLD 
>> AP.
>> Please note that in this case the  NL80211_IFTYPE_STATION Acts as both 
>> the MLD
>> and one of the MLO Link’s.
>> 
>>> 
>>> Wrt. MAC addresses, I suppose from our pure software POV the 
>>> _MLO_LINK
>>> could share a MAC address with the MLD (_STATION), although I hear 
>>> that
>>> there's still a discussion right now on MLD-addressed and 
>>> link-addressed
>>> management frames, so I think we need to wait until we know that for
>>> sure.
>>> 
>>> A couple of questions:
>>> 
>>>  1) How do we present this to userspace, is that it? Wouldn't the
>>>     _STATION (MLD) interface ideally still have *some* visible 
>>> wireless
>>>     state, and show which network it's connected to? It might be very
>>>     awkward to require all userspace tools to be updated to know 
>>> about
>>>     and query for _MLO_LINKs.
>>> 
>>>     Obviously, wpa_supplicant needs to be aware of these and can 
>>> handle
>>>     it just fine, so I'm more concerned about other userspace. After
>>>     all, people still use tools built on wireless extensions
>> 
>> As I have mentioned above , the _STATION is both the MLD and one of 
>> the
>> MLO Links.
>> This shall still have the connected state with its MLO Link 
>> representing
>> the connection info with the AP.
>> The other MLO Link of a 2 Link MLO connection to the AP (for example) 
>> is
>> represented by the _MLO_LINK wdev.
>> Userspace tools can still see this _STATION as both the MLD and non 
>> MLD
>> station interface connection.
>> For an MLD connection this _STATION interface will also link with the
>> corresponding _MLO_LINK wdev’s and thus any
>> MLO aware user applications can as well get the connection stats of 
>> the
>> corresponding MLO Links along with _STATION link through the _STATION 
>> interface.
>> 
>>> 
>>>  2) In some ways related to 1), but in other ways also not - perhaps 
>>> we
>>>     need to anticipate that some devices will want to handle MLO link
>>>     decisions in firmware? I haven't thought about this much at all, 
>>> but
>>>     if we require separate MLO_LINK type wdevs for each link that 
>>> might
>>>     be tricky?
>> 
>> Are you saying that these devices want to totally handle the MLO link
>> establishments with in the firmware ?
>> Let me take an example here.  I have taken a 2 link MLO for a 
>> reference.
>> Such devices want to still represent the station interface with
>> NL80211_IFTYPE_STATION to the cfg80211 and create multiple links with 
>> in
>> the firmware ?
>> Technically, the _STATION interface here is connected to 2 BSSID’s .
>> Can I know What would _STATION(wdev)->current_bss represent here ?
>> 
>> 
>>>  3) I keep thinking about moving much "associated" state into the STA
>>>     struct we maintain in the kernel, and actually maintaining the
>>>     *links* only as "multiple associations". This also gets tricky 
>>> with
>>>     the link MAC addresses in a way, though that could be handled. It
>>>     might also be an easier way to manage some of that state problem
>>>     from my question 1)?
>>> 
>>>     Any thoughts on this? I'm definitely not saying this would be 
>>> easy,
>>>     but would it simplify things regarding the userspace APIs and the
>>>     offload question in 2)?
>> 
>> Can I know how these “multiple associations” would be represented as 
>> to
>> the user space ?
>> With your proposal above, the userspace applications shall still see a
>> single NL80211_IFTYPE_STATION and multiple links are maintained within 
>> this
>> wdev ?
>> Fine , this would work as long as these links are with in the same 
>> wiphy.
>> 
>> Let me present the two use cases we considered MLO for.
>> 
>> 1)single wiphy to represent multiple bands on which the MLO Links can
>> be formed :
>> In this case the _STATION interface would be on a single wiphy and 
>> yeah your
>> proposal would hold good. We initially thought on similar lines. 
>> Thanks.
>> 2) single wiphy for each supported band: Say there are two wiphy’s 
>> here , each
>> representing the respective bands 2G and 5G/6G. In this specific case, 
>> the non
>> MLO solution had two _STATION interfaces connecting to the AP’s on
>> respective bands.
>> 
>> We are aiming to enhance this design for MLO . In this case, the MLO 
>> Links spawn
>> across different wiphy’s and at the same time has to be backward 
>> compatible for
>> the non MLO connection ( dual STA ) .
>> To suite the above two use cases , we proposed the introduction of
>> _MLO_LINK wdev
>> and the _STATION interface to link all the _MLO_LINK wdev’s that are 
>> part of the
>> respective MLD connection.
>> Thus, a _STATION wdev can be changed to the _MLO_LINK wdev and vice
>> versa to have
>> both the MLO and non MLO connection (Dual STA).
>> 
>>>     Any other designs than the MLO_LINK wdev that you have considered
>>>     and discarded, and if so for which reasons?
>>> 
>>> 
>>>> The wdev - NL80211_IFTYPE_MLO_LINK_DEVICE only represents a “MLO 
>>>> Link”
>>>> on the non-AP MLD.This would not be required for an AP MLO.
>>> 
>>> FWIW, I don't buy the part about this not being required for an AP 
>>> MLD.
>>> 
>>>> The following explains our design for AP.
>>>> For AP , NL80211_IFTYPE_AP wdev shall represent both –  AP instance 
>>>> for
>>>> non-MLO / legacy client and an MLO link for AP-MLD.
>>>> To be specific, For a 2 link AP MLD , there will be 2  
>>>> NL80211_IFTYPE_AP
>>>> wdev's created.
>>> 
>>> This will not work if there's a need (and possibly spec requirement) 
>>> to
>>> have an MLD address that's different from *all* the link addresses. 
>>> It
>>> will also be difficult to manage that one of the AP interfaces would
>>> have to be defacto the MLD, but (at least in theory) any one of the 
>>> AP
>>> interfaces could be removed for 'degraded' operation.
>>> 
>>> I suspect will also not work right if you want to have AP_VLAN on the 
>>> AP
>>> MLD.
>>> 
>>> IMHO it'd be better for things to be symmetric like you suggest for 
>>> the
>>> client side.
>>> 
>>> Now, I can see the need for legacy interoperability, but then it 
>>> seems
>>> it would probably be better to do this the other way around and 
>>> declare
>>> a new AP_MLD interface type (with a netdev) that doesn't maintain its
>>> own beacons etc. but just has its own MAC address (the AP MLD 
>>> address)
>>> and bubbles up the data frames exchanged on the MLD.
>> 
>> OK.  A new AP_MLD with a netdev to represent the MLD. I guess this is 
>> to
>> only facilitate the need for a different MLD address over the MLO link
>> addresses?
>> 
>> Taking an example , A 2 MLO AP would have the following . Please 
>> correct me .
>> Two _ IFTYPE_AP wdev’s , representing a Link for an MLD AP and an AP 
>> instance
>> for a non MLD AP ( for the legacy clients to connect ). These two
>> wdev’s maintain
>> their own beacon’s and do have the corresponding netdev’s.
>> A new AP_MLD with it’s own netdev but doesn’t maintain it’s beacon. 
>> The two
>> _IFTYPE_AP wdev’s, representing the link shall point to this AP_MLD 
>> interface
>> for the MLD address ?
>> 
>> We had seen some concerns on this model and please allow me to get 
>> back to you
>> as early as possible.
> 
> Continuing with this 2 link MLO example further,  our thought is to 
> bridge the
> 2 netdev’s associated with each MLO Link ( MLD AP ) / AP instance (
> non MLD AP ).
> Thus, the bridge interface shall represent the network interface for
> the non MLD &
> MLD AP to the network stack.
> Adding further, it is this bridge interface that gets routed over the
> network stack
> and thus the destination / source MAC address of the IP frames from /
> to non MLO / MLO
> clients associated to the AP would be the bridge MAC address.
> If this is agreed, then in the above topology the MLD MAC Address /
> netdev is not used
> and this MAC address is used as the destination MAC only for certain 
> frames
> ( EAPOL frames , from our study till now ) .
> So, we were debating if we need a separate netdev to represent the MLD
> MAC address.
> Would it be needed for RX / TX of EAPOL frames also from the hostapd /
> user space ?
> IMHO No, as these frames could as well be exchanged over the NL
> interface , isn’t ?
> 
> Another thought is to just consider this MLD MAC address as a logical 
> entity
> (without associating to the netdev) which is different address from
> the Link addresses.
> That said, can this model of “AP_MLD interface type ( with a netdev )
> “ made optional
> and left for the driver architectures to use it ( separate netdev for
> the MLD MAC ) ?
> 
> Regards,
> Sunil

Hi ,
Can you please help us review the proposal for MLO AP and STA.
The following is the high level summary of MLO behavior for both the 
modes, based on your earlier suggestions.

MLO STA ( non – AP )

1) An MLD is represented by the NL80211_IFTYPE_STATION wdev.
2) Each MLO Link is represented by a new wdev type - 
NL80211_IFTYPE_MLO_LINK
3) Each MLO Link wdev represent the connection information of the 
respective link with the MLO AP.
4) The NL80211_IFTYPE_STATION wdev behavior would change based on if the 
connection is MLO vs non MLO.
     a) For a non MLO NL80211_IFTYPE_STATION Wdev, the current_bss (wdev) 
represents the current connected bss information.
     b) For an MLO, NL80211_IFTYPE_STATION Wdev will fetch the 
current_bss info from the respective NL80211_IFTYPE_MLO_LINK Wdev.
5) Thus, the NL80211_IFTYPE_STATION wdev will maintain the list of all 
such NL80211_IFTYPE_MLO_LINK Wdev's for an MLO station.
6) These NL80211_IFTYPE_MLO_LINK Wdev’s can be either on the same or 
different wiphy as that of NL80211_IFTYPE_STATION Wdev. This is to 
facilitate the dual band architectures, where each wiphy represents the 
respective band.
7) Can either of following options be considered to represent a MLD STA. 
Leave up to the driver architectures to use the same.
     a) Having a separate wdev for an MLD STA. This provides an option to 
set any link specific attributes ( e.g., MAC address) via MLO Link  wdev 
while ML specific attributes can be set via MLD STA  wdev
     b) No separate wdev / netdev representation for the MLD STA. We 
wanted to explore if a NL80211_IFTYPE_STATION wdev can as well act as 
one of the MLO Link’s. For the architectures that can support same MLO 
Link and MLD.
        This will allow driver to support the model of MLD mac being same 
as link mac address or different.


MLO AP

1) For AP , NL80211_IFTYPE_AP wdev shall represent both –  distinct AP 
instance (for non-MLO client associations) and an AP in AP MLD for MLO 
client associations.
2) The MLO Links for the AP are represented by the respective 
NL80211_IFTYPE_AP wdev's.
3) Can either of following options be considered to represent a MLD AP.
Leave up to the driver architectures to use the same.
     a) A new wdev interface type NL80211_IFTYPE_MLD_AP represents the 
MLD for an MLO AP. This NL80211_IFTYPE_MLD_AP Shall not have its own 
beacon, but will have a netdev associated to it, which represents the 
MLD of MLO AP.
     b) No separate wdev / netdev representation for the MLD AP.  Hostapd 
is aware of/derives the MLD MAC address and uses the regular MLO Link AP
        wdevs(any) for all the required ML mgmt and EAPOL interactions. 
This is for
        the architectures where  there are no Data frames ( apart from 
EAPOL ) destined to MLD.
        The MLO Link AP’s are added to the  bridge interface and data 
frames are forwarded via bridge, practically. This also helps in 
architectures where large number of virtual AP’s are the requirement but 
resources such
        as the net devices are a constraint.

Regards,
Sunil


