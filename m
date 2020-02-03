Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36915086C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBCObu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 09:31:50 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42542 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBCObu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 09:31:50 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iyclP-00DlX1-VF; Mon, 03 Feb 2020 15:31:48 +0100
Message-ID: <1c90ea159042d923504aaaeaf45536c6579a17e8.camel@sipsolutions.net>
Subject: Re: SOCK_WIFI_STATUS for control port over nl80211?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
Date:   Mon, 03 Feb 2020 15:31:46 +0100
In-Reply-To: <43d429f0-5948-46d0-ef98-378dfb4ca0f0@tu-ilmenau.de> (sfid-20200203_145103_570513_D1BCA7B4)
References: <43d429f0-5948-46d0-ef98-378dfb4ca0f0@tu-ilmenau.de>
         (sfid-20200203_145103_570513_D1BCA7B4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-03 at 14:50 +0100, Markus Theil wrote:
> In the last few weeks I used a wpa_supplicant with my patches for tx and
> rx over nl80211 control port and sometimes observed longer time to
> successful connection than without these patches. I think that this is a
> result of wpa_supplicant using SOCK_WIFI_STATUS when transmitting EAPOL
> frames over AF_PACKET sockets and using a fast retransmit, if the Wi-Fi
> ack is not observed timely. So the question here is, should we add an
> analog feature for tx over nl80211 control port? I think of a
> control_port_tx_status message with a cookie delivered to user-space.

Somehow I thought we treated this like the mgmt tx and already had a
notification over nl80211 going back, but looks like not?

Then yeah, we should definitely add that.

johannes

