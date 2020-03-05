Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE317A72D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCEOOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:14:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35100 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCEOOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:14:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rGe-001EaS-VN; Thu, 05 Mar 2020 15:14:29 +0100
Message-ID: <eab92ed50b403437786244b664a99f04e341ecc1.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: add frame transmission support over
 virtio
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Mar 2020 15:14:27 +0100
In-Reply-To: <E37B1033-8525-422A-AF10-5EEE5988FE57@holtmann.org>
References: <20200305143212.c6e4c87d225b.I7ce60bf143e863dcdf0fb8040aab7168ba549b99@changeid>
         <2F7ADB4C-8C2C-4DEC-80AF-9E2D6B55CA88@holtmann.org>
         <c5319f6630be431c8680051fd4c33d59524683a2.camel@sipsolutions.net>
         <E37B1033-8525-422A-AF10-5EEE5988FE57@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-05 at 15:09 +0100, Marcel Holtmann wrote:
> 
> can we just make it a Kconfig option that defaults to 2, but gets set
> to 0 when virtio support is included.

We could, I guess, but I don't understand why?

I don't understand why you think there should be any relation between
virtio and the number of fake radios?

Basically, hwsim works like this:

There are a number of virtual radios (defaulting to two), which can
communicate with each other. This communication can be

1) handled inside the hwsim driver itself, "perfect" medium simulation
   without any latency etc.
2) handled over netlink with wmediumd (running inside the same kernel),
   i.e. calling out to userspace for all frame transmissions etc.

With this patch, in addition, the communication can be

3) handled over virtio to wmediumd running *outside* the qemu (untested)
   or user-mode-linux virtual machine.


So you still need virtual radios inside, and virtio doesn't *create* any
new virtual radios, it just provides the wmediumd communication
mechanism. Regardless of virtio, you can have any number of virtual
radios inside the kernel.

johannes

