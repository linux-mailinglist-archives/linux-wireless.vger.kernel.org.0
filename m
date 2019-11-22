Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B31076BC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVRuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:50:18 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48654 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:50:17 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYD4R-00028d-U5; Fri, 22 Nov 2019 18:50:16 +0100
Message-ID: <d6d9eef2a6260fd7b677f137d00c4aa416ba4c3f.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix overwriting of qos_ctrl.tid field
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 18:50:13 +0100
In-Reply-To: <CADiFmNOFfjoZ9ah-_AyrJmKUvVoYjO3EfG9LqozZDFq4tUoZ-Q@mail.gmail.com> (sfid-20191122_160659_482033_F1641F35)
References: <20191119133451.14711-1-fredrik.olofsson@anyfinetworks.com>
         <e28361a05a275e999be17eb7ce659423db255497.camel@sipsolutions.net>
         <CADiFmNOFfjoZ9ah-_AyrJmKUvVoYjO3EfG9LqozZDFq4tUoZ-Q@mail.gmail.com>
         (sfid-20191122_160659_482033_F1641F35)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 16:06 +0100, Fredrik Olofsson wrote:

> > I'm not sure I understand.
> > 
> > If the QoS field is overwritten (where, btw?) then wouldn't that still
> > be done even after this change, and if the frame is pre-encrypted it is
> > corrupted?
> 
> Thanks for your response, and sorry for being too terse.
> 
> What we are doing is injecting pre-encrypted frames on the monitor interface.
> This used to work without issues (prior to the commit I mentioned). But now,
> the QoS field is overwritten, corrupting the frame. Actually the overwriting
> happened previously as well, but the QoS.TID field was not changed since it
> was always overwritten with the same value as it already had. This
> overwriting with the same value happens after my patch as well.
> 
> The simplified call flow for the frame is something like this:
> 
> netdev_core_pick_tx()
>   if (dev->real_num_tx_queues != 1) {
>     dev->ndo_select_queue()      <<< really: ieee80211_monitor_select_queue()
>   }
> 
> ...
> 
> ieee80211_monitor_start_xmit()
>   ieee80211_xmit()
>     ieee80211_set_qos_hdr()      <<< here the tid is overwritten
>     ieee80211_tx()
> 
> But after dbd50a851c50, real_num_tx_queues == 1 and
> ieee80211_monitor_select_queue() is never called. Then when the frame arrives
> in ieee80211_set_qos_hdr() the qos.tid field is overwritten with the wrong
> value. My patch makes sure ieee80211_set_qos_hdr() writes the same QoS.TID
> value as was originally in the frame. Even if ieee80211_monitor_select_queue()
> is not called.
> 
> My suggested patch tries to do the same as what happened before, but it may
> not be the correct way to do this. Maybe real_num_queues should not be 1?
> Maybe it would be better to detect the case that the frame is already
> encrypted, and make sure not to touch any protected fields at all?

No ... I get it now I think. Will need to think about it correctly
again.

What confused me is that you said the field was 'encrypted' but really
it's not, it's just part of what gets protected during the encryption. I
paid too much attention to your email vs. remembering how this all works
and then figured you couldn't write back the value to an encrypted
field. All good, I'll figure it out :)

johannes

