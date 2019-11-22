Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DF1071E1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKVMAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:00:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44336 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKVMAf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:00:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY7c1-0002TL-DI; Fri, 22 Nov 2019 13:00:33 +0100
Message-ID: <e28361a05a275e999be17eb7ce659423db255497.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix overwriting of qos_ctrl.tid field
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Fredrik Olofsson <fredrik.olofsson@anyfinetworks.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:00:32 +0100
In-Reply-To: <20191119133451.14711-1-fredrik.olofsson@anyfinetworks.com> (sfid-20191119_143525_400237_AC0E3C8B)
References: <20191119133451.14711-1-fredrik.olofsson@anyfinetworks.com>
         (sfid-20191119_143525_400237_AC0E3C8B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-11-19 at 14:34 +0100, Fredrik Olofsson wrote:
> Fixes overwriting of qos_ctrl.tid field for encrypted frames injected on
> monitor interface. qos_ctrl.tid is protected by the encryption, and
> cannot be modified after encryption. For injected frames, the encryption
> key may not be available.
> 
> Before passing the frame to the driver, the qos_ctrl.tid field is
> updated from skb->priority. Prior to dbd50a851c50 skb->priority was
> updated in ieee80211_select_queue_80211(), but this function is no longer
> always called. This patch tries to mimmic the previous behaviour by
> updating skb->priority in ieee80211_monitor_start_xmit().

I'm not sure I understand.

If the QoS field is overwritten (where, btw?) then wouldn't that still
be done even after this change, and if the frame is pre-encrypted it is
corrupted?

johannes

