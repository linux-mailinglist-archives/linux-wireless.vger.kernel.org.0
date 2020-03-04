Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7517950A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbgCDQZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 11:25:05 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:38135 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgCDQZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 11:25:05 -0500
Received: from [141.24.212.108] (thunderstorm.prakinf.tu-ilmenau.de [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 940FC580074;
        Wed,  4 Mar 2020 17:24:59 +0100 (CET)
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
To:     Denis Kenzior <denkenz@gmail.com>, Jouni Malinen <j@w1.fi>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
 <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
 <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
 <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
 <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
 <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
 <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
 <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
 <20200225110018.GA7561@w1.fi>
 <957c6850-b26b-4cfd-5bc9-d77400e621b3@gmail.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; prefer-encrypt=mutual; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Organization: TU Ilmenau
Message-ID: <ed6047dd-e71d-0cff-3c1f-5a11a53c6d8c@tu-ilmenau.de>
Date:   Wed, 4 Mar 2020 17:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <957c6850-b26b-4cfd-5bc9-d77400e621b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25.02.20 18:06, Denis Kenzior wrote:
> Hi Jouni,
>
> On 2/25/20 5:00 AM, Jouni Malinen wrote:
>> On Mon, Feb 24, 2020 at 01:35:51PM -0600, Denis Kenzior wrote:
>>> But it seems like the benefits outweigh the drawbacks?  At least we
>>> have
>>> been super happy with how control port works for us.  If you take the
>>> pre-auth path away, I'm really not sure there's any point in (at
>>> least for
>>> us) keeping support for the control port path.
>>
>> Do you use the control port for RX only or both TX and RX? The RX side
>
> Both.  For reasons already discussed.
>
>> is mostly harmless _if_ something filters unprotected RSN
>> pre-authentication frames that are received between the association and
>> the completion of 4-way handshake. That something would either need to
>> be the specific user space application using the interface or
>> potentially mac80211 with some special rules that are different between
>> EAPOL and RSN pre-authentication ethertypes.
>
> For mac80211, pre-authentication frames are already filtered, or at
> least that is the intent.  See ieee80211_frame_allowed().  Only
> control_port_protocol packets are allowed through if the station is
> not yet authorized.  Under normal circumstances that would only be
> EAPoL packets (or esoteric protocols like WAPI).  Pre-auth frames
> would be filtered.
>
> Furthermore, only the userspace daemon that initiated the association
> would get to see the packets flowing via
> NL80211_CMD_CONTROL_PORT_FRAME (by providing SOCKET_OWNER attribute). 
> In iwd, we would drop any pre-auth packets without an initiated
> session on the floor.  And we don't initiate pre-auth sessions until
> we are fully associated/authenticated/authorized.
>
> Last I checked, mac80211 is the only driver that supports this control
> port mechanism.  If other drivers obtain this support, then perhaps
> stricter checking of the packets flowing via
> cfg80211_rx_control_port() would be a good idea.  However, I'm not
> sure how much can be done here due to nl80211 being stateless.
>
>>
>> For TX, the control port path will likely result in more problematic
>> issues. I'd expect drivers to use higher priority and/or higher
>> reliability for delivering the frames. That is justifiable for EAPOL
>
> Fair enough, but the driver is notified of the protocol being sent in
> tx_control_port().  So it can easily choose not to prioritize pre-auth
> packets.
>
>> frames, but unnecessary for RSN pre-authentication frames. Being able to
>> bypass the port authorization control would be undesired from security
>> view point.
>
> TX_CONTROL_PORT does require administrative access for the caller. 
> The userspace management daemon is already trusted to do a lot of
> things by the kernel (including cleaning up things inside the kernel
> itself in certain cases).  If the userspace daemon cannot be trusted
> to send control port frames at the appropriate time, then the
> 'undesired from security view point' argument would apply quite
> broadly across the entire nl80211 API.  In fact, even the
> NL80211_ATTR_CONTROL_PORT_ETHERTYPE is implicitly trusted to be
> provided correctly by userspace.
>
> From a practical perspective, if you're worried about this, then
> perhaps stricter checking in nl80211_tx_control_port() is warranted.
> But that really implies peeking into the frames being sent...
>
> Another related issue is that NL80211_CMD_TX_CONTROL_PORT (amongst
> others) doesn't actually check whether the command is being called by
> the $SOCKET_OWNER process for the target netdev.  Realistically, only
> the $SOCKET_OWNER process has the necessary secrets to generate
> packets that go via this path.  I've submitted some RFC patches to
> lock this down, but they were rejected.
>
>>
>> The key point for me here is the concept of authorized/unauthorized port
>> for normal Data frames based on the IEEE 802.1X standard. Only the
>> frames critical for the authentication service (establishing protected
>> link with the current access point) are allowed to be transmitted and
>> received while the port used for normal data is unauthorized. For IEEE
>> 802.11, only the EAPOL frames are such Data frames that are needed
>> before the port can be authorized. RSN pre-authentication frames are
>> used to establish a new security association with a different access
>> point once the port with the current AP is authorized. As such, RSN
>> pre-authentication frames do not need to go through any special path
>> from the protocol view point and in fact, it would be incorrect to allow
>> them to be transmitted or received before the main port has been
>> authorized.
>>   The IEEE 802.11 standard describes this with "communication of all
>> non-IEEE-802.1X MSDUs sent or received" being authorized/not-authorized.
>> MSDU is a reference to Data frames and "non-IEEE-802.1X" in this context
>> to any ethertype other than the one defined in IEEE 802.1X (EAPOL).
>>
>> As a more specific example, the EAPOL frames are expected to be
>> transmitted unencrypted during the initial 4-way handshake (and with
>> some old IEEE 802.1X/WEP designs and some WPA(v1) implementation, even
>> during rekeying). On the other hand, RSN pre-authentication frames are
>> never supposed to go out unencrypted over the air (i.e., they must not
>> be sent or received before the encryption key has been established for
>> the link). The IEEE 802.11 standard describes this with "A STA shall not
>> use preauthentication except when pairwise keys are employed" and "As
>> preauthentication frames do not use the IEEE 802.1X EAPOL EtherType
>> field, the AP with which the STA is currently associated need not apply
>> any special handling. The AP and the MAC in the STA shall handle these
>> frames in the same way as other frames with arbitrary EtherType field
>> values that require distribution via the DS."
>
> No disagreement with anything you said here...
>
>>
>> I understand that there is a different view point for this from the
>> kernel--user space interface side and it may indeed look more
>> convenient to use the same path for both EAPOL and RSN
>> pre-authentication frames from that view point. If that mechanism is
>> used, it needs to be understood that the rules for EAPOL and RSN
>> pre-authentication frames are different, though, and it is not clear
>> where that difference is going to be enforced if the same interface path
>> is used.
>>
>
> I understand the purity argument you're making here, and I don't
> disagree with it.  Perhaps the naming of the commands, with
> CONTROL_PORT inside them, is unfortunate, but it seemed like a good
> idea at the time.  It is also unfortunate that pre-authentication was
> designed the way it was.  It is turning out to be somewhat of an
> anomaly that we nevertheless have to deal with.
>
> I do indeed view this through a different lens.  Only the wifi
> management daemon can realistically generate any frames that flow
> through the control port, including pre-auth frames.  So I think it
> makes very good sense to provide an optimized path for the userspace
> daemon to send/receive these frames and not force it to create sockets
> and use up resources needlessly.
>
> I also don't mind if RX forwarding of pre-auth frames via the control
> port is made optional.  What I would not want to happen is for this
> capability to be removed completely. 
Is there any consensus on how to move on in this discussion? In my
opinion a pragmatic way would be to make rx forwarding of pre-auth
frames optional with a flag which can be set whenever
NL80211_ATTR_CONTROL_PORT_OVER_NL80211 is included, like Denis has
already proposed. We could call this flag for example
NL80211_ATTR_CONTROL_PORT_NO_PREAUTH.
