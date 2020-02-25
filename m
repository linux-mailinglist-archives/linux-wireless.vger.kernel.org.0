Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B116EC63
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 18:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBYRWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 12:22:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46950 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYRWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 12:22:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id a22so21296oid.13
        for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2020 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7mmkJ8k32H1ZLqwFAuCD+TIe7pAWu11xbgTHsL2XLo=;
        b=lXMCnawCm8yky2wXRtc7R0vqqXcTL2sjqCmuPoJKt3N8izTQJYYPYDsJ8zL7qgA0WM
         lnWLtTvxeaUPursi2O802sNDU/uAz72ExWB+/MyzNwSjKXmjIMqLSG4OHakT5IDNd9cF
         mhgxo2c7/BT4+1oos4hHUz2SFVocEh7L43RqPpYkcWdN0eaVNrx+sQnUtJjLRVEqnCk3
         pv5sdGALO1uU3zSPTqRJHXLcqIwmy4YaJufsV0fKlc5Myx41/0IlijVvSTM9w4lxd+Ry
         YanXN81zryWbq0oJxRRh1DsHXpUKiUKDDDHGGinjCG2VKGxe5FJNzXWkWgbDc/jaXTuX
         RJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7mmkJ8k32H1ZLqwFAuCD+TIe7pAWu11xbgTHsL2XLo=;
        b=sxfAI1IVcU3wT3mgNbq2bgGt3njro3GXgCkAvHjbDGtrO7OsuK3YhYnfmgHppfXPdy
         +mOe3iEikjp+r7rPMrPVJPJRGOrBmEi79AO213CLh8iT21kQUYs2vvYxNwGAtL9eCNI/
         9SXeSqdmFBNTBXjzem1No5dUduFDAlpQpwUUf4nqhO2NAI3bwcwjqVSk4QZIpyXm4iiI
         37bbN9ltLOyzDTODyXVyZJUyt2QGDgGfro16oXdkdXcFwEoxZ21dGBI9XG/Gsv9hJj8o
         S0RREAIS8ECfAU0jbF7ku/iKumMD0bziSOg1cFHwW114Qp6fj5JjKRTXTpjqiAjQsRdE
         a64w==
X-Gm-Message-State: APjAAAULDQM9nQz7V6tKfFogB1jL+kd0MBI04wL3k4ndFU59rLtidxmM
        oCtvvb4HFvSE50M8YlkN8go=
X-Google-Smtp-Source: APXvYqx6mtgnKyv+bd6PzNJLNgNkN3XHLcl4WZpNi4fIZ4jqywlw6DTuhP88BrfOFerI4vwzcQ46qA==
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr1930oij.121.1582651330892;
        Tue, 25 Feb 2020 09:22:10 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q9sm999829otl.53.2020.02.25.09.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 09:22:09 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
To:     Jouni Malinen <j@w1.fi>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
 <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
 <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
 <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
 <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
 <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
 <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
 <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
 <20200225110018.GA7561@w1.fi>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <957c6850-b26b-4cfd-5bc9-d77400e621b3@gmail.com>
Date:   Tue, 25 Feb 2020 11:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200225110018.GA7561@w1.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jouni,

On 2/25/20 5:00 AM, Jouni Malinen wrote:
> On Mon, Feb 24, 2020 at 01:35:51PM -0600, Denis Kenzior wrote:
>> But it seems like the benefits outweigh the drawbacks?  At least we have
>> been super happy with how control port works for us.  If you take the
>> pre-auth path away, I'm really not sure there's any point in (at least for
>> us) keeping support for the control port path.
> 
> Do you use the control port for RX only or both TX and RX? The RX side

Both.  For reasons already discussed.

> is mostly harmless _if_ something filters unprotected RSN
> pre-authentication frames that are received between the association and
> the completion of 4-way handshake. That something would either need to
> be the specific user space application using the interface or
> potentially mac80211 with some special rules that are different between
> EAPOL and RSN pre-authentication ethertypes.

For mac80211, pre-authentication frames are already filtered, or at 
least that is the intent.  See ieee80211_frame_allowed().  Only 
control_port_protocol packets are allowed through if the station is not 
yet authorized.  Under normal circumstances that would only be EAPoL 
packets (or esoteric protocols like WAPI).  Pre-auth frames would be 
filtered.

Furthermore, only the userspace daemon that initiated the association 
would get to see the packets flowing via NL80211_CMD_CONTROL_PORT_FRAME 
(by providing SOCKET_OWNER attribute).  In iwd, we would drop any 
pre-auth packets without an initiated session on the floor.  And we 
don't initiate pre-auth sessions until we are fully 
associated/authenticated/authorized.

