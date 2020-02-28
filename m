Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921B31734F6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 11:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB1KGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 05:06:39 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:60996 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1KGi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 05:06:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j7cXT-000XXc-AG; Fri, 28 Feb 2020 11:06:35 +0100
Message-ID: <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 28 Feb 2020 11:06:34 +0100
In-Reply-To: <5E4B39B2.8050905@candelatech.com> (sfid-20200218_021119_773183_F7B60EC4)
References: <5E4B39B2.8050905@candelatech.com>
         (sfid-20200218_021119_773183_F7B60EC4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-17 at 17:11 -0800, Ben Greear wrote:
> To sniff /AX stations, it is helpful to know their AID.  So, any problems
> with adding it to 'iw station dump' output?

No, no problem at all. I guess it was just never added because it
originally comes from userspace (hostapd), and so didn't really need to
be sent back. But yeah, we have trivial infrastructure to send it back,
so sure, why not.

johannes

