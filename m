Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD817A740
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEOUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:20:23 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35178 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEOUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:20:23 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rMG-001FKG-Ri; Thu, 05 Mar 2020 15:20:16 +0100
Message-ID: <5c2861b21d604ed070eaca6c25f901d1c2c6512f.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: add frame transmission support over
 virtio
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Mar 2020 15:20:15 +0100
In-Reply-To: <2C212BF0-D7EF-4BB3-940E-95F47A96704E@holtmann.org>
References: <20200305143212.c6e4c87d225b.I7ce60bf143e863dcdf0fb8040aab7168ba549b99@changeid>
         <2F7ADB4C-8C2C-4DEC-80AF-9E2D6B55CA88@holtmann.org>
         <c5319f6630be431c8680051fd4c33d59524683a2.camel@sipsolutions.net>
         <E37B1033-8525-422A-AF10-5EEE5988FE57@holtmann.org>
         <eab92ed50b403437786244b664a99f04e341ecc1.camel@sipsolutions.net>
         <2C212BF0-D7EF-4BB3-940E-95F47A96704E@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-05 at 15:18 +0100, Marcel Holtmann wrote:
> 
> of course and I would prefer they are created by using genl or when
> you set the kernel module option to the number you want.
> 
> The default of 2 radios is just bugging me. I refrained from adding
> genl autoloading to mac80211_hwsim because of this 2 radios default. I
> would like to get that added as well.

Sure, I don't really have any objection to either of those. I just don't
really see the connection to this particular patch?

johannes