Last I checked, mac80211 is the only driver that supports this control 
port mechanism.  If other drivers obtain this support, then perhaps 
stricter checking of the packets flowing via cfg80211_rx_control_port() 
would be a good idea.  However, I'm not sure how much can be done here 
due to nl80211 being stateless.

> 
> For TX, the control port path will likely result in more problematic
> issues. I'd expect drivers to use higher priority and/or higher
> reliability for delivering the frames. That is justifiable for EAPOL

Fair enough, but the driver is notified of the protocol being sent in 
tx_control_port().  So it can easily choose not to prioritize pre-auth 
packets.

> frames, but unnecessary for RSN pre-authentication frames. Being able to
> bypass the port authorization control would be undesired from security
> view point.

TX_CONTROL_PORT does require administrative access for the caller.  The 
userspace management daemon is already trusted to do a lot of things by 
the kernel (including cleaning up things inside the kernel itself in 
certain cases).  If the userspace daemon cannot be trusted to send 
control port frames at the appropriate time, then the 'undesired from 
security view point' argument would apply quite broadly across the 
entire nl80211 API.  In fact, even the 
NL80211_ATTR_CONTROL_PORT_ETHERTYPE is implicitly trusted to be provided 
correctly by userspace.

 From a practical perspective, if you're worried about this, then 
perhaps stricter checking in nl80211_tx_control_port() is warranted. 
But that really implies peeking into the frames being sent...

Another related issue is that NL80211_CMD_TX_CONTROL_PORT (amongst 
others) doesn't actually check whether the command is being called by 
the $SOCKET_OWNER process for the target netdev.  Realistically, only 
the $SOCKET_OWNER process has the necessary secrets to generate packets 
that go via this path.  I've submitted some RFC patches to lock this 
down, but they were rejected.

> 
> The key point for me here is the concept of authorized/unauthorized port
> for normal Data frames based on the IEEE 802.1X standard. Only the
> frames critical for the authentication service (establishing protected
> link with the current access point) are allowed to be transmitted and
> received while the port used for normal data is unauthorized. For IEEE
> 802.11, only the EAPOL frames are such Data frames that are needed
> before the port can be authorized. RSN pre-authentication frames are
> used to establish a new security association with a different access
> point once the port with the current AP is authorized. As such, RSN
> pre-authentication frames do not need to go through any special path
> from the protocol view point and in fact, it would be incorrect to allow
> them to be transmitted or received before the main port has been
> authorized.
>   
> The IEEE 802.11 standard describes this with "communication of all
> non-IEEE-802.1X MSDUs sent or received" being authorized/not-authorized.
> MSDU is a reference to Data frames and "non-IEEE-802.1X" in this context
> to any ethertype other than the one defined in IEEE 802.1X (EAPOL).
> 
> As a more specific example, the EAPOL frames are expected to be
> transmitted unencrypted during the initial 4-way handshake (and with
> some old IEEE 802.1X/WEP designs and some WPA(v1) implementation, even
> during rekeying). On the other hand, RSN pre-authentication frames are
> never supposed to go out unencrypted over the air (i.e., they must not
> be sent or received before the encryption key has been established for
> the link). The IEEE 802.11 standard describes this with "A STA shall not
> use preauthentication except when pairwise keys are employed" and "As
> preauthentication frames do not use the IEEE 802.1X EAPOL EtherType
> field, the AP with which the STA is currently associated need not apply
> any special handling. The AP and the MAC in the STA shall handle these
> frames in the same way as other frames with arbitrary EtherType field
> values that require distribution via the DS."

No disagreement with anything you said here...

> 
> I understand that there is a different view point for this from the
> kernel--user space interface side and it may indeed look more
> convenient to use the same path for both EAPOL and RSN
> pre-authentication frames from that view point. If that mechanism is
> used, it needs to be understood that the rules for EAPOL and RSN
> pre-authentication frames are different, though, and it is not clear
> where that difference is going to be enforced if the same interface path
> is used.
> 

I understand the purity argument you're making here, and I don't 
disagree with it.  Perhaps the naming of the commands, with CONTROL_PORT 
inside them, is unfortunate, but it seemed like a good idea at the time. 
  It is also unfortunate that pre-authentication was designed the way it 
was.  It is turning out to be somewhat of an anomaly that we 
nevertheless have to deal with.

I do indeed view this through a different lens.  Only the wifi 
management daemon can realistically generate any frames that flow 
through the control port, including pre-auth frames.  So I think it 
makes very good sense to provide an optimized path for the userspace 
daemon to send/receive these frames and not force it to create sockets 
and use up resources needlessly.

I also don't mind if RX forwarding of pre-auth frames via the control 
port is made optional.  What I would not want to happen is for this 
capability to be removed completely.

Regards,
-Denis
